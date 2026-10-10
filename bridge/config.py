import json
import os
import threading
import uuid
from pathlib import Path
from urllib.parse import urlsplit

from pydantic import BaseModel, Field, field_validator

DEFAULT_MYSQL_USER = "bohaomarketodbc"
DEFAULT_MYSQL_PASSWORD = "bohaomarketodbc"


def data_directory() -> Path:
    return Path(
        os.environ.get(
            "BOHAO_SYNC_DATA", str(Path(os.environ.get("LOCALAPPDATA", ".")) / "NexofluxBohaoSync")
        )
    )


class Settings(BaseModel):
    installation_id: str = Field(default_factory=lambda: uuid.uuid4().hex[:12])
    mysql_host: str = "127.0.0.1"
    mysql_port: int = Field(default=3306, ge=1, le=65535)
    mysql_database: str = "bohaosupermarket3"
    mysql_user: str = DEFAULT_MYSQL_USER
    mysql_password: str = DEFAULT_MYSQL_PASSWORD
    b2b_url: str = ""
    local_ca_file: str = ""
    organization_id: str = ""
    api_key: str = ""
    warehouse_ids: list[int] = Field(default_factory=lambda: [1], min_length=1)
    price_column: str = "PrecioMayor"
    tax_class: str = "standard"
    safety_stock: int = Field(default=0, ge=0, le=10_000_000)
    interval_seconds: int = Field(default=60, ge=30, le=3600)
    enabled: bool = False
    dispatch_origin_types: list[str] = Field(default_factory=lambda: ["PedidoCliente", "pedidocliente"])
    article_ids: list[str] = Field(default_factory=list)

    @field_validator("mysql_database", "installation_id")
    @classmethod
    def identifier(cls, value):
        if not value or not all(c.isalnum() or c == "_" for c in value):
            raise ValueError("Identificador inválido")
        return value

    @field_validator("b2b_url")
    @classmethod
    def url(cls, value):
        if not value:
            return value
        parsed = urlsplit(value)
        local = parsed.hostname in ("localhost", "127.0.0.1") or (parsed.hostname or "").endswith(
            ".localhost"
        )
        if (
            (parsed.scheme != "https" and not (parsed.scheme == "http" and local))
            or not parsed.hostname
            or parsed.username
            or parsed.password
            or parsed.query
            or parsed.fragment
        ):
            raise ValueError("Usa HTTPS, o HTTP en localhost para desarrollo")
        return value.rstrip("/")

    @field_validator("price_column")
    @classmethod
    def price(cls, value):
        if value not in {
            "PrecioMayor",
            "PrecioDetalle",
            "PrecioInternet",
            "PrecioSocio",
            "PrecioEspecial",
            "PrecioAmigo",
            "PrecioDomicilio",
            "PrecioOferta",
        }:
            raise ValueError("Tarifa no publicable")
        return value

    @field_validator("tax_class")
    @classmethod
    def tax(cls, value):
        if value not in {"standard", "reduced", "super_reduced", "exempt"}:
            raise ValueError("Clase de impuesto inválida")
        return value


class ConfigStore:
    def __init__(self, directory: Path):
        self.directory = directory
        self.lock = threading.RLock()
        directory.mkdir(parents=True, exist_ok=True)
        self.path = directory / "config.json"
        self.secrets_path = directory / "secrets.json"
        if not self.path.exists():
            self.save(Settings())

    def load(self) -> Settings:
        with self.lock:
            return self._load()

    def _load(self) -> Settings:
        content = json.loads(self.path.read_text(encoding="utf-8"))
        secrets = content.pop("_secrets", None)
        if secrets is None and self.secrets_path.exists():
            secrets = json.loads(self.secrets_path.read_text(encoding="utf-8"))
        if secrets is not None:
            for key, value in secrets.items():
                content[key] = self._unprotect(value)
        # Older installations may have been created before the Bohao ODBC
        # account was identified. Fill its default pair when the user is blank.
        if not content.get("mysql_user"):
            content["mysql_user"] = DEFAULT_MYSQL_USER
            content["mysql_password"] = DEFAULT_MYSQL_PASSWORD
        elif not content.get("mysql_password"):
            content["mysql_password"] = DEFAULT_MYSQL_PASSWORD
        return Settings(**content)

    def save(self, settings: Settings):
        with self.lock:
            self._save(settings)

    def _save(self, settings: Settings):
        content = settings.model_dump()
        secrets = {key: self._protect(content.pop(key)) for key in ("mysql_password", "api_key")}
        content["_secrets"] = secrets
        temporary = self.path.with_suffix(".tmp")
        temporary.write_text(json.dumps(content, ensure_ascii=False, indent=2), encoding="utf-8")
        self._restrict(temporary)
        temporary.replace(self.path)

    @staticmethod
    def _restrict(path):
        import win32api
        import win32con
        import win32security

        with_token = win32security.OpenProcessToken(win32api.GetCurrentProcess(), win32con.TOKEN_QUERY)
        try:
            current = win32security.GetTokenInformation(with_token, win32security.TokenUser)[0]
        finally:
            with_token.Close()
        acl = win32security.ACL()
        for sid in (
            current,
            win32security.CreateWellKnownSid(win32security.WinLocalSystemSid),
            win32security.CreateWellKnownSid(win32security.WinBuiltinAdministratorsSid),
        ):
            acl.AddAccessAllowedAce(win32security.ACL_REVISION, win32con.GENERIC_ALL, sid)
        win32security.SetNamedSecurityInfo(
            str(path),
            win32security.SE_FILE_OBJECT,
            win32security.DACL_SECURITY_INFORMATION | win32security.PROTECTED_DACL_SECURITY_INFORMATION,
            None,
            None,
            acl,
            None,
        )

    @staticmethod
    def _protect(value):
        if os.name != "nt":
            raise RuntimeError("El almacenamiento de credenciales requiere Windows DPAPI")
        import win32crypt

        # Machine scope permits the installed service and local console to share credentials.
        return win32crypt.CryptProtectData(value.encode(), "NexofluxBohaoSync", None, None, None, 4).hex()

    @staticmethod
    def _unprotect(value):
        import win32crypt

        return win32crypt.CryptUnprotectData(bytes.fromhex(value), None, None, None, 0)[1].decode()

    def public(self):
        settings = self.load().model_dump()
        for key in ("mysql_password", "api_key"):
            settings[f"has_{key}"] = bool(settings.pop(key))
        return settings
