# Criteria: bogachev_gaussian_2_7_2_feldman_hajek

**Statement:** [bogachev_gaussian_2_7_2_feldman_hajek.md](bogachev_gaussian_2_7_2_feldman_hajek.md) · **Lean:** [bogachev_gaussian_2_7_2_feldman_hajek.lean](bogachev_gaussian_2_7_2_feldman_hajek.lean)

The statement is a single disjunction and its whole content is that *no third possibility* occurs: two Gaussian measures on one space are either equivalent or mutually singular, never merely comparable. Because the statement is so short, almost every way of getting it wrong consists in adding a hypothesis (centered, equal covariance, nondegenerate, separable) that the theorem does not have, or in weakening the disjunction to an implication.

Legend: ✅ ground truth satisfies the criterion · ⚠️ ground truth acceptable but improvable · ❗ trap — known/likely model error to check in candidate statements.

| # | Category | Criterion / potential error | Assessment of ground truth |
|---|----------|-----------------------------|----------------------------|
| 1 | Conclusion completeness | The conclusion is a disjunction of the two-sided notions: `(μ ≪ ν ∧ ν ≪ μ) ∨ μ ⟂ₘ ν`. Replacing the first disjunct by `μ ≪ ν` gives a *false* statement (take $\mu$ and $\nu$ Gaussian with different nondegenerate covariances on an infinite-dimensional space). | ✅ `Equivalent μ ν ∨ μ ⟂ₘ ν`. ❗ Predicted error: one-sided absolute continuity. |
| 2 | Hypothesis completeness | Both measures are arbitrary Gaussian measures on the *same* space; no centering, no shared covariance, no nondegeneracy. | ✅ `[IsGaussian μ] [IsGaussian ν]` only. ❗ Predicted error: assuming `∫ x ∂μ = ∫ x ∂ν = 0`. |
| 3 | Semantic closeness | The dichotomy is genuinely infinite-dimensional in interest but holds in every dimension; it must not be stated only for $\mathbb{R}^n$ or only for Wiener measure. | ✅ Stated for an arbitrary normed space with a Borel structure. |
| 4 | Mathlib conventions | `⟂ₘ` is `MeasureTheory.Measure.MutuallySingular`; `≪` is `AbsolutelyContinuous`. A hand-rolled definition of either duplicates mathlib. | ✅ Both taken from mathlib; only the (genuinely absent) two-sided `Equivalent` is introduced. |
| 5 | Junk values | No suprema, integrals or `toReal` appear, so there is no junk-value surface; the only modelling choice is the ambient space. | ✅ Junk-free. |
| 6 | Semantic closeness | Bogachev states the theorem for locally convex spaces. Restricting to normed spaces narrows the scope but not the mathematical content of the dichotomy. | ⚠️ Documented; a candidate stating it on a locally convex space with a hand-rolled Gaussianity predicate is at least as faithful, provided the predicate matches Definition 2.2.1. |
