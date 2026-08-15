# dataset

Lean statement dataset for hard autoformalization targets, using the local
mathlib checkout as dependency. The whole dataset elaborates under
`lake build`: 160 statement files, 160 `sorry` warnings, no errors.

## Layout

The dataset contains sixteen textbooks with ten problems each. Every problem has
its own directory `Dataset/<Book>/<decl>/`, named after the Lean declaration and
holding that problem's four files, each also named after the declaration:

- `<decl>.lean` — the statement-only formalization (the proof is intentionally
  `sorry`). Custom notions not already supplied by Mathlib live in the book's
  `Dataset/<Book>/Defs.lean`, which problem files import.
- `<decl>.md` — the natural-language statement transcribed from the textbook,
  with all mathematics in LaTeX (`$...$` / `$$...$$`).
- `<decl>.criteria.md` — a quality rubric for the problem: a table of criteria
  and potential errors a model can make when formalizing this statement
  (hypothesis/conclusion completeness, junk values, semantic closeness to the
  text, closeness to Mathlib conventions, likely traps), together with an
  honest assessment of the ground-truth statement against each criterion, and
  a `## Grading (out of 100)` section instantiating the shared scale of
  [GRADING.md](GRADING.md) for this problem — the per-problem point split,
  the requirements whose violation is fatal, and the domain-specific pitfalls
  to check for. These rubrics define what it means for a candidate Lean
  statement of this problem to be good quality.
- `<decl>.context.md` — the minimal background a reader needs in order to read
  the statement correctly: what the notation means, which of several
  same-sounding notions the book intends, and which readings are wrong. It is
  natural language only — no Lean, and no hint at how to formalize the
  statement — and exists to resolve confusion rather than to give the answer
  away. Example: Bogachev 8.6.2 speaks of a family `M` of "measures", and the
  context file records that in that chapter "measure" means a finite *signed*
  Borel measure.

So a problem occupies four files in one folder:

```
Dataset/Bogachev/proposition_5_5_4/
  proposition_5_5_4.lean         -- the statement, proof `sorry`
  proposition_5_5_4.md           -- the textbook statement
  proposition_5_5_4.criteria.md  -- rubric + grading section
  proposition_5_5_4.context.md   -- background needed to read it
```

Notions shared across a book live in `Dataset/<Book>/Defs.lean`, one level up.
`Dataset/<Book>.lean` is an import roll-up for the book, so `lake build` builds
every problem file; declaration names are unchanged from the original
monolithic per-book files, though module paths now carry the folder
(`Dataset.Bogachev.proposition_5_5_4.proposition_5_5_4`).

## Grading

[GRADING.md](GRADING.md) defines the 100-point scale used by every rubric:
five bands (completeness 50, semantic fidelity 20, Mathlib-concept
correctness 15, non-degeneracy 10, hygiene 5), a list of caps for statements
that are false, vacuous, junk-satisfied or simply a different theorem, and a
catalogue of the recurring failure modes each band is meant to catch. Each
`<decl>.criteria.md` closes with that scale instantiated for its own problem.

## Repairs

Applying the rubrics to the dataset's own statements turned up defects in the
ground truth — statements that are false or unsatisfiable, terms that silently
evaluate to a junk default, and statements that are true but are not the
book's theorem. Those defects have been repaired in the Lean sources and are
recorded in [GROUND_TRUTH_ISSUES.md](GROUND_TRUTH_ISSUES.md) as a regression
ledger. Relevant rubrics retain the original failure mode as a model-error
trap and carry a note that the current ground truth incorporates the repair.

Included books:

- `Dataset/Bogachev/` — V. I. Bogachev, *Measure Theory*
- `Dataset/BogachevGaussian/` — V. I. Bogachev, *Gaussian Measures*
- `Dataset/ConwayFunctionalAnalysis/` — J. B. Conway, *A Course in Functional Analysis*
- `Dataset/EngelkingGeneralTopology/` — R. Engelking, *General Topology*
- `Dataset/FollandHarmonic/` — G. B. Folland, *A Course in Abstract Harmonic Analysis*
- `Dataset/GrafakosFourier/` — L. Grafakos, *Classical Fourier Analysis*
- `Dataset/HaymanMeromorphic/` — W. K. Hayman, *Meromorphic Functions*
- `Dataset/KongODE/` — Q. Kong, *A Short Course in Ordinary Differential Equations*
- `Dataset/KallenbergProbability/` — O. Kallenberg, *Foundations of Modern Probability*
- `Dataset/KrylovHolder/` — N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Hölder Spaces*
- `Dataset/KrylovSobolev/` — N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Sobolev Spaces*
- `Dataset/LeeSmoothManifolds/` — J. M. Lee, *Introduction to Smooth Manifolds*
- `Dataset/MattilaGeometry/` — P. Mattila, *Geometry of Sets and Measures in Euclidean Spaces*
- `Dataset/NivenIrrational/` — I. Niven, *Numbers: Rational and Irrational*
- `Dataset/NivenZuckermanNumberTheory/` — I. Niven and H. S. Zuckerman, *An Introduction to the Theory of Numbers*
- `Dataset/NikolskiOperators/` — N. K. Nikolski, *Operators, Functions, and Systems*

## Expansion

[CANDIDATE_BOOKS.md](CANDIDATE_BOOKS.md) records a search for freely licensed
textbooks that could become new books, with the licence of each checked against
its copyright page and the Mathlib gap checked against the library.

## Source texts

`reference/` holds the source textbooks themselves and nothing else: one PDF
per book, named after the `Dataset/<Book>/` directory it feeds. Generated
benchmark reports and books that back no `Dataset/` directory have been removed
from it. `reference/README.md` records, for each PDF, the offset between PDF
page numbers and printed page numbers — several of these books are scans with
no text layer, so a page has to be rendered to an image before it can be read.

## Scripts and generated artifacts

- `scripts/make_benchmark_pdfs.py` generates one report per textbook in
  `build/benchmarks/` (git-ignored; the directory is a build artifact, not part
  of the dataset). Every report has exactly three columns: the textbook's
  natural-language statement (followed by textbook definitions only when a
  required notion is absent from Mathlib), domain, and `GroundTruth`
  (including the corresponding Lean definitions and theorem statement).
  Natural-language definitions are transcribed from the textbook and are never
  synthesized from Lean docstrings.
- `scripts/make_index.py` generates `data/records.jsonl` with one record per
  problem: id, book, domain, declaration name, file paths (Lean / statement /
  criteria / context / Defs), the natural-language statement, and the extracted
  Lean formalization.
- `scripts/rubric_lib.py` holds the shared machinery for maintaining the
  rubrics: it computes each problem's point split from its own requirement
  table and writes the `## Grading (out of 100)` section and the
  `<decl>.context.md` header.
