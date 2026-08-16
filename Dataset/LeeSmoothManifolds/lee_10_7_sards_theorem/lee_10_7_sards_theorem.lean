import Mathlib.Geometry.Manifold.SmoothApprox
import Mathlib.Geometry.Manifold.Submersion
import Dataset.LeeSmoothManifolds.Defs

/-!
# `lee_10_7_sards_theorem`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `lee_10_7_sards_theorem.md`.
Quality rubric: `lee_10_7_sards_theorem.criteria.md`.
-/

open MeasureTheory
open scoped ContDiff Manifold

namespace Dataset
namespace LeeSmoothManifolds

universe u v

/-- Lee 10.7, Sard's theorem. -/
theorem lee_10_7_sards_theorem
    {m n : ℕ} {M : Type u} {N : Type v}
    [TopologicalSpace M] [ChartedSpace ((Fin m → ℝ)) M]
    [IsManifold 𝓘(ℝ, (Fin m → ℝ)) ∞ M] [T2Space M] [SecondCountableTopology M]
    [TopologicalSpace N] [ChartedSpace ((Fin n → ℝ)) N]
    [IsManifold 𝓘(ℝ, (Fin n → ℝ)) ∞ N] [T2Space N] [SecondCountableTopology N]
    {F : M → N} (hF : ContMDiff 𝓘(ℝ, (Fin m → ℝ)) 𝓘(ℝ, (Fin n → ℝ)) ∞ F) :
    ∀ ψ : OpenPartialHomeomorph N (Fin n → ℝ),
      ψ ∈ IsManifold.maximalAtlas 𝓘(ℝ, (Fin n → ℝ)) ∞ N →
        volume (ψ '' (F '' CriticalSet (m := m) (n := n) F ∩ ψ.source)) = 0 := by
  sorry

end LeeSmoothManifolds
end Dataset
