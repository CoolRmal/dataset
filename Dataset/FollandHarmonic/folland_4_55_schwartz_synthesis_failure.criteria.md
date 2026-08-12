# Criteria: folland_4_55_schwartz_synthesis_failure

**Statement:** [folland_4_55_schwartz_synthesis_failure.md](folland_4_55_schwartz_synthesis_failure.md) · **Lean:** [folland_4_55_schwartz_synthesis_failure.lean](folland_4_55_schwartz_synthesis_failure.lean)

This is an **existence** statement: some closed ideal has the unit sphere as its hull and is strictly smaller than the kernel of the sphere. The strictness `I ≠ ι(S)` is the point; a candidate that asserts $\nu(I) = S$ alone has formalized a triviality. The dimension restriction $n \ge 3$ is genuine — the sphere in $\mathbb{R}^1$ and $\mathbb{R}^2$ behaves differently — and the ideal must be exhibited as a closed, translation-invariant subspace.

Legend: ✅ ground truth satisfies the criterion · ⚠️ ground truth acceptable but improvable · ❗ trap — known/likely model error to check in candidate statements.

| # | Category | Criterion / potential error | Assessment of ground truth |
|---|----------|-----------------------------|----------------------------|
| 1 | Conclusion completeness | Both `ν(I) = S` and `I ≠ ι(S)` are required. | ✅ Both conjuncts. ❗ Highest-value trap: dropping the inequality. |
| 2 | Hypothesis completeness | `3 ≤ n`. Schwartz's construction uses the normal derivative of $\widehat f$ on $S$ and needs the sphere to be a genuine hypersurface with enough curvature. | ✅ `hn : 3 ≤ n`. ❗ Predicted error: stating it for all `n`. |
| 3 | Faithful encoding | `I` must be a closed **ideal**; on `ℝⁿ` an equivalent and more checkable formulation (Theorem 2.45) is that it is a closed translation-invariant subspace. | ✅ `Submodule ℂ (…→ ℂ)`, `IsLpClosed 1 volume`, and translation invariance `(fun x ↦ f (x - y)) ∈ I`. ⚠️ The ideal property is expressed through 2.45's criterion rather than through convolution; documented. |
| 4 | Faithful encoding | `S` is the **unit** sphere centred at the origin in the Euclidean metric, and the transform is the classical `∫ e^{-2πi x·ξ} f(x) dx`. | ✅ `Metric.sphere (0 : EuclideanSpace ℝ (Fin n)) 1` and `euclideanFourier`. ❗ Predicted error: working on `Fin n → ℝ`, where the "sphere" is a sup-norm cube boundary. |
| 5 | Junk values | `euclideanFourier f ξ` is `0` for non-integrable `f`, so the hull could be all of `ℝⁿ` for junk reasons; the `Integrable f volume` condition on members of `I` and inside `ι(S)` prevents this. | ✅ Both carry the integrability condition. |
