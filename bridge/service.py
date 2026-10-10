"""Windows Service host for the packaged application."""

import os
from pathlib import Path

import servicemanager
import uvicorn
import win32service
import win32serviceutil

from .app import create_app


class BridgeService(win32serviceutil.ServiceFramework):
    _svc_name_ = "NexofluxBohaoSync"
    _svc_display_name_ = "Nexoflux Bohao Sync"
    _svc_description_ = "Sincronización local Bohao y Nexoflux B2B con consola en localhost:8765."

    def SvcStop(self):
        self.ReportServiceStatus(win32service.SERVICE_STOP_PENDING)
        if hasattr(self, "server"):
            self.server.should_exit = True

    def SvcDoRun(self):
        servicemanager.LogInfoMsg("Nexoflux Bohao Sync iniciado")
        self.server = uvicorn.Server(
            uvicorn.Config(
                create_app(directory=Path(os.environ["PROGRAMDATA"]) / "NexofluxBohaoSync"),
                host="127.0.0.1",
                port=8765,
                access_log=False,
                log_config=None,
            )
        )
        self.server.run()


def command():
    import sys

    if len(sys.argv) == 1:
        servicemanager.Initialize()
        servicemanager.PrepareToHostSingle(BridgeService)
        servicemanager.StartServiceCtrlDispatcher()
    else:
        win32serviceutil.HandleCommandLine(BridgeService)
