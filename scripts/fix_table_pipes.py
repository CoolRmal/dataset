#!/usr/bin/env python3
"""Escape literal `|` inside criteria-table cells.

A bare `|` in a GitHub-flavoured Markdown table cell splits the row, so
absolute values, set-builders and Lean `|` all corrupt the rendering. Inside
code spans the GFM escape `\\|` is right; inside `$…$` it is not, because
LaTeX reads `\\|` as ‖ — there we use `\\lvert`/`\\rvert` for a matched pair
and `\\mid` for a lone separator.
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def fix_math(seg: str) -> str:
    """Rewrite bare pipes inside a `$…$` span.

    An already-escaped `\\|` is LaTeX's ‖ and is left alone; it is also a valid
    GFM pipe escape, so it does not split the row.
    """
    # Matched pair around a short body: absolute value / cardinality / measure.
    seg = re.sub(r"(?<!\\)\|([^|$]{1,60}?)(?<!\\)\|", r"\\lvert \1\\rvert ", seg)
    # Anything left is a separator (set-builder, conditional probability).
    seg = re.sub(r"(?<!\\)\|", r"\\mid ", seg)
    return re.sub(r" {2,}", " ", seg)


def fix_line(line: str) -> str:
    """Escape content pipes in one table row, leaving the 5 delimiters alone."""
    out: list[str] = []
    i = 0
    n = len(line)
    while i < n:
        ch = line[i]
        if ch == "`":  # code span: GFM escape is correct here
            j = line.find("`", i + 1)
            if j == -1:
                out.append(line[i:])
                break
            span = line[i + 1 : j]
            out.append("`" + span.replace("\\|", "|").replace("|", "\\|") + "`")
            i = j + 1
        elif ch == "$":  # math span: LaTeX-level rewrite
            close = line.find("$", i + 1)
            if close == -1:
                out.append(line[i:])
                break
            out.append("$" + fix_math(line[i + 1 : close]) + "$")
            i = close + 1
        else:
            out.append(ch)
            i += 1
    return "".join(out)


def unescaped(line: str) -> int:
    return len(re.findall(r"(?<!\\)\|", line))


SEPARATOR = re.compile(r"^\|(?:\s*:?-{3,}:?\s*\|)+$")


def main() -> None:
    paths = sorted(ROOT.glob("Dataset/*/*.criteria.md"))
    fixed_rows = fixed_files = 0
    still_bad: list[str] = []
    for path in paths:
        lines = path.read_text(encoding="utf-8").splitlines()
        changed = False
        # A file may hold several tables with different widths; the `|---|---|`
        # separator under each header fixes that table's delimiter count.
        width = 0
        for idx, line in enumerate(lines):
            if SEPARATOR.match(line):
                width = unescaped(line)
                continue
            if not line.startswith("| ") or not width or unescaped(line) == width:
                continue
            new = fix_line(line)
            if new != line:
                lines[idx] = new
                changed = True
                fixed_rows += 1
            if unescaped(lines[idx]) != width:
                still_bad.append(f"{path.relative_to(ROOT)}:{idx + 1}")
        if changed:
            path.write_text("\n".join(lines) + "\n", encoding="utf-8")
            fixed_files += 1
    print(f"rewrote {fixed_rows} rows in {fixed_files} files")
    if still_bad:
        print("STILL MALFORMED:", *still_bad, sep="\n  ")
        sys.exit(1)


if __name__ == "__main__":
    main()
