#!/usr/bin/env python3
"""Ensure Slides_abidjan_2026/Images points at repo Images/ (for file:// and local render)."""
from __future__ import annotations

import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
LINK = ROOT / "Images"
TARGET = (ROOT / ".." / "Images").resolve()


def main() -> None:
    if LINK.exists():
        return
    if not TARGET.is_dir():
        print(f"Missing image source: {TARGET}", file=sys.stderr)
        sys.exit(1)
    if sys.platform == "win32":
        subprocess.run(
            ["cmd", "/c", "mklink", "/J", str(LINK), str(TARGET)],
            check=True,
        )
    else:
        LINK.symlink_to(TARGET, target_is_directory=True)
    print(f"Linked {LINK} -> {TARGET}")


if __name__ == "__main__":
    main()
