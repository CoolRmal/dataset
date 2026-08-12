# Criteria: bogachev_gaussian_2_8_10_anderson_inequality

**Statement:** [bogachev_gaussian_2_8_10_anderson_inequality.md](bogachev_gaussian_2_8_10_anderson_inequality.md) · **Lean:** [bogachev_gaussian_2_8_10_anderson_inequality.lean](bogachev_gaussian_2_8_10_anderson_inequality.lean)

A faithful formalization must have **both** conclusions — $\gamma(A+a) \le \gamma(A)$ and the monotonicity $\gamma(A+a) \le \gamma(A+ta)$ for $t \in [0,1]$ — and all three hypotheses on $A$: measurable, convex, and balanced. Dropping balancedness makes the inequality false (translate a half-space), dropping convexity makes it false (a symmetric annulus), and dropping centeredness of $\gamma$ makes it false for the obvious reason that the maximum is then attained elsewhere.

Legend: ✅ ground truth satisfies the criterion · ⚠️ ground truth acceptable but improvable · ❗ trap — known/likely model error to check in candidate statements.

| # | Category | Criterion / potential error | Assessment of ground truth |
|---|----------|-----------------------------|----------------------------|
| 1 | Hypothesis completeness | $A$ must be *absolutely convex* — convex **and** balanced. Either alone is insufficient. | ✅ `hconv : Convex ℝ A` and `hbal : Balanced ℝ A`, using mathlib's `Balanced` rather than a hand-rolled symmetry condition. ❗ Predicted error: only `Convex ℝ A`, or only symmetry `-A = A` without convexity. |
| 2 | Hypothesis completeness | $\gamma$ must be **centered**; for a shifted Gaussian the inequality fails at $a$ equal to minus the mean. | ✅ `hcentered : ∫ x, x ∂γ = 0`. ❗ Predicted error: omitting it. |
| 3 | Conclusion completeness | The second, monotone conclusion is strictly stronger than the first and is what is used in applications. | ✅ Both, as a conjunction. ❗ Predicted error: keeping only `γ (A + a) ≤ γ A`. |
| 4 | Faithful encoding | $A + a$ is the translate of the set, `(fun x ↦ x + a) '' A`, and the family is indexed by $t \in [0,1]$ with the translate $A + ta$. | ✅ As written, with `t ∈ Icc (0:ℝ) 1`. |
| 5 | Junk values | Mathlib's Bochner integral is `if _ : CompleteSpace G then … else 0`, so on an **incomplete** `E` the centering hypothesis `∫ x, x ∂γ = 0` is a tautology and the theorem is asserted for arbitrary non-centered Gaussians — which is false (a shifted Gaussian on an incomplete subspace of $\ell^2$ refutes it). | ✅ `[CompleteSpace E]` (added after review; the first version omitted it and was false). ❗ Predicted error: any statement whose only centering condition is a Bochner integral over a space not known to be complete. |
| 6 | Mathlib conventions | Inequalities are written with the smaller side on the left, and the balanced/convex predicates come from mathlib. | ✅ `γ (A + a) ≤ γ A`, `Balanced ℝ A`, `Convex ℝ A`. |
