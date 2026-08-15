# Grading a candidate formalization

Every problem carries a `<decl>.criteria.md` rubric, and every rubric ends with a
`## Grading (out of 100)` section. This file defines what those 100 points mean, so
that a judge — human or LLM — applies the same scale to all 160 problems.

## What is being graded

The input to a grader is:

- `<decl>.md` — the textbook statement (the **specification**),
- `<decl>.context.md` — background: what the notation means, which Mathlib name
  corresponds to which textbook notion, and which readings of the text are wrong,
- `<decl>.criteria.md` — the rubric: a table of requirements, a table of expected
  mistakes, and the grading section,
- a **candidate** Lean statement produced by a model.

The candidate is graded **against the textbook statement**, not against the ground-truth
Lean file. A candidate that is spelled differently from the ground truth but is
mathematically equivalent to the text loses nothing. Conversely, a candidate that
matches the ground truth token-for-token in a place where the rubric marks the ground
truth ⚠️ inherits that defect.

The candidate is a *statement*, not a proof. `sorry` in the proof is expected and is
never penalized. Anything that makes the file fail to compile is a score of 0.

## The five bands

| Band | Points | What it measures |
|---|---|---|
| **A. Completeness** | 50 | Every hypothesis and every part of the conclusion that the text asserts is present, and nothing is asserted that the text does not. Scored row by row against the requirement table. |
| **B. Semantic fidelity** | 20 | The Lean terms *denote* what they appear to denote: no junk values, no silent default, no coercion that changes the claim, quantifiers in the right order and with the right scope. |
| **C. Mathlib-concept correctness** | 15 | Textbook notions are rendered by the Mathlib notion that actually means the same thing, with the typeclass assumptions those notions require. |
| **D. Non-degeneracy** | 10 | The statement is not vacuous, not trivially true, not unsatisfiable, and not a strictly weaker theorem wearing the right name. |
| **E. Hygiene** | 5 | Mathlib style: no unnecessary auxiliary definitions, no redundant conjuncts, no unused hypotheses, standard naming and binder conventions. |

### Band A — Completeness (50)

The requirement table in each rubric has $N$ rows. Each row is worth $50/N$ points.

- **Full credit** for a row the candidate states, in any mathematically equivalent form.
- **Half credit** for a variant that is stronger or weaker in a way that does not
  interact with the other rows (e.g. `0 < r` where `0 ≤ r` would do).
- **No credit** if the row is absent, or is stated in a form that another row's
  requirement then contradicts.

Asserting *more* than the text is not free: a conjunct with no counterpart in the text is
charged here at the cost of one row, and if it makes the statement false it triggers the
falsity cap below.

### Band B — Semantic fidelity (20)

This band is where formalizations most often fail while still compiling. Check at least:

- **Junk values.** In Lean every function is total, so a term outside its intended domain
  silently returns a default. The recurring cases:
  - `∫ f ∂μ` (Bochner) is `0` when `f` is not integrable — so "the integral is finite" or
    "the integral is bounded by …" is *not* expressible with `∫`. Use `∫⁻ … ∂μ` into
    `ℝ≥0∞`, or carry an `Integrable` hypothesis.
  - `sSup`/`⨆` over `ℝ` is `0` for a set that is empty or unbounded above, so
    `sSup S ≤ C` can hold vacuously. Take suprema in `ℝ≥0∞` or `EReal`, or add
    `BddAbove`.
  - `x / 0 = 0`, `x⁻¹` at `0` is `0`, `Real.log` of a non-positive number is `0`,
    `Real.sqrt` of a negative number is `0`, `n - m` in `ℕ` truncates, `Classical.choice`
    on an empty type. Each turns a false claim into a provable one.
  - `deriv f x`, `fderiv`, `mfderiv` are `0` where `f` is not differentiable, so
    "the derivative is bounded" is empty without a differentiability hypothesis.
  - `Measure` applied to a non-measurable set is the outer measure, not junk, but
    `MeasurableSet` hypotheses are still needed wherever the text assumes them.
- **`ℝ` vs `ℝ≥0∞` vs `EReal`.** A quantity the text allows to be $+\infty$ must live in a
  type that has $+\infty$. Conversely `ENNReal.ofReal` sends negatives to `0` and
  `ENNReal.toReal` sends `∞` to `0`; both are junk-producing and must be applied only
  where the sign or finiteness is already known.
- **Quantifier order and scope.** `∀ ε, ∃ δ` is not `∃ δ, ∀ ε`. A constant that the text
  says depends only on the dimension must not be quantified inside the variable it is
  supposed to be uniform in. "There is one $G$ for the whole family" is not
  "each member has its own $G$".
- **Coercions.** `(n : ℝ)` for `n : ℕ`, `↑` between `ℝ≥0` and `ℝ≥0∞`, subtype coercions:
  each is a place where a claim can quietly change.
- **a.e. vs everywhere.** `∀ᵐ x ∂μ` and `∀ x` are different theorems; so are
  `f =ᵐ[μ] g` and `f = g`.

### Band C — Mathlib-concept correctness (15)

The candidate must use the Mathlib notion that means the textbook notion, not one that
merely shares a name. Recurring traps:

- A *smooth embedding* of manifolds is `Manifold.IsSmoothEmbedding` — an immersion **and**
  a topological embedding. `ContMDiff` plus `Topology.IsEmbedding` is strictly weaker
  ($t \mapsto t^3$ on `ℝ`), so it is the wrong notion, not a paraphrase.
- Countability assumptions must be the ones the textbook uses. Where a book says
  "second countable", use `[SecondCountableTopology M]`; do not substitute
  `[SigmaCompactSpace M]` because it happens to be equivalent for that class of spaces.
  Equivalent-but-different assumptions cost credit here even when the theorem is
  unchanged.
- `Continuous` vs `ContinuousOn` vs `ContinuousAt`; `Differentiable` vs `DifferentiableOn`;
  `HasDerivAt` vs `deriv`.
- `IsCompact` on a set vs `[CompactSpace]` on a type; `IsOpen`/`IsClosed` in the subspace
  topology vs in the ambient space.
- `MeasurableSet` vs `NullMeasurableSet`; `Measure` vs `SignedMeasure` vs `VectorMeasure`;
  `IsFiniteMeasure` vs `IsProbabilityMeasure`.
- Model-with-corners choices: `𝓘(ℝ, E)` is boundaryless; a manifold *with boundary* needs
  a half-space model. Smoothness exponent `∞` (from `open scoped ContDiff`) is $C^\infty$,
  while `⊤` in the same scope elaborates to `ω`, real-analytic.
- Re-defining a notion that Mathlib already has is charged here, and again under Band E.

### Band D — Non-degeneracy (10)

- **Vacuity.** Hypotheses that cannot all hold at once (or hold only for the empty type,
  or only in dimension `0`) make the statement provable and worthless.
- **Triviality.** A conclusion that follows from the hypotheses by `simp` or from a
  Mathlib one-liner is not a formalization of a hard theorem.
- **Strictly weaker theorems.** Existentially quantifying a constant the text pins down
  ("`∃ N, M` embeds in `ℝ^N`" for "`M` embeds in `ℝ^{2m+1}`"), or asserting one direction
  of a stated equivalence.
- **Junk-satisfiable statements.** If some clause is satisfied only because of a junk
  value, that is charged in Band B and again here.

### Band E — Hygiene (5)

- No `def`/`let`/`abbrev` introduced for something Mathlib already names, and no auxiliary
  definition that is used once and could be inlined.
- No redundant conjunct (e.g. asserting `ContMDiff … F` alongside `IsSmoothEmbedding … F`,
  which already implies it).
- No unused hypothesis, no `autoImplicit` reliance, binders and names follow Mathlib
  convention, `variable` used where it belongs.

## Caps

Caps are applied after the bands are summed, and the lowest applicable cap wins.

| Situation | Cap |
|---|---|
| The statement is **false** (a counterexample exists) | 20 |
| The hypotheses are **unsatisfiable**, or the statement is vacuous or trivially provable | 15 |
| The statement is true but is **not this theorem** (a different, usually weaker, result) | 45 |
| A clause holds only through a **junk value** | 45 |
| Any single requirement row flagged **fatal** in the rubric's grading section is violated | 25 |
| The file does not compile | 0 |

## Reporting

A grader should report the five band subtotals, every cap applied, and a one-line
justification per band, then the total. A total of 90 or above means "as good as the
ground truth"; 70–89 means "usable with a named defect"; below 70 means the candidate
should be rejected.
