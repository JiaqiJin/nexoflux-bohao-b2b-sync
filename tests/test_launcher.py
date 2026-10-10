import webbrowser
from http.server import BaseHTTPRequestHandler, HTTPServer
from threading import Thread

from bridge.__main__ import open_console_when_ready


def test_console_opens_only_after_local_server_is_ready(monkeypatch):
    class ReadyHandler(BaseHTTPRequestHandler):
        def do_GET(self):
            self.send_response(200)
            self.end_headers()

        def log_message(self, *_args):
            pass

    server = HTTPServer(("127.0.0.1", 0), ReadyHandler)
    thread = Thread(target=server.serve_forever, daemon=True)
    opened = []
    thread.start()
    monkeypatch.setattr(webbrowser, "open", opened.append)
    try:
        url = f"http://127.0.0.1:{server.server_port}"
        open_console_when_ready(url)
        assert opened == [url]
    finally:
        server.shutdown()
        thread.join(timeout=2)
        server.server_close()
