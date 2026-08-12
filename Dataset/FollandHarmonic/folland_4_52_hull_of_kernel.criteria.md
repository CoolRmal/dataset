# Criteria: folland_4_52_hull_of_kernel

**Statement:** [folland_4_52_hull_of_kernel.md](folland_4_52_hull_of_kernel.md) · **Lean:** [folland_4_52_hull_of_kernel.lean](folland_4_52_hull_of_kernel.lean)

A one-line statement whose entire content is that $\nu$ recovers a **closed** set from its kernel. Closedness of $N$ is indispensable — $\nu(\iota(N))$ is always closed, so for non-closed $N$ the identity fails — and $\iota(N)$ must be the kernel inside $\mathcal{L}^1$, not inside $\mathcal{L}^2$ or the measure algebra.

Legend: ✅ ground truth satisfies the criterion · ⚠️ ground truth acceptable but improvable · ❗ trap — known/likely model error to check in candidate statements.

| # | Category | Criterion / potential error | Assessment of ground truth |
|---|----------|-----------------------------|----------------------------|
| 1 | Hypothesis completeness | `N` must be closed in `Ĝ`. Dropping it makes the statement false for any non-closed `N`. | ✅ `hN : IsClosed N`. ❗ Highest-value trap. |
| 2 | Faithful encoding | $\iota(N)$ consists of `𝓛¹` functions whose transform vanishes on `N`; $\nu(I)$ consists of characters killing every transform of a member of `I`. | ✅ `kernel μ N = {f \| MemLp f 1 μ ∧ ∀ ξ ∈ N, f̂ ξ = 0}` and `hull μ I = {ξ \| ∀ f ∈ I, f̂ ξ = 0}`. ❗ Predicted error: omitting `Integrable f μ` from `kernel`, which admits functions whose transform is a junk `0`. |
| 3 | Junk values | `fourierTransform μ f ξ` is a Bochner integral and is `0` for non-integrable `f`; the `Integrable f μ` clause inside `kernel` is what stops non-integrable functions from being vacuously admitted. | ✅ Present. |
| 4 | Mathlib conventions | Characters are `PontryaginDual G = ContinuousMonoidHom G Circle`; the transform pairs `f` against the conjugate of the character's complex value. | ✅ Uses mathlib's `PontryaginDual` and the `Circle → ℂ` coercion. |
| 5 | Semantic closeness | The result is an equality of subsets of `Ĝ`, in the direction `ν(ι(N)) = N`; the companion `ι(ν(I)) = I` is a different (and generally false) statement. | ✅ Exactly `hull μ (kernel μ N) = N`. ❗ Predicted error: stating the companion identity. |
