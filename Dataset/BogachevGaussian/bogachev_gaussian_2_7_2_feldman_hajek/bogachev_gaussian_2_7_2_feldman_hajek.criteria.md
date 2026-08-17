# Criteria: bogachev_gaussian_2_7_2_feldman_hajek

**Statement:** [bogachev_gaussian_2_7_2_feldman_hajek.md](bogachev_gaussian_2_7_2_feldman_hajek.md) · **Lean:** [bogachev_gaussian_2_7_2_feldman_hajek.lean](bogachev_gaussian_2_7_2_feldman_hajek.lean) · **Context:** [bogachev_gaussian_2_7_2_feldman_hajek.context.md](bogachev_gaussian_2_7_2_feldman_hajek.context.md)

## What the theorem says

Take any two Gaussian measures on the same space. Then exactly one of two things happens: either
they have the same null sets (they are equivalent), or they live on disjoint sets (they are
mutually singular). There is no middle ground — no pair of Gaussian measures is, say, absolutely
continuous in one direction only, or partly overlapping. The whole content of the theorem is that
the third possibility is excluded.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | Two measures $\mu,\nu$ on one and the same space. | ✅ `(μ ν : Measure E)` for a single `E`. |
| 2 | Both are Gaussian; nothing else is assumed about them. | ✅ `[IsGaussian μ] [IsGaussian ν]`, and no other hypothesis. |
| 3 | The conclusion is a disjunction, so that the two cases are exhaustive. | ✅ The top-level connective is `∨`. |
| 4 | "Equivalent" is two-sided: each measure is absolutely continuous with respect to the other. | ✅ `Equivalent μ ν`, defined as `μ ≪ ν ∧ ν ≪ μ`. |
| 5 | "Mutually singular" is the standard notion: the space splits into a set carrying $\mu$ and its complement carrying $\nu$. | ✅ `μ ⟂ₘ ν`, Mathlib's `MeasureTheory.Measure.MutuallySingular`. |
| 6 | The result holds in any dimension, including infinite-dimensional spaces, and is stated for a general space rather than a particular one. | ✅ `{E : Type*}` carrying `[AddCommGroup E] [Module ℝ E] [TopologicalSpace E] [IsTopologicalAddGroup E] [ContinuousSMul ℝ E] [LocallyConvexSpace ℝ E] [MeasurableSpace E] [BorelSpace E]` — Bogachev's locally convex setting exactly. Mathlib's `IsGaussian` needs only a topological `ℝ`-module, so no normed structure has to be imposed. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Weakening the first disjunct to one-sided absolute continuity, `μ ≪ ν ∨ μ ⟂ₘ ν`. | Strictly weaker than the theorem, and it throws away the point. What Hájek–Feldman gives is that a Gaussian pair that is not mutually singular has *identical* null sets; a one-sided version would still be satisfied by measures with a genuine density in one direction only, which for Gaussians never happens. |
| 2 | Turning the disjunction into an implication, e.g. "if not mutually singular then equivalent" stated with an extra hypothesis. | Loses the exhaustiveness that is the whole content. |
| 3 | Assuming both measures are centered, e.g. `∫ x ∂μ = ∫ x ∂ν = 0`. | Not a hypothesis of the theorem. The dichotomy holds for arbitrary means. |
| 4 | Assuming the two measures share a covariance operator. | With equal covariance the answer is decided by the Cameron–Martin criterion of Theorem 2.4.5; assuming it removes the hard part. |
| 5 | Adding non-degeneracy or separability of the space. | Neither is needed. Each narrows the theorem. |
| 6 | Stating it only for $\mathbb{R}^n$, or only for Wiener measure on $C[0,1]$. | On $\mathbb{R}^n$ the dichotomy is easy and the interesting content is infinite-dimensional; specializing to one example is not the theorem. |

## Notes on the ground truth

- Bogachev states the theorem on a locally convex space, and so does the Lean: `[AddCommGroup E] [Module ℝ E] [TopologicalSpace E] [IsTopologicalAddGroup E] [ContinuousSMul ℝ E] [LocallyConvexSpace ℝ E]` with a Borel structure, which requirement row 6 records. A candidate that restricts to a normed or Banach space narrows the scope but not the mathematical content; a hand-written Gaussianity predicate is equally faithful provided it matches Definition 2.2.1 (every continuous linear functional has a real Gaussian law).
- `Equivalent` is our own definition, in `Defs.lean`, because Mathlib supplies `≪` and `⟂ₘ` but no bundled notion of equivalent measures. A candidate writing `μ ≪ ν ∧ ν ≪ μ` inline is equally correct.
- The statement contains no suprema, integrals or `toReal` conversions, so there is no place where a Lean default value could make it true for the wrong reason. The only modelling choice is the ambient space.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[bogachev_gaussian_2_7_2_feldman_hajek.md](bogachev_gaussian_2_7_2_feldman_hajek.md) and the background in [bogachev_gaussian_2_7_2_feldman_hajek.context.md](bogachev_gaussian_2_7_2_feldman_hajek.context.md),
not against the ground-truth Lean file: a candidate spelled differently but
mathematically equivalent to the text loses nothing. The scale is defined in
[GRADING.md](../../GRADING.md); the numbers below are this problem's instance of it.

| Band | Points | This problem |
|---|---|---|
| A. Completeness | 50 | The requirement table above has 6 rows, so each row is worth 8.3 points: full credit if the candidate states it in any equivalent form, half for a harmless strengthening or weakening, none if it is absent. |
| B. Semantic fidelity | 20 | Junk values, `ℝ` vs `ℝ≥0∞`, coercions, quantifier order, a.e. vs everywhere — see the pitfalls below. |
| C. Mathlib-concept correctness | 15 | The Mathlib notion must mean the textbook notion, with the typeclass assumptions it needs. |
| D. Non-degeneracy | 10 | Not vacuous, not trivial, not a strictly weaker theorem. |
| E. Hygiene | 5 | No needless definitions, redundant conjuncts or unused hypotheses. |

**Every row of the *Mistakes to check for* table above is a defect.** Charge each one to the band it belongs to and deduct there.

### Fatal — any of these caps the total at 25

- Requirement 3 or 4 weakened to a one-sided statement (`μ ≪ ν ∨ μ ⟂ₘ ν`), which loses the theorem.
- Requirement 2 strengthened by assuming a common covariance operator, which reduces the statement to Theorem 2.4.5.

### Domain-specific pitfalls for this problem

- "Equivalent" is two-sided absolute continuity; Mathlib's `≪` gives only one side.
- The conclusion is a disjunction, not an implication with an extra hypothesis: exhaustiveness is what is being asserted.
- Centredness, non-degeneracy and separability are all absent from the hypotheses; each is a narrowing.
- Specialising the ambient space to $\mathbb{R}^n$ or to $C[0,1]$ removes the interesting content.
