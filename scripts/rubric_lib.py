"""Helpers for maintaining `<decl>.criteria.md` rubrics and `<decl>.context.md` files.

`add_grading(path, fatal, pitfalls)` appends (or replaces) the standard
`## Grading (out of 100)` section of a rubric.  The band table is shared across all
problems — the spec lives in `GRADING.md` — while the number of requirement rows, the
list of fatal requirements and the list of domain-specific pitfalls are per problem.
"""

from __future__ import annotations

import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent

BANDS = [
    ("A. Completeness", 50),
    ("B. Semantic fidelity", 20),
    ("C. Mathlib-concept correctness", 15),
    ("D. Non-degeneracy", 10),
    ("E. Hygiene", 5),
]


def count_requirement_rows(text: str) -> int:
    """Number of numbered rows in the 'What a correct formalization must contain' table."""
    sections = re.split(r"^## ", text, flags=re.M)
    for sec in sections[1:]:
        if sec.split("\n", 1)[0].strip() == "What a correct formalization must contain":
            return len([l for l in sec.split("\n") if re.match(r"^\|\s*\d+\s*\|", l)])
    raise ValueError("no requirement table")


def count_mistake_rows(text: str) -> int:
    sections = re.split(r"^## ", text, flags=re.M)
    for sec in sections[1:]:
        if sec.split("\n", 1)[0].strip() == "Mistakes to check for":
            return len([l for l in sec.split("\n") if re.match(r"^\|\s*\d+\s*\|", l)])
    raise ValueError("no mistake table")


def grading_section(decl: str, n_req: int, fatal: list[str], pitfalls: list[str]) -> str:
    per_row = 50 / n_req
    lines = [
        "## Grading (out of 100)",
        "",
        "Grade a candidate Lean statement of this problem against the textbook statement in",
        f"[{decl}.md]({decl}.md) and the background in [{decl}.context.md]({decl}.context.md),",
        "not against the ground-truth Lean file: a candidate spelled differently but",
        "mathematically equivalent to the text loses nothing. The scale is defined in",
        "[GRADING.md](../../GRADING.md); the numbers below are this problem's instance of it.",
        "",
        "| Band | Points | This problem |",
        "|---|---|---|",
        (
            f"| A. Completeness | 50 | The requirement table above has {n_req} rows, "
            f"so each row is worth {per_row:.1f} points: full credit if the candidate states it "
            "in any equivalent form, half for a harmless strengthening or weakening, none if it "
            "is absent. |"
        ),
        "| B. Semantic fidelity | 20 | Junk values, `ℝ` vs `ℝ≥0∞`, coercions, quantifier order, "
        "a.e. vs everywhere — see the pitfalls below. |",
        "| C. Mathlib-concept correctness | 15 | The Mathlib notion must mean the textbook notion, "
        "with the typeclass assumptions it needs. |",
        "| D. Non-degeneracy | 10 | Not vacuous, not trivial, not a strictly weaker theorem. |",
        "| E. Hygiene | 5 | No needless definitions, redundant conjuncts or unused hypotheses. |",
        "",
        "**Every row of the *Mistakes to check for* table above is a defect.** Charge each one to "
        "the band it belongs to and deduct there.",
        "",
        "### Fatal — any of these caps the total at 25",
        "",
    ]
    lines += [f"- {f}" for f in fatal]
    lines += [
        "",
        "### Domain-specific pitfalls for this problem",
        "",
    ]
    lines += [f"- {p}" for p in pitfalls]
    lines.append("")
    return "\n".join(lines)


def add_grading(decl_dir: str, decl: str, fatal: list[str], pitfalls: list[str]) -> None:
    path = ROOT / "Dataset" / decl_dir / decl / f"{decl}.criteria.md"
    text = path.read_text()
    n_req = count_requirement_rows(text)
    section = grading_section(decl, n_req, fatal, pitfalls)
    # Drop an existing grading section, then append a fresh one at the end.
    text = re.sub(r"\n## Grading \(out of 100\).*?(?=\n## |\Z)", "\n", text, flags=re.S)
    text = text.rstrip("\n") + "\n\n" + section
    path.write_text(text)


def write_context(decl_dir: str, decl: str, title: str, body: str) -> None:
    path = ROOT / "Dataset" / decl_dir / decl / f"{decl}.context.md"
    header = (
        f"# Context: {decl}\n\n"
        f"**Statement:** [{decl}.md]({decl}.md) · "
        f"**Criteria:** [{decl}.criteria.md]({decl}.criteria.md)\n\n"
        "Background needed to read the statement correctly. Natural language only: no Lean, "
        "and no hint at how to formalize it.\n\n"
    )
    path.write_text(header + f"## {title}\n\n" + body.strip() + "\n")
