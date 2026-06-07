"""Unwrap .center divs around figures and normalize Quarto image attributes."""
import re
import sys
from pathlib import Path

def fix(text: str) -> str:
    text = re.sub(
        r"::: \{\.center\}\s*\n+((?:!\[[^\]]*\]\([^)]+\)(?:\{[^}]+\})?\s*)+)\n+:::",
        r"\1",
        text,
        flags=re.MULTILINE,
    )
    text = re.sub(
        r'(\!\[[^\]]*\]\([^)]+\))\{width="(\d+)"\}',
        r'\1{width="\2px" fig-align="center"}',
        text,
    )
    return text

def main() -> None:
    path = Path(sys.argv[1]) if len(sys.argv) > 1 else Path(__file__).parents[1] / "1_causalinference-slides-en-fr.qmd"
    path.write_text(fix(path.read_text(encoding="utf-8")), encoding="utf-8")
    print(f"Fixed figures in {path}")

if __name__ == "__main__":
    main()
