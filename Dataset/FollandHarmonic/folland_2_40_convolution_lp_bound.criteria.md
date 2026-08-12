# Criteria: folland_2_40_convolution_lp_bound

**Statement:** [folland_2_40_convolution_lp_bound.md](folland_2_40_convolution_lp_bound.md) · **Lean:** [folland_2_40_convolution_lp_bound.lean](folland_2_40_convolution_lp_bound.lean)

Three separate assertions, and (b) and (c) are conditional on unimodularity and on compact support respectively. A candidate that states only (a), or that states (b) unconditionally, has lost the point of the proposition — (b) is *false* on a non-unimodular group.

Legend: ✅ ground truth satisfies the criterion · ⚠️ ground truth acceptable but improvable · ❗ trap — known/likely model error to check in candidate statements.

| # | Category | Criterion / potential error | Assessment of ground truth |
|---|----------|-----------------------------|----------------------------|
| 1 | Conclusion completeness | All three parts (a), (b), (c) are asserted. | ✅ A three-fold conjunction. ❗ Predicted error: only part (a). |
| 2 | Hypothesis completeness | Part (b) holds only for unimodular `G`; part (c) only for `f` with compact support. | ✅ Each is an implication with its own hypothesis. ❗ Highest-value trap: asserting `‖g * f‖ₚ ≤ ‖f‖₁‖g‖ₚ` with no unimodularity hypothesis. |
| 3 | Conclusion completeness | (a) also asserts the a.e. absolute convergence of the defining integral, which is what makes `groupConv` meaningful rather than junk. | ✅ `∀ᵐ x ∂μ, Integrable (fun y ↦ f y * g (y⁻¹ * x)) μ`. ❗ Predicted error: omitting it, leaving the norm bound about a function that is `0` by default wherever the integral diverges. |
| 4 | Junk values | Mathlib's Bochner integral of a non-integrable function is `0`, so without the a.e.-integrability conjunct the bound could hold vacuously. | ✅ Addressed by the conjunct above. |
| 5 | Faithful encoding | `‖·‖_p` is `eLpNorm … p μ` and membership is `MemLp`; the exponent range is `1 ≤ p ≤ ∞`, with `p = ∞` allowed. | ✅ `p : ℝ≥0∞` with only `1 ≤ p`, so `p = ∞` is included as in the book. ❗ Predicted error: excluding `p = ∞`. |
| 6 | Mathlib conventions | Smaller side of the inequality on the left. | ✅ `eLpNorm (groupConv μ f g) p μ ≤ eLpNorm f 1 μ * eLpNorm g p μ`. |
