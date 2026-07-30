# dataset

Lean statement dataset for hard autoformalization targets, using the local
mathlib checkout as dependency.

## Layout

The dataset contains ten textbooks with ten problems each. Every problem has
its own set of files under `Dataset/<Book>/`, named after the Lean
declaration:

- `<decl>.lean` — the statement-only formalization (the proof is intentionally
  `sorry`). Custom notions not already supplied by Mathlib live in the book's
  `Dataset/<Book>/Defs.lean`, which problem files import.
- `<decl>.md` — the natural-language statement transcribed from the textbook,
  with all mathematics in LaTeX (`$...$` / `$$...$$`).
- `<decl>.criteria.md` — a quality rubric for the problem: a table of criteria
  and potential errors a model can make when formalizing this statement
  (hypothesis/conclusion completeness, junk values, semantic closeness to the
  text, closeness to Mathlib conventions, likely traps), together with an
  honest assessment of the ground-truth statement against each criterion.
  These rubrics define what it means for a candidate Lean statement of this
  problem to be good quality.

`Dataset/<Book>.lean` is an import roll-up for the book, so `lake build`
builds every problem file; declaration names are unchanged from the original
monolithic per-book files.

Included books:

- `Dataset/Bogachev/` — V. I. Bogachev, *Measure Theory*
- `Dataset/ConwayFunctionalAnalysis/` — J. B. Conway, *A Course in Functional Analysis*
- `Dataset/EngelkingGeneralTopology/` — R. Engelking, *General Topology*
- `Dataset/GrafakosFourier/` — L. Grafakos, *Classical Fourier Analysis*
- `Dataset/KongODE/` — Q. Kong, *A Short Course in Ordinary Differential Equations*
- `Dataset/KallenbergProbability/` — O. Kallenberg, *Foundations of Modern Probability*
- `Dataset/KrylovHolder/` — N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Hölder Spaces*
- `Dataset/LeeSmoothManifolds/` — J. M. Lee, *Introduction to Smooth Manifolds*
- `Dataset/MattilaGeometry/` — P. Mattila, *Geometry of Sets and Measures in Euclidean Spaces*
- `Dataset/NikolskiOperators/` — N. K. Nikolski, *Operators, Functions, and Systems*

## Scripts and generated artifacts

- `scripts/make_benchmark_pdfs.py` generates one report per textbook in
  `reports/`. Every report has exactly three columns: the textbook's
  natural-language statement (followed by textbook definitions only when a
  required notion is absent from Mathlib), domain, and `GroundTruth`
  (including the corresponding Lean definitions and theorem statement).
  Natural-language definitions are transcribed from the textbook and are never
  synthesized from Lean docstrings.
- `scripts/make_index.py` generates `data/records.jsonl` with one record per
  problem: id, book, domain, declaration name, file paths (Lean / statement /
  criteria / Defs), the natural-language statement, and the extracted Lean
  formalization.
