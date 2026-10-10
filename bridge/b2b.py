import ssl
import time
from urllib.parse import quote, urlsplit

import httpx


class APIError(RuntimeError):
    def __init__(self, status, code, detail=None):
        self.status, self.code, self.detail = status, code, detail or {}
        super().__init__(f"B2B: {code} (HTTP {status})")


class LocalTransport(httpx.HTTPTransport):
    """Windows DNS need not resolve development .localhost names; preserve Host and TLS SNI."""

    def handle_request(self, request):
        local = httpx.Request(
            request.method,
            request.url.copy_with(host="127.0.0.1"),
            headers=request.headers,
            stream=request.stream,
            extensions=request.extensions | {"sni_hostname": request.url.host},
        )
        return super().handle_request(local)


class B2B:
    def __init__(self, settings, transport=None):
        verify = True
        if settings.local_ca_file:
            verify = ssl.create_default_context(cafile=settings.local_ca_file)
        if transport is None and (urlsplit(settings.b2b_url).hostname or "").endswith(".localhost"):
            transport = LocalTransport(verify=verify)
        self.next_request = 0.0
        self.client = httpx.Client(
            base_url=settings.b2b_url
            + "/api/v1/organizations/"
            + quote(settings.organization_id, safe="")
            + "/",
            headers={"Authorization": "Bearer " + settings.api_key},
            timeout=30,
            follow_redirects=False,
            transport=transport,
            verify=verify,
        )

    def close(self):
        self.client.close()

    def pace(self):
        # Leave headroom below the server's 300 requests/minute per key.
        delay = self.next_request - time.monotonic()
        if delay > 0:
            time.sleep(delay)
        self.next_request = time.monotonic() + 0.25

    def upload_image(self, path, data, key, content_type):
        self.pace()
        try:
            response = self.client.post(
                path,
                data={"idempotencyKey": key},
                files={
                    "file": ("bohao.png" if content_type == "image/png" else "bohao.jpg", data, content_type)
                },
            )
        except httpx.HTTPError as error:
            raise APIError(0, "CONNECTION_FAILED") from error
        if response.is_error:
            try:
                content = response.json()
            except ValueError:
                content = {}
            raise APIError(response.status_code, content.get("code", "IMAGE_FAILED"), content.get("data"))
        if response.is_redirect:
            raise APIError(response.status_code, "UNEXPECTED_REDIRECT")
        return response.json()

    def call(self, method, path, payload=None, params=None):
        self.pace()
        try:
            response = self.client.request(method, path.lstrip("/"), json=payload, params=params)
        except httpx.HTTPError as error:
            raise APIError(0, "CONNECTION_FAILED") from error
        if response.is_error:
            try:
                data = response.json()
            except ValueError:
                data = {}
            raise APIError(response.status_code, data.get("code", "REQUEST_FAILED"), data.get("data"))
        if response.is_redirect:
            raise APIError(response.status_code, "UNEXPECTED_REDIRECT")
        return response.json()

    def require_stock_batch(self):
        path = self.client.base_url.copy_with(path="/api/v1/reference/openapi.json")
        spec = self.call("GET", str(path))
        if "/organizations/{organizationId}/stock/external-snapshots" not in spec.get("paths", {}):
            raise APIError(409, "STOCK_BATCH_API_REQUIRED")

    def pages(self, path, params=None):
        query = dict(params or {})
        while True:
            page = self.call("GET", path, params=query)
            yield from page["items"]
            if not page.get("nextCursor"):
                return
            query["cursor"] = page["nextCursor"]

    def upsert(self, path, payload, version=None):
        body = dict(payload)
        if version is not None:
            body["version"] = version
        try:
            return self.call("PUT", path, body)
        except APIError as error:
            if error.code == "CONFLICT" and error.detail.get("currentVersion") is not None:
                # An upsert can retry only fields owned by Bohao. The engine refreshes preserved fields.
                raise
            raise
