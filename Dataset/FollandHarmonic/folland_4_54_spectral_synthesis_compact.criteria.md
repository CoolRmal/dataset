# Criteria: folland_4_54_spectral_synthesis_compact

**Statement:** [folland_4_54_spectral_synthesis_compact.md](folland_4_54_spectral_synthesis_compact.md) · **Lean:** [folland_4_54_spectral_synthesis_compact.lean](folland_4_54_spectral_synthesis_compact.lean)

Compactness of $G$ is the entire hypothesis: it forces $\widehat{G} \subset L^2 \subset L^1$, which is what makes every closed ideal the kernel of its hull. Theorem 4.55 shows that the same statement is false for $\mathbb{R}^n$, $n \ge 3$, so a candidate that drops compactness is not merely weaker but wrong.

Legend: ✅ ground truth satisfies the criterion · ⚠️ ground truth acceptable but improvable · ❗ trap — known/likely model error to check in candidate statements.

| # | Category | Criterion / potential error | Assessment of ground truth |
|---|----------|-----------------------------|----------------------------|
| 1 | Hypothesis completeness | `[CompactSpace G]` is essential — Folland 4.55 in this same dataset is the counterexample. | ✅ `[CompactSpace G]`. ❗ Highest-value trap. |
| 2 | Hypothesis completeness | `I` must be a **closed ideal**: a linear subspace, `𝓛¹`-closed, and stable under convolution by `𝓛¹` functions. | ✅ the `Submodule` structure, `hclosed`, `hideal`. ❗ Predicted error: omitting `hideal` and stating it for closed subspaces (false). |
| 3 | Semantic closeness | The direction formalized is `ι(ν(I)) = I`, the hard inclusion being `ι(ν(I)) ⊆ I`. | ✅ `kernel μ (hull μ I) = I`. |
| 4 | Faithful encoding | `hull` is taken of the *set of functions* `I`, and `kernel` of the resulting set of characters. | ✅ `kernel μ (hull μ I)`. Because mathlib has no ready-made `𝓛¹(G)` Banach algebra for a general locally compact group, the statement works with sets of *functions* together with `Submodule ℂ (G → ℂ)` and `IsLpClosed 1 μ` in place of a closed subspace of the `Lp` quotient. This is faithful — the `Lp` quotient of an `𝓛¹`-closed subspace of functions is a closed subspace and conversely — but a candidate must supply both the linearity and the `𝓛¹`-closedness, since either alone is strictly weaker. |
| 5 | Junk values | Membership of `kernel` carries `Integrable f μ`, so the identity is between two genuine subsets of `𝓛¹`. | ✅ Safe; `hmem` records the matching condition on `I`. |
