#!/usr/bin/env python3
"""
Convert a two-column bilingual .Rmd deck to a Santiago .qmd skeleton.

Santiago convention: Spanish is the primary (LEFT) column, English secondary
(RIGHT); the emitted shorthand is `::: es` then `::: en`, which
assets/santiago-bilingual.lua pairs into columns. If your source deck has the
columns the other way around (e.g. the EN|FR decks in
../Slides_bilingual_fr_en/, where English is on the left), swap the emitted
group order below or swap the columns in the source first.

Usage (from this folder):
  python3 scripts/convert_bilingual_rmd.py ../Slides_esp/foo-slides.Rmd foo.qmd

Post-convert: strip any remaining <!-- comments -->, make slide titles use
"Titulo en espanol | *English title*", and add a ROUTING.md table row.
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

SANTIAGO = Path(__file__).resolve().parents[1]
ROOT = SANTIAGO.parent

YAML_TAIL = """---
title: "{title}"
author: "{author}"
date: {date}
bibliography: assets/learningdays-book.bib
format:
  revealjs:
    embed-resources: true
---

"""

_COL_TRIPLET = (
    r"::: \{\.col data-latex=\"\{0\.(?:48|5)\\textwidth\}\"\}\s*"
    r"(.*?)"
    r":::\s*"
    r"::: \{\.col data-latex=\"\{0\.04\\textwidth\}\"\}\s*"
    r"(?:.*?)\s*"
    r":::\s*"
    r"::: \{\.col data-latex=\"\{0\.(?:48|5)\\textwidth\}\"\}\s*"
    r"(.*?)"
    r":::\s*"
)

COL_WRAPPED_PATTERN = re.compile(
    r":+\s*\{\.cols data-latex=\"\"\}\s*" + _COL_TRIPLET + r":+\s*",
    re.DOTALL,
)

COL_BARE_PATTERN = re.compile(_COL_TRIPLET, re.DOTALL)


def replace_cols(m: re.Match) -> str:
    # First captured column = Spanish (Santiago primary), second = English.
    es, en = m.group(1).strip(), m.group(2).strip()
    return (
        "::: es\n\n"
        f"{es}\n\n"
        ":::\n"
        "::: en\n\n"
        f"{en}\n\n"
        ":::\n\n"
    )


def convert_all_cols(body: str) -> str:
    for pattern in (COL_WRAPPED_PATTERN, COL_BARE_PATTERN):
        while True:
            body, n = pattern.subn(replace_cols, body)
            if n == 0:
                break
    return body


def parse_yaml_field(text: str, key: str) -> str:
    m = re.search(rf"^{key}:\s*\"(.+)\"\s*$", text, re.MULTILINE)
    return m.group(1) if m else ""


def convert_body(text: str) -> str:
    body = re.sub(r"^---.*?^---\s*", "", text, count=1, flags=re.DOTALL | re.MULTILINE)
    body = re.sub(r"^```\{r setup.*?\n```\s*", "", body, count=1, flags=re.DOTALL)
    body = convert_all_cols(body)
    body = body.replace("![](bullseye.pdf)", "![](Images/bullseye.png){fig-align=\"center\"}")
    body = re.sub(r"!\[\]\((\.\./)?Images/", r"![](Images/", body)
    body = body.replace(r"\medskip", "")
    body = body.replace(r"\bigskip", "\n\n")
    body = re.sub(r"\\centering\s*\n", "::: {.center}\n\n", body)
    body = re.sub(r"\\footnotesize\s*\n", "::: {.footnote}\n\n", body)
    body = re.sub(r"\\url\{([^}]+)\}", r"<\1>", body)
    body = re.sub(r"^(\s*#{1,2} .+?)\\\|", r"\1|", body, flags=re.MULTILINE)
    body = re.sub(
        r"(::: \{\.footnote\}\n\n)(.*?)(\n+## )",
        lambda m: m.group(1) + m.group(2).rstrip() + "\n\n:::\n\n" + m.group(3),
        body,
        flags=re.DOTALL,
    )
    body = strip_html_comments(body)
    body = close_center_divs(body)
    body = re.sub(
        r"::: \{\.center\}\s*\n+((?:!\[[^\]]*\]\([^)]+\)(?:\{[^}]+\})?\s*)+)\n+:::",
        r"\1",
        body,
        flags=re.MULTILINE,
    )
    body = re.sub(
        r'(\!\[[^\]]*\]\([^)]+\))\{width="(\d+)"\}',
        r'\1{width="\2px" fig-align="center"}',
        body,
    )
    return body


def strip_html_comments(text: str) -> str:
    return re.sub(r"<!--.*?-->\s*", "", text, flags=re.DOTALL)


def close_center_divs(text: str) -> str:
    lines = text.split("\n")
    out: list[str] = []
    in_center = False
    for line in lines:
        if line.strip() == "::: {.center}":
            in_center = True
        elif in_center and (
            re.match(r"^#{1,2} ", line)
            or (line.strip().startswith(":::") and "center" not in line)
        ):
            out.append(":::")
            in_center = False
        out.append(line)
    if in_center:
        out.append(":::")
    return "\n".join(out)


def main() -> None:
    if len(sys.argv) != 3:
        print(__doc__)
        sys.exit(1)
    src = Path(sys.argv[1])
    if not src.is_absolute():
        src = (Path.cwd() / src).resolve()
    out = SANTIAGO / sys.argv[2]
    text = src.read_text(encoding="utf-8")
    title = parse_yaml_field(text, "title") or "Slides"
    author = parse_yaml_field(text, "author") or ""
    raw_date = parse_yaml_field(text, "date")
    date_yaml = raw_date if raw_date else "today"
    if date_yaml not in ("today", "now") and not date_yaml.startswith('"'):
        date_yaml = f'"{date_yaml}"'
    body = convert_body(text)
    out.write_text(
        YAML_TAIL.format(title=title, author=author, date=date_yaml) + body,
        encoding="utf-8",
    )
    print(f"Wrote {out}")


if __name__ == "__main__":
    main()
