#!/usr/bin/env python3
from __future__ import annotations

import re
import textwrap
import unicodedata
from dataclasses import dataclass
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]


@dataclass
class Entry:
    number: int
    statement: str
    domain: str
    lean_file: str
    decl: str
    definitions: list[str]


def extract_decl(path: Path, name: str) -> str:
    lines = path.read_text(encoding="utf-8").splitlines()
    pattern = re.compile(
        rf"^(?:noncomputable\s+)?(?:def|theorem|structure|abbrev|class|inductive)\s+{re.escape(name)}\b"
    )
    start = None
    for i, line in enumerate(lines):
        if pattern.search(line):
            start = i
            break
    if start is None:
        return f"-- declaration {name} not found"

    first = lines[start].lstrip()
    is_theorem = first.startswith("theorem ")
    out: list[str] = []
    for line in lines[start:]:
        out.append(line)
        if is_theorem:
            if line.strip() == "sorry":
                break
        elif len(out) > 1 and line.strip() == "":
            out.pop()
            break
    return "\n".join(out)


TRANSLATE = {
    "ℕ": "N",
    "ℤ": "Z",
    "ℝ": "R",
    "ℂ": "C",
    "∞": "inf",
    "⇒": " => ",
    "≲": " <= C * ",
    "≡": " == ",
    "∼": " ~ ",
    "≪": " << ",
    "−": "-",
    "→": "->",
    "↦": "=>",
    "∧": "/\\",
    "∨": "\\/",
    "¬": "not ",
    "↔": "<->",
    "∀": "forall",
    "∃": "exists",
    "≤": "<=",
    "≥": ">=",
    "≠": "!=",
    "∈": "in",
    "⊆": "subset",
    "⊂": "subset",
    "⊊": "proper_subset",
    "⊃": "superset",
    "⊇": "superset",
    "⊤": "top",
    "⊥": "bot",
    "∩": "inter",
    "∪": "union",
    "⋂": "intersection",
    "⋃": "union",
    "×": " x ",
    "‖": "||",
    "∥": "||",
    "•": " * ",
    "⊗": " tensor ",
    "∂": "d",
    "∫": "integral",
    "∏": "prod",
    "Σ": "sum",
    "ᵐ": "^m",
    "₀": "0",
    "₁": "1",
    "₂": "2",
    "₃": "3",
    "₄": "4",
    "₅": "5",
    "₆": "6",
    "₇": "7",
    "₈": "8",
    "₉": "9",
    "⁻": "^-",
    "⁺": "^+",
    "θ": "theta",
    "Θ": "Theta",
    "φ": "phi",
    "ψ": "psi",
    "ζ": "zeta",
    "μ": "mu",
    "ν": "nu",
    "λ": "lambda",
    "ω": "omega",
    "Ω": "Omega",
    "Λ": "Lambda",
    "Γ": "Gamma",
    "π": "pi",
    "σ": "sigma",
    "τ": "tau",
    "ε": "eps",
    "δ": "delta",
    "Δ": "Delta",
    "α": "alpha",
    "β": "beta",
    "η": "eta",
    "ι": "iota",
    "ξ": "xi",
    "Ξ": "Xi",
    "κ": "kappa",
    "Ξ": "Xi",
    "κ": "kappa",
    "ρ": "rho",
    "⟂": "perp",
    "∘": "comp",
    "·": ".",
    "⟨": "<",
    "⟩": ">",
    "₊": "+",
    "₋": "-",
    "ᵢ": "i",
    "ₗ": "l",
    "ₘ": "m",
    "ᵥ": "v",
    "𝕜": "k",
    "𝓝": "nhds",
    "↑": "coe",
    "∑": "sum",
    "≃": "equiv",
    "∉": "notin",
    "∅": "empty",
    "ᶜ": "^c",
    "¹": "1",
    "²": "2",
    "ⁿ": "n",
    "ᵖ": "p",
    "ᵃ": "a",
    "ᵉ": "e",
    "ᵗ": "t",
    "ₙ": "n",
    "ᵣ": "r",
    "ₛ": "s",
    "ᵢ": "i",
    "–": "-",
    "—": "-",
    "’": "'",
    "“": '"',
    "”": '"',
}


def ascii_text(s: str) -> str:
    for src, dst in TRANSLATE.items():
        s = s.replace(src, dst)
    s = unicodedata.normalize("NFKD", s).encode("ascii", "ignore").decode("ascii")
    return s


def pdf_escape(s: str) -> str:
    s = ascii_text(s)
    return s.replace("\\", "\\\\").replace("(", "\\(").replace(")", "\\)")


def wrap_plain(text: str, width: int) -> list[str]:
    text = ascii_text(text)
    lines: list[str] = []
    for para in text.splitlines() or [""]:
        if not para:
            lines.append("")
        else:
            lines.extend(textwrap.wrap(para, width=width, break_long_words=False) or [""])
    return lines


def wrap_code(code: str, width: int) -> list[str]:
    code = ascii_text(code)
    out: list[str] = []
    for line in code.splitlines():
        if len(line) <= width:
            out.append(line)
            continue
        indent = len(line) - len(line.lstrip())
        prefix = " " * min(indent, 8)
        rest = line
        while len(rest) > width:
            cut = rest.rfind(" ", 0, width)
            if cut < max(20, indent + 8):
                cut = width
            out.append(rest[:cut])
            rest = prefix + rest[cut:].lstrip()
        out.append(rest)
    return out


class SimplePDF:
    def __init__(self) -> None:
        self.pages: list[str] = []
        self.width = 792
        self.height = 612

    def add_page(self, ops: list[str]) -> None:
        self.pages.append("\n".join(ops))

    def save(self, path: Path) -> None:
        objects: list[bytes] = []
        objects.append(b"<< /Type /Catalog /Pages 2 0 R >>")
        kids = " ".join(f"{3 + 2 * i} 0 R" for i in range(len(self.pages)))
        objects.append(f"<< /Type /Pages /Kids [{kids}] /Count {len(self.pages)} >>".encode())
        font_obj_base = 3 + 2 * len(self.pages)
        resources = (
            f"<< /Font << /F1 {font_obj_base} 0 R /F2 {font_obj_base + 1} 0 R "
            f"/F3 {font_obj_base + 2} 0 R >> >>"
        )
        for i, stream in enumerate(self.pages):
            page_obj_num = 3 + 2 * i
            content_obj_num = page_obj_num + 1
            page = (
                f"<< /Type /Page /Parent 2 0 R /MediaBox [0 0 {self.width} {self.height}] "
                f"/Resources {resources} /Contents {content_obj_num} 0 R >>"
            )
            stream_bytes = stream.encode("latin-1", errors="replace")
            content = (
                f"<< /Length {len(stream_bytes)} >>\nstream\n".encode()
                + stream_bytes
                + b"\nendstream"
            )
            objects.append(page.encode())
            objects.append(content)
        objects.append(b"<< /Type /Font /Subtype /Type1 /BaseFont /Helvetica >>")
        objects.append(b"<< /Type /Font /Subtype /Type1 /BaseFont /Helvetica-Bold >>")
        objects.append(b"<< /Type /Font /Subtype /Type1 /BaseFont /Courier >>")

        data = bytearray(b"%PDF-1.4\n%\xe2\xe3\xcf\xd3\n")
        offsets = [0]
        for idx, obj in enumerate(objects, start=1):
            offsets.append(len(data))
            data.extend(f"{idx} 0 obj\n".encode())
            data.extend(obj)
            data.extend(b"\nendobj\n")
        xref = len(data)
        data.extend(f"xref\n0 {len(objects) + 1}\n".encode())
        data.extend(b"0000000000 65535 f \n")
        for off in offsets[1:]:
            data.extend(f"{off:010d} 00000 n \n".encode())
        data.extend(
            f"trailer\n<< /Size {len(objects) + 1} /Root 1 0 R >>\nstartxref\n{xref}\n%%EOF\n".encode()
        )
        path.write_bytes(data)


def text_op(x: float, y: float, text: str, font: str = "F1", size: float = 7) -> str:
    return f"BT /{font} {size} Tf {x:.2f} {y:.2f} Td ({pdf_escape(text)}) Tj ET"


def line_op(x1: float, y1: float, x2: float, y2: float) -> str:
    return f"{x1:.2f} {y1:.2f} m {x2:.2f} {y2:.2f} l S"


def draw_header(ops: list[str], title: str, page_no: int) -> None:
    ops.append(text_op(24, 586, title, "F2", 12))
    ops.append(text_op(740, 586, f"p. {page_no}", "F1", 7))
    y = 565
    headers = [
        ("Natural language statement", 24),
        ("Domain", 314),
        ("GroundTruth", 394),
    ]
    for h, x in headers:
        ops.append(text_op(x, y, h, "F2", 7))
    ops.append(line_op(20, 558, 772, 558))


GREEK_LATEX = {
    "α": r"\alpha",
    "β": r"\beta",
    "Γ": r"\Gamma",
    "δ": r"\delta",
    "Δ": r"\Delta",
    "ε": r"\varepsilon",
    "ζ": r"\zeta",
    "γ": r"\gamma",
    "η": r"\eta",
    "θ": r"\theta",
    "Θ": r"\Theta",
    "ι": r"\iota",
    "κ": r"\kappa",
    "λ": r"\lambda",
    "Λ": r"\Lambda",
    "μ": r"\mu",
    "ν": r"\nu",
    "ξ": r"\xi",
    "π": r"\pi",
    "ρ": r"\rho",
    "σ": r"\sigma",
    "τ": r"\tau",
    "φ": r"\phi",
    "ψ": r"\psi",
    "ω": r"\omega",
    "Ω": r"\Omega",
    "ℕ": r"\mathbb{N}",
    "ℤ": r"\mathbb{Z}",
    "ℝ": r"\mathbb{R}",
    "ℂ": r"\mathbb{C}",
}

SUPERSCRIPT_LATEX = {
    "⁰": "0",
    "¹": "1",
    "²": "2",
    "³": "3",
    "⁴": "4",
    "⁵": "5",
    "⁶": "6",
    "⁷": "7",
    "⁸": "8",
    "⁹": "9",
    "⁺": "+",
    "⁻": "-",
    "ⁿ": "n",
    "ᵃ": "a",
    "ᵈ": "d",
    "ᵉ": "e",
    "ᵏ": "k",
    "ᵐ": "m",
    "ᵖ": "p",
    "ᵣ": "r",
    "ᵗ": "t",
    "ᵢ": "i",
    "ᵥ": "v",
}

SUBSCRIPT_LATEX = {
    "₀": "0",
    "₁": "1",
    "₂": "2",
    "₃": "3",
    "₄": "4",
    "₅": "5",
    "₆": "6",
    "₇": "7",
    "₈": "8",
    "₉": "9",
    "₊": "+",
    "₋": "-",
    "ₗ": "l",
    "ₘ": "m",
    "ₙ": "n",
    "ₛ": "s",
}

SYMBOL_LATEX = {
    "∞": r"\infty",
    "→": r"\to",
    "↦": r"\mapsto",
    "∧": r"\land",
    "∨": r"\lor",
    "↔": r"\leftrightarrow",
    "∀": r"\forall",
    "∃": r"\exists",
    "≤": r"\le",
    "≥": r"\ge",
    "≠": r"\ne",
    "∈": r"\in",
    "∉": r"\notin",
    "⊂": r"\subset",
    "⊊": r"\subsetneq",
    "⊆": r"\subseteq",
    "⊃": r"\supset",
    "⊇": r"\supseteq",
    "∩": r"\cap",
    "∪": r"\cup",
    "⋂": r"\bigcap",
    "⋃": r"\bigcup",
    "×": r"\times",
    "‖": r"\|",
    "∥": r"\|",
    "·": r"\cdot",
    "⊗": r"\otimes",
    "⊕": r"\oplus",
    "⟂": r"\perp",
    "∘": r"\circ",
    "∫": r"\int",
    "∏": r"\prod",
    "Σ": r"\sum",
    "∑": r"\sum",
    "−": "-",
    "∅": r"\emptyset",
    "⟨": r"\langle",
    "⟩": r"\rangle",
    "∂": r"\partial",
    "∇": r"\nabla",
    "∖": r"\setminus",
    "≈": r"\approx",
    "±": r"\pm",
    "≡": r"\equiv",
    "←": r"\leftarrow",
    "⇒": r"\Rightarrow",
    "⇐": r"\Leftarrow",
    "⇔": r"\Longleftrightarrow",
}

PRECOMPOSED_LATEX = {
    "ā": r"\bar a",
}

COMBINING_LATEX = {
    "\u0303": r"\tilde",
    "\u0304": r"\bar",
    "\u0307": r"\dot",
}

WORD_LATEX_OPERATORS = {
    "alg": r"\operatorname{alg}",
    "clos": r"\operatorname{clos}",
    "dist": r"\operatorname{dist}",
    "exp": r"\exp",
    "ind": r"\operatorname{ind}",
    "Ind": r"\operatorname{Ind}",
    "inf": r"\inf",
    "ker": r"\ker",
    "lim": r"\lim",
    "log": r"\log",
    "rank": r"\operatorname{rank}",
    "sin": r"\sin",
    "sup": r"\sup",
    "Sym": r"\operatorname{Sym}",
}


def display_math(body: str, use_dollars: bool) -> str:
    if use_dollars:
        return f"$${body}$$"
    if re.fullmatch(r"\\[A-Za-z]+", body):
        return body + " "
    return body


def latex_base(ch: str) -> str | None:
    if ch in GREEK_LATEX:
        return GREEK_LATEX[ch]
    if ch in PRECOMPOSED_LATEX:
        return PRECOMPOSED_LATEX[ch]
    if ch.isascii() and ch.isalnum():
        return ch
    return None


def latex_simple_token(ch: str) -> str:
    return GREEK_LATEX.get(ch, SYMBOL_LATEX.get(ch, ch))


def collect_braced(text: str, start: int) -> tuple[str, int]:
    depth = 0
    for idx in range(start, len(text)):
        if text[idx] == "{":
            depth += 1
        elif text[idx] == "}":
            depth -= 1
            if depth == 0:
                return text[start + 1 : idx], idx + 1
    return text[start + 1 :], len(text)


def parse_math_atom(text: str, i: int, use_dollars: bool) -> tuple[str, int] | None:
    ch0 = text[i]
    is_named_operator = False
    if ch0.isascii() and ch0.isalnum():
        if i > 0 and text[i - 1].isascii() and text[i - 1].isalnum():
            return None
        j = i
        while j < len(text) and text[j].isascii() and text[j].isalnum():
            j += 1
        word = text[i:j]
        is_named_operator = word in WORD_LATEX_OPERATORS
        base = WORD_LATEX_OPERATORS.get(word, word)
    elif ch0 in SYMBOL_LATEX:
        base = SYMBOL_LATEX[ch0]
        j = i + 1
    else:
        base = latex_base(ch0)
        if base is None:
            return None
        j = i + 1

    had_combining = False
    while j < len(text) and text[j] in COMBINING_LATEX:
        base = rf"{COMBINING_LATEX[text[j]]}{{{base}}}"
        had_combining = True
        j += 1

    sup = ""
    sub = ""
    while j < len(text):
        ch = text[j]
        if ch in SUPERSCRIPT_LATEX:
            sup += SUPERSCRIPT_LATEX[ch]
            j += 1
        elif ch in SUBSCRIPT_LATEX:
            sub += SUBSCRIPT_LATEX[ch]
            j += 1
        elif ch == "∞":
            sup += r"\infty"
            j += 1
        elif ch in "_^" and j + 1 < len(text):
            target_is_sub = ch == "_"
            j += 1
            if text[j] == "{":
                raw, j = collect_braced(text, j)
                value = latex_markup_text(raw, use_dollars=False)
            else:
                start = j
                while j < len(text) and (
                    text[j].isascii() and text[j].isalnum()
                    or text[j] in GREEK_LATEX
                    or text[j] == "∞"
                ):
                    j += 1
                value = latex_markup_text(text[start:j], use_dollars=False)
            if target_is_sub:
                sub += value
            else:
                sup += value
        else:
            break

    has_math_feature = (
        ch0 in GREEK_LATEX
        or ch0 in PRECOMPOSED_LATEX
        or ch0 in SYMBOL_LATEX
        or is_named_operator
        or had_combining
        or sup != ""
        or sub != ""
    )
    if not has_math_feature:
        return None

    body = base
    if sub:
        body += "_{" + sub + "}"
    if sup:
        body += "^{" + sup + "}"
    return display_math(body, use_dollars), j


def latex_markup_text(text: str, use_dollars: bool = True) -> str:
    out: list[str] = []
    i = 0
    while i < len(text):
        atom = parse_math_atom(text, i, use_dollars)
        if atom is not None:
            body, i = atom
            out.append(body)
            continue

        ch = text[i]
        if ch in SYMBOL_LATEX:
            out.append(display_math(SYMBOL_LATEX[ch], use_dollars))
        elif ch in COMBINING_LATEX:
            out.append(ch)
        else:
            out.append(ch)
        i += 1
    return "".join(out)


def decl_search_paths(entry: Entry, name: str) -> list[Path]:
    """Candidate files for a declaration, per-problem layout first.

    Each book lives in `Dataset/<Book>/` with one `<decl>.lean` per problem and
    shared custom notions in `Defs.lean`; the legacy monolith path is kept as a
    fallback so the script also works on pre-split checkouts.
    """
    monolith = ROOT / entry.lean_file
    book_dir = monolith.with_suffix("")
    paths = [book_dir / f"{name}.lean", book_dir / "Defs.lean", monolith]
    if book_dir.is_dir():
        paths.extend(sorted(book_dir.glob("*.lean")))
    seen: set[Path] = set()
    out: list[Path] = []
    for p in paths:
        if p.exists() and p not in seen:
            seen.add(p)
            out.append(p)
    return out


def find_decl(entry: Entry, name: str) -> str:
    for path in decl_search_paths(entry, name):
        text = extract_decl(path, name)
        if not text.startswith("-- declaration"):
            return text
    return f"-- declaration {name} not found"


def make_formalization(entry: Entry) -> str:
    parts = [find_decl(entry, name) for name in entry.definitions]
    parts.append(find_decl(entry, entry.decl))
    return "\n\n".join(parts)


def make_natural_statement(entry: Entry) -> str:
    return entry.statement


def render_plain_pdf_report(title: str, output: Path, entries: list[Entry]) -> None:
    pdf = SimplePDF()
    page_no = 1
    ops: list[str] = []
    draw_header(ops, title, page_no)
    y = 546
    bottom = 30
    leading = 7

    for entry in entries:
        cells = [
            wrap_plain(make_natural_statement(entry), 62),
            wrap_plain(entry.domain, 12),
            wrap_code(make_formalization(entry), 76),
        ]
        while any(cells):
            available = max(1, int((y - bottom - 10) // leading))
            need = max(len(c) for c in cells)
            take = min(available, need)
            if y - (take * leading + 10) < bottom:
                pdf.add_page(ops)
                page_no += 1
                ops = []
                draw_header(ops, title, page_no)
                y = 546
                continue
            row_height = take * leading + 10
            top = y + 4
            bottom_y = y - row_height + 4
            for x in [20, 310, 390, 772]:
                ops.append(line_op(x, top, x, bottom_y))
            ops.append(line_op(20, top, 772, top))
            ops.append(line_op(20, bottom_y, 772, bottom_y))

            slices: list[list[str]] = []
            for cell in cells:
                slices.append(cell[:take])
            cells = [cell[take:] for cell in cells]
            x_positions = [24, 314, 394]
            fonts = ["F1", "F1", "F3"]
            sizes = [5.8, 5.8, 4.9]
            for col, lines in enumerate(slices):
                yy = y - 4
                for line in lines:
                    ops.append(text_op(x_positions[col], yy, line, fonts[col], sizes[col]))
                    yy -= leading
            y -= row_height
    pdf.add_page(ops)
    pdf.save(output)


LATEX_SPECIALS = {
    "\\": r"\textbackslash{}",
    "&": r"\&",
    "%": r"\%",
    "$": r"\$",
    "#": r"\#",
    "_": r"\_",
    "{": r"\{",
    "}": r"\}",
    "~": r"\textasciitilde{}",
    "^": r"\textasciicircum{}",
}

LATEX_REPLACEMENTS = {
    "⁰": r"\textsuperscript{0}",
    "¹": r"\textsuperscript{1}",
    "²": r"\textsuperscript{2}",
    "³": r"\textsuperscript{3}",
    "⁴": r"\textsuperscript{4}",
    "⁵": r"\textsuperscript{5}",
    "⁶": r"\textsuperscript{6}",
    "⁷": r"\textsuperscript{7}",
    "⁸": r"\textsuperscript{8}",
    "⁹": r"\textsuperscript{9}",
    "⁺": r"\textsuperscript{+}",
    "⁻": r"\textsuperscript{-}",
    "ⁿ": r"\textsuperscript{n}",
    "ᵃ": r"\textsuperscript{a}",
    "ᵉ": r"\textsuperscript{e}",
    "ᵐ": r"\textsuperscript{m}",
    "ᵖ": r"\textsuperscript{p}",
    "ᵣ": r"\textsuperscript{r}",
    "ᵗ": r"\textsuperscript{t}",
    "ᵢ": r"\textsuperscript{i}",
    "ᵥ": r"\textsuperscript{v}",
    "₀": r"\textsubscript{0}",
    "₁": r"\textsubscript{1}",
    "₂": r"\textsubscript{2}",
    "₃": r"\textsubscript{3}",
    "₄": r"\textsubscript{4}",
    "₅": r"\textsubscript{5}",
    "₆": r"\textsubscript{6}",
    "₇": r"\textsubscript{7}",
    "₈": r"\textsubscript{8}",
    "₉": r"\textsubscript{9}",
    "₊": r"\textsubscript{+}",
    "₋": r"\textsubscript{-}",
    "ₗ": r"\textsubscript{l}",
    "ₘ": r"\textsubscript{m}",
    "ₙ": r"\textsubscript{n}",
    "ₛ": r"\textsubscript{s}",
}


def latex_escape(text: str) -> str:
    return "".join(
        LATEX_REPLACEMENTS.get(ch, LATEX_SPECIALS.get(ch, ch)) for ch in text
    )


def latex_code_line(line: str) -> str:
    if not line:
        return r"\strut\par"
    indent = len(line) - len(line.lstrip(" "))
    content = latex_escape(line.lstrip(" "))
    return rf"\hspace*{{{0.36 * indent:.2f}em}}{content}\par"


def latex_code_block(code: str, width: int = 92) -> str:
    lines = wrap_unicode_code(code, width)
    body = "\n".join(latex_code_line(line) for line in lines)
    return (
        r"{\ttfamily\tiny\setlength{\parindent}{0pt}"
        "\n"
        + body
        + "\n}"
    )


def latex_table_row(entry: Entry) -> str:
    cells = [
        latex_escape(make_natural_statement(entry)),
        latex_escape(entry.domain),
        latex_code_block(make_formalization(entry)),
    ]
    return " & ".join(cells) + r" \\ \hline"


def latex_document(title: str, entries: list[Entry]) -> str:
    rows = "\n".join(latex_table_row(entry) for entry in entries)
    return rf"""\documentclass[10pt]{{article}}
\usepackage{{fontspec}}
\usepackage{{amsmath,amssymb,array,longtable,geometry,ragged2e,xcolor}}
\geometry{{landscape,margin=0.28in}}
\IfFontExistsTF{{Arial Unicode MS}}{{\setmainfont{{Arial Unicode MS}}}}{{\setmainfont{{Helvetica}}}}
\IfFontExistsTF{{Arial Unicode MS}}{{\setmonofont{{Arial Unicode MS}}}}{{\IfFontExistsTF{{STIX Two Text}}{{\setmonofont{{STIX Two Text}}}}{{\setmonofont{{Courier New}}}}}}
\newcolumntype{{P}}[1]{{>{{\RaggedRight\arraybackslash}}p{{#1}}}}
\setlength{{\tabcolsep}}{{2pt}}
\renewcommand{{\arraystretch}}{{1.06}}
\pagestyle{{plain}}
\sloppy
\begin{{document}}
\scriptsize
\begin{{center}}
  {{\Large\bfseries {latex_escape(title)}}}
\end{{center}}
\begin{{longtable}}{{|P{{3.9in}}|P{{1.0in}}|P{{6.0in}}|}}
\hline
\textbf{{Natural language statement}} & \textbf{{Domain}} & \textbf{{GroundTruth}} \\ \hline
\endfirsthead
\hline
\textbf{{Natural language statement}} & \textbf{{Domain}} & \textbf{{GroundTruth}} \\ \hline
\endhead
{rows}
\end{{longtable}}
\end{{document}}
"""


def render_report(title: str, output: Path, entries: list[Entry]) -> None:
    render_plain_pdf_report(title, output, entries)


BOGACHEV = [
    Entry(1, "3.6.8. Definition. Let F : X → Y be a mapping between measure spaces (X, 𝒜, μ) and (Y, ℬ, ν). We shall say that F has Lusin's property (N) with respect to the pair (μ, ν) if ν(F(A)) = 0 for every set A ∈ 𝒜 with μ(A) = 0. 3.6.9. Theorem. Let F : Rⁿ → Rⁿ be a Lebesgue measurable mapping. Then F has Lusin's property (N) with respect to Lebesgue measure precisely when F takes all Lebesgue measurable sets to Lebesgue measurable sets.", "Measure theory", "Dataset/Bogachev.lean", "hasLusinPropertyN_iff_maps_nullMeasurableSet", ["HasLusinPropertyN"]),
    Entry(2, "8.6.2. Theorem. Let X be a complete separable metric space and let M be a family of Borel measures on X. Then the following conditions are equivalent: (i) every sequence {μₙ} ⊂ M contains a weakly convergent subsequence; (ii) the family M is uniformly tight and uniformly bounded in the variation norm. The above conditions are equivalent for any complete metric space X if M ⊂ Mₜ(X).", "Measure theory", "Dataset/Bogachev.lean", "bogachev_8_6_2_prokhorov_signed_measures", ["signedMeasureIntegral", "weakly_converges_signed", "relatively_sequentially_weakly_compact_signed", "UniformlyBoundedInTotalVariation"]),
    Entry(3, "5.5.4. Proposition. Let f be a function on the real line and let E be a measurable set such that at every point of E the function f is differentiable. Then λ(f(E)) ≤ ∫_E |f′(x)| dx. In particular, the function f on E has Lusin's property (N). If for all x ∈ E we have |f′(x)| ≤ L, then λ(f(E)) ≤ Lλ(E).", "Analysis", "Dataset/Bogachev.lean", "proposition_5_5_4", ["HasLusinPropertyNOn"]),
    Entry(4, "3.7.1. Theorem. If the mapping F is injective on U, then, for any measurable set A ⊂ U and any Borel function g ∈ L¹(Rⁿ), one has the equality ∫_A g(F(x)) |J_F(x)| dx = ∫_{F(A)} g(y) dy.", "Analysis", "Dataset/Bogachev.lean", "bogachev_3_7_1_change_of_variables_in_Rn", []),
    Entry(5, "4.5.9. Theorem. Let μ be a finite nonnegative measure. A family F of μ-integrable functions is uniformly integrable if and only if there exists a nonnegative increasing function G on [0, +∞) such that lim_{t→+∞} G(t)/t = ∞ and sup_{f∈F} ∫ G(|f(x)|) μ(dx) < ∞. In such a case, one can choose a convex increasing function G.", "Measure theory", "Dataset/Bogachev.lean", "bogachev_4_5_9_de_la_vallee_poussin", []),
    Entry(6, "4.6.3. Theorem. Let a sequence of measures μₙ in the space M(X, 𝓐) be such that limₙ→∞ μₙ(A) exists and is finite for every set A ∈ 𝓐. Then: (i) the formula μ(A) = limₙ→∞ μₙ(A) defines a measure μ ∈ M(X, 𝓐); (ii) there exist a nonnegative measure ν ∈ M(X, 𝓐) and a bounded nondecreasing nonnegative function α on [0, +∞) such that limₜ→₀ α(t) = 0 and supₙ |μₙ(A)| ≤ α(ν(A)), ∀ A ∈ 𝓐. In particular, supₙ ‖μₙ‖ < ∞ and the sequence {μₙ} is uniformly countably additive; (iii) if a nonnegative measure λ ∈ M(X, 𝓐) is such that μₙ ≪ λ for all n, then limₜ→₀ sup {μₙ(A) : A ∈ 𝓐, λ(A) ≤ t, n ∈ ℕ} = 0.\n\n4.6.2. Definition. Let M be a family of real measures on a σ-algebra 𝓐. This family is called uniformly countably additive if, for every sequence of pairwise disjoint sets Aᵢ, the series ∑ᵢ₌₁∞ μ(Aᵢ) converges uniformly in μ ∈ M, i.e., for every ε > 0, there exists nε such that |∑ᵢ₌ₙ∞ μ(Aᵢ)| < ε for all n ≥ nε and all μ ∈ M.", "Measure theory", "Dataset/Bogachev.lean", "bogachev_4_6_3_nikodym_vitali_hahn_saks", ["UniformlyBoundedInTotalVariation", "UniformlyCountablyAdditive", "UniformlyAbsolutelyContinuous"]),
    Entry(7, "9.12.37. Corollary. Let μ₁, . . . , μₙ be atomless Borel probability measures on a Souslin space X. Then, for every Borel probability measure ν on X, there exists a Borel transformation T : X → X such that μᵢ ◦ T⁻¹ = ν for all i ≤ n.\n\n7.14.15. Definition. Let (M, 𝓜, μ) be a space with a nonnegative measure. An element A ⊂ M is called an atom of the measure μ if μ(A) > 0 and every element B in 𝓜 that is contained in A has measure either zero or μ(A). A measure without atoms is called atomless.", "Measure theory", "Dataset/Bogachev.lean", "bogachev_9_12_37_simultaneous_transport", ["is_atomless_measure"]),
    Entry(8, "10.5.4. Theorem. For every complete probability measure μ, there exists a lifting on L∞(μ).\n\n10.5.1. Definition. Let (X, 𝓐, μ) be a measurable space with a nonnegative measure μ (possibly with values in [0, +∞]) and let L∞𝓐 be the space of all bounded 𝓐-measurable functions. A lifting on L∞𝓐 is a mapping L : L∞𝓐 → L∞𝓐 satisfying the following conditions: (i) L(f) = f μ-a.e.; (ii) L(f)(x) = L(g)(x) for all x ∈ X if f = g μ-a.e.; (iii) L(f)(x) = 1 for all x ∈ X if f = 1 μ-a.e.; (iv) L(αf + βg)(x) = αL(f)(x) + βL(g)(x) for all x ∈ X, f, g ∈ L∞𝓐 and α, β ∈ ℝ¹; (v) L(fg)(x) = L(f)(x)L(g)(x) for all x ∈ X, f, g ∈ L∞𝓐.", "Measure theory", "Dataset/Bogachev.lean", "bogachev_10_5_4_lifting", ["LInfinityLifting"]),
    Entry(9, "9.1.9. Theorem. Let f be a mapping from a topological space X to a topological space Y with a Radon measure ν. Suppose that there exists an increasing sequence of compact sets Kₙ ⊂ X such that f is continuous on every Kₙ and limₙ→∞ |ν|(f(Kₙ)) = ‖ν‖. Then, there exists a Radon measure μ on X with μ ◦ f⁻¹ = ν. In addition, this measure can be chosen with the property ‖ν‖ = ‖μ‖. In particular, this is true if X and Y are compact and f is a continuous surjection.", "Measure theory", "Dataset/Bogachev.lean", "bogachev_9_1_9_radon_preimage_from_compact_approximation", []),
    Entry(10, "4.7.75. (G. Hardy) Let f ∈ Lᵖ(0, +∞), where p > 1. Show that the functions φ(x) = x⁻¹ ∫₀ˣ f(t) dt and ψ(x) = ∫ₓ∞ f(t)/t dt belong to Lᵖ(0, +∞) as well.", "Analysis", "Dataset/Bogachev.lean", "hardy_average_and_tail_memLp", []),
]

KALLENBERG = [
    Entry(
        1,
        "Theorem 3.4 (disintegration) Let ρ be a σ-finite measure on S × T, where T is Borel. Then\n"
        "(i) ρ = ν ⊗ μ for a σ-finite measure ν ∼ ρ(· × T) ≡ ρ̂S and a σ-finite kernel μ : S → T,\n"
        "(ii) the μs are ν-a.e. unique up to normalizations, and they are a.e. bounded iff ρ̂S is σ-finite,\n"
        "(iii) when ρ̂ is σ-finite and ν = ρ̂S, we may choose the μs to be probability measures on T.\n\n"
        "Any σ-finite measure ν ∼ ρ(· × T) is called a supporting measure of ρ, and we refer to μ as the associated disintegration kernel.\n\n"
        "A kernel μ : S → T is said to be finite if μsT < ∞ for all s ∈ S, s-finite if it is a countable sum of finite kernels, and σ-finite if it satisfies μsfs < ∞ for some measurable function f > 0 on S × T, where fs = f(s, ·).",
        "Probability",
        "Dataset/KallenbergProbability.lean",
        "kallenberg_3_4_disintegration",
        [
            "IsAEBoundedKernel",
            "IsSigmaFiniteKernel",
        ],
    ),
    Entry(
        2,
        "Theorem 4.23 (moments and Hölder continuity, Kolmogorov, Loève, Chentsov) Let X be a process on R^d with values in a complete metric space (S, ρ), such that E ρ(Xs, Xt)^a ≲ |s − t|^(d+b), s, t ∈ R^d, for some constants a, b > 0. Then a version of X is locally Hölder continuous of order p, for every p ∈ (0, b/a).\n\n"
        "For any mapping f between two metric spaces (S, ρ) and (S′, ρ′), we define the modulus of continuity wf = w(f, ·) by wf(r) = sup{ρ′(fs, ft); s, t ∈ S, ρ(s, t) ≤ r}, r > 0, so that f is uniformly continuous iff wf(r) → 0 as r → 0. Say that f is Hölder continuous of order p, if wf(r) ≲ r^p as r → 0. The stated property is said to hold locally if it is valid on every bounded set.\n\n"
        "For functions f, g > 0, we mean by f ≲ g that f ≤ cg for some constant c < ∞.",
        "Stochastic processes",
        "Dataset/KallenbergProbability.lean",
        "kallenberg_4_23_moments_and_holder_continuity",
        ["IsLocallyHolder"],
    ),
    Entry(
        3,
        "Theorem 5.25 (portmanteau theorem, Alexandrov) Let ξ, ξ1, ξ2, ... be random elements in a metric space (S, S) with classes G, F of open and closed sets. Then these conditions are equivalent:\n"
        "(i) ξn → ξ in distribution,\n"
        "(ii) lim inf_{n→∞} P{ξn ∈ G} ≥ P{ξ ∈ G}, G ∈ G,\n"
        "(iii) lim sup_{n→∞} P{ξn ∈ F} ≤ P{ξ ∈ F}, F ∈ F,\n"
        "(iv) P{ξn ∈ B} → P{ξ ∈ B}, B ∈ Sξ.\n\n"
        "For a random element ξ in a metric space S with Borel σ-field S, let Sξ denote the class of sets B ∈ S with ξ ∉ ∂B a.s., called the ξ-continuity sets.",
        "Probability",
        "Dataset/KallenbergProbability.lean",
        "kallenberg_5_25_portmanteau",
        [],
    ),
    Entry(
        4,
        "Theorem 5.27 (continuous mapping, Mann & Wald, Prohorov, Rubin) For any metric spaces S, T and set C ⊂ S, consider some measurable functions f, f1, f2, ... : S → T satisfying sn → s ∈ C ⇒ fn(sn) → f(s). Then for any random elements ξ, ξ1, ξ2, ... in S, ξn →ᵈ ξ ∈ C a.s. ⇒ fn(ξn) →ᵈ f(ξ). In particular, we see that if f : S → T is a.s. continuous at ξ, then ξn →ᵈ ξ ⇒ f(ξn) →ᵈ f(ξ).",
        "Probability",
        "Dataset/KallenbergProbability.lean",
        "kallenberg_5_27_continuous_mapping",
        [],
    ),
    Entry(
        5,
        "Theorem 6.13 (Gaussian variance criteria, Lindeberg, Feller) Let (ξnj) be a triangular array with E ξnj = 0 and Σj Var(ξnj) → 1, and let ζ be N(0, 1). Then these conditions are equivalent:\n"
        "(i) Σj ξnj → ζ in distribution and supj Var(ξnj) → 0,\n"
        "(ii) Σj E(ξnj²; |ξnj| > ε) → 0, ε > 0.\n"
        "Here (ii) is the celebrated Lindeberg condition.",
        "Probability",
        "Dataset/KallenbergProbability.lean",
        "kallenberg_6_13_gaussian_variance_criteria",
        [],
    ),
    Entry(
        6,
        "Theorem 8.5 (conditional distributions, disintegration) Let ξ, η be random elements in S, T, where T is Borel. Then L(ξ, η) = L(ξ) ⊗ μ for a probability kernel μ : S → T, where μ is unique a.e. L(ξ) and satisfies\n"
        "(i) L(η | ξ) = μ(ξ, ·) a.s.,\n"
        "(ii) E(f(ξ, η) | ξ) = ∫ μ(ξ, dt) f(ξ, t) a.s., f ≥ 0.\n\n"
        "For any random element ξ in a measurable space (S, S), we define a conditional distribution of η, given ξ, as a random measure of the form μ(ξ, B) = P{η ∈ B | ξ} a.s., B ∈ T, for a probability kernel μ : S → T.",
        "Probability",
        "Dataset/KallenbergProbability.lean",
        "kallenberg_8_5_conditional_distributions",
        [],
    ),
    Entry(
        7,
        "Theorem 9.30 (optional sampling and closure, Doob) Let X be an F-submartingale on R+, where X and F are right-continuous, and consider some optional times σ, τ, where τ is bounded. Then Xτ is integrable, and X_{σ∧τ} ≤ E(Xτ | Fσ) a.s. This extends to unbounded times τ iff X+ is uniformly integrable.",
        "Martingales",
        "Dataset/KallenbergProbability.lean",
        "kallenberg_9_30_optional_sampling_and_closure",
        [],
    ),
    Entry(
        8,
        "Theorem 10.5 (Doob–Meyer decomposition, Meyer, Doléans) For an adapted process X, these conditions are equivalent:\n"
        "(i) X is a local sub-martingale,\n"
        "(ii) X = M + A a.s. for a local martingale M and a locally integrable, non-decreasing, predictable process A with A0 = 0.\n"
        "The processes M and A are then a.s. unique.\n\n"
        "By an increasing process we mean a non-decreasing, right-continuous, and adapted process A with A0 = 0. It is said to be integrable if EA∞ < ∞. Recall that all sub-martingales are taken to be right-continuous. Local sub-martingales and locally integrable processes are defined by localization, in the usual way.\n\n"
        "A process M is said to be a local martingale, if it is adapted to F and such that the stopped and centered processes M^{τn} − M0 are true martingales for some optional times τn ↑ ∞. By a similar localization we may define local L²-martingales, locally bounded martingales, locally integrable processes, etc. The required optional times τn are said to form a localizing sequence.",
        "Martingales",
        "Dataset/KallenbergProbability.lean",
        "kallenberg_10_5_doob_meyer",
        [
            "LocalizesToInfinity",
            "IsLocalMartingale",
            "IsLocalSubmartingale",
            "IsLocallyIntegrableProcess",
        ],
    ),
    Entry(
        9,
        "Theorem 23.2 (tightness and relative compactness, Prohorov) For a set Ξ of random elements in a metric space S, we have (i) ⇒ (ii) with\n"
        "(i) Ξ is tight,\n"
        "(ii) Ξ is relatively compact in distribution,\n"
        "and equivalence holds when S is separable and complete.",
        "Probability",
        "Dataset/KallenbergProbability.lean",
        "kallenberg_23_2_tightness_and_relative_compactness",
        [],
    ),
    Entry(
        10,
        "Theorem 23.6 (functional central limit theorem, Donsker) Let ξ1, ξ2, ... be i.i.d. random vectors in R^d with mean 0 and covariances δij, form the continuous processes X_t^n = n^−1/2[Σ_{k≤nt} ξk + (nt − [nt]) ξ_[nt]+1], t ≥ 0, n ∈ N, and let B be a Brownian motion in R^d. Then X^n → B in distribution in C_{R+,R^d}.\n\n"
        "A d-dimensional Brownian motion is a process B = (B¹, ..., B^d) in R^d, where B¹, ..., B^d are independent, one-dimensional Brownian motions.",
        "Stochastic processes",
        "Dataset/KallenbergProbability.lean",
        "kallenberg_23_6_functional_central_limit",
        ["IsBrownianVector"],
    ),
]


CONWAY = [
    Entry(1, "V.13.1. The Eberlein-Smulian Theorem. If 𝓧 is a Banach space and A ⊆ 𝓧, then the following statements are equivalent. (a) Each sequence of elements of A has a subsequence that is weakly convergent. (b) Each sequence of elements of A has a weak cluster point. (c) The weak closure of A is weakly compact.", "Functional analysis", "Dataset/ConwayFunctionalAnalysis.lean", "conway_V_13_1_eberlein_smulian", []),
    Entry(2, "V.13.3. James's Theorem. If 𝓧 is a Banach space and A is a closed convex subset of 𝓧 such that for each x* in 𝓧* there is an x₀ in A with |⟨x₀, x*⟩| = sup{|⟨x, x*⟩| : x ∈ A}, then A is weakly compact.", "Functional analysis", "Dataset/ConwayFunctionalAnalysis.lean", "conway_V_13_3_james", []),
    Entry(3, "VI.2.1. The Banach-Stone Theorem. If X and Y are compact and T : C(X) → C(Y) is a surjective isometry, then there is a homeomorphism τ : Y → X and a function α in C(Y) such that |α(y)| = 1 for all y and (Tf)(y) = α(y)f(τ(y)) for all f in C(X) and y in Y.", "Functional analysis", "Dataset/ConwayFunctionalAnalysis.lean", "conway_VI_2_1_banach_stone", []),
    Entry(4, "VIII.3.6. Theorem. If 𝓐 is a C*-algebra and a ∈ 𝓐, then the following statements are equivalent. (a) a ≥ 0. (b) a = b² for some b in Re 𝓐. (c) a = x*x for some x in 𝓐. (d) a = a* and ‖t − a‖ ≤ t for all t ≥ ‖a‖. (e) a = a* and ‖t − a‖ ≤ t for some t ≥ ‖a‖.", "Operator algebras", "Dataset/ConwayFunctionalAnalysis.lean", "conway_VIII_3_6_positive_element_characterizations", []),
    Entry(5, "VII.7.1. Theorem. (F. Riesz) If dim 𝓧 = ∞ and A ∈ 𝓑₀(𝓧), then one and only one of the following possibilities occurs. (a) σ(A) = {0}. (b) σ(A) = {0, λ₁, . . . , λₙ}, where for 1 ≤ k ≤ n, λₖ ≠ 0, each λₖ is an eigenvalue of A, and dim ker(A − λₖ) < ∞. (c) σ(A) = {0, λ₁, λ₂, . . .}, where for each k ≥ 1, λₖ is an eigenvalue of A, dim ker(A − λₖ) < ∞, and, moreover, lim λₖ = 0.", "Operator theory", "Dataset/ConwayFunctionalAnalysis.lean", "conway_VII_7_1_riesz_compact_operator_spectrum", []),
    Entry(6, "VIII.5.17. Theorem. If 𝓐 is a C*-algebra, then there is a representation (π, 𝓗) of 𝓐 such that π is an isometry. If 𝓐 is separable, then 𝓗 can be chosen separable.", "Operator algebras", "Dataset/ConwayFunctionalAnalysis.lean", "conway_VIII_5_17_gelfand_naimark", []),
    Entry(7, "Definition. A bounded operator A : 𝓗 → 𝓗′ is left semi-Fredholm if it is left invertible modulo the compact operators: there are bounded B : 𝓗′ → 𝓗 and compact C : 𝓗 → 𝓗 such that BA = 1 + C. XI.2.3. Theorem. If A : 𝓗 → 𝓗′ is a bounded operator, the following statements are equivalent. (a) A is left semi-Fredholm. (b) ran A is closed and dim ker A < ∞. (c) There is a bounded operator B : 𝓗′ → 𝓗 and a finite rank operator F on 𝓗 such that BA = 1 + F. (d) There is no sequence {hₙ} of unit vectors in 𝓗 such that hₙ → 0 weakly and lim ‖Ahₙ‖ = 0. (e) There is no orthonormal sequence {eₙ} in 𝓗 such that lim ‖Aeₙ‖ = 0. (f) There is a δ > 0 such that {h ∈ 𝓗 : ‖Ah‖ ≤ δ‖h‖} contains no infinite dimensional manifold. (g) If the positive operator (A*A)¹ᐟ² = ∫₀∞ t dE(t), then there is a δ > 0 such that E[0, δ]𝓗 is finite dimensional. (h) If K ∈ 𝓑₀(𝓗), then dim ker(A + K) < ∞.", "Fredholm theory", "Dataset/ConwayFunctionalAnalysis.lean", "conway_XI_2_3_left_semi_fredholm_characterizations", ["ProjectionValuedMeasure", "IsLeftSemiFredholm"]),
    Entry(8, "II.7.6. Spectral Theorem for Compact Normal Operators. If T is a compact normal operator on the complex Hilbert space 𝓗, then T has only a countable number of distinct eigenvalues. If {λ₁, λ₂, . . .} are the distinct nonzero eigenvalues of T, and Pₙ is the projection of 𝓗 onto ker(T − λₙ), then PₙPₘ = PₘPₙ = 0 if n ≠ m and T = ∑ₙ₌₁∞ λₙPₙ, where this series converges to T in the metric defined by the norm on 𝓑(𝓗).", "Operator theory", "Dataset/ConwayFunctionalAnalysis.lean", "conway_II_7_6_compact_normal_spectral_theorem", ["IsOrthogonalProjection"]),
    Entry(9, "IX.2.2. The Spectral Theorem. If N is a normal operator, there is a unique spectral measure E on the Borel subsets of σ(N) such that: (a) N = ∫ z dE(z); (b) if G is a nonempty relatively open subset of σ(N), E(G) ≠ 0; (c) if A ∈ 𝓑(𝓗), then AN = NA and AN* = N*A if and only if AE(Δ) = E(Δ)A for every Δ.", "Operator theory", "Dataset/ConwayFunctionalAnalysis.lean", "conway_IX_2_2_bounded_normal_spectral_theorem", ["IsOrthogonalProjection", "ProjectionValuedMeasure"]),
    Entry(10, "X.5.6. Stone's Theorem. If U is a strongly continuous one parameter unitary group, then there is a self-adjoint operator A such that U(t) = exp(itA).", "Operator theory", "Dataset/ConwayFunctionalAnalysis.lean", "conway_X_5_6_stone_theorem", ["ProjectionValuedMeasure", "DenselyDefinedOperator", "IsSelfAdjointUnbounded", "IsUnitaryOperator", "StronglyContinuousUnitaryGroup", "IsSpectralExponential"]),
]


NIKOLSKI = [
    Entry(1, "1.3.2. Theorem (A. Beurling, H. Helson). Let E ⊂ L², zE ⊊ E. Then there exists a measurable function Θ, unique up to a multiplicative constant of modulus 1, such that |Θ| = 1 a.e. on T and E = ΘH².", "Hardy spaces", "Dataset/NikolskiOperators.lean", "nikolski_A_1_3_beurling_invariant_subspaces", ["boundaryValue", "unitCirclePoint", "HasRadialBoundaryValues", "HardyClass", "HasTaylorSeries", "HardySquareSummable", "CauchyProduct", "IsComplexLinearSubspace", "ShiftInvariant", "InnerFunction", "InnerGeneratedSubspace"]),
    Entry(2, "2.4.1. Theorem (V. Smirnov, 1928). Let f ∈ H², f ≠ 0. Then there exist an inner function fᵢₙₙ ∈ H² and an outer function fₒᵤₜ ∈ H² such that f = fᵢₙₙfₒᵤₜ. Moreover, such a factorization is unique up to a constant factor, and E_f = fᵢₙₙH².\n\nRecall that a function f ∈ H² is called inner if |f| = 1 a.e. on T. It is called outer if E_f = H².", "Hardy spaces", "Dataset/NikolskiOperators.lean", "nikolski_A_2_4_inner_outer_factorization", ["boundaryValue", "unitCirclePoint", "HasRadialBoundaryValues", "HardyClass", "InnerFunction", "OuterFunction"]),
    Entry(3, "3.6.1. Corollary. If g ∈ H¹, g ≠ 0, then log |g| ∈ L¹(T). In particular, if g ∈ H¹ and m{t ∈ T : g(t) = 0} > 0, then g = 0.", "Hardy spaces", "Dataset/NikolskiOperators.lean", "nikolski_A_3_6_boundary_uniqueness", ["boundaryValue", "unitCirclePoint", "HasRadialBoundaryValues", "HardyClass"]),
    Entry(4, "3.7.1. Lemma (Blaschke condition, interior uniqueness theorem). Suppose f ∈ Hol(D), f ≠ 0, and let (λₙ)ₙ≥₁ be the zero sequence of f in D, each zero is repeated according to its multiplicity. Suppose that limᵣ→1 ∫ᵀ log |fᵣ| dm < ∞, then ∑ₙ≥₁(1 − |λₙ|) < ∞. In particular, this holds whenever f ∈ Hᵖ(D), p > 0.\n\n3.7.3. Lemma (Blaschke Product). If (λₙ)ₙ≥₁ is a sequence in D satisfying the Blaschke condition ∑ₙ≥₁(1 − |λₙ|) < ∞, then the infinite product B = ∏ₙ≥₁ bλₙ converges uniformly on compact subsets of D (and even on compact subsets of ℂ ∖ clos{1/λₙ}ₙ≥₁). Moreover |B| ≤ 1 in D, |B| = 1 a.e. on T, and the zeros of B are exactly (λₙ)ₙ≥₁ (counting multiplicities).\n\n3.7.2. Remark. The condition ∑ₙ≥₁(1 − |λₙ|) < ∞ is called the Blaschke condition.", "Hardy spaces", "Dataset/NikolskiOperators.lean", "nikolski_A_3_7_blaschke_zero_sets", ["HardyClass", "HasZeroSequence", "BlaschkeCondition"]),
    Entry(5, "5.4.1. Theorem. Let μ be a finite Borel measure on T. The following assertions are equivalent. (1) The family (zⁿ)_{n∈Z} is a (symmetric or non-symmetric) basis of L²(μ). (2) The Riesz projection P₊ is bounded on L²(μ). (3) sin(Pol₊, Pol₋) > 0. (4) dμ = |h|² dm where h ∈ H² is an outer function such that dist(h̄/h, H∞) < 1. (5) dμ = w dm where w = e^{u+ṽ} and u, v are real valued bounded functions and ‖v‖∞ < π/2 (condition (HS)).", "Harmonic analysis", "Dataset/NikolskiOperators.lean", "nikolski_A_5_4_helson_szego", ["boundaryValue", "unitCirclePoint", "HardyClass", "OuterFunction", "trigonometricPolynomial", "weightedL2NormSq", "analyticFourierPart", "circleHilbertTransform"]),
    Entry(6, "1.3.2. Theorem (Z. Nehari, 1957). If H : H² → H²₋ is a bounded Hankel operator, then there exists φ ∈ L∞ such that H = H_φ and ‖H_φ‖ = ‖φ‖∞ = dist(φ, H∞).", "Operator theory", "Dataset/NikolskiOperators.lean", "nikolski_B_1_3_nehari_theorem", ["boundaryValue", "unitCirclePoint", "HardyClass", "circleFourierCoefficient", "BoundedHankelForm", "HasBoundedHankelSymbol", "hankelFormNorm", "symbolDistanceToHInfinity"]),
    Entry(7, "2.2.5. Theorem (P. Hartman, 1958). Let f ∈ L∞. Then H_f ∈ S∞ if and only if f ∈ H∞ + C. In other words, a Hankel operator H is compact if and only if H = H_g with some g ∈ C(T).", "Operator theory", "Dataset/NikolskiOperators.lean", "nikolski_B_2_2_hartman_compact_hankel", ["boundaryValue", "unitCirclePoint", "HardyClass", "circleFourierCoefficient", "BoundedHankelForm", "HasBoundedHankelSymbol", "CompactHankel", "InHInfinityPlusContinuous"]),
    Entry(8, "3.2.4. Corollary (G. Pick, 1916). There exists f ∈ H∞ such that f(λ_k) = w_k, k = 1, ..., n, and ‖f‖∞ ≤ 1 if and only if I − WW* ≥ 0: Σ_{i,j=1}^n a_i ā_j (1 − w_i w̄_j)/(1 − λ_i λ̄_j) ≥ 0, a_i ∈ C. Moreover, the solution f is unique if and only if the matrix I − WW* is degenerated, i.e. ∂ = rank(I − WW*) < n.", "Function theory", "Dataset/NikolskiOperators.lean", "nikolski_B_3_2_nevanlinna_pick_interpolation", ["boundaryValue", "unitCirclePoint", "HardyClass", "SchurFunction", "PickMatrix", "PositiveSemidefiniteMatrix"]),
    Entry(9, "4.3.3. Lemma. Let u ∈ L∞(T) be such that |u| = 1 a.e. on T. The following are equivalent. (1) Tᵤ is invertible. (2) dist(u, H∞) < 1, dist(ū, H∞) < 1. (3) There exists an outer function h ∈ H∞ such that ‖u − h‖∞ < 1. (4) There exist real valued bounded functions a, b and a constant c ∈ ℝ such that u = e^{i(c+a+b̃)} and ‖a‖∞ < π/2.\n\n3.9.7. Definition. Let f ∈ Hᵖ, p > 0. The function [f] is called the outer part of f, and λBS is called the inner part of f. A function f ∈ Hᵖ which is equal to its outer part (up to a multiplicative constant of modulus 1), f = λ[f], will simply be called outer.", "Operator theory", "Dataset/NikolskiOperators.lean", "nikolski_B_4_3_3_devinatz_widom", ["boundaryValue", "unitCirclePoint", "HardyClass", "OuterFunction", "circleHilbertTransform", "circleFourierCoefficient", "symbolDistanceToHInfinity", "RepresentsToeplitzOperator", "EssentiallyBoundedCircleSymbol", "IsUnimodularCircleSymbol"]),
    Entry(10, "7.2.1. Theorem (V. Adamyan, D. Arov, and M. Krein, 1971). Let Hφ be a Hankel operator and let Rₙ be the set of rational functions tending to 0 at infinity and having all poles in D such that their total multiplicity is less than or equal to n. Then sₙ(Hφ) = min{‖Hφ − Hψ‖ : rank Hψ ≤ n} = distₗ∞(φ, Rₙ + H∞) = min{‖H_{̅Bφ}‖ : B is a Blaschke product of degree ≤ n}, where the degree deg Θ of an inner function Θ is equal to n if Θ is a finite Blaschke product with n zeros (counting multiplicities) and ∞ otherwise.", "Operator theory", "Dataset/NikolskiOperators.lean", "nikolski_B_7_2_1_adamyan_arov_krein", ["unitCirclePoint", "circleFourierCoefficient", "BoundedHankelForm", "HasBoundedHankelSymbol", "HankelMatrixRankLE", "hankelRankApproximationDistance", "RationalVanishingAtInfinityDegreeLE", "rationalPlusHInfinityDistance", "FiniteBlaschkeProductDegreeLE", "finiteBlaschkeHankelDistance"]),
]


KRYLOV_HOLDER = [
    Entry(
        1,
        "Theorem 2.3.1. Let Ω be a regular bounded domain. Assume that for any x ∈ Ω there exists a function h(x, ·) ∈ C²(Ω) such that Δ_y h(x,y) = 0 in Ω, h(x,y) = K(x,y) for y ∈ ∂Ω. Define the Green's function G(x,y) = K(x,y) - h(x,y) so that, in particular, Δ_y G(x,y) = 0 in Ω ∖ {x} and G(x,y) = 0 for y ∈ ∂Ω. Then for any C²(Ω)-solution u of the Dirichlet problem (2.3.1) and x ∈ Ω we have u(x) = ∫_Ω G(x,y)f(y)dy + ∫_{∂Ω} H(x,y)g(y)dS_y, where H(x,y) := -∂G(x,y)/∂n_y, x ∈ Ω, y ∈ ∂Ω, is the so-called Poisson kernel.",
        "PDE",
        "Dataset/KrylovHolder.lean",
        "krylov_2_3_1_green_poisson_representation",
        [
            "directionalDerivativeList",
            "multiIndexDirections",
            "multiDerivative",
            "laplacian",
            "RegularBoundedDomain",
            "IsOutwardUnitNormal",
            "LaplaceDirichletSolution",
        ],
    ),
    Entry(
        2,
        "Theorem 2.5.2. Let Ω be a domain and u ∈ C²_{loc}(Ω) ∩ C(Ω) be a harmonic function in Ω. Then u is infinitely differentiable in Ω and for any multi-index α and any x ∈ Ω we have |D^α u(x)| ≤ N R^{-|α|} sup_{B_R(x)} |u| whenever B_R(x) ⊂ Ω.",
        "PDE",
        "Dataset/KrylovHolder.lean",
        "krylov_2_5_2_harmonic_smooth_interior_estimates",
        ["directionalDerivativeList", "multiIndexDirections", "multiDerivative", "laplacian", "HarmonicIn"],
    ),
    Entry(
        3,
        "Theorem 2.9.2. Let Ω be a domain in ℝ^d and u be a bounded and continuous function on Ω and u = 0 on ∂Ω if ∂Ω ≠ ∅ (that is, if Ω ≠ ℝ^d). Moreover, assume that u ∈ C²_{loc}(Ω). Finally, let a(x), b(x) be bounded and c(x) ≤ -λ where the constant λ > 0. Then in Ω, u ≤ λ^{-1} sup_Ω (Lu)^- and |u| ≤ λ^{-1} sup_Ω |Lu|.",
        "PDE",
        "Dataset/KrylovHolder.lean",
        "krylov_2_9_2_bounded_maximum_principle_resolvent",
        ["directionalDerivativeList", "multiIndexDirections", "multiDerivative", "EllipticOperatorData", "SecondOrderEllipticOperator", "functionSupNorm"],
    ),
    Entry(
        4,
        "Theorem 3.7.2. Let λ ≠ 0, k ≥ 0 be an integer and 0 < δ < 1. Then for any f ∈ C^{k+δ}(ℝ^d) there exists a unique solution u ∈ C^{k+m+δ}(ℝ^d) of the equation L_λ u(x) = f(x), x ∈ ℝ^d.",
        "PDE",
        "Dataset/KrylovHolder.lean",
        "krylov_3_7_2_constant_coefficient_holder_solvability",
        [
            "directionalDerivativeList",
            "multiIndexDirections",
            "multiDerivative",
            "holderGauge",
            "HolderOn",
            "EllipticOperatorData",
            "ConstantCoefficientEllipticOperator",
            "ShiftedEllipticEquation",
        ],
    ),
    Entry(
        5,
        "Theorem 4.2.1. Let the assumptions of Theorem 4.1.2 be satisfied, and let k ≥ 0 be an integer, K₁ ≥ 1 be a constant. Assume that for any α we have |a^α|_{k+δ} ≤ K₁. Then for any λ, the inclusions u ∈ C^{m+δ}(ℝ^d) and L_λ u ∈ C^{k+δ}(ℝ^d) imply that u ∈ C^{k+m+δ}(ℝ^d). Moreover, if we take λ₀ from Theorem 4.1.2 and take a real λ so that |λ| ≥ λ₀, then there exists a constant N > 0 depending only on κ, k, m, δ, K₁, d, such that for any u ∈ C^{k+m+δ}(ℝ^d) we have |u|_{k+m+δ} + |λ|^{(k+m+δ)/m}|u|₀ ≤ N(|L_λu|_{k+δ} + |λ|^{(k+δ)/m}|L_λu|₀).",
        "PDE",
        "Dataset/KrylovHolder.lean",
        "krylov_4_2_1_better_regular_data_better_regular_solution",
        [
            "directionalDerivativeList",
            "multiIndexDirections",
            "multiDerivative",
            "holderGauge",
            "HolderOn",
            "EllipticOperatorData",
            "VariableCoefficientEllipticOperator",
            "OperatorCoefficientsHolder",
            "OperatorCoefficientGaugeLE",
            "ShiftedEllipticEquation",
        ],
    ),
    Entry(
        6,
        "Theorem 4.5.1. Let L = L(x) = ∑_{|α|≤m} a^α(x)D^α be a uniformly elliptic operator, and k ≥ 0 be an integer. Assume that a^α ∈ C^{k+δ}(ℝ^d) for any α. Define the constant λ₀ depending only on the ellipticity constant κ and m, δ, d and maximum of |a^α|_δ as in Theorem 4.1.2, and take any real λ such that |λ| ≥ λ₀. Then for any f ∈ C^{k+δ}(ℝ^d) there exists a unique solution u ∈ C^{k+m+δ}(ℝ^d) of the equation L_λ u(x) = f(x), x ∈ ℝ^d.",
        "PDE",
        "Dataset/KrylovHolder.lean",
        "krylov_4_5_1_variable_coefficient_global_solvability",
        [
            "directionalDerivativeList",
            "multiIndexDirections",
            "multiDerivative",
            "holderGauge",
            "HolderOn",
            "EllipticOperatorData",
            "VariableCoefficientEllipticOperator",
            "OperatorCoefficientsHolder",
            "ShiftedEllipticEquation",
        ],
    ),
    Entry(
        7,
        "Theorem 6.5.3. For any f ∈ C^{k+δ}(Ω) and g ∈ C^{k+2+δ}(Ω̄) there exists a unique function u ∈ C^{k+2+δ}(Ω) satisfying the equation Lu = f in Ω and equal to g on ∂Ω.",
        "PDE",
        "Dataset/KrylovHolder.lean",
        "krylov_6_5_3_smooth_domain_dirichlet_solvability",
        [
            "directionalDerivativeList",
            "multiIndexDirections",
            "multiDerivative",
            "holderGauge",
            "HolderOn",
            "SmoothBoundedDomain",
            "EllipticOperatorData",
            "VariableCoefficientEllipticOperator",
            "EllipticDirichletSolution",
        ],
    ),
    Entry(
        8,
        "Theorem 7.1.2. Let Ω be a domain in ℝ^d and u ∈ C^{m+δ}(Ω). Assume that L_λu ∈ C^{k+δ}(Ω) for some λ. Then u ∈ C^{k+m+δ}(Ω).",
        "PDE",
        "Dataset/KrylovHolder.lean",
        "krylov_7_1_2_interior_holder_regularization",
        ["directionalDerivativeList", "multiIndexDirections", "multiDerivative", "holderGauge", "HolderOn", "EllipticOperatorData", "ShiftedEllipticEquation"],
    ),
    Entry(
        9,
        "Theorem 8.7.3. For any f ∈ C^{δ/2,δ}(ℝ^{d+1}) there exists a unique function u ∈ C^{1+δ/2,2+δ}(ℝ^{d+1}) satisfying the equation Δu - u_t - u = f in ℝ^{d+1}.",
        "PDE",
        "Dataset/KrylovHolder.lean",
        "krylov_8_7_3_shifted_heat_holder_solvability",
        ["directionalDerivativeList", "multiIndexDirections", "multiDerivative", "laplacian", "HolderOnReal", "ParabolicHolderOn", "ShiftedHeatEquation"],
    ),
    Entry(
        10,
        "Theorem 10.3.3. For any f ∈ C^{δ/2,δ}(Q) and g ∈ C^{1+δ/2,2+δ}(Q) there exists a unique function u ∈ C^{1+δ/2,2+δ}(Q) satisfying the equation Lu - u_t = f in Q and equal g on ∂'Q.",
        "PDE",
        "Dataset/KrylovHolder.lean",
        "krylov_10_3_3_parabolic_dirichlet_domain_solvability",
        ["directionalDerivativeList", "multiIndexDirections", "multiDerivative", "holderGauge", "HolderOnReal", "ParabolicHolderOn", "ParabolicOperator", "ParabolicOperatorCoefficientsHolder", "parabolicBoundary", "ParabolicDirichletSolution"],
    ),
]


KRYLOV_SOBOLEV = [
    Entry(
        1,
        'Exercise 10.4.2. Let Ω = ℝ^d or Ω = ℝ^d_+ and assume that (2) holds for any u ∈ C_0^∞(Ω) and some k, m, p, q with a constant independent of u. Then prove that k ≥ m and (1) holds. Notation: The displays referred to are those of Lemma 10.4.1, where k ∈ {1, 2, ...}, p ∈ [1, ∞), m ∈ {0, ..., k} and q ∈ (0, ∞): k - (d)/(p) = m - (d)/(q) [u]_{W_q^m(Ω)} ≤ N[u]_{W_p^k(Ω)} Here [u]_{W_p^k(Ω)} = ∑_{|α| = k}‖D^α u‖_{L_p(Ω)} is the top-order seminorm — the sum runs over multi-indices of order exactly k — and ℝ^d_+ = {x ∈ ℝ^d : x^1 > 0}. In the exercise k, m, p, q are not assumed to satisfy any relation that they must is the point. For an integer k ≥ 0, C_0^k denotes the C^k functions on ℝ^d that vanish for |x| sufficiently large, and C_0^∞ the infinitely differentiable ones. Subscripts denote partial derivatives: u_{x^i} = D_iu and u_{x^ix^j} = D_{ij}u. Repeated indices are summed. L_p = L_p(ℝ^d) is taken with respect to Lebesgue measure.',
        "PDE",
        "Dataset/KrylovSobolev.lean",
        "krylov_sobolev_10_4_2_seminorm_embedding_forces_scaling_relation",
        ['partialDeriv', 'multiDeriv'],
    ),
    Entry(
        2,
        'Lemma 12.10.2. Let p ∈ (1, ∞] and let 0 < δ := γ - d/p < 1. Then there is a constant N such that, for any φ ∈ S and x, y ∈ ℝ^d, |φ(x)| ≤ N‖(1 - Δ)^{γ/2}φ‖_{L_p}, |φ(x) - φ(y)| ≤ N|x - y|^δ‖(1 - Δ)^{γ/2}φ‖_{L_p}. Notation: S is the Schwartz space. By Definition 12.9.1, (1 - Δ)^{γ/2} is the pseudo-differential operator with symbol (1 + |ξ|^2)^{γ/2}, that is (1-Δ)^{γ/2}φ = F^{-1}((1 + |ξ|^2)^{γ/2}Fφ), where F is the Fourier transform. At p = ∞ the convention is d/p = 0, so δ = γ.',
        "PDE",
        "Dataset/KrylovSobolev.lean",
        "krylov_sobolev_12_10_2_bessel_potential_holder_embedding",
        ['besselOp'],
    ),
    Entry(
        3,
        'Exercise 12.2.13. Prove that if the coefficients a^α of an mth order strongly elliptic differential operator are real and d ≥ 2, then m is even. Notation: From Definition 12.2.1: let m ≥ 1 be an integer and let a^α be some (complex) numbers given for any multi-indices α such that |α| ≤ m. The operator L = ∑_{|α| ≤ m}a^α D^α is called an mth order operator with constant coefficients. It is called (mth order) strongly elliptic if both ∑_{|α| = m}a^αξ^α ≠ 0 for ξ ∈ ℝ^d minus {0}, ∑_{|α| ≤ m}a^α i^{|α|}ξ^α ≠ 0 for ξ ∈ ℝ^d. The polynomial σ(ξ) = σ_L(ξ) = ∑_{|α| ≤ m}a^α i^{|α|}ξ^α is called the characteristic polynomial of L. Here ξ^α = (ξ^1)^{α_1}...(ξ^d)^{α_d}.',
        "PDE",
        "Dataset/KrylovSobolev.lean",
        "krylov_sobolev_12_2_13_real_strongly_elliptic_order_even",
        ['IsStronglyElliptic'],
    ),
    Entry(
        4,
        "Exercise 13.3.13. Prove that for any g ∈ H_p^{-1} there exist f_0, ..., f_d ∈ L_p such that g = f_0 + ∑_j D_jf_j and ∑_{j=0}^d‖f_j‖_{L_p} ≤ N‖g‖_{H_p^{-1}}, where the constant N is independent of g. Also prove that if (7) holds with f_0, ..., f_d ∈ L_p, then g ∈ H_p^{-1} and ‖g‖_{H_p^{-1}} ≤ N∑_{j=0}^d‖f_j‖_{L_p}, where the constant N is independent of the f_j's. Notation: Throughout Section 13.3, p ∈ (1, ∞). By Definition 13.3.1, H_p^γ = (1 - Δ)^{-γ/2}L_p and, for g ∈ H_p^γ, ‖g‖_{H_p^γ} = ‖(1 - Δ)^{γ/2}g‖_{L_p}. These are the spaces of Bessel potentials. In (7) the D_jf_j are distributional derivatives, so the identity is an identity of distributions, not of functions.",
        "PDE",
        "Dataset/KrylovSobolev.lean",
        "krylov_sobolev_13_3_13_negative_order_divergence_decomposition",
        ['sobolevNorm'],
    ),
    Entry(
        5,
        'Exercise 13.3.16. Sometimes it is hard to recognize whether a function u is in H_p^γ, for a γ < 0. Prove that if u has support in B_ρ, where ρ ∈ (0, ∞), and |u(x)| ≤ N_0|x|^{-ν}, ν < d, 0 < (ν + γ)p < d, γ < 0, then u ∈ H_p^γ and ‖u‖_{H_p^γ} is less than a constant depending only on d, p, ρ, ν, γ, N_0. Observe that generally such a u ∉ L_p, because one need not have ν p < d, and one cannot use the trivial embedding L_p ⊂ H_p^γ. By using Corollary 11 generalize the result and prove that if n ∈ {0, 1, ...}, γ ∈ ℝ, γ ≤ n, u has support in B_ρ, |D^α u(x)| ≤ N_0|x|^{-ν}, ∀|α| ≤ n, ν < d, and either γ < n and 0 < (ν + γ - n)p < d, or γ = n and ν p < d, then u ∈ H_p^γ and ‖u‖_{H_p^γ} is estimated by a constant depending only on d, p, ρ, ν, γ, n, N_0. Notation: Throughout Section 13.3, p ∈ (1, ∞), and H_p^γ with its norm is Definition 13.3.1: H_p^γ = (1 - Δ)^{-γ/2}L_p with ‖g‖_{H_p^γ} = ‖(1 - Δ)^{γ/2}g‖_{L_p}. B_ρ is the ball of radius ρ centered at the origin. For an integer k ≥ 0, C_0^k denotes the C^k functions on ℝ^d that vanish for |x| sufficiently large, and C_0^∞ the infinitely differentiable ones. Subscripts denote partial derivatives: u_{x^i} = D_iu and u_{x^ix^j} = D_{ij}u. Repeated indices are summed. L_p = L_p(ℝ^d) is taken with respect to Lebesgue measure.',
        "PDE",
        "Dataset/KrylovSobolev.lean",
        "krylov_sobolev_13_3_16_pointwise_decay_implies_negative_order_membership",
        ['partialDeriv', 'multiDeriv', 'sobolevNorm'],
    ),
    Entry(
        6,
        'Theorem 13.6.3. There exists a constant λ_0 > 0, depending only on d, p, κ, ω, and K, such that for any λ ≥ λ_0 and f^1, ..., f^d, g ∈ L_p there exists a unique u ∈ W_p^1 satisfying (1). Furthermore, for this solution λ^{1/2}‖u‖_{L_p} + ‖Du‖_{L_p} ≤ N(λ^{-1/2}‖g‖_{L_p} + ∑_{i=1}^d‖f^i‖_{L_p}), where N depends only on d, p, κ, and K. Notation: The standing setting of Section 13.6: p ∈ (1, ∞) is fixed and in ℝ^d we consider the equation Lu - λ u = D_if^i + g where Lu(x) = D_i(a^{ij}(x)D_ju(x) + a^i(x)u(x)) + b^i(x)D_iu(x) + c(x)u(x). All coefficients and f^i and g are real valued and, for some constant K, κ > 0 and all i, j, on ℝ^d |a^{ij}|, |a^i|, |b^i|, |c| ≤ K, a^{rk}ξ^rξ^k ≥ κ|ξ|^2, ∀ξ ∈ ℝ^d. There also exists a function ω(ε), ε > 0, such that ω(ε) → 0 as ε ↓ 0 and, for all i, j and x, y ∈ ℝ^d with |x - y| ≤ ε, |a^{ij}(x) - a^{ij}(y)| ≤ ω(ε). Solutions of (1) are sought in the class W_p^1 = H_p^1, and (1) is understood in the sense of distributions. For an integer k ≥ 0, C_0^k denotes the C^k functions on ℝ^d that vanish for |x| sufficiently large, and C_0^∞ the infinitely differentiable ones. Subscripts denote partial derivatives: u_{x^i} = D_iu and u_{x^ix^j} = D_{ij}u. Repeated indices are summed. L_p = L_p(ℝ^d) is taken with respect to Lebesgue measure.',
        "PDE",
        "Dataset/KrylovSobolev.lean",
        "krylov_sobolev_13_6_3_divergence_form_solvability",
        ['partialDeriv', 'HasWeakGradient', 'IsDivergenceFormSolution'],
    ),
    Entry(
        7,
        'Exercise 1.1.13. Let m ≥ 1 be an integer and let a^α be some (complex) numbers, not all of which are zero, given for any multi-indices α such that |α| ≤ m. Consider the operator L = ∑_{|α| ≤ m} a^α D^α and prove that the set LC_0^∞ is everywhere dense in L_p for any p ∈ [2, ∞). Notation: A multi-index is a d-tuple α = (α_1, ..., α_d) of non-negative integers, |α| = α_1 + ... + α_d, and D^α = D_1^{α_1}... D_d^{α_d}. The exponent range here is [2, ∞), not the [1, ∞) of Theorem 1.1.6 Remark 1.1.14 flags the restriction. For an integer k ≥ 0, C_0^k denotes the C^k functions on ℝ^d that vanish for |x| sufficiently large, and C_0^∞ the infinitely differentiable ones. Subscripts denote partial derivatives: u_{x^i} = D_iu and u_{x^ix^j} = D_{ij}u. Repeated indices are summed. L_p = L_p(ℝ^d) is taken with respect to Lebesgue measure.',
        "PDE",
        "Dataset/KrylovSobolev.lean",
        "krylov_sobolev_1_1_13_const_coeff_operator_range_dense",
        ['partialDeriv', 'multiDeriv'],
    ),
    Entry(
        8,
        'Exercise 1.3.23. (i) Let B be the open unit ball centered at the origin and let u be a twice continuously differentiable function on B-bar. Assume that u = 0 on ∂ B. Set f = Δ u and prove that ‖u‖^2_{L_2(B)} + ∑_i‖u_{x^i}‖^2_{L_2(B)} ≤ 4‖f‖^2_{L_2(B)}. (ii) Given an integer n, denote by P_n the set of polynomials of x of degree ≤ n and let A be the operator A : P_n → P_n given by the formula Ap = Δ[(1 - |x|^2)p]. Conclude from (i) that A is invertible. Notation: Part (iii) of the exercise, which needs W_2^2(B), is not formalized. Δ u = u_{x^1x^1} + ... + u_{x^dx^d} is the Laplacian, and "degree ≤ n" means total degree in the d variables. For an integer k ≥ 0, C_0^k denotes the C^k functions on ℝ^d that vanish for |x| sufficiently large, and C_0^∞ the infinitely differentiable ones. Subscripts denote partial derivatives: u_{x^i} = D_iu and u_{x^ix^j} = D_{ij}u. Repeated indices are summed. L_p = L_p(ℝ^d) is taken with respect to Lebesgue measure.',
        "PDE",
        "Dataset/KrylovSobolev.lean",
        "krylov_sobolev_1_3_23_unit_ball_estimate_and_polynomial_operator_bijective",
        ['partialDeriv'],
    ),
    Entry(
        9,
        'Exercise 1.4.8. Let d = 2, a^{ij}(x) be measurable functions on ℝ^2 satisfying a^{ij} = a^{ji} and condition (5) for all x, ξ ∈ ℝ^2, where μ > 0 and ν > 0 are some constants. For a λ > 0 define Lu = L_λ u = a^{ij}u_{x^ix^j} - λ(a^{11} + a^{22})u. Prove that, for any u ∈ C_0^2, λ^2‖u‖^2_{L_2} + 2λ∑_{j=1}^2‖u_{x^j}‖^2_{L_2} + ∑_{j,k=1}^2‖u_{x^jx^k}‖^2_{L_2} ≤ (ν^2)/(μ^4)‖Lu‖^2_{L_2}. Notation: Condition (5), from Exercise 1.4.7, is the two-sided ellipticity bound μ|ξ|^2 ≤ a^{ij}ξ^iξ^j ≤ ν|ξ|^2 for all ξ ∈ ℝ^2. For an integer k ≥ 0, C_0^k denotes the C^k functions on ℝ^d that vanish for |x| sufficiently large, and C_0^∞ the infinitely differentiable ones. Subscripts denote partial derivatives: u_{x^i} = D_iu and u_{x^ix^j} = D_{ij}u. Repeated indices are summed. L_p = L_p(ℝ^d) is taken with respect to Lebesgue measure.',
        "PDE",
        "Dataset/KrylovSobolev.lean",
        "krylov_sobolev_1_4_8_two_dim_measurable_coeff_L2_estimate",
        ['partialDeriv'],
    ),
    Entry(
        10,
        'Exercise 9.1.7. Prove that, if u ∈ L_2 and ∈t_0^1‖u^{(ε)} - u‖^2_{L_2} ε^{-3} dε ≤ M^2, then u ∈ W_2^1 and ‖u_x‖_{L_2} ≤ N(M + ‖u‖_{L_2}), where N is independent of M and u. Notation: The mollification (1.8.4) is u^{(ε)}(x) = ∈t_{ℝ^d}u(x - ε y)ζ(y) dy, and the standing assumption inherited from Exercise 9.1.6 is that ζ ∈ C_0^∞ is even and integrates to one. W_2^1 is the space of u ∈ L_2 whose generalized first derivatives u_{x^j} exist and lie in L_2 v is the generalized derivative D_ju when ∈t u D_jφ = -∈t v φ for every φ ∈ C_0^∞. ‖u_x‖_{L_2} is the summed first-order seminorm ∑_j‖u_{x^j}‖_{L_2}. For an integer k ≥ 0, C_0^k denotes the C^k functions on ℝ^d that vanish for |x| sufficiently large, and C_0^∞ the infinitely differentiable ones. Subscripts denote partial derivatives: u_{x^i} = D_iu and u_{x^ix^j} = D_{ij}u. Repeated indices are summed. L_p = L_p(ℝ^d) is taken with respect to Lebesgue measure.',
        "PDE",
        "Dataset/KrylovSobolev.lean",
        "krylov_sobolev_9_1_7_mollification_rate_implies_weak_derivative",
        ['partialDeriv', 'HasWeakGradient'],
    ),
]


BOGACHEV_GAUSSIAN = [
    Entry(
        1,
        "Theorem 1.9.2. A random vector ξ in R^n is centered Gaussian if and only if for every pair (ξ_1,ξ_2) of independent copies of ξ and every real number φ, the random vectors ξ_1sinφ + ξ_2cosφ, ξ_1cosφ - ξ_2sinφ are independent copies of ξ. Notation: \"Independent copies of ξ\" means a pair of independent random vectors each distributed as ξ; equivalently, the joint law of the pair is μ⊗μ, where μ is the law of ξ. A Borel probability measure on R^n is Gaussian if every continuous linear functional has a (possibly degenerate) Gaussian law, and centered if its mean vector is 0.",
        "Probability",
        "Dataset/BogachevGaussian.lean",
        "bogachev_gaussian_1_9_2_rotation_characterization",
        [],
    ),
    Entry(
        2,
        "Theorem 1.9.3. Let η and ξ be two independent random variables with a common symmetric distribution such that P(|{ξ+η}{sqrt{2}}| ≥ t) ≤ P(|ξ| ≥ t), ∀ t ≥ 0. Then these random variables are Gaussian. Notation: A distribution μ on the real line is *symmetric* if it is invariant under x ↦ -x. A measure on R is Gaussian when it is of the form N(a,σ^2), degenerate values σ = 0 (Dirac measures) included.",
        "Probability",
        "Dataset/BogachevGaussian.lean",
        "bogachev_gaussian_1_9_3_symmetric_tail_characterization",
        [],
    ),
    Entry(
        3,
        "Theorem 2.4.5. Let γ be a Gaussian measure on a locally convex space X. (i) Let h ∈ X be a vector such that |h|_{H(γ)} = sup{f(h) : f ∈ X^, R_γ(f)(f) ≤ 1} = ∞; then the measures γ_h and γ are mutually singular; (ii) if |h|_{H(γ)} < ∞, then the measures γ and γ_h are equivalent. In particular, H(γ) = {h ∈ X : γ_h ~ γ} = {h ∈ X : |h|_{H(γ)} < ∞} = X ∩ R_γ(X^). Notation: A Gaussian measure on a locally convex space X is a Borel probability measure γ all of whose one-dimensional projections f_{\\#}γ, f ∈ X^, are Gaussian measures on the real line. Write a_γ(f) = ∫_X f dγ and R_γ(f)(f) = ∫_X (f-a_γ(f))^2 dγ. Definition 2.4.1. The *Cameron–Martin space* of γ is H(γ) = {h ∈ X : |h|_{H(γ)} < ∞}, where |h|_{H(γ)} = sup{f(h) : f ∈ X^, R_γ(f)(f) ≤ 1}. For h ∈ X we write γ_h = γ( · - h) for the shift of γ by h; μ ~ ν means that μ and ν are equivalent (mutually absolutely continuous) and μ ⊥ ν that they are mutually singular.",
        "Measure theory",
        "Dataset/BogachevGaussian.lean",
        "bogachev_gaussian_2_4_5_cameron_martin_dichotomy",
        ["cameronMartinNorm", "cameronMartinSpace", "Equivalent"],
    ),
    Entry(
        4,
        "Theorem 2.5.2. Let γ be a Gaussian measure on a locally convex space X such that R_γ(X^) ⊂ X. Suppose that a set A ∈ E(X)_γ satisfies the condition γ(A + h) = γ(A), ∀ h ∈ R_γ(X^). Then either γ(A) = 1 or γ(A) = 0. In addition, if f is a γ-measurable function such that for every h ∈ R_γ(X^) one has f(x+h) = f(x) γ-a.e., then f coincides a.e. with a constant. Notation: A Gaussian measure on a locally convex space X is a Borel probability measure γ all of whose one-dimensional projections f_{\\#}γ, f ∈ X^, are Gaussian measures on the real line. Write a_γ(f) = ∫_X f dγ and R_γ(f)(f) = ∫_X (f-a_γ(f))^2 dγ. Definition 2.4.1. The *Cameron–Martin space* of γ is H(γ) = {h ∈ X : |h|_{H(γ)} < ∞}, where |h|_{H(γ)} = sup{f(h) : f ∈ X^, R_γ(f)(f) ≤ 1}. For h ∈ X we write γ_h = γ( · - h) for the shift of γ by h; μ ~ ν means that μ and ν are equivalent (mutually absolutely continuous) and μ ⊥ ν that they are mutually singular. Under the hypothesis R_γ(X^) ⊂ X one has H(γ) = R_γ(X^), so the shifts in the statement are exactly the shifts by Cameron–Martin vectors.",
        "Measure theory",
        "Dataset/BogachevGaussian.lean",
        "bogachev_gaussian_2_5_2_zero_one_law",
        ["cameronMartinSpace"],
    ),
    Entry(
        5,
        "Theorem 2.7.2. Any two Gaussian measures on one and the same locally convex space are either equivalent or mutually singular. Notation: A Gaussian measure on a locally convex space X is a Borel probability measure γ all of whose one-dimensional projections f_{\\#}γ, f ∈ X^, are Gaussian measures on the real line. Write a_γ(f) = ∫_X f dγ and R_γ(f)(f) = ∫_X (f-a_γ(f))^2 dγ. Definition 2.4.1. The *Cameron–Martin space* of γ is H(γ) = {h ∈ X : |h|_{H(γ)} < ∞}, where |h|_{H(γ)} = sup{f(h) : f ∈ X^, R_γ(f)(f) ≤ 1}. For h ∈ X we write γ_h = γ( · - h) for the shift of γ by h; μ ~ ν means that μ and ν are equivalent (mutually absolutely continuous) and μ ⊥ ν that they are mutually singular.",
        "Measure theory",
        "Dataset/BogachevGaussian.lean",
        "bogachev_gaussian_2_7_2_feldman_hajek",
        ["Equivalent"],
    ),
    Entry(
        6,
        "Theorem 2.8.10. Let γ be a centered Gaussian measure on a locally convex space X and let A ∈ E(X)_γ be an absolutely convex set. Then, for any a ∈ X such that A + a ∈ E(X)_γ, the following inequality holds true: γ(A+a) ≤ γ(A). More generally, if A + ta ∈ E(X)_γ for all t ∈ [0,1], then γ(A+a) ≤ γ(A+ta), ∀ t ∈ [0,1]. Notation: A Gaussian measure on a locally convex space X is a Borel probability measure γ all of whose one-dimensional projections f_{\\#}γ, f ∈ X^, are Gaussian measures on the real line. Write a_γ(f) = ∫_X f dγ and R_γ(f)(f) = ∫_X (f-a_γ(f))^2 dγ. Definition 2.4.1. The *Cameron–Martin space* of γ is H(γ) = {h ∈ X : |h|_{H(γ)} < ∞}, where |h|_{H(γ)} = sup{f(h) : f ∈ X^, R_γ(f)(f) ≤ 1}. For h ∈ X we write γ_h = γ( · - h) for the shift of γ by h; μ ~ ν means that μ and ν are equivalent (mutually absolutely continuous) and μ ⊥ ν that they are mutually singular. A set A is *absolutely convex* if it is convex and balanced, i.e. α A ⊂ A whenever |α| ≤ 1.",
        "Measure theory",
        "Dataset/BogachevGaussian.lean",
        "bogachev_gaussian_2_8_10_anderson_inequality",
        [],
    ),
    Entry(
        7,
        "Theorem 4.2.1. Let A and B be two convex sets in R^n. Then one has for all λ ∈ [0,1]: Φ^{-1}{γ_n(λ A + (1-λ)B)} ≥ λΦ^{-1}{γ_n(A)} + (1-λ)Φ^{-1}{γ_n(B)}. Notation: γ_n is the standard Gaussian measure on R^n, Φ is the standard normal distribution function Φ(x) = γ_1((-∞,x]), and Φ^{-1} is its inverse with the convention Φ^{-1}(0) = -∞ and Φ^{-1}(1) = +∞. λ A + (1-λ)B = {λ x + (1-λ)y : x ∈ A, y ∈ B} is the Minkowski combination of the two sets.",
        "Measure theory",
        "Dataset/BogachevGaussian.lean",
        "bogachev_gaussian_4_2_1_ehrhard_inequality",
        ["quantile"],
    ),
    Entry(
        8,
        "Theorem 4.3.1. Let γ_n be the standard Gaussian measure on R^n and let U be the closed unit ball in R^n centered at the origin. For every measurable set A ⊂ R^n, the following inequality holds true: Φ^{-1}(γ_n(A+rU)) ≥ Φ^{-1}(γ_n(A)) + r, ∀ r > 0. Notation: γ_n is the standard Gaussian measure on R^n, Φ is the standard normal distribution function Φ(x) = γ_1((-∞,x]), and Φ^{-1} is its inverse with the convention Φ^{-1}(0) = -∞ and Φ^{-1}(1) = +∞. A + rU = {z : dist(z,A) ≤ r} is the closed r-neighbourhood of A in the Euclidean metric.",
        "Measure theory",
        "Dataset/BogachevGaussian.lean",
        "bogachev_gaussian_4_3_1_isoperimetric_inequality",
        ["quantile"],
    ),
    Entry(
        9,
        "Example 4.5.8. Let f be a γ-measurable seminorm on X. Then it satisfies condition (4.5.4). Put χ(f) := sup{f(h) : |h|_{H(γ)} ≤ 1}, Ef := ∫ f dγ. Then one has γ{x : |f(x) - Ef| > t} ≤ 2exp(-(2)/(π^2χ(f)^2)t^2). Notation: A Gaussian measure on a locally convex space X is a Borel probability measure γ all of whose one-dimensional projections f_{\\#}γ, f ∈ X^, are Gaussian measures on the real line. Write a_γ(f) = ∫_X f dγ and R_γ(f)(f) = ∫_X (f-a_γ(f))^2 dγ. Definition 2.4.1. The *Cameron–Martin space* of γ is H(γ) = {h ∈ X : |h|_{H(γ)} < ∞}, where |h|_{H(γ)} = sup{f(h) : f ∈ X^, R_γ(f)(f) ≤ 1}. For h ∈ X we write γ_h = γ( · - h) for the shift of γ by h; μ ~ ν means that μ and ν are equivalent (mutually absolutely continuous) and μ ⊥ ν that they are mutually singular.",
        "Measure theory",
        "Dataset/BogachevGaussian.lean",
        "bogachev_gaussian_4_5_8_seminorm_concentration",
        ["cameronMartinGauge"],
    ),
    Entry(
        10,
        "Theorem 4.6.1. Let γ be a centered Gaussian measure on R^n. Then for every absolutely convex set A and every strip Π of the form Π = {x : |f(x)| ≤ c}, where f is a linear function and c ∈ R^1, one has γ(A ∩ Π) ≥ γ(A)γ(Π). Notation: A set A is *absolutely convex* if it is convex and balanced. A measure on R^n is centered Gaussian when every linear functional has a centered Gaussian law.",
        "Measure theory",
        "Dataset/BogachevGaussian.lean",
        "bogachev_gaussian_4_6_1_correlation_convex_strip",
        [],
    ),
]


FOLLAND_HARMONIC = [
    Entry(
        1,
        '1.18 Corollary. If f(e^{iθ}) = ∑ a_n e^{inθ} with ∑ |a_n| < ∞, and f never vanishes, then 1/f(e^{iθ}) = ∑ b_n e^{inθ} with ∑ |b_n| < ∞. Notation: the sums run over all n ∈ ℤ. The corollary is read off from Theorem 1.17, which identifies the Gelfand spectrum σ(l^1) of the convolution algebra l^1(ℤ) with the unit circle T so that the Gelfand transform becomes â(e^{iθ}) = ∑_{-∞}^{∞} a_n e^{inθ}.',
        "Harmonic analysis",
        "Dataset/FollandHarmonic.lean",
        "folland_1_18_wiener_inverse_of_absolutely_convergent_series",
        [],
    ),
    Entry(
        2,
        '2.29 Proposition. If G/[G,G] is compact, then G is unimodular. Notation: [G,G] denotes the smallest closed subgroup of G containing all elements of the form [x,y] = xyx^{-1}y^{-1}; it is called the commutator subgroup of G, and it is normal since z[x,y]z^{-1} = [zxz^{-1}, zyz^{-1}]. Notation: Throughout, G is a locally compact group with a fixed left Haar measure, L_yf(x) = f(y^{-1}x) and R_yf(x) = f(xy) are the left and right translates of f, and f*g(x) = ∫ f(y)g(y^{-1}x) dy is convolution. 𝓛^1(G) is a Banach algebra under convolution. The modular function Δ : G → (0,∞) is determined by λ(Ex) = Δ(x)λ(E) for a left Haar measure λ; G is unimodular when Δ ≡ 1.',
        "Harmonic analysis",
        "Dataset/FollandHarmonic.lean",
        "folland_2_29_unimodular_of_compact_commutator_quotient",
        [],
    ),
    Entry(
        3,
        "2.31 Theorem. If λ is a left Haar measure on G and Δ is the modular function of G, then for every f ∈ L^1(G) ∫_G f(x^{-1})Δ(x^{-1}) dλ(x) = ∫_G f(x) dλ(x). Notation: Throughout, G is a locally compact group with a fixed left Haar measure, L_yf(x) = f(y^{-1}x) and R_yf(x) = f(xy) are the left and right translates of f, and f*g(x) = ∫ f(y)g(y^{-1}x) dy is convolution. L^1(G) is a Banach algebra under convolution. The modular function Δ : G → (0,∞) is determined by λ(Ex) = Δ(x)λ(E) for a left Haar measure λ; it is a continuous homomorphism and is identically 1 exactly when G is unimodular.",
        "Harmonic analysis",
        "Dataset/FollandHarmonic.lean",
        "folland_2_31_modular_inversion_formula",
        [],
    ),
    Entry(
        4,
        '2.40 Proposition. Suppose 1 ≤ p ≤ ∞, f ∈ L^1(G), and g ∈ L^p(G). (a) The integrals in (2.36) converge absolutely for almost every x, and we have f*g ∈ L^p(G) and ‖f*g‖_p ≤ ‖f‖_1‖g‖_p. (b) If G is unimodular, the same conclusions hold with f*g replaced by g*f. (c) If G is not unimodular, we still have g*f ∈ L^p(G) when f has compact support. Notation: Throughout, G is a locally compact group with a fixed left Haar measure, L_yf(x) = f(y^{-1}x) and R_yf(x) = f(xy) are the left and right translates of f, and f*g(x) = ∫ f(y)g(y^{-1}x) dy is convolution. 𝓛^1(G) is a Banach algebra under convolution. The modular function Δ : G → (0,∞) is determined by λ(Ex) = Δ(x)λ(E) for a left Haar measure λ; G is unimodular when Δ ≡ 1.',
        "Harmonic analysis",
        "Dataset/FollandHarmonic.lean",
        "folland_2_40_convolution_lp_bound",
        ['groupConv'],
    ),
    Entry(
        5,
        '2.42 Proposition. If 1 ≤ p < ∞ and f ∈ L^p(G) then ‖L_yf - f‖_p and ‖R_yf - f‖_p tend to zero as y → 1. Notation: Throughout, G is a locally compact group with a fixed left Haar measure, L_yf(x) = f(y^{-1}x) and R_yf(x) = f(xy) are the left and right translates of f, and f*g(x) = ∫ f(y)g(y^{-1}x) dy is convolution. 𝓛^1(G) is a Banach algebra under convolution. The modular function Δ : G → (0,∞) is determined by λ(Ex) = Δ(x)λ(E) for a left Haar measure λ; G is unimodular when Δ ≡ 1.',
        "Harmonic analysis",
        "Dataset/FollandHarmonic.lean",
        "folland_2_42_translation_continuity_lp",
        ['leftTranslate', 'rightTranslate'],
    ),
    Entry(
        6,
        '2.44 Proposition. Let 𝒰 be a neighborhood base at 1 in G. For each U ∈ 𝒰, let ψ_U be a function such that (i) supp ψ_U is compact and contained in U, (ii) ψ_U ≥ 0 and ∫ ψ_U = 1. Then ‖ψ_U * f - f‖_p → 0 as U → {1} if 1 ≤ p < ∞ and f ∈ L^p, or if p = ∞ and f is left uniformly continuous. If, in addition, (iii) ψ_U(x^{-1}) = ψ_U(x) for all x, then ‖f * ψ_U - f‖_p → 0 as U → {1} if 1 ≤ p < ∞ and f ∈ L^p, or if p = ∞ and f is right uniformly continuous. A family {ψ_U} satisfying (i)–(iii) is called an approximate identity. Notation: Throughout, G is a locally compact group with a fixed left Haar measure, L_yf(x) = f(y^{-1}x) and R_yf(x) = f(xy) are the left and right translates of f, and f*g(x) = ∫ f(y)g(y^{-1}x) dy is convolution. 𝓛^1(G) is a Banach algebra under convolution. The modular function Δ : G → (0,∞) is determined by λ(Ex) = Δ(x)λ(E) for a left Haar measure λ; G is unimodular when Δ ≡ 1.',
        "Harmonic analysis",
        "Dataset/FollandHarmonic.lean",
        "folland_2_44_approximate_identity",
        ['groupConv'],
    ),
    Entry(
        7,
        "2.45 Theorem. Let I be a closed subspace of L^1(G). Then I is a left ideal if and only if it is closed under left translations, and I is a right ideal if and only if it is closed under right translations. Notation: Throughout, G is a locally compact group with a fixed left Haar measure, L_yf(x) = f(y^{-1}x) and R_yf(x) = f(xy) are the left and right translates of f, and f*g(x) = ∫ f(y)g(y^{-1}x) dy is convolution. L^1(G) is a Banach algebra under convolution.",
        "Harmonic analysis",
        "Dataset/FollandHarmonic.lean",
        "folland_2_45_closed_ideals_are_translation_invariant",
        ["leftTranslate", "rightTranslate", "groupConv", "IsLpClosed"],
    ),
    Entry(
        8,
        "2.51 Theorem. Suppose G is a locally compact group and H is a closed subgroup. There is a G-invariant Radon measure μ on G/H if and only if Δ_G|_H = Δ_H. In this case, μ is unique up to a constant factor, and if this factor is suitably chosen we have ∫_G f(x) dx = ∫_{G/H} Pf dμ = ∫_{G/H}∫_H f(xξ) dξ dμ(xH) for f ∈ C_c(G). Notation: Throughout, G is a locally compact group with a fixed left Haar measure, L_yf(x) = f(y^{-1}x) and R_yf(x) = f(xy) are the left and right translates of f, and f*g(x) = ∫ f(y)g(y^{-1}x) dy is convolution. L^1(G) is a Banach algebra under convolution. Pf(xH) = ∫_H f(xξ) dξ is the averaging map C_c(G) → C_c(G/H), and Δ_G, Δ_H are the modular functions of G and of H.",
        "Harmonic analysis",
        "Dataset/FollandHarmonic.lean",
        "folland_2_51_invariant_measure_on_quotient",
        [],
    ),
    Entry(
        9,
        "2.69 Theorem. On any locally compact group G we have L^1(G) L^p(G) = L^p(G) for 1 ≤ p < ∞. Moreover, L^1(G)*L^∞(G) = L^1(G)*C_{lu}(G) = C_{lu}(G) and L^∞(G)*L^1(G) = C_{ru}(G)*L^1(G) = C_{ru}(G). Notation: Throughout, G is a locally compact group with a fixed left Haar measure, L_yf(x) = f(y^{-1}x) and R_yf(x) = f(xy) are the left and right translates of f, and f*g(x) = ∫ f(y)g(y^{-1}x) dy is convolution. L^1(G) is a Banach algebra under convolution. C_{lu}(G) and C_{ru}(G) denote the bounded left- and right-uniformly continuous functions on G.",
        "Harmonic analysis",
        "Dataset/FollandHarmonic.lean",
        "folland_2_69_convolution_factorization",
        ["groupConv"],
    ),
    Entry(
        10,
        "4.81 Theorem. If f is a bounded continuous function on G, the following are equivalent: a. f is the restriction to G of a continuous function on bG. b. f is the uniform limit of linear combinations of characters on G. c. f is uniformly almost periodic. Notation: G is a locally compact abelian group, Ĝ its dual group of continuous characters ξ : G → T, and f̂(ξ) = ∫ f(x)conj(⟨ x,ξ⟩) dx the Fourier transform. For a closed ideal I ⊂ L^1(G), ν(I) = {ξ : f̂(ξ) = 0 for all f ∈ I} is its cospectrum (hull) and, for E ⊂ Ĝ, ι(E) = {f ∈ L^1(G) : f̂|_E = 0} is the kernel of E; ν(f) := ν({f}). bG is the Bohr compactification of G, and f is *uniformly almost periodic* when the set of its right translates {R_yf : y ∈ G} is totally bounded in the uniform norm.",
        "Harmonic analysis",
        "Dataset/FollandHarmonic.lean",
        "folland_4_81_almost_periodic_characterization",
        ["rightTranslate", "IsUniformlyAlmostPeriodic"],
    ),
]


HAYMAN_MEROMORPHIC = [
    Entry(
        1,
        "§2.0. The result [the second fundamental theorem] contains as a special case Picard's theorem that a transcendental meromorphic function assumes infinitely often all values in the plane except at most two. Notation: For a function f meromorphic in |z| < R_0, m(r,a), N(r,a) and T(r,f) = m(r,∞)+N(r,∞) are Nevanlinna's proximity, counting and characteristic functions; n(t,a) counts the roots of f(z)=a in |z| ≤ t with multiplicity and nbar(t,a) counts them without. Correspondingly Nbar(r,a) = ∫_0^r (nbar(t,a)-nbar(0,a))/(t) dt + nbar(0,a)log r. Assuming T(r,f)→∞ as r→ R_0, one sets δ(a) = liminf_{r→ R_0} (m(r,a))/(T(r)), Θ(a) = 1 - limsup_{r→ R_0}(Nbar(r,a))/(T(r)) and θ(a) = liminf_{r→ R_0}(N(r,a)-Nbar(r,a))/(T(r)). f is *admissible* in |z|<R_0 when R_0 = +∞ and f is not constant, or R_0<+∞ and (2.8) holds; S(r,f) denotes any quantity satisfying the conclusions of Theorem 2.2, so S(r,f)=o{T(r,f)}.",
        "Complex analysis",
        "Dataset/HaymanMeromorphic.lean",
        "hayman_2_0_picard_theorem",
        [],
    ),
    Entry(
        2,
        "Theorem 2.4. Suppose that f(z) is admissible in |z| < R_0. Then the set of values a for which Θ(a) > 0 is countable, and we have, on summing over all such values a ∑_a {δ(a)+θ(a)} ≤ ∑_a Θ(a) ≤ 2. Notation: For a function f meromorphic in |z| < R_0, m(r,a), N(r,a) and T(r,f) = m(r,∞)+N(r,∞) are Nevanlinna's proximity, counting and characteristic functions; n(t,a) counts the roots of f(z)=a in |z| ≤ t with multiplicity and nbar(t,a) counts them without. Correspondingly Nbar(r,a) = ∫_0^r (nbar(t,a)-nbar(0,a))/(t) dt + nbar(0,a)log r. Assuming T(r,f)→∞ as r→ R_0, one sets δ(a) = liminf_{r→ R_0} (m(r,a))/(T(r)), Θ(a) = 1 - limsup_{r→ R_0}(Nbar(r,a))/(T(r)) and θ(a) = liminf_{r→ R_0}(N(r,a)-Nbar(r,a))/(T(r)). f is *admissible* in |z|<R_0 when R_0 = +∞ and f is not constant, or R_0<+∞ and (2.8) holds; S(r,f) denotes any quantity satisfying the conclusions of Theorem 2.2, so S(r,f)=o{T(r,f)}.",
        "Complex analysis",
        "Dataset/HaymanMeromorphic.lean",
        "hayman_2_4_deficiency_relation",
        ["deficiency", "ramificationIndex", "nevanlinnaTheta"],
    ),
    Entry(
        3,
        "Theorem 2.5. If f(z) is meromorphic and admissible in |z| < R_0 and a_1(z), a_2(z), a_3(z) are distinct meromorphic functions satisfying for ν = 1, 2, and 3 T{r, a_ν(z)} = o{T(r,f)}, as r → R_0, then {1+o(1)}T(r,f) ≤ ∑_{ν=1}^{3} Nbar(r, (1)/(f-a_ν)) + S(r,f), as r → R_0, where S(r,f) satisfies the conclusions of Theorem 2.2. Notation: For a function f meromorphic in |z| < R_0, m(r,a), N(r,a) and T(r,f) = m(r,∞)+N(r,∞) are Nevanlinna's proximity, counting and characteristic functions; n(t,a) counts the roots of f(z)=a in |z| ≤ t with multiplicity and nbar(t,a) counts them without. Correspondingly Nbar(r,a) = ∫_0^r (nbar(t,a)-nbar(0,a))/(t) dt + nbar(0,a)log r. Assuming T(r,f)→∞ as r→ R_0, one sets δ(a) = liminf_{r→ R_0} (m(r,a))/(T(r)), Θ(a) = 1 - limsup_{r→ R_0}(Nbar(r,a))/(T(r)) and θ(a) = liminf_{r→ R_0}(N(r,a)-Nbar(r,a))/(T(r)). f is *admissible* in |z|<R_0 when R_0 = +∞ and f is not constant, or R_0<+∞ and (2.8) holds; S(r,f) denotes any quantity satisfying the conclusions of Theorem 2.2, so S(r,f)=o{T(r,f)}.",
        "Complex analysis",
        "Dataset/HaymanMeromorphic.lean",
        "hayman_2_5_deficient_small_functions",
        ["reducedLogCounting"],
    ),
    Entry(
        4,
        "Theorem 2.6. Suppose that f_1(z), f_2(z) are meromorphic in the plane and let E_j(a) be the set of points z such that f_j(z) = a (j = 1, 2). Then if E_1(a) = E_2(a) for five distinct values of a, f_1(z) ≡ f_2(z), or f_1, f_2 are both constant. Notation: For a function f meromorphic in |z| < R_0, m(r,a), N(r,a) and T(r,f) = m(r,∞)+N(r,∞) are Nevanlinna's proximity, counting and characteristic functions; n(t,a) counts the roots of f(z)=a in |z| ≤ t with multiplicity and nbar(t,a) counts them without. Correspondingly Nbar(r,a) = ∫_0^r (nbar(t,a)-nbar(0,a))/(t) dt + nbar(0,a)log r. Assuming T(r,f)→∞ as r→ R_0, one sets δ(a) = liminf_{r→ R_0} (m(r,a))/(T(r)), Θ(a) = 1 - limsup_{r→ R_0}(Nbar(r,a))/(T(r)) and θ(a) = liminf_{r→ R_0}(N(r,a)-Nbar(r,a))/(T(r)). f is *admissible* in |z|<R_0 when R_0 = +∞ and f is not constant, or R_0<+∞ and (2.8) holds; S(r,f) denotes any quantity satisfying the conclusions of Theorem 2.2, so S(r,f)=o{T(r,f)}.",
        "Complex analysis",
        "Dataset/HaymanMeromorphic.lean",
        "hayman_2_6_five_value_theorem",
        [],
    ),
    Entry(
        5,
        "Theorem 2.7. If f(z) is a transcendental integral function then f(z) possesses infinitely many fix-points of exact order n, except for at most one value of n. Notation: Let f(z) be an integral function. Set f_1(z) = f(z) and inductively f_{ν+1}(z) = f{f_ν(z)} for ν ≥ 1. The solutions of the equation f_ν(z) = z are called *fix-points of f(z) of order ν*. If ζ is a fix-point of f(z) of order ν, but of no lower order, then ζ is called a fix-point of *exact order* ν. An *integral function* is an entire function, and it is *transcendental* when it is not a polynomial.",
        "Complex analysis",
        "Dataset/HaymanMeromorphic.lean",
        "hayman_2_7_fixpoints_of_entire_functions",
        ["IsTranscendentalEntire"],
    ),
    Entry(
        6,
        "Theorem 2.9. Suppose that f(z), g(z) are integral functions and that φ(z) = g{f(z)} has finite order. Then either f(z) is a polynomial or g(z) has zero order. Notation: An *integral function* is an entire function. Writing M(r,f) = max_{|z|=r}|f(z)|, the function f has *finite order* when log M(r,f) = O(r^k) for some k, and *zero order* when log M(r,f) = O(r^ε) for every ε > 0.",
        "Complex analysis",
        "Dataset/HaymanMeromorphic.lean",
        "hayman_2_9_polya_composition_order",
        ["HasFiniteOrder", "HasZeroOrder"],
    ),
    Entry(
        7,
        "Theorem 3.4. Suppose that f(z) is a transcendental meromorphic function in the plane and ψ(z) = f^{(l)}(z). Then in the notation of Theorem 2.4 we have ∑_{a ≠ ∞} Θ(a,ψ) ≤ 1 + (1)/(l+1). In particular ψ(z) assumes every finite value with at most one exception infinitely often. Notation: For a function f meromorphic in |z| < R_0, m(r,a), N(r,a) and T(r,f) = m(r,∞)+N(r,∞) are Nevanlinna's proximity, counting and characteristic functions; n(t,a) counts the roots of f(z)=a in |z| ≤ t with multiplicity and nbar(t,a) counts them without. Correspondingly Nbar(r,a) = ∫_0^r (nbar(t,a)-nbar(0,a))/(t) dt + nbar(0,a)log r. Assuming T(r,f)→∞ as r→ R_0, one sets δ(a) = liminf_{r→ R_0} (m(r,a))/(T(r)), Θ(a) = 1 - limsup_{r→ R_0}(Nbar(r,a))/(T(r)) and θ(a) = liminf_{r→ R_0}(N(r,a)-Nbar(r,a))/(T(r)). f is *admissible* in |z|<R_0 when R_0 = +∞ and f is not constant, or R_0<+∞ and (2.8) holds; S(r,f) denotes any quantity satisfying the conclusions of Theorem 2.2, so S(r,f)=o{T(r,f)}.",
        "Complex analysis",
        "Dataset/HaymanMeromorphic.lean",
        "hayman_3_4_derivative_deficiency_bound",
        ["nevanlinnaTheta"],
    ),
    Entry(
        8,
        "Corollary. For all sufficiently large l, f^{(l)}(z) has zeros in every disk in which f(z) is meromorphic and has at least two distinct poles. Notation: For a function f meromorphic in |z| < R_0, m(r,a), N(r,a) and T(r,f) = m(r,∞)+N(r,∞) are Nevanlinna's proximity, counting and characteristic functions; n(t,a) counts the roots of f(z)=a in |z| ≤ t with multiplicity and nbar(t,a) counts them without. Correspondingly Nbar(r,a) = ∫_0^r (nbar(t,a)-nbar(0,a))/(t) dt + nbar(0,a)log r. Assuming T(r,f)→∞ as r→ R_0, one sets δ(a) = liminf_{r→ R_0} (m(r,a))/(T(r)), Θ(a) = 1 - limsup_{r→ R_0}(Nbar(r,a))/(T(r)) and θ(a) = liminf_{r→ R_0}(N(r,a)-Nbar(r,a))/(T(r)). f is *admissible* in |z|<R_0 when R_0 = +∞ and f is not constant, or R_0<+∞ and (2.8) holds; S(r,f) denotes any quantity satisfying the conclusions of Theorem 2.2, so S(r,f)=o{T(r,f)}.",
        "Complex analysis",
        "Dataset/HaymanMeromorphic.lean",
        "hayman_3_6_corollary_derivative_zeros_in_disk",
        [],
    ),
    Entry(
        9,
        "Theorem 3.6. Suppose that f(z) is meromorphic in |z-z_0| < R, where 0 < R ≤ ∞, and has at least two distinct poles there. Let r be the radius of the largest circle with centre z_0 containing no pole of f(z) in its interior. Then (i) if the circle |z-z_0| = r contains at least two distinct poles of f(z), then for every positive δ, the equation f^{(l)}(z) = 0 has roots in |z-z_0| < δ, when l is sufficiently large; (ii) if the circle |z-z_0| = r contains only one pole of f(z), then if δ is sufficiently small, f^{(l)}(z) → ∞ as l → ∞ uniformly in |z-z_0| ≤ δ. Notation: For a function f meromorphic in |z| < R_0, m(r,a), N(r,a) and T(r,f) = m(r,∞)+N(r,∞) are Nevanlinna's proximity, counting and characteristic functions; n(t,a) counts the roots of f(z)=a in |z| ≤ t with multiplicity and nbar(t,a) counts them without. Correspondingly Nbar(r,a) = ∫_0^r (nbar(t,a)-nbar(0,a))/(t) dt + nbar(0,a)log r. Assuming T(r,f)→∞ as r→ R_0, one sets δ(a) = liminf_{r→ R_0} (m(r,a))/(T(r)), Θ(a) = 1 - limsup_{r→ R_0}(Nbar(r,a))/(T(r)) and θ(a) = liminf_{r→ R_0}(N(r,a)-Nbar(r,a))/(T(r)). f is *admissible* in |z|<R_0 when R_0 = +∞ and f is not constant, or R_0<+∞ and (2.8) holds; S(r,f) denotes any quantity satisfying the conclusions of Theorem 2.2, so S(r,f)=o{T(r,f)}.",
        "Complex analysis",
        "Dataset/HaymanMeromorphic.lean",
        "hayman_3_6_derivative_zeros_near_poles",
        [],
    ),
    Entry(
        10,
        "Theorem 3.8. Suppose that f(z) is meromorphic and has only a finite number of poles in the plane, and that f(z), f^{(l)}(z) have only a finite number of zeros for some l ≥ 2. Then f(z) = (P_1(z))/(P_2(z))e^{P_3(z)}, where P_1, P_2, P_3 are polynomials. If, further, f(z) and f^{(l)}(z) have no zeros, then f(z) = e^{Az+B} or f(z) = (Az+B)^{-n}. Notation: For a function f meromorphic in |z| < R_0, m(r,a), N(r,a) and T(r,f) = m(r,∞)+N(r,∞) are Nevanlinna's proximity, counting and characteristic functions; n(t,a) counts the roots of f(z)=a in |z| ≤ t with multiplicity and nbar(t,a) counts them without. Correspondingly Nbar(r,a) = ∫_0^r (nbar(t,a)-nbar(0,a))/(t) dt + nbar(0,a)log r. Assuming T(r,f)→∞ as r→ R_0, one sets δ(a) = liminf_{r→ R_0} (m(r,a))/(T(r)), Θ(a) = 1 - limsup_{r→ R_0}(Nbar(r,a))/(T(r)) and θ(a) = liminf_{r→ R_0}(N(r,a)-Nbar(r,a))/(T(r)). f is *admissible* in |z|<R_0 when R_0 = +∞ and f is not constant, or R_0<+∞ and (2.8) holds; S(r,f) denotes any quantity satisfying the conclusions of Theorem 2.2, so S(r,f)=o{T(r,f)}.",
        "Complex analysis",
        "Dataset/HaymanMeromorphic.lean",
        "hayman_3_8_tumura_clunie_form",
        [],
    ),
]


NIVEN_ZUCKERMAN = [
    Entry(
        1,
        "Theorem 10.14. If p is a prime and 0 ≤ x < 1 then (φ(x^p))/(φ(x)^p) = 1 + p∑_{i=1}^{∞}a_ix^i where the a_i are integers. Notation: Here φ(x) = ∏_{n=1}^{∞}(1-x^n) is Euler's product, convergent for 0 ≤ x < 1, and p(n) denotes the number of partitions of n.",
        "Number theory",
        "Dataset/NivenZuckermanNumberTheory.lean",
        "niven_zuckerman_10_14_euler_product_prime_power",
        [],
    ),
    Entry(
        2,
        "Theorem 10.15. For 0 ≤ x < 1 we have xφ(x)^4 = ∑_{m=1}^{∞}b_mx^m where the b_m are integers and b_m ≡ 0 mod 5 if m ≡ 0 mod 5. Notation: Here φ(x) = ∏_{n=1}^{∞}(1-x^n) is Euler's product, convergent for 0 ≤ x < 1, and p(n) denotes the number of partitions of n.",
        "Number theory",
        "Dataset/NivenZuckermanNumberTheory.lean",
        "niven_zuckerman_10_15_mod_five_coefficients",
        [],
    ),
    Entry(
        3,
        "Theorem 10.16. We have p(5m + 4) ≡ 0 mod 5. Notation: Here φ(x) = ∏_{n=1}^{∞}(1-x^n) is Euler's product, convergent for 0 ≤ x < 1, and p(n) denotes the number of partitions of n.",
        "Number theory",
        "Dataset/NivenZuckermanNumberTheory.lean",
        "niven_zuckerman_10_16_ramanujan_congruence",
        ["partitionCount"],
    ),
    Entry(
        4,
        "Lemma 11.2. The function τ(n), representing the number of positive divisors of n, satisfies the inequality τ(n) ≤ 2sqrt{n} for n ≥ 1. Notation: τ(n) is the number of positive divisors of n.",
        "Number theory",
        "Dataset/NivenZuckermanNumberTheory.lean",
        "niven_zuckerman_11_2_divisor_bound",
        [],
    ),
    Entry(
        5,
        "Theorem 11.3. We have ∑_{n=1}^{∞}(μ(n))/(n^2)∑_{n=1}^{∞}(1)/(n^2) = 1. Notation: μ is the Möbius function.",
        "Number theory",
        "Dataset/NivenZuckermanNumberTheory.lean",
        "niven_zuckerman_11_3_moebius_zeta_product",
        [],
    ),
    Entry(
        6,
        "Corollary 11.4. We have ∑_{n=1}^{∞}(μ(n))/(n^2) = (6)/(π^2). Notation: μ is the Möbius function; the proof uses the classical evaluation ∑_{n=1}^{∞}1/n^2 = π^2/6.",
        "Number theory",
        "Dataset/NivenZuckermanNumberTheory.lean",
        "niven_zuckerman_11_4_moebius_sum_eq_six_div_pi_sq",
        [],
    ),
    Entry(
        7,
        "An integer is square-free if it is divisible by no perfect square a^2 > 1. Theorem 11.5. The set of square-free integers has natural density 6/π^2. Notation: Definition 11.1. If A is a set of positive integers and A(n) denotes the number of elements of A not exceeding n, the *asymptotic* (or natural) density of A is δ(A) = lim_{n→∞} A(n)/n when the limit exists. Definition 11.2. The *Schnirelmann density* d(A) of a set A of non-negative integers is d(A) = inf_{n≥1} A(n)/n. Definition 11.3. Assume 0 ∈ A and 0 ∈ B. The sum A + B is the collection of all integers of the form a + b where a ∈ A and b ∈ B.",
        "Number theory",
        "Dataset/NivenZuckermanNumberTheory.lean",
        "niven_zuckerman_11_5_squarefree_density",
        ["HasNaturalDensity"],
    ),
    Entry(
        8,
        "Lemma 11.6. Let ∑ c_j be a divergent series with 0 < c_j < 1 for j = 1, 2, .... Then, given any real number ε > 0, there is an integer N such that ∏_{j=1}^{n}(1-c_j) < ε for every integer n ≥ N. Notation: Divergence of ∑ c_j means that the partial sums tend to +∞; since all factors 1-c_j lie in (0,1) the partial products are decreasing, so the conclusion says exactly that they tend to 0.",
        "Number theory",
        "Dataset/NivenZuckermanNumberTheory.lean",
        "niven_zuckerman_11_6_divergent_product_tendsto_zero",
        [],
    ),
    Entry(
        9,
        "Theorem 11.8. Let k be a fixed positive integer. If each integer in a set A is divisible by k or fewer distinct prime factors, then δ(A) = 0. Notation: Definition 11.1. If A is a set of positive integers and A(n) denotes the number of elements of A not exceeding n, the *asymptotic* (or natural) density of A is δ(A) = lim_{n→∞} A(n)/n when the limit exists. Definition 11.2. The *Schnirelmann density* d(A) of a set A of non-negative integers is d(A) = inf_{n≥1} A(n)/n. Definition 11.3. Assume 0 ∈ A and 0 ∈ B. The sum A + B is the collection of all integers of the form a + b where a ∈ A and b ∈ B.",
        "Number theory",
        "Dataset/NivenZuckermanNumberTheory.lean",
        "niven_zuckerman_11_8_few_prime_factors_density_zero",
        ["HasNaturalDensity"],
    ),
    Entry(
        10,
        "The αβ theorem of H. B. Mann. If A and B are sets of non-negative integers, each containing 0, and if α, β, γ are the Schnirelmann densities of A, B, A+B, then γ ≥ min(1, α+β). In other words γ ≥ α + β unless α + β ≥ 1, in which case γ = 1. Notation: Definition 11.1. If A is a set of positive integers and A(n) denotes the number of elements of A not exceeding n, the *asymptotic* (or natural) density of A is δ(A) = lim_{n→∞} A(n)/n when the limit exists. Definition 11.2. The *Schnirelmann density* d(A) of a set A of non-negative integers is d(A) = inf_{n≥1} A(n)/n. Definition 11.3. Assume 0 ∈ A and 0 ∈ B. The sum A + B is the collection of all integers of the form a + b where a ∈ A and b ∈ B.",
        "Number theory",
        "Dataset/NivenZuckermanNumberTheory.lean",
        "niven_zuckerman_11_mann_alpha_beta_theorem",
        [],
    ),
]


NIVEN_IRRATIONAL = [
    Entry(
        1,
        'Any rational fraction a/b is expressible as a terminating decimal or an infinite periodic decimal; conversely, any decimal expansion which is either terminating or infinite periodic is equal to some rational number. (§2.4, with §2.5 "Terminating Decimals Written as Periodic Decimals".) Notation: the decimal expansion of x in [0,1) is the digit sequence d_k = floor(10^{k+1} x) mod 10; a terminating expansion is the eventually periodic one whose repeating digit is 0.',
        "Number theory",
        "Dataset/NivenIrrational.lean",
        "niven_2_4_rational_iff_periodic_decimal",
        ['decimalDigit', 'EventuallyPeriodic'],
    ),
    Entry(
        2,
        '§3.5. sqrt(2) + sqrt(3) is irrational.',
        "Number theory",
        "Dataset/NivenIrrational.lean",
        "niven_3_5_sqrt_two_add_sqrt_three_irrational",
        [],
    ),
    Entry(
        3,
        '§5.3, Example 3. Let c and d be two different non-negative integers. Prove that log(2^c 5^d) is irrational. Notation: all logarithms are to base 10, i.e. log y = k means 10^k = y.',
        "Number theory",
        "Dataset/NivenIrrational.lean",
        "niven_5_3_log_two_pow_five_pow_irrational",
        [],
    ),
    Entry(
        4,
        'Theorem on Geometric Constructions. Beginning with a line segment of unit length, any length that can be constructed by straightedge and compass methods is an algebraic number of degree 1, or 2, or 4, or 8, ..., i.e., in general, an algebraic number whose degree is a power of 2. Notation: a length is constructible when it can be obtained from a unit segment by straightedge and compass; algebraically these are the numbers reachable from the rationals by the field operations and by square roots of non-negative constructed quantities. The degree of an algebraic number is the degree of its minimal polynomial over the rationals.',
        "Number theory",
        "Dataset/NivenIrrational.lean",
        "niven_5_5_constructible_degree_is_power_of_two",
        ['IsConstructible'],
    ),
    Entry(
        5,
        '§5.5. The duplication of the cube amounts to constructing a line of length 2^{1/3} from a given unit length. Since 2^{1/3} is an algebraic number of degree 3, by the Theorem on Geometric Constructions it is not constructible. Hence it is impossible to duplicate the cube.',
        "Number theory",
        "Dataset/NivenIrrational.lean",
        "niven_5_5_duplication_of_the_cube_impossible",
        ['IsConstructible'],
    ),
    Entry(
        6,
        '§5.5. Squaring the circle amounts to constructing a square of area equal to that of a circle of unit radius, i.e. to constructing the length sqrt(pi). Granted that pi is a transcendental number, sqrt(pi) is not an algebraic number of degree a power of 2, so by the Theorem on Geometric Constructions it is not constructible.',
        "Number theory",
        "Dataset/NivenIrrational.lean",
        "niven_5_5_squaring_the_circle_impossible",
        ['IsConstructible'],
    ),
    Entry(
        7,
        '§5.5. To establish that the trisection of an angle is impossible, it is enough to show that a specific angle cannot be trisected by the prescribed methods. The specific angle that we take is 60 degrees. To trisect an angle of 60 degrees means the construction of a 20 degree angle, equivalently of the length cos 20 degrees, which is not constructible.',
        "Number theory",
        "Dataset/NivenIrrational.lean",
        "niven_5_5_trisection_of_the_angle_impossible",
        ['IsConstructible'],
    ),
    Entry(
        8,
        'Theorem 6.2. Corresponding to any irrational number alpha there is a unique integer m such that -1/2 < alpha - m < 1/2.',
        "Number theory",
        "Dataset/NivenIrrational.lean",
        "niven_6_2_unique_nearest_integer",
        [],
    ),
    Entry(
        9,
        '§7.5. The number e is transcendental. Notation: a real number is transcendental when it satisfies no polynomial equation with rational (equivalently, integer) coefficients, other than the zero polynomial.',
        "Number theory",
        "Dataset/NivenIrrational.lean",
        "niven_7_5_transcendence_of_e",
        [],
    ),
    Entry(
        10,
        'Theorem C.5. The set of real transcendental numbers is uncountable. Notation: a real number is algebraic when it is a root of a non-zero polynomial with rational coefficients, and transcendental otherwise.',
        "Number theory",
        "Dataset/NivenIrrational.lean",
        "niven_C_5_transcendentals_uncountable",
        [],
    ),
]


KONG_ODE = [
    Entry(
        1,
        "Theorem 1.3.3. Let D be an open subset of ℝ × ℝⁿ and (t₀, a₁, a₂, ..., aₙ) ∈ D. (a) Assume g ∈ C(D, ℝⁿ). Then there exists a γ > 0 such that IVP (1.3.10) has at least one solution which exists for |t - t₀| ≤ γ. (b) Assume g ∈ C(D, ℝⁿ), and as a function of (t, y₁, y₂, ..., yₙ), g is locally Lipschitz in (y₁, y₂, ..., yₙ) on D. Then there exists a γ > 0 such that IVP (1.3.10) has a unique solution which exists for |t - t₀| ≤ γ.",
        "ODE",
        "Dataset/KongODE.lean",
        "kong_1_3_3_nth_order_scalar_ivp",
        [
            "IsTrajectory",
            "companionField",
            "LocallyLipschitzInState",
        ],
    ),
    Entry(
        2,
        "Theorem 1.5.3. Assume that f ∈ C(D, ℝⁿ), ∂f/∂x ∈ C(D, ℝ^{n×n}), and ∂f/∂μ ∈ C(D, ℝ^{n×k}). Then IVP (V[t₀, x₀, μ]) has a unique solution x(t; t₀, x₀, μ) which is C¹ in t₀, x₀, and μ in its domain. Furthermore, let J(t; t₀, x₀, μ) := ∂f/∂x(t, x(t; t₀, x₀, μ); μ). Then (a) (∂x/∂μ)(t; t₀, x₀, μ) is the solution of the IVP z' = J(t; t₀, x₀, μ)z + ∂f/∂μ(t, x(t; t₀, x₀, μ); μ), z(t₀)=0; (b) (∂x/∂x₀)(t; t₀, x₀, μ) is the solution of z' = J(t; t₀, x₀, μ)z, z(t₀)=I; (c) (∂x/∂t₀)(t; t₀, x₀, μ) is the solution of z' = J(t; t₀, x₀, μ)z, z(t₀)=-f(t₀, x₀; μ). Here I stands for the n × n identity matrix.",
        "ODE",
        "Dataset/KongODE.lean",
        "kong_1_5_3_differentiable_dependence",
        [
            "IsTrajectory",
        ],
    ),
    Entry(
        3,
        "Theorem 2.3.1 (Variation of Parameters Formula). Let X(t) be a fundamental matrix solution of Eq. (H) and t₀ ∈ (a,b). Then the general solution of Eq. (NH) is x = X(t)c + ∫_{t₀}^{t} X(t)X^{-1}(s)f(s) ds. In particular, the solution of the IVP consisting of Eq. (NH) and the IC x(t₀)=x₀ is x = X(t)X^{-1}(t₀)x₀ + ∫_{t₀}^{t} X(t)X^{-1}(s)f(s) ds.",
        "ODE",
        "Dataset/KongODE.lean",
        "kong_2_3_1_variation_of_parameters",
        [
            "IsTrajectory",
            "FundamentalMatrixSolution",
        ],
    ),
    Entry(
        4,
        "Theorem 2.5.3 (Floquet Theorem). Let X(t) be a fundamental matrix solution of Eq. (H-p). Then there exists an R ∈ ℂ^{n×n} and a nonsingular ω-periodic P ∈ C¹(ℝ, ℂ^{n×n}) such that X(t) = P(t)e^{Rt}.",
        "ODE",
        "Dataset/KongODE.lean",
        "kong_2_5_3_floquet_theorem",
        [
            "FundamentalMatrixSolution",
            "PeriodicLinearEquation",
        ],
    ),
    Entry(
        5,
        "Theorem 3.2.3. Let μᵢ, i = 1, ..., n, be the characteristic multipliers of Eq. (H-p). Then (a) Equation (H-p) is uniformly stable ⇐⇒ |μᵢ| ≤ 1, i = 1, ..., n, and |μᵢ| = 1 occurs only when the μᵢ's are in the diagonal Jordan block of the transition matrix V; (b) Equation (H-p) is asymptotically stable ⇐⇒ |μᵢ| < 1, i = 1, ..., n; (c) Equation (H-p) is unstable ⇐⇒ there exists an i ∈ {1, ..., n} such that either |μᵢ| > 1, or |μᵢ| = 1 which occurs when μᵢ is not in the diagonal Jordan block of the transition matrix V.",
        "ODE",
        "Dataset/KongODE.lean",
        "kong_3_2_3_characteristic_multiplier_stability",
        [
            "IsTrajectory",
            "CharacteristicMultipliers",
            "InDiagonalJordanBlock",
            "UniformlyStableLinearEquation",
            "AsymptoticallyStableLinearEquation",
            "UnstableLinearEquation",
        ],
    ),
    Entry(
        6,
        "Theorem 3.4.2. Assume that there exists a function p ∈ C([0, ∞), [0, ∞)) such that ∫_0^∞ p(t) dt < ∞, and |r(t, x)| ≤ p(t)|x| for sufficiently small |x| and all t ∈ [0, ∞). (a) If Eq. (H) is uniformly stable, then the zero solution of Eq. (3.4.6) is uniformly stable. (b) If Eq. (H) is uniformly stable and asymptotically stable, then the zero solution of Eq. (3.4.6) is uniformly stable and asymptotically stable.",
        "ODE",
        "Dataset/KongODE.lean",
        "kong_3_4_2_integrable_perturbation_stability",
        [
            "IsTrajectory",
            "IntegrableSmallPerturbation",
            "UniformlyStableLinearEquation",
            "AsymptoticallyStableLinearEquation",
            "UniformlyStableZeroSolution",
            "AsymptoticallyStableZeroSolution",
        ],
    ),
    Entry(
        7,
        "Theorem 3.5.2. Let D = {x ∈ ℝⁿ : |x| ≤ l} for some l > 0 and V ∈ C¹(D, ℝ). Assume that V(x) is positive definite and V̇(x) is negative semi-definite. Moreover, if the set D₀ := {x ∈ D : V̇(x) = 0} does not contain any nontrivial orbit of Eq. (A), then the zero solution of Eq. (A) is uniformly stable and asymptotically stable.",
        "ODE",
        "Dataset/KongODE.lean",
        "kong_3_5_2_lasalle_invariance_stability",
        [
            "IsTrajectory",
            "LyapunovFunctionOnBall",
            "NoNontrivialOrbitInZeroDerivativeSet",
            "UniformlyStableZeroSolution",
            "AsymptoticallyStableZeroSolution",
        ],
    ),
    Entry(
        8,
        "Theorem 4.5.3. Let x(t) be a solution of system (A-2) and Γ its orbit. Assume Γ⁺ is contained in a compact set E ⊂ ℝ² and system (A-2) has at most a finite number of equilibria in E. Then one of the following four statements is true: (a) Ω(Γ⁺) contains only one equilibrium of system (A-2); (b) Γ is a closed orbit; (c) Ω(Γ⁺) is a closed orbit; (d) Ω(Γ⁺) is a graphic for System (A-2). The same conclusion holds when Γ⁺ and Ω(Γ⁺) are replaced by Γ⁻ and A(Γ⁻), respectively.",
        "ODE",
        "Dataset/KongODE.lean",
        "kong_4_5_3_generalized_poincare_bendixson",
        [
            "IsAutonomousTrajectory",
            "omegaLimitSet",
            "alphaLimitSet",
            "IsClosedOrbit",
            "GraphicForPlanarSystem",
        ],
    ),
    Entry(
        9,
        "Theorem 5.4.2. Assume (5.4.2) and (5.4.4) hold with α'(0) = 0. Then either (a) all orbits of system (5.4.1-0) in a neighborhood of (0,0) are closed orbits and system (5.4.1-μ) does not have closed orbits for μ ≠ 0 in a neighborhood of μ = 0, or (b) for μ > 0 sufficiently close to zero only or for μ < 0 sufficiently close to zero only, system (5.4.1-μ) has a unique limit cycle Γ(μ) satisfying Γ(μ) → (0,0) with its period T(μ) → 2π/β as μ → 0.",
        "ODE",
        "Dataset/KongODE.lean",
        "kong_5_4_2_hopf_friedrich_dichotomy",
        [
            "IsAutonomousTrajectory",
            "IsClosedOrbit",
            "linearizationMatrix",
        ],
    ),
    Entry(
        10,
        "Theorem 6.6.4. SLP (S-L), (P) has a countably infinite number of eigenvalues λₙ, n ∈ ℕ₀, which are all real, bounded below and unbounded above, and can be arranged to satisfy the coupling relations with μₙ and νₙ for n ∈ ℕ₀: ν₀ ≤ λ₀ < {μ₀,ν₁} < λ₁ ≤ {μ₁,ν₂} ≤ λ₂ < {μ₂,ν₃} < λ₃ ≤ {μ₃,ν₄} ≤ λ₄ < ··· < {μ_{2n},ν_{2n+1}} < λ_{2n+1} ≤ {μ_{2n+1},ν_{2n+2}} ≤ λ_{2n+2} < ···. Furthermore, (a) λ₀ is geometrically simple; and for n ≥ 1, λₙ may be geometrically simple or double, and λₙ is geometrically double ⇐⇒ λₙ = μᵢ = νⱼ for some i,j ∈ ℕ₀. (b) The eigenfunctions associated with λ₀ have no zeros in [a,b], and for n ∈ ℕ₀, the eigenfunctions associated with λ_{2n+1} and λ_{2n+2} have exactly 2n+2 zeros in the half-open interval [a,b).",
        "ODE",
        "Dataset/KongODE.lean",
        "kong_6_6_4_periodic_sturm_liouville_coupling",
        [
            "IsSturmLiouvilleEigenfunction",
            "PeriodicSturmLiouvilleData",
            "periodicBoundary",
            "dirichletBoundary",
            "neumannBoundary",
        ],
    ),
]


LEE_SMOOTH = [
    Entry(1, "Theorem 7.6 (Inverse Function Theorem). Suppose U and V are open subsets of ℝⁿ, and F: U → V is a smooth map. If DF(p) is nonsingular at some point p ∈ U, then there exist connected neighborhoods U₀ ⊂ U of p and V₀ ⊂ V of F(p) such that F|_{U₀}: U₀ → V₀ is a diffeomorphism.", "Smooth manifolds", "Dataset/LeeSmoothManifolds.lean", "lee_7_6_inverse_function_theorem", ["SmoothDiffeomorphismOn"]),
    Entry(2, "Theorem 7.8 (Rank Theorem). Suppose U ⊂ ℝᵐ and V ⊂ ℝⁿ are open sets and F: U → V is a smooth map with constant rank k. For any p ∈ U, there exist smooth coordinate charts centered at p and F(p), with U₀ ⊂ U and F(U₀) ⊂ V₀ ⊂ V, such that ψ ∘ F ∘ φ^{-1}(x¹, ..., xᵏ, x^{k+1}, ..., xᵐ) = (x¹, ..., xᵏ, 0, ..., 0).", "Smooth manifolds", "Dataset/LeeSmoothManifolds.lean", "lee_7_8_rank_theorem", ["SmoothDiffeomorphismOn", "EuclideanConstantRank"]),
    Entry(3, "Theorem 7.13 (Rank Theorem for Manifolds). Suppose M and N are smooth manifolds of dimensions m and n, respectively, and F: M → N is a smooth map with constant rank k. For each p ∈ M there exist smooth coordinates (x¹, ..., xᵐ) centered at p and (v¹, ..., vⁿ) centered at F(p) in which F has the coordinate representation (x¹, ..., xᵐ) ↦ (x¹, ..., xᵏ, 0, ..., 0).", "Smooth manifolds", "Dataset/LeeSmoothManifolds.lean", "lee_7_13_rank_theorem_for_manifolds", ["ConstantRank"]),
    Entry(4, "Theorem 8.8 (Constant-Rank Level Set Theorem). Let M and N be smooth manifolds, and let Φ: M → N be a smooth map with constant rank equal to k. Each level set of Φ is a closed embedded submanifold of codimension k in M.", "Smooth manifolds", "Dataset/LeeSmoothManifolds.lean", "lee_8_8_constant_rank_level_set_theorem", ["ConstantRank", "EmbeddedSubmanifoldOfCodimension"]),
    Entry(5, "Corollary 8.10 (Regular Level Set Theorem). Every regular level set of a smooth map is a closed embedded submanifold whose codimension is equal to the dimension of the range.", "Smooth manifolds", "Dataset/LeeSmoothManifolds.lean", "lee_8_10_regular_level_set_theorem", ["RegularValue", "EmbeddedSubmanifoldOfCodimension"]),
    Entry(6, "Theorem 9.16 (Quotient Manifold Theorem). Suppose a Lie group G acts smoothly, freely, and properly on a smooth manifold M. Then the orbit space M/G is a topological manifold of dimension equal to dim M - dim G, and has a unique smooth structure with the property that the quotient map π: M → M/G is a smooth submersion.", "Smooth manifolds", "Dataset/LeeSmoothManifolds.lean", "lee_9_16_quotient_manifold_theorem", ["SmoothFreeProperAction"]),
    Entry(7, "Theorem 10.7 (Sard's Theorem). If F: M → N is any smooth map, the set of critical values of F has measure zero in N.", "Smooth manifolds", "Dataset/LeeSmoothManifolds.lean", "lee_10_7_sards_theorem", []),
    Entry(8, "Theorem 10.11 (Whitney Embedding Theorem). Every smooth n-manifold admits a proper smooth embedding into ℝ^{2n+1}.", "Smooth manifolds", "Dataset/LeeSmoothManifolds.lean", "lee_10_11_whitney_embedding_theorem", []),
    Entry(9, "Theorem 10.16 (Whitney Approximation Theorem). Let M be a smooth manifold and let F: M → ℝᵏ be a continuous function. Given any positive continuous function δ: M → ℝ, there exists a smooth function F': M → ℝᵏ that is δ-close to F. If F is smooth on a closed subset A ⊂ M, then F' can be chosen to be equal to F on A.", "Smooth manifolds", "Dataset/LeeSmoothManifolds.lean", "lee_10_16_whitney_approximation_theorem", []),
    Entry(10, "Theorem 10.19 (Tubular Neighborhood Theorem). Every embedded submanifold of ℝⁿ has a tubular neighborhood.", "Smooth manifolds", "Dataset/LeeSmoothManifolds.lean", "lee_10_19_tubular_neighborhood_theorem", ["EmbeddedSubmanifoldOfCodimension", "IsNormalVector", "NormalDiskBundle"]),
]


ENGELKING_TOPOLOGY = [
    Entry(1, "Definition. A topological space X is called a realcompact space if X is a Tychonoff space and there is no Tychonoff space X̃ which satisfies: (RC1) there exists a homeomorphic embedding r: X → X̃ such that r(X) ≠ closure(r(X)) = X̃; (RC2) for every continuous real-valued function f: X → R there exists a continuous function f̃: X̃ → R such that f̃r = f. 3.11.16. Theorem. For every Tychonoff space X there exists exactly one (up to a homeomorphism) realcompact space νX which satisfies: (i) there exists a homeomorphic embedding ν: X → νX such that closure(ν(X)) = νX; (ii) for every continuous real-valued function f: X → R there exists a continuous function f^ν: νX → R such that f^νν = f. The space νX also satisfies: (iii) for every continuous mapping f: X → Y of X to a realcompact space Y there exists a continuous mapping f^ν: νX → Y such that f^νν = f.", "Topology", "Dataset/EngelkingGeneralTopology.lean", "engelking_3_11_16_hewitt_realcompactification", ["IsRealcompact"]),
    Entry(2, "Definition. A topological space X is called countably paracompact if X is a Hausdorff space and every countable open cover of X has a locally finite open refinement. 5.2.8. Theorem. A topological space X is normal and countably paracompact if and only if the Cartesian product X × I of X and the closed unit interval I is normal.", "Topology", "Dataset/EngelkingGeneralTopology.lean", "engelking_5_2_8_normal_product_interval", ["IsOpenCover", "Refines", "IsCountablyParacompact"]),
    Entry(3, "Definitions. A family {A_s}_{s∈S} is star-finite (star-countable) if for every s₀ ∈ S the set {s ∈ S : A_s ∩ A_{s₀} ≠ ∅} is finite (countable). A topological space X is called strongly paracompact if X is a Hausdorff space and every open cover of X has a star-finite open refinement. 5.3.10. Theorem. For every regular space X the following conditions are equivalent: (i) X is strongly paracompact; (ii) every open cover of X has a closed refinement which is both locally finite and star-finite; (iii) every open cover of X has a closed refinement which is both locally finite and star-countable; (iv) every open cover of X has a star-countable open refinement.", "Topology", "Dataset/EngelkingGeneralTopology.lean", "engelking_5_3_10_strong_paracompactness", ["IsOpenCover", "Refines", "IsClosedCover", "IsStarFiniteFamily", "IsStarCountableFamily", "IsStronglyParacompact"]),
    Entry(4, "4.4.1. The Stone Theorem. Every open cover of a metrizable space has an open refinement which is both locally finite and σ-discrete.", "Topology", "Dataset/EngelkingGeneralTopology.lean", "engelking_4_4_1_stone_open_refinement", ["IsDiscreteFamily", "IsOpenCover", "Refines"]),
    Entry(5, "4.4.7. The Nagata-Smirnov Metrization Theorem. A topological space is metrizable if and only if it is regular and has a σ-locally finite base.", "Topology", "Dataset/EngelkingGeneralTopology.lean", "engelking_4_4_7_nagata_smirnov_metrization", ["HasSigmaLocallyFiniteBase"]),
    Entry(6, "4.4.8. The Bing Metrization Theorem. A topological space is metrizable if and only if it is regular and has a σ-discrete base.", "Topology", "Dataset/EngelkingGeneralTopology.lean", "engelking_4_4_8_bing_metrization", ["IsDiscreteFamily", "HasSigmaDiscreteBase"]),
    Entry(7, "5.1.9. Theorem. For every T₁-space X the following conditions are equivalent: (i) the space X is paracompact; (ii) every open cover of the space X has a locally finite partition of unity subordinated to it; (iii) every open cover of X has a partition of unity subordinated to it.", "Topology", "Dataset/EngelkingGeneralTopology.lean", "engelking_5_1_9_paracompact_partition_of_unity", ["IsOpenCover"]),
    Entry(8, "5.1.38. The Tamano Theorem. For every Tychonoff space X the following conditions are equivalent: (i) the space X is paracompact; (ii) for every compactification cX of the space X the Cartesian product X × cX is normal; (iii) the Cartesian product X × βX is normal; (iv) there exists a compactification cX of X such that X × cX is normal.", "Topology", "Dataset/EngelkingGeneralTopology.lean", "engelking_5_1_38_tamano_theorem", ["IsCompactification"]),
    Entry(9, "7.2.1. The Countable Sum Theorem. If a normal space X has a countable closed cover {F_j} such that dim F_j ≤ n for j = 1,2,..., then dim X ≤ n.", "Topology", "Dataset/EngelkingGeneralTopology.lean", "engelking_7_2_1_countable_sum_theorem", ["IsOpenCover", "Refines", "CoverOrderLE", "CoveringDimensionLE"]),
    Entry(10, "8.4.13. The Smirnov Theorem. Assigning to every compactification cX of a Tychonoff space X the proximity δ(c) establishes a one-to-one correspondence between compactifications of X and proximities on X.", "Topology", "Dataset/EngelkingGeneralTopology.lean", "engelking_8_4_13_smirnov_proximity_compactification", ["IsCompactification", "EquivalentCompactifications", "Proximity", "IsAssignedProximity"]),
]


GRAFAKOS_FOURIER = [
    Entry(1, "Theorem 1.3.2. Let (X, μ) be a σ-finite measure space, let (Y, ν) be another measure space, and let 0 < p₀ < p₁ ≤ ∞. Let T be a sublinear operator defined on L^{p₀}(X) + L^{p₁}(X) = {f₀ + f₁ : fⱼ ∈ L^{pⱼ}(X), j = 0, 1} and taking values in the space of measurable functions on Y. Assume that there exist A₀, A₁ < ∞ such that ‖T(f)‖_{L^{p₀,∞}(Y)} ≤ A₀‖f‖_{L^{p₀}(X)} for all f ∈ L^{p₀}(X), and ‖T(f)‖_{L^{p₁,∞}(Y)} ≤ A₁‖f‖_{L^{p₁}(X)} for all f ∈ L^{p₁}(X). Then for all p₀ < p < p₁ and for all f in Lᵖ(X) we have the estimate ‖T(f)‖_{Lᵖ(Y)} ≤ A‖f‖_{Lᵖ(X)}, where A = 2[p/(p − p₀) + p/(p₁ − p)]^{1/p} A₀^{(p₀/p)(p₁−p)/(p₁−p₀)} A₁^{(p₁/p)(p−p₀)/(p₁−p₀)}.", "Fourier analysis", "Dataset/GrafakosFourier.lean", "grafakos_1_3_2_marcinkiewicz_interpolation", ["IsSublinearOperator", "HasWeakType", "HasStrongType"]),
    Entry(2, "Theorem 1.3.4. Let (X, μ) and (Y, ν) be two σ-finite measure spaces. Let T be a linear operator defined on the set of all finitely simple functions on X and taking values in the set of measurable functions on Y. Let 1 ≤ p₀, p₁, q₀, q₁ ≤ ∞ and assume that ‖T(f)‖_{L^{q₀}} ≤ M₀‖f‖_{L^{p₀}} and ‖T(f)‖_{L^{q₁}} ≤ M₁‖f‖_{L^{p₁}} for all finitely simple functions f on X. Then for all 0 < θ < 1 we have ‖T(f)‖_{L^q} ≤ M₀^{1−θ}M₁^θ‖f‖_{L^p} for all finitely simple functions f on X, where 1/p = (1−θ)/p₀ + θ/p₁ and 1/q = (1−θ)/q₀ + θ/q₁. Consequently, when p < ∞, by density, T has a unique bounded extension from Lᵖ(X, μ) to L^q(Y, ν) when p and q are as above.", "Fourier analysis", "Dataset/GrafakosFourier.lean", "grafakos_1_3_4_riesz_thorin_interpolation", ["HasStrongType"]),
    Entry(3, "Theorem 2.1.6. The uncentered and centered Hardy-Littlewood maximal operators M and Mᶜ map L¹(ℝⁿ) to L^{1,∞}(ℝⁿ) with constant at most 3ⁿ and also Lᵖ(ℝⁿ) to Lᵖ(ℝⁿ) for 1 < p < ∞ with constant at most 3^{n/p}p(p-1)^{-1}. For any f ∈ L¹(ℝⁿ) we also have |{M(f)>α}| ≤ (3ⁿ/α)∫_{M(f)>α}|f(y)|dy.", "Fourier analysis", "Dataset/GrafakosFourier.lean", "grafakos_2_1_6_hardy_littlewood_maximal", ["hardyLittlewoodMaximal", "hardyLittlewoodCenteredMaximal"]),
    Entry(4, "Theorem 2.2.14. Given f, g, and h in 𝒮(ℝⁿ), we have (1) ∫ℝⁿ f(x)ĝ(x) dx = ∫ℝⁿ f̂(x)g(x) dx; (2) (Fourier Inversion) (f̂)∨ = f = (f∨)̂; (3) (Parseval's relation) ∫ℝⁿ f(x)h̄(x) dx = ∫ℝⁿ f̂(ξ)ĥ̄(ξ) dξ; (4) (Plancherel's identity) ‖f‖_{L²} = ‖f̂‖_{L²} = ‖f∨‖_{L²}; (5) ∫ℝⁿ f(x)h(x) dx = ∫ℝⁿ f̂(x)h∨(x) dx.", "Fourier analysis", "Dataset/GrafakosFourier.lean", "grafakos_2_2_14_fourier_identities_on_schwartz", []),
    Entry(5, "Proposition 2.2.16 (Hausdorff-Young inequality). For every function f in Lᵖ(ℝⁿ) we have the estimate ‖f̂‖_{p'} ≤ ‖f‖_p whenever 1 ≤ p ≤ 2.", "Fourier analysis", "Dataset/GrafakosFourier.lean", "grafakos_2_2_16_hausdorff_young", []),
    Entry(6, "Theorem 3.2.8 (Poisson summation formula). Let f be a continuous function on ℝⁿ which satisfies |f(x)| ≤ C(1+|x|)^{-n-δ} for some C,δ > 0 and whose Fourier transform f̂ restricted on ℤⁿ satisfies ∑_{m∈ℤⁿ}|f̂(m)| < ∞. Then for all x ∈ ℝⁿ, ∑_{m∈ℤⁿ} f̂(m)e^{2πim·x} = ∑_{k∈ℤⁿ} f(x+k), and in particular ∑_{m∈ℤⁿ} f̂(m) = ∑_{k∈ℤⁿ} f(k).", "Fourier analysis", "Dataset/GrafakosFourier.lean", "grafakos_3_2_8_poisson_summation", []),
    Entry(7, "Theorem 4.1.1. For R > 0 and m ∈ ℤⁿ, let a(m, R) be complex numbers such that (i) for every R > 0 there is a qR such that a(m, R) = 0 if |m| > qR; (ii) there is an M₀ < ∞ such that |a(m, R)| ≤ M₀ for all m ∈ ℤⁿ and all R > 0; (iii) for each m ∈ ℤⁿ, the limit of a(m, R) exists as R → ∞ and limR→∞ a(m, R) = aₘ. Let 1 ≤ p < ∞. For f ∈ Lᵖ(𝕋ⁿ) and x ∈ 𝕋ⁿ define S_R(f)(x) = ∑_{m∈ℤⁿ} a(m, R)f̂(m)e^{2πim·x}, noting that the sum is well defined because of (i). Also, for h ∈ C∞(𝕋ⁿ) define A(h)(x) = ∑_{m∈ℤⁿ} aₘĥ(m)e^{2πim·x}. Then for all f ∈ Lᵖ(𝕋ⁿ) the sequence S_R(f) converges in Lᵖ as R → ∞ if and only if there exists a constant K < ∞ such that supR>0 ‖S_R‖_{Lᵖ→Lᵖ} ≤ K. Furthermore, if this holds, then for the same constant K we have sup_{h∈C∞, h≠0} ‖A(h)‖_{Lᵖ}/‖h‖_{Lᵖ} ≤ K, and then A extends to a bounded operator Â from Lᵖ(𝕋ⁿ) to itself; moreover, for every f ∈ Lᵖ(𝕋ⁿ) we have that S_R(f) → Â(f) in Lᵖ as R → ∞.", "Fourier analysis", "Dataset/GrafakosFourier.lean", "grafakos_4_1_1_torus_summability_uniform_boundedness", ["HasStrongType", "torusCharacter", "torusFourierCoefficient"]),
    Entry(8, "Theorem 4.3.15. For every 1 < p < ∞ there exists a finite constant Cₚ such that for all f ∈ C₀∞(ℝ) we have ‖C**(f)‖_{Lᵖ(ℝ)} ≤ Cₚ‖f‖_{Lᵖ(ℝ)}, where C**(f)(x) = supR>0 |∫_{|ξ|≤R} f̂(ξ)e^{2πixξ} dξ| is the Carleson operator.", "Fourier analysis", "Dataset/GrafakosFourier.lean", "grafakos_4_3_15_carleson_hunt_line", ["carlesonHuntMaximal"]),
    Entry(9, "Theorem 5.3.1. Let f ∈ L¹(ℝⁿ) and α > 0. Then there exist functions g and b on ℝⁿ such that f = g+b; ‖g‖_{L¹} ≤ ‖f‖_{L¹} and ‖g‖_{L∞} ≤ 2ⁿα; b = ∑_j b_j where each b_j is supported in a dyadic cube Q_j, the cubes are disjoint, ∫_{Q_j}b_j(x)dx=0, ‖b_j‖_{L¹}≤2^{n+1}α|Q_j|, and ∑_j |Q_j|≤α^{-1}‖f‖_{L¹}.", "Fourier analysis", "Dataset/GrafakosFourier.lean", "grafakos_5_3_1_calderon_zygmund_decomposition", ["DyadicCube", "DyadicCube.carrier"]),
    Entry(10, "Theorem 5.6.6. For 1 < p,r < ∞ the Hardy-Littlewood maximal function M satisfies the vector-valued inequalities ‖(∑_j |M(f_j)|^r)^{1/r}‖_{1,∞} ≤ C_n(1+(r-1)^{-1})‖(∑_j |f_j|^r)^{1/r}‖_1 and ‖(∑_j |M(f_j)|^r)^{1/r}‖_p ≤ C_n c(p,r)‖(∑_j |f_j|^r)^{1/r}‖_p.", "Fourier analysis", "Dataset/GrafakosFourier.lean", "grafakos_5_6_6_vector_valued_maximal", ["hardyLittlewoodMaximal"]),
]


MATTILA_GEOMETRY = [
    Entry(1, "8.19. Theorem. For a compact metric space X, H^s(X) = sup {H^s(C) : C ⊂ X is compact with H^s(C) < ∞}.", "Geometric measure theory", "Dataset/MattilaGeometry.lean", "mattila_8_19_compact_subsets_of_finite_hausdorff_measure", []),
    Entry(2, "12.14. Theorem. Let A be a Borel set in ℝⁿ. (1) If dim A > (n+1)/2, then L¹(D(A)) > 0. (2) If (n−1)/2 < dim A < (n+1)/2, then dim D(A) > dim A − (n−1)/2, where D(A) = {|x−y| : x,y ∈ A}.", "Geometric measure theory", "Dataset/MattilaGeometry.lean", "mattila_12_14_falconer_distance_set", []),
    Entry(3, "6.1. Definition. The upper s-dimensional density of A at x is Θ^{*s}(A,x) = lim sup_{r↓0}(2r)^{-s}H^s(A ∩ B(x,r)). 6.2. Theorem. Suppose A ⊂ ℝⁿ with H^s(A) < ∞. (1) 2^{-s} ≤ Θ^{*s}(A,x) ≤ 1 for H^s almost all x ∈ A. (2) If A is H^s measurable, Θ^{*s}(A,x) = 0 for H^s almost all x ∈ ℝⁿ \\ A.", "Geometric measure theory", "Dataset/MattilaGeometry.lean", "mattila_6_2_hausdorff_density_estimates", ["upperHausdorffDensity"]),
    Entry(4, "15.3. Definition. A set E ⊂ ℝⁿ is called m-rectifiable if there exist Lipschitz maps fᵢ : ℝᵐ → ℝⁿ, i = 1,2,..., such that H^m(E \\ ⋃ᵢ fᵢ(ℝᵐ)) = 0. A set F ⊂ ℝⁿ is called purely m-unrectifiable if H^m(E ∩ F) = 0 for every m-rectifiable set E. 18.1. Theorem. Let A be an H^m measurable subset of ℝⁿ with H^m(A) < ∞. (1) A is m-rectifiable if and only if H^m(P_V B) > 0 for γ_{n,m} almost all V ∈ G(n,m) whenever B is an H^m measurable subset of A with H^m(B) > 0. (2) A is purely m-unrectifiable if and only if H^m(P_V A) = 0 for γ_{n,m} almost all V ∈ G(n,m).", "Geometric measure theory", "Dataset/MattilaGeometry.lean", "mattila_18_1_besicovitch_federer_projection", ["Grassmannian", "grassmannianAction", "IsInvariantGrassmannianMeasure", "RectifiableSet", "PurelyUnrectifiableSet"]),
    Entry(5, "7.7. Theorem. Let A ⊂ ℝⁿ and let f: A → ℝᵐ be a Lipschitz map. If m < s < n, then ∫^{*} H^{s-m}(A ∩ f^{-1}{y}) dL^m y ≤ c(n,m) Lip(f)^m H^s(A).", "Geometric measure theory", "Dataset/MattilaGeometry.lean", "mattila_7_7_lipschitz_level_sets", []),
    Entry(6, "Definition. The s-dimensional Hausdorff content of A is H^s_∞(A) = inf Σᵢ d(Eᵢ)^s, where the infimum is over all countable covers A ⊂ ⋃ᵢEᵢ. 8.8. Theorem. Let B be a Borel set in ℝⁿ. Then H^s(B) > 0 if and only if there exists μ ∈ M(B) such that μ(B(x,r)) < r^s for x ∈ ℝⁿ and r > 0. Moreover, we can find μ so that μ(B) > cH^s_∞(B), where c > 0 depends only on n.", "Geometric measure theory", "Dataset/MattilaGeometry.lean", "mattila_8_8_frostman_lemma", ["hausdorffContent"]),
    Entry(7, "Definition. The Riesz s-energy of μ is I_s(μ) = ∫∫|x−y|^{-s} dμx dμy. The Grassmannian G(n,m) is the space of m-dimensional linear subspaces of ℝⁿ, and γ_{n,m} is its orthogonally invariant probability measure. 9.7. Theorem. Let μ be a Radon measure on ℝⁿ with compact support and with I_m(μ) < ∞. Then P_{V#}μ ≪ H^m for γ_{n,m} almost all V ∈ G(n,m) and ∫_V D(P_{V#}μ,u)^2 dH^m u dγ_{n,m}V < cI_m(μ), where c is a constant depending only on n and m.", "Geometric measure theory", "Dataset/MattilaGeometry.lean", "mattila_9_7_projection_energy", ["rieszEnergy", "Grassmannian", "grassmannianAction", "IsInvariantGrassmannianMeasure"]),
    Entry(8, "Definition. The Grassmannian G(n,k) is the space of k-dimensional linear subspaces of ℝⁿ, and γ_{n,k} is its orthogonally invariant probability measure. 10.10. Theorem. Let m < t < n and let A ⊂ ℝⁿ be a Borel set with 0 < H^t(A) < ∞. Then for all W ∈ G(n,n-m), H^{t-m}(A∩W_a) < ∞ for H^m almost all a ∈ W^⊥, and for γ_{n,n-m} almost all W ∈ G(n,n-m), H^m({a ∈ W^⊥ : dim(A∩W_a)=t-m}) > 0.", "Geometric measure theory", "Dataset/MattilaGeometry.lean", "mattila_10_10_plane_sections", ["Grassmannian", "grassmannianAction", "IsInvariantGrassmannianMeasure"]),
    Entry(9, "14.10. Theorem. Let s be a positive number. Suppose that there exists a Radon measure μ on ℝⁿ such that the density Θ^s(μ,a) exists and is positive and finite in a set of positive μ measure. Then s is an integer.", "Geometric measure theory", "Dataset/MattilaGeometry.lean", "mattila_14_10_marstrand_density_integer", []),
    Entry(10, "15.3. Definition. A set E ⊂ ℝⁿ is called m-rectifiable if there exist Lipschitz maps fᵢ : ℝᵐ → ℝⁿ, i = 1,2,..., such that H^m(E \\ ⋃ᵢfᵢ(ℝᵐ)) = 0. 15.7. Definition. We say that a subset E of ℝⁿ is m-linearly approximable if for H^m almost all a ∈ E the following holds: if η is a positive number, there are positive numbers r₀ and λ and an affine m-plane W such that a ∈ W and for any 0 < r < r₀, H^m(E ∩ B(x,ηr)) ≥ λr^m for x ∈ W ∩ B(a,r), and H^m(E ∩ B(a,r) \\ W(ηr)) < ηr^m. 15.17. Definition. Let A ⊂ ℝⁿ, a ∈ ℝⁿ and V ∈ G(n,m). We say that V is an approximate tangent m-plane for A at a if Θ^{*m}(A,a) > 0 and for all 0 < s < 1, r^{-m}H^m(A ∩ B(a,r) \\ X(a,V,s)) → 0 as r ↓ 0. 15.19. Theorem. Let E be an H^m measurable subset of ℝⁿ with H^m(E) < ∞. Then the following are equivalent: (1) E is m-rectifiable. (2) E is m-linearly approximable. (3) For H^m almost all a ∈ E there is a unique approximate tangent m-plane for E at a. (4) For H^m almost all a ∈ E there is some approximate tangent m-plane for E at a.", "Geometric measure theory", "Dataset/MattilaGeometry.lean", "mattila_15_19_rectifiability_tangent_planes", ["Grassmannian", "RectifiableSet", "LinearlyApproximableSet", "IsApproximateTangentPlane"]),
]


def main() -> None:
    out_dir = ROOT / "reports"
    out_dir.mkdir(exist_ok=True)
    for stale_tex in out_dir.glob("*.tex"):
        stale_tex.unlink()
    render_report(
        "Kallenberg Foundations of Modern Probability Benchmark",
        out_dir / "Kallenberg_Foundations_Modern_Probability_Benchmark.pdf",
        KALLENBERG,
    )
    render_report("Bogachev Measure Theory Benchmark", out_dir / "Bogachev_Benchmark.pdf", BOGACHEV)
    render_report(
        "Conway Functional Analysis Benchmark",
        out_dir / "Conway_Functional_Analysis_Benchmark.pdf",
        CONWAY,
    )
    render_report(
        "Nikolski Operators Functions Systems Benchmark",
        out_dir / "Nikolski_Operators_Functions_Systems_Benchmark.pdf",
        NIKOLSKI,
    )
    render_report(
        "Krylov Holder PDE Benchmark",
        out_dir / "Krylov_Holder_Benchmark.pdf",
        KRYLOV_HOLDER,
    )
    render_report(
        "Krylov Sobolev PDE Benchmark",
        out_dir / "Krylov_Sobolev_Benchmark.pdf",
        KRYLOV_SOBOLEV,
    )
    render_report(
        "Bogachev Gaussian Measures Benchmark",
        out_dir / "Bogachev_Gaussian_Measures_Benchmark.pdf",
        BOGACHEV_GAUSSIAN,
    )
    render_report(
        "Folland Abstract Harmonic Analysis Benchmark",
        out_dir / "Folland_Abstract_Harmonic_Analysis_Benchmark.pdf",
        FOLLAND_HARMONIC,
    )
    render_report(
        "Hayman Meromorphic Functions Benchmark",
        out_dir / "Hayman_Meromorphic_Functions_Benchmark.pdf",
        HAYMAN_MEROMORPHIC,
    )
    render_report(
        "Niven Zuckerman Number Theory Benchmark",
        out_dir / "Niven_Zuckerman_Number_Theory_Benchmark.pdf",
        NIVEN_ZUCKERMAN,
    )
    render_report(
        "Niven Rational and Irrational Benchmark",
        out_dir / "Niven_Rational_and_Irrational_Benchmark.pdf",
        NIVEN_IRRATIONAL,
    )
    render_report(
        "Kong ODE Benchmark",
        out_dir / "Kong_ODE_Benchmark.pdf",
        KONG_ODE,
    )
    render_report(
        "Lee Smooth Manifolds Benchmark",
        out_dir / "Lee_Smooth_Manifolds_Benchmark.pdf",
        LEE_SMOOTH,
    )
    render_report(
        "Engelking General Topology Benchmark",
        out_dir / "Engelking_General_Topology_Benchmark.pdf",
        ENGELKING_TOPOLOGY,
    )
    render_report(
        "Grafakos Classical Fourier Analysis Benchmark",
        out_dir / "Grafakos_Classical_Fourier_Analysis_Benchmark.pdf",
        GRAFAKOS_FOURIER,
    )
    render_report(
        "Mattila Geometry Sets Measures Benchmark",
        out_dir / "Mattila_Geometry_Sets_Measures_Benchmark.pdf",
        MATTILA_GEOMETRY,
    )


if __name__ == "__main__":
    main()
