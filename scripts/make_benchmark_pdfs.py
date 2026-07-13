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
    pattern = re.compile(rf"^(?:noncomputable\s+)?(?:def|theorem|structure|abbrev)\s+{re.escape(name)}\b")
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


def make_formalization(entry: Entry) -> str:
    path = ROOT / entry.lean_file
    parts = [extract_decl(path, name) for name in entry.definitions]
    parts.append(extract_decl(path, entry.decl))
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
