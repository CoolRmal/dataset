# Criteria: bogachev_gaussian_2_7_2_feldman_hajek

**Statement:** [bogachev_gaussian_2_7_2_feldman_hajek.md](bogachev_gaussian_2_7_2_feldman_hajek.md) · **Lean:** [bogachev_gaussian_2_7_2_feldman_hajek.lean](bogachev_gaussian_2_7_2_feldman_hajek.lean)

## What the theorem says

Take any two Gaussian measures on the same space. Then exactly one of two things happens: either
they have the same null sets (they are equivalent), or they live on disjoint sets (they are
mutually singular). There is no middle ground — no pair of Gaussian measures is, say, absolutely
continuous in one direction only, or partly overlapping. The whole content of the theorem is that
the third possibility is excluded.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | Two measures $\mu,\nu$ on one and the same space. | ✅ `(μ ν : Measure E)` for a single `E`. |
| 2 | Both are Gaussian; nothing else is assumed about them. | ✅ `[IsGaussian μ] [IsGaussian ν]`, and no other hypothesis. |
| 3 | The conclusion is a disjunction, so that the two cases are exhaustive. | ✅ The top-level connective is `∨`. |
| 4 | "Equivalent" is two-sided: each measure is absolutely continuous with respect to the other. | ✅ `Equivalent μ ν`, defined as `μ ≪ ν ∧ ν ≪ μ`. |
| 5 | "Mutually singular" is the standard notion: the space splits into a set carrying $\mu$ and its complement carrying $\nu$. | ✅ `μ ⟂ₘ ν`, Mathlib's `MeasureTheory.Measure.MutuallySingular`. |
| 6 | The result holds in any dimension, including infinite-dimensional spaces, and is stated for a general space rather than a particular one. | ⚠️ `{E : Type*}` with a normed and Borel structure. Bogachev states it for locally convex spaces; a normed space is where Mathlib's `IsGaussian` lives, so this is a narrower setting than the printed one. |

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

- Bogachev states the theorem on a locally convex space. We state it on a normed space with a Borel structure, because that is where Mathlib's `IsGaussian` lives. This narrows the scope but not the mathematical content. A candidate that states it on a locally convex space with a hand-written Gaussianity predicate is at least as faithful, provided the predicate matches Definition 2.2.1 (every continuous linear functional has a real Gaussian law).
- `Equivalent` is our own definition, in `Defs.lean`, because Mathlib supplies `≪` and `⟂ₘ` but no bundled notion of equivalent measures. A candidate writing `μ ≪ ν ∧ ν ≪ μ` inline is equally correct.
- The statement contains no suprema, integrals or `toReal` conversions, so there is no place where a Lean default value could make it true for the wrong reason. The only modelling choice is the ambient space.
