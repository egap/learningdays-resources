#!/usr/bin/env python3
"""Emit an HTML table from the first four columns of schedule.xlsx (stdout)."""
from __future__ import annotations

import html
import sys
from datetime import date, datetime, time
from pathlib import Path

import openpyxl


def fmt(value) -> str:
    if value is None:
        return ""
    if isinstance(value, datetime):
        return value.strftime("%Y-%m-%d %H:%M")
    if isinstance(value, time):
        return value.strftime("%H:%M")
    if isinstance(value, date):
        return value.isoformat()
    return str(value).strip()


def main() -> None:
    path = Path(sys.argv[1] if len(sys.argv) > 1 else "../schedule.xlsx")
    wb = openpyxl.load_workbook(path, read_only=True, data_only=True)
    rows = list(wb.active.iter_rows(values_only=True))
    if not rows:
        return

    header = [fmt(c) for c in rows[0][:4]]
    print('<table class="schedule-table">')
    print("<thead><tr>" + "".join(f"<th>{html.escape(c)}</th>" for c in header) + "</tr></thead>")
    print("<tbody>")
    for row in rows[1:]:
        cells = [fmt(c) for c in (list(row[:4]) + [None] * 4)[:4]]
        print("<tr>" + "".join(f"<td>{html.escape(c)}</td>" for c in cells) + "</tr>")
    print("</tbody></table>")


if __name__ == "__main__":
    main()
