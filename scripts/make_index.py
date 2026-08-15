#!/usr/bin/env python3
"""Generate `data/records.jsonl`: one JSON record per problem (LeanCat-style index).

Each record carries the problem id, book, domain, declaration name, file paths
(Lean statement, natural-language Markdown, criteria rubric, minimal context, shared
Defs), the
natural-language statement text, and the extracted Lean formalization
(shared definitions followed by the theorem statement).
"""
from __future__ import annotations

import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

import make_benchmark_pdfs as bench

ROOT = bench.ROOT

BOOKS = [
    ("Bogachev Measure Theory", bench.BOGACHEV),
    ("Bogachev Gaussian Measures", bench.BOGACHEV_GAUSSIAN),
    ("Conway Functional Analysis", bench.CONWAY),
    ("Engelking General Topology", bench.ENGELKING_TOPOLOGY),
    ("Folland Abstract Harmonic Analysis", bench.FOLLAND_HARMONIC),
    ("Grafakos Classical Fourier Analysis", bench.GRAFAKOS_FOURIER),
    ("Hayman Meromorphic Functions", bench.HAYMAN_MEROMORPHIC),
    ("Kallenberg Foundations of Modern Probability", bench.KALLENBERG),
    ("Kong ODE", bench.KONG_ODE),
    ("Krylov Holder PDE", bench.KRYLOV_HOLDER),
    ("Krylov Sobolev PDE", bench.KRYLOV_SOBOLEV),
    ("Lee Smooth Manifolds", bench.LEE_SMOOTH),
    ("Mattila Geometry of Sets and Measures", bench.MATTILA_GEOMETRY),
    ("Niven Irrational", bench.NIVEN_IRRATIONAL),
    ("Niven Zuckerman Number Theory", bench.NIVEN_ZUCKERMAN),
    ("Nikolski Operators Functions Systems", bench.NIKOLSKI),
]


def record(title: str, entry: bench.Entry) -> dict:
    book = Path(entry.lean_file).stem
    book_dir = Path(entry.lean_file).with_suffix("")
    lean_path = book_dir / f"{entry.decl}.lean"
    md_path = book_dir / f"{entry.decl}.md"
    criteria_path = book_dir / f"{entry.decl}.criteria.md"
    context_path = book_dir / f"{entry.decl}.context.md"
    defs_path = book_dir / "Defs.lean"
    rec = {
        "id": f"{book}/{entry.decl}",
        "book": book,
        "book_title": title,
        "number": entry.number,
        "domain": entry.domain,
        "decl": entry.decl,
        "definitions": entry.definitions,
        "lean_file": str(lean_path),
        "statement_file": str(md_path),
        "criteria_file": str(criteria_path),
        "context_file": str(context_path),
        "defs_file": str(defs_path) if (ROOT / defs_path).exists() else None,
        "natural_language_statement": entry.statement,
        "lean_statement": bench.make_formalization(entry),
    }
    for key in ("lean_file", "statement_file", "criteria_file", "context_file"):
        if not (ROOT / rec[key]).exists():
            print(f"warning: missing {rec[key]}", file=sys.stderr)
    return rec


def main() -> None:
    out = ROOT / "data" / "records.jsonl"
    out.parent.mkdir(exist_ok=True)
    with out.open("w", encoding="utf-8") as fh:
        for title, entries in BOOKS:
            for entry in entries:
                fh.write(json.dumps(record(title, entry), ensure_ascii=False) + "\n")
    print(f"wrote {out}")


if __name__ == "__main__":
    main()
