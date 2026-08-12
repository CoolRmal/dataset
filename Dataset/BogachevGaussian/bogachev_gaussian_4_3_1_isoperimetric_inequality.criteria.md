# Criteria: bogachev_gaussian_4_3_1_isoperimetric_inequality

**Statement:** [bogachev_gaussian_4_3_1_isoperimetric_inequality.md](bogachev_gaussian_4_3_1_isoperimetric_inequality.md) · **Lean:** [bogachev_gaussian_4_3_1_isoperimetric_inequality.lean](bogachev_gaussian_4_3_1_isoperimetric_inequality.lean)

A faithful formalization must say that the Gaussian quantile of the closed $r$-neighbourhood of *any* measurable set exceeds that of the set by at least $r$ — the sharp form in which half-spaces are the extremals. The two hazards are the same as for Ehrhard: the quantile must take values in $[-\infty,+\infty]$, and the neighbourhood must be the **Euclidean** $r$-neighbourhood $A + rU$, which on `Fin n → ℝ` would be a cube instead of a ball.

Legend: ✅ ground truth satisfies the criterion · ⚠️ ground truth acceptable but improvable · ❗ trap — known/likely model error to check in candidate statements.

| # | Category | Criterion / potential error | Assessment of ground truth |
|---|----------|-----------------------------|----------------------------|
| 1 | Junk values | $\Phi^{-1}$ at $\gamma_n(A) = 0$ must be $-\infty$, in which case the inequality is trivially true; a real-valued quantile would make it a false finite assertion. | ✅ `quantile (gaussianReal 0 1)` is `EReal`-valued. ❗ Predicted error: `.toReal` of a real quantile. |
| 2 | Faithful encoding | $A + rU$ with $U$ the **closed unit ball** is $\{z : \exists x \in A,\ \|z - x\| \le r\}$, the closed Euclidean $r$-neighbourhood. | ✅ `{z \| ∃ x ∈ A, ‖z - x‖ ≤ r}` on `EuclideanSpace`. ❗ Predicted error: using the open ball, or working on `Fin n → ℝ` where `‖·‖` is the sup norm and the statement becomes a (false) cube-enlargement inequality. |
| 3 | Hypothesis completeness | $A$ is an arbitrary measurable set — no convexity, no closedness. This is what distinguishes the isoperimetric inequality from Ehrhard's. | ✅ `hA : MeasurableSet A` only. ❗ Predicted error: adding `Convex ℝ A`, which yields a much weaker corollary. |
| 4 | Conclusion completeness | The gain is exactly `+ r`, not `+ c·r` for an unspecified constant; sharpness is the content. | ✅ `… + (r : EReal) ≤ …`. ❗ Predicted error: `∃ c > 0, … + c * r ≤ …`. |
| 5 | Hypothesis completeness | The inequality is asserted for every $r > 0$. | ✅ `hr : 0 < r`. ⚠️ It also holds at $r = 0$ trivially; requiring positivity matches the text. |
| 6 | Junk values | `(stdGaussian n A).toReal` is safe because `stdGaussian n` is a probability measure, so the value lies in $[0,1]$ and never hits the `∞ ↦ 0` truncation. | ✅ Safe. |
