import Mathlib.Geometry.Manifold.SmoothApprox

/-!
# `lee_10_16_whitney_approximation_theorem`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `lee_10_16_whitney_approximation_theorem.md`.
Quality rubric: `lee_10_16_whitney_approximation_theorem.criteria.md`.
-/

open Set
open scoped ContDiff Manifold Topology

namespace Dataset
namespace LeeSmoothManifolds

universe u v

/-- Lee 10.16, the relative Whitney approximation theorem. -/
theorem lee_10_16_whitney_approximation_theorem
    {m k : ℕ} {M : Type u} [TopologicalSpace M] [ChartedSpace ((Fin m → ℝ)) M]
    [IsManifold 𝓘(ℝ, (Fin m → ℝ)) ∞ M] [T2Space M] [SecondCountableTopology M]
    {F : M → (Fin k → ℝ)} {δ : M → ℝ} {A : Set M}
    (hF : Continuous F) (hδ : Continuous δ) (hδpos : ∀ x, 0 < δ x)
    (hA : IsClosed A)
    (hFsmoothOnA : ∀ p ∈ A, ∃ U ∈ 𝓝 p, ∃ G : M → (Fin k → ℝ),
      ContMDiff 𝓘(ℝ, (Fin m → ℝ)) 𝓘(ℝ, (Fin k → ℝ)) ∞ G ∧ EqOn G F (U ∩ A)) :
    ∃ Fsmooth : M → (Fin k → ℝ),
      ContMDiff 𝓘(ℝ, (Fin m → ℝ)) 𝓘(ℝ, (Fin k → ℝ)) ∞ Fsmooth ∧
        (∀ x, dist (Fsmooth x) (F x) < δ x) ∧ EqOn Fsmooth F A := by
  sorry

end LeeSmoothManifolds
end Dataset
