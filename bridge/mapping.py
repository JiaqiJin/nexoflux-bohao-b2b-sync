import base64
from decimal import ROUND_HALF_UP, Decimal


class MappingError(ValueError):
    pass


def external_id(installation: str, kind: str, *parts) -> str:
    encoded = base64.urlsafe_b64encode("\x00".join(map(str, parts)).encode()).decode().rstrip("=")
    result = f"bh_{installation}_{kind}_{encoded}"
    if len(result) > 128:
        raise MappingError("Identidad Bohao demasiado larga")
    return result


def decode_id(value: str, installation: str, kind: str) -> list[str]:
    prefix = f"bh_{installation}_{kind}_"
    if not value or not value.startswith(prefix):
        raise MappingError("El registro no está vinculado a esta instalación Bohao")
    encoded = value[len(prefix) :]
    return base64.urlsafe_b64decode(encoded + "=" * (-len(encoded) % 4)).decode().split("\x00")


def scaled(value, factor=10000) -> int:
    number = Decimal(str(value or 0)) * factor
    if not number.is_finite():
        raise MappingError("Importe no válido")
    return int(number.quantize(Decimal(1), rounding=ROUND_HALF_UP))


def whole(value, label="Cantidad") -> int:
    number = Decimal(str(value))
    if not number.is_finite() or number != number.to_integral_value():
        raise MappingError(f"{label}: {value} no es una unidad entera. Configura una unidad mínima exacta.")
    return int(number)


def product_payload(row, settings, category_id, current=None):
    name = row.get("NombreES") or row.get("NombreCN") or row["ArticuloID"]
    current = current or {}
    return {
        "name": name,
        "description": row.get("Descripcion") or None,
        "translations": {
            "es": {"name": row.get("NombreES") or None, "description": None},
            "zh": {"name": row.get("NombreCN") or None, "description": None},
        },
        "categoryId": category_id,
        "brandId": current.get("brandId"),
        "lotTracked": current.get("lotTracked", False),
        "active": not bool(row.get("Bloqueado") or row.get("Privado")),
    }


def customer_payload(row):
    country = (row.get("CountryID") or "ES").upper()
    nif = (row.get("CIF") or row.get("NumeroIVA") or "").strip()
    if not nif:
        raise MappingError(f"Cliente {row['EmpresaID']}: falta identificación fiscal")
    if country != "ES" or row.get("IVAClase") or row.get("ReglaIVA") or row.get("Extrajero"):
        raise MappingError(
            f"Cliente {row['EmpresaID']}: perfil fiscal especial necesita mapeo verificado antes de publicar"
        )
    if row.get("DescuentoExtra") or row.get("DescuentoSerie"):
        raise MappingError(f"Cliente {row['EmpresaID']}: descuentos especiales necesitan mapeo explícito")
    return {
        "name": row.get("NombreES") or row.get("NombreCN") or str(row["EmpresaID"]),
        "tradeName": None,
        "idType": ("nie" if nif[:1].upper() in "XYZ" else "nif" if nif[:1].isdigit() else "cif")
        if country == "ES"
        else "foreign_tax_id",
        "idNumber": nif,
        "countryCode": country,
        "preferredLanguage": "es",
        "defaultLineDiscountBps": scaled(row.get("Descuento"), 100),
        "creditLimitCents": scaled(row["MaxSobregiro"], 100) if row.get("MaxSobregiro") else None,
        "active": not bool(row.get("Bloqueado")),
        "notes": row.get("Observacion") or None,
        "addresses": (
            [
                {
                    "kind": "delivery",
                    "label": "Principal",
                    "line1": row["Domicilio"],
                    "line2": None,
                    "postalCode": row.get("CodigoPostal") or None,
                    "city": row.get("Poblacion") or None,
                    "province": row.get("Provincia") or None,
                    "countryCode": country,
                }
            ]
            if row.get("Domicilio")
            else []
        ),
        "contacts": (
            [
                {
                    "name": row.get("PersonaContacto") or "Contacto",
                    "role": None,
                    "phone": row.get("Telefono") or None,
                    "email": row.get("Email") or None,
                }
            ]
            if row.get("Telefono") or row.get("Email") or row.get("PersonaContacto")
            else []
        ),
    }


def native_order_amounts(order, rates):
    """Net-only B2B terms, with tax rates owned by Bohao; never change agreed prices."""
    groups = {}
    global_discount = whole(order.get("orderDiscountBps", 0), "Descuento global")
    if not 0 <= global_discount <= 10000:
        raise MappingError("Descuento global fuera de rango")
    for line, rate in zip(order["lines"], rates, strict=True):
        discount = whole(line["lineDiscountBps"], "Descuento de línea")
        if not 0 <= discount <= 10000:
            raise MappingError("Descuento de línea fuera de rango")
        net = scaled(
            Decimal(line["quantity"])
            * Decimal(line["unitPrice"])
            * (10000 - discount)
            * (10000 - global_discount),
            Decimal(1) / Decimal(100 * 10000 * 10000),
        )
        if line.get("netCents", net) != net:
            raise MappingError("Importe de línea B2B no coincide con sus términos congelados")
        groups[rate] = groups.get(rate, 0) + net
    net_total = sum(groups.values())
    if order["amounts"]["netCents"] != net_total:
        raise MappingError("Total neto B2B no coincide con sus líneas")
    tax_groups = [
        {
            "impuesto": "IVA",
            "rateBps": scaled(rate, 100),
            "recargoBps": 0,
            "baseCents": net,
            "taxCents": scaled(Decimal(net) * rate / 100, 1),
            "recargoCents": 0,
        }
        for rate, net in sorted(groups.items())
    ]
    return {
        "netCents": net_total,
        "totalCents": net_total + sum(g["taxCents"] for g in tax_groups),
        "taxGroups": tax_groups,
    }


def catalogue_source(bohao, settings, article, category):
    """One source fingerprint shared by bulk export and ongoing synchronization."""
    if article.get("UsarPrecioPorCantidad") or article.get("UsarDescuentoPorCantidad"):
        raise MappingError(f"Artículo {article['ArticuloID']}: reglas de cantidad requieren mapeo explícito")
    options, combinations = bohao.variants(article)
    factor = whole(article.get("CantidadPorUnidad") or 1, "Factor de venta")
    if factor < 1:
        raise MappingError("Factor de venta debe ser positivo")
    tax_class = category.get("bohaoTaxClass")
    if not tax_class:
        raise MappingError(f"Artículo {article['ArticuloID']}: IVA de su categoría no compatible")
    settings = settings.model_copy(update={"tax_class": tax_class})
    raw_codes = []
    if not options:
        raw_codes = [article.get("CodigoBarra", "")] + [
            r["CodigoBarra"]
            for r in bohao.query(
                "SELECT CodigoBarra FROM articulocodigobarra WHERE ArticuloID=%s", (article["ArticuloID"],)
            )
        ]
    codes = [{"code": code, "kind": "internal"} for code in sorted(code for code in set(raw_codes) if code)]
    owned = {
        "categoryId": category["id"],
        "categoryActive": category.get("bohaoActive", True),
        "priceColumn": settings.price_column,
        "priceRule": "unchanged",
        "taxClass": tax_class,
        "article": {k: v for k, v in article.items() if k not in ("OrdenNo", "OrdenNoFinal")},
        "options": options,
        "barcodes": codes,
    }
    return settings, options, combinations, factor, codes, owned


def base_price(article, settings):
    """The Bohao amount unchanged: synchronization never adds or removes taxes."""
    return Decimal(str(article[settings.price_column]))
