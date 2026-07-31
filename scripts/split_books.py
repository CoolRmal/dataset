#!/usr/bin/env python3
"""Split each monolithic `Dataset/<Book>.lean` into per-problem modules.

Layout produced (mirroring the Bogachev exemplar):

    Dataset/<Book>.lean            import roll-up + module docstring
    Dataset/<Book>/Defs.lean       shared custom notions (if the book has any)
    Dataset/<Book>/<decl>.lean     one statement-only theorem per file

Declaration text is copied byte-for-byte; only headers are synthesized.
"""
from __future__ import annotations

import re
import sys
from dataclasses import dataclass
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

import make_benchmark_pdfs as bench

ROOT = bench.ROOT

BOOKS = {
    "Bogachev": bench.BOGACHEV,
    "ConwayFunctionalAnalysis": bench.CONWAY,
    "EngelkingGeneralTopology": bench.ENGELKING_TOPOLOGY,
    "GrafakosFourier": bench.GRAFAKOS_FOURIER,
    "KallenbergProbability": bench.KALLENBERG,
    "KongODE": bench.KONG_ODE,
    "KrylovHolder": bench.KRYLOV_HOLDER,
    "LeeSmoothManifolds": bench.LEE_SMOOTH,
    "MattilaGeometry": bench.MATTILA_GEOMETRY,
    "NikolskiOperators": bench.NIKOLSKI,
}

DECL_RE = re.compile(
    r"^(?:noncomputable\s+)?(?:private\s+)?"
    r"(def|theorem|lemma|structure|abbrev|class|inductive|instance)\s+([^\s({\[:]+)"
)


@dataclass
class Item:
    name: str
    kind: str
    text: str


@dataclass
class Book:
    name: str
    imports: list[str]
    docstring: str
    opens: list[str]
    namespaces: list[str]
    preamble: list[str]
    items: list[Item]


def parse(path: Path, book: str) -> Book:
    lines = path.read_text(encoding="utf-8").splitlines()
    imports: list[str] = []
    opens: list[str] = []
    namespaces: list[str] = []
    doc_lines: list[str] = []
    i = 0
    while i < len(lines):
        line = lines[i]
        if line.startswith("import ") or line.startswith("public import "):
            imports.append(line.split("import ", 1)[1].strip())
        elif line.startswith("/-!"):
            while i < len(lines):
                doc_lines.append(lines[i])
                if lines[i].rstrip().endswith("-/"):
                    break
                i += 1
        elif line.startswith("open "):
            opens.append(line)
        elif line.startswith("namespace "):
            namespaces.append(line.split(None, 1)[1].strip())
            if len(namespaces) >= 2:
                i += 1
                break
        i += 1

    end_idx = len(lines)
    for j in range(len(lines) - 1, -1, -1):
        if lines[j].startswith("end ") and lines[j].split(None, 1)[1].strip() in namespaces:
            end_idx = min(end_idx, j)
    body = lines[i:end_idx]

    starts: list[int] = []
    k = 0
    while k < len(body):
        line = body[k]
        if line.startswith("/--"):
            starts.append(k)
            while k < len(body) and not body[k].rstrip().endswith("-/"):
                k += 1
        elif DECL_RE.match(line) and (not starts or _closed(body, starts[-1], k)):
            starts.append(k)
        k += 1

    items: list[Item] = []
    for idx, start in enumerate(starts):
        stop = starts[idx + 1] if idx + 1 < len(starts) else len(body)
        chunk = body[start:stop]
        while chunk and not chunk[-1].strip():
            chunk.pop()
        name = kind = ""
        for line in chunk:
            m = DECL_RE.match(line)
            if m:
                kind, name = m.group(1), m.group(2)
                break
        if not name:
            raise SystemExit(f"{book}: cannot identify declaration near line {start}")
        items.append(Item(name=name, kind=kind, text="\n".join(chunk)))

    # Top-level commands sitting between the namespace lines and the first
    # declaration (`universe`, `variable`, `set_option`, …) scope over every
    # declaration, so each generated file needs them too.
    preamble = [l for l in body[: starts[0]] if l.strip()] if starts else []
    return Book(book, imports, "\n".join(doc_lines), opens, namespaces, preamble, items)


def _closed(body: list[str], start: int, here: int) -> bool:
    """True when the item beginning at `start` already contains its declaration line."""
    return any(DECL_RE.match(l) for l in body[start:here])


def header(book: Book, imports: list[str], doc: str) -> list[str]:
    out = ["module", ""]
    out += [f"public import {m}" for m in imports]
    # `@[expose] public section` reproduces the single-module visibility the
    # monolithic book files had: importers see both signatures and definition
    # bodies, which some declarations need in order to compile.
    out += ["", doc, "", "@[expose] public section", ""]
    out += book.opens + [""]
    out += [f"namespace {n}" for n in book.namespaces]
    if book.preamble:
        out += [""] + book.preamble
    return out


def footer(book: Book) -> list[str]:
    return [f"end {n}" for n in reversed(book.namespaces)]


def write(path: Path, lines: list[str]) -> None:
    path.write_text("\n".join(lines).rstrip("\n") + "\n", encoding="utf-8")


def split_book(name: str, entries: list[bench.Entry]) -> None:
    path = ROOT / f"Dataset/{name}.lean"
    book = parse(path, name)
    out_dir = ROOT / "Dataset" / name
    out_dir.mkdir(exist_ok=True)

    problems = {e.decl: e for e in entries}
    missing = problems.keys() - {it.name for it in book.items}
    if missing:
        raise SystemExit(f"{name}: entries reference unknown declarations {sorted(missing)}")

    defs = [it for it in book.items if it.name not in problems]
    thms = [it for it in book.items if it.name in problems]
    def_names = {it.name for it in defs}

    if defs:
        doc = (
            "/-!\n"
            f"# Shared definitions for the {name} problems\n\n"
            f"Custom notions used by the statement files in `Dataset/{name}/` that are\n"
            "not already supplied by Mathlib. Each problem file that needs them imports\n"
            "this module.\n"
            "-/"
        )
        lines = header(book, book.imports, doc)
        for it in defs:
            lines += ["", it.text]
        lines += [""] + footer(book)
        write(out_dir / "Defs.lean", lines)

    for it in thms:
        entry = problems[it.name]
        needs_defs = any(
            re.search(rf"(?<![\w.]){re.escape(d)}(?![\w])", it.text) for d in def_names
        )
        imports = ([f"Dataset.{name}.Defs"] if needs_defs else []) + book.imports
        doc = (
            "/-!\n"
            f"# {_title(entry)}\n\n"
            "Statement-only formalization; the proof is intentionally `sorry`.\n"
            f"Natural-language statement: `{it.name}.md`.\n"
            f"Quality rubric: `{it.name}.criteria.md`.\n"
            "-/"
        )
        lines = header(book, imports, doc) + ["", it.text, ""] + footer(book)
        write(out_dir / f"{it.name}.lean", lines)

    roll = ["module", ""]
    if defs:
        roll.append(f"public import Dataset.{name}.Defs")
    roll += [f"public import Dataset.{name}.{it.name}" for it in thms]
    roll += ["", _rollup_doc(book, defs)]
    write(ROOT / f"Dataset/{name}.lean", roll)
    print(f"{name}: {len(defs)} defs, {len(thms)} problems")


RESULT_KINDS = "Theorem|Corollary|Proposition|Lemma|Exercise"


def _title(entry: bench.Entry) -> str:
    """`decl` plus the textbook's result number.

    Prefer the number attached to the theorem itself: several statements open
    with an auxiliary *definition*, whose number is not the result's.
    """
    num = r"[A-Za-z0-9IVXLC]+(?:\.[A-Za-z0-9]+)+"
    m = re.search(rf"({num})\.?\s+(?:{RESULT_KINDS})\b", entry.statement)
    if not m:
        m = re.match(rf"\s*({num})\.?\s", entry.statement)
    return f"`{entry.decl}` — {m.group(1)}" if m else f"`{entry.decl}`"


def _rollup_doc(book: Book, defs: list[Item]) -> str:
    """The book's original module docstring, extended with a layout paragraph."""
    body = book.docstring.rstrip()
    body = body.removeprefix("/-!").removesuffix("-/").strip("\n")
    note = (
        f"Each problem lives in `Dataset/{book.name}/<declaration_name>.lean`,\n"
        f"accompanied by `<declaration_name>.md` (the natural-language statement from\n"
        f"the textbook) and `<declaration_name>.criteria.md` (a quality rubric for\n"
        f"judging formalizations of that statement)."
    )
    if defs:
        note += (
            f"\nCustom notions shared between problems are in"
            f" `Dataset/{book.name}/Defs.lean`."
        )
    return f"/-!\n{body}\n\n{note}\n-/"


def main() -> None:
    names = sys.argv[1:] or list(BOOKS)
    for name in names:
        split_book(name, BOOKS[name])


if __name__ == "__main__":
    main()
