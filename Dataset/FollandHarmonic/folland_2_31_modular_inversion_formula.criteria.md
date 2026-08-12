# Criteria: folland_2_31_modular_inversion_formula

**Statement:** [folland_2_31_modular_inversion_formula.md](folland_2_31_modular_inversion_formula.md) · **Lean:** [folland_2_31_modular_inversion_formula.lean](folland_2_31_modular_inversion_formula.lean)

The content is the exact weight $\Delta(x^{-1})$ that makes inversion measure-preserving. Getting the exponent or the argument of $\Delta$ wrong ($\Delta(x)$ instead of $\Delta(x^{-1})$, or $\Delta(x)^{-1}$ outside the integral) produces a formula that is correct only on unimodular groups — where the statement is vacuous — so such errors are invisible on every abelian or compact example.

Legend: ✅ ground truth satisfies the criterion · ⚠️ ground truth acceptable but improvable · ❗ trap — known/likely model error to check in candidate statements.

| # | Category | Criterion / potential error | Assessment of ground truth |
|---|----------|-----------------------------|----------------------------|
| 1 | Conclusion completeness | The identity is $\int f(x^{-1})\Delta(x^{-1})\,dx = \int f\,dx$: the integrand is $f$ evaluated at $x^{-1}$ **times** $\Delta(x^{-1})$. | ✅ `∫ x, f x⁻¹ * (modularCharacterFun x⁻¹ : ℝ) ∂μ = ∫ x, f x ∂μ`. ❗ Predicted error: `Δ(x)` in place of `Δ(x⁻¹)`, which is the reciprocal weight. |
| 2 | Mathlib conventions / convention mismatch | Mathlib's `Measure.modularCharacterFun` satisfies `map (· * g) μ = Δ_M g • μ`, i.e. $\mu(Ag^{-1}) = \Delta_M(g)\mu(A)$, whereas Folland's $\Delta$ satisfies $\lambda(Ex) = \Delta(x)\lambda(E)$ — so $\Delta_M = \Delta_{\text{Folland}}^{-1}$. Folland's $\Delta(x^{-1})$ is therefore mathlib's `modularCharacterFun x`. The two agree on every unimodular group, so the error is invisible on abelian and compact examples; the $ax+b$ group separates them. | ✅ `modularCharacterFun x` (corrected after review; the first version wrote `modularCharacterFun x⁻¹` and stated the reciprocal identity). ❗ Highest-value trap. |
| 3 | Hypothesis completeness | `f ∈ 𝓛¹(μ)` is needed for both integrals to be genuine; no continuity or compact support is required. | ✅ `hf : MemLp f 1 μ`. ⚠️ Folland states it for `f ∈ L¹`; a `Cc(G)` version is weaker. |
| 4 | Junk values | Bochner integrals of non-integrable functions are `0`, so without `hf` the identity could hold for a junk reason on both sides. | ✅ Guarded by `hf`. |
| 5 | Semantic closeness | The measure must be a **left** Haar measure; on a right Haar measure the same formula is false. | ✅ `[μ.IsHaarMeasure]`, mathlib's left-invariant notion. |
