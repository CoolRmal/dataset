# dataset

Lean statement dataset for hard autoformalization targets, using the local
mathlib checkout as dependency.

Included source files:

- `Dataset/Bogachev.lean`
- `Dataset/ConwayFunctionalAnalysis.lean`
- `Dataset/EngelkingGeneralTopology.lean`
- `Dataset/GrafakosFourier.lean`
- `Dataset/KongODE.lean`
- `Dataset/KallenbergProbability.lean`
- `Dataset/KrylovHolder.lean`
- `Dataset/LeeSmoothManifolds.lean`
- `Dataset/MattilaGeometry.lean`
- `Dataset/NikolskiOperators.lean`

Each file contains ten deliberately hard, statement-only declarations. Their
proofs intentionally end in `sorry`; custom notions not already supplied by
Mathlib have documented Lean definitions rather than placeholder propositions.

`scripts/make_benchmark_pdfs.py` generates one report per textbook in
`reports/`. Every report has exactly three columns: the textbook's natural-language statement
(followed by textbook definitions only when a required notion is absent from Mathlib), domain, and
`GroundTruth` (including the corresponding Lean definitions and theorem statement). Natural-language
definitions are transcribed from the textbook and are never synthesized from Lean docstrings.
