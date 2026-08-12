# Criteria: niven_5_5_trisection_of_the_angle_impossible

**Statement:** [niven_5_5_trisection_of_the_angle_impossible.md](niven_5_5_trisection_of_the_angle_impossible.md) · **Lean:** [niven_5_5_trisection_of_the_angle_impossible.lean](niven_5_5_trisection_of_the_angle_impossible.lean)

Trisecting a general angle is shown impossible by exhibiting one angle that cannot be trisected: $60°$. The formal content is that $\cos 20° = \cos(\pi/9)$ is not constructible — an angle is constructible exactly when its cosine is.

Legend: ✅ ground truth satisfies the criterion · ⚠️ ground truth acceptable but improvable · ❗ trap — known/likely model error to check in candidate statements.

| # | Category | Criterion / potential error | Assessment of ground truth |
|---|----------|-----------------------------|----------------------------|
| 1 | Faithful encoding | $20° = \pi/9$ radians, and the constructibility of the angle is the constructibility of its cosine. | ✅ `¬ IsConstructible (Real.cos (Real.pi / 9))`. ❗ Predicted error: `Real.pi / 3` (that is $60°$, which *is* constructible) or degrees left unconverted. |
| 2 | Semantic closeness / scope | The theorem is about a *specific* angle; a statement quantified over all angles would be false, since many angles are trisectable. | ✅ The specific `π/9`. ❗ Predicted error: `∀ θ, ¬ IsConstructible (cos (θ/3))`. |
| 3 | Conclusion completeness | Non-constructibility, not irrationality: `cos 20°` is irrational, but so is `cos 15°`, which is constructible. | ✅ `¬ IsConstructible`. |
| 4 | Definition necessity | Reuses `IsConstructible`. | ✅ No new machinery. |
