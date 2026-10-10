"""Inspect the configured native schema without displaying credentials or customer rows."""

import argparse
import json
from pathlib import Path

from bridge.bohao import Bohao
from bridge.config import ConfigStore


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--data-dir", required=True)
    args = parser.parse_args()
    print(json.dumps(Bohao(ConfigStore(Path(args.data_dir)).load()).inspect(), ensure_ascii=False))


if __name__ == "__main__":
    main()
