import argparse
import hashlib
import os
import sys
import threading
import time
import urllib.request
import webbrowser

import uvicorn


def open_console_when_ready(url):
    deadline = time.monotonic() + 30
    while time.monotonic() < deadline:
        try:
            with urllib.request.urlopen(url + "/api/status", timeout=1):
                webbrowser.open(url)
                return
        except OSError:
            time.sleep(0.25)


def main():
    if "--service" in sys.argv:
        sys.argv.remove("--service")
        from .service import command

        command()
        return
    parser = argparse.ArgumentParser(description="Nexoflux Bohao Sync")
    parser.add_argument("--port", type=int, default=8765)
    parser.add_argument("--data-dir")
    parser.add_argument("--open", action="store_true", help="Abrir consola local")
    args = parser.parse_args()
    if args.data_dir:
        os.environ["BOHAO_SYNC_DATA"] = args.data_dir
    import win32api
    import win32event

    from .app import create_app
    from .config import data_directory

    mutex = win32event.CreateMutex(
        None,
        False,
        "Local\\NexofluxBohaoSync_"
        + hashlib.sha256(str(data_directory().resolve()).casefold().encode()).hexdigest(),
    )
    if win32api.GetLastError() == 183:
        if args.open:
            webbrowser.open(f"http://127.0.0.1:{args.port}")
        return

    if args.open:
        url = f"http://127.0.0.1:{args.port}"
        threading.Thread(target=open_console_when_ready, args=(url,), daemon=True).start()
    app = create_app()
    server = uvicorn.Server(
        uvicorn.Config(app, host="127.0.0.1", port=args.port, access_log=False, log_config=None)
    )
    app.state.request_shutdown = lambda: setattr(server, "should_exit", True)
    server.run()
    mutex.Close()


if __name__ == "__main__":
    main()
