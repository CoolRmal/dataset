# Criteria: hayman_3_6_derivative_zeros_near_poles

**Statement:** [hayman_3_6_derivative_zeros_near_poles.md](hayman_3_6_derivative_zeros_near_poles.md) · **Lean:** [hayman_3_6_derivative_zeros_near_poles.lean](hayman_3_6_derivative_zeros_near_poles.lean)

A two-case theorem whose cases are governed by how many poles lie on the *critical circle* — the boundary of the largest pole-free disk about $z_0$. Both cases must be present, and the maximality of $r$ is the hypothesis that makes the dichotomy exhaustive.

Legend: ✅ ground truth satisfies the criterion · ⚠️ ground truth acceptable but improvable · ❗ trap — known/likely model error to check in candidate statements.

| # | Category | Criterion / potential error | Assessment of ground truth |
|---|----------|-----------------------------|----------------------------|
| 1 | Conclusion completeness | Both (i) and (ii) are required, and they are governed by different hypotheses on the critical circle. | ✅ A conjunction of two implications. ❗ Predicted error: keeping only (i). |
| 2 | Hypothesis completeness | $r$ must be the radius of the **largest** pole-free circle; without maximality neither case holds. | ✅ `hrmax : IsGreatest {t \| 0 < t ∧ ∀ z ∈ P, ¬ ‖z - z₀‖ < t} r`. ❗ Predicted error: merely `∀ z ∈ P, r ≤ ‖z - z₀‖`. |
| 3 | Hypothesis completeness | $f$ must have at least two *distinct* poles in the disk. | ✅ `htwo`. ❗ Predicted error: two poles counted with multiplicity, i.e. a single double pole. |
| 4 | Faithful encoding | "Pole" is a point of the disk at which `f` is meromorphic but not analytic. | ✅ `P = {z ∈ ball z₀ R \| ¬ AnalyticAt ℂ f z}`. ⚠️ This also admits removable singularities in principle; for a genuinely meromorphic `f` in normal form it is the pole set. |
| 5 | Faithful encoding / case (ii) | "$f^{(l)} \to \infty$ uniformly in $\lvert z-z_0\rvert \le \delta$" is uniform divergence, rendered as divergence of the infimum of $\|f^{(l)}\|$ over the closed disk. | ✅ `Tendsto (fun l ↦ ⨅ z : closedBall z₀ δ, ‖iteratedDeriv l f z‖) atTop atTop`. ❗ Predicted error: pointwise divergence, which is strictly weaker. |
