import Mathlib.Geometry.Manifold.SmoothEmbedding
import Mathlib.Topology.Maps.Proper.Basic

/-!
# `lee_10_11_whitney_embedding_theorem`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `lee_10_11_whitney_embedding_theorem.md`.
Quality rubric: `lee_10_11_whitney_embedding_theorem.criteria.md`.
-/

open Function Manifold Set Topology
open scoped ContDiff Manifold Topology

namespace Dataset
namespace LeeSmoothManifolds

universe u

/-- Lee 10.11, the Whitney embedding theorem: every smooth `m`-manifold admits a proper smooth
embedding into `ℝ^(2m+1)`. "Smooth embedding" is `IsSmoothEmbedding`, i.e. a `C^∞` immersion that
is also a topological embedding; it already entails smoothness of the map. -/
theorem lee_10_11_whitney_embedding_theorem
    {m : ℕ} {M : Type u} [TopologicalSpace M] [ChartedSpace (Fin m → ℝ) M]
    [IsManifold 𝓘(ℝ, (Fin m → ℝ)) ∞ M] [T2Space M] [SecondCountableTopology M] :
    ∃ F : M → (Fin (2 * m + 1) → ℝ),
      IsSmoothEmbedding 𝓘(ℝ, (Fin m → ℝ)) 𝓘(ℝ, (Fin (2 * m + 1) → ℝ)) ∞ F ∧ IsProperMap F := by
  sorry

end LeeSmoothManifolds
end Dataset
