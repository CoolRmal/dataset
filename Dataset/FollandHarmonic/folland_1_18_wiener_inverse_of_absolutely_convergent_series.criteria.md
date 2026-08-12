# Criteria: folland_1_18_wiener_inverse_of_absolutely_convergent_series

**Statement:** [folland_1_18_wiener_inverse_of_absolutely_convergent_series.md](folland_1_18_wiener_inverse_of_absolutely_convergent_series.md) · **Lean:** [folland_1_18_wiener_inverse_of_absolutely_convergent_series.lean](folland_1_18_wiener_inverse_of_absolutely_convergent_series.lean)

Wiener's theorem. The whole content is that the reciprocal's Fourier coefficients are again **absolutely summable** — that $1/f$ has *some* Fourier expansion is not the theorem. The hypothesis is that $f$ vanishes nowhere on the circle, which for a series indexed by all of `ℤ` must be checked at every `θ`, not only on a subinterval.

Legend: ✅ ground truth satisfies the criterion · ⚠️ ground truth acceptable but improvable · ❗ trap — known/likely model error to check in candidate statements.

| # | Category | Criterion / potential error | Assessment of ground truth |
|---|----------|-----------------------------|----------------------------|
| 1 | Conclusion completeness | The conclusion is the conjunction `Summable ‖b ·‖` **and** the identity; dropping summability leaves a triviality. | ✅ Both conjuncts are asserted. ❗ Highest-value trap. |
| 2 | Junk values | `∑'` of a non-summable family is the junk value `0`, which would make `hne` refutable and the identity meaningless. | ✅ `ha : Summable fun n ↦ ‖a n‖` forces the `a`-series to converge for every `θ` (the exponentials have modulus one); the conclusion likewise carries `Summable ‖b ·‖`, so both `tsum`s are genuine. |
| 3 | Junk values / division | Writing the conclusion as `∑' n, b n * e = 1 / ∑' n, a n * e` would be junk-safe only because of `hne`; the product form avoids the question. | ✅ Stated as `(∑' b …) * (∑' a …) = 1`. ⚠️ Slightly further from the book's `1/f` than a division would be, but strictly stronger and junk-free. |
| 4 | Hypothesis completeness | `f` never vanishes — at every point of the circle. | ✅ `∀ θ : ℝ, … ≠ 0`. ❗ Predicted error: quantifying `θ` over `[0, 2π)` only (harmless) or forgetting the hypothesis (fatal). |
| 5 | Faithful encoding | The circle is parameterised by `θ ↦ e^{iθ}` and the series is two-sided, indexed by `ℤ`. | ✅ `n : ℤ` and `Complex.exp (n * θ * I)`. ❗ Predicted error: indexing by `ℕ`, which states a different (false) theorem about analytic functions. |
| 6 | Semantic closeness / mathlib coverage | Mathlib has no Wiener lemma and no Gelfand theory of `ℓ¹(ℤ)`; `Mathlib/NumberTheory/LSeries/PrimesInAP.lean` mentions Wiener–Ikehara, a different result. | ✅ Genuinely absent from mathlib. |
