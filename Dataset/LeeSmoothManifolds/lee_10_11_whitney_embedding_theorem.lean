module

public import Mathlib.Geometry.Manifold.Algebra.LieGroup
public import Mathlib.Geometry.Manifold.ContMDiffMFDeriv
public import Mathlib.Geometry.Manifold.Immersion
public import Mathlib.Geometry.Manifold.SmoothApprox
public import Mathlib.Geometry.Manifold.Submersion
public import Mathlib.Geometry.Manifold.WhitneyEmbedding
public import Mathlib.MeasureTheory.Measure.Haar.NormedSpace

/-!
# `lee_10_11_whitney_embedding_theorem`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `lee_10_11_whitney_embedding_theorem.md`.
Quality rubric: `lee_10_11_whitney_embedding_theorem.criteria.md`.
-/

@[expose] public section

open Function MeasureTheory Set Topology
open scoped ContDiff Manifold Topology

namespace Dataset
namespace LeeSmoothManifolds

universe u v

/-- Lee 10.11, the weak Whitney embedding theorem. -/
theorem lee_10_11_whitney_embedding_theorem
    {m : ℕ} {M : Type u} [TopologicalSpace M] [ChartedSpace ((Fin m → ℝ)) M]
    [IsManifold 𝓘(ℝ, (Fin m → ℝ)) ∞ M] [T2Space M] [SigmaCompactSpace M] :
    ∃ F : M → (Fin (2 * m + 1) → ℝ),
      IsProperMap F ∧ IsEmbedding F ∧
        ContMDiff 𝓘(ℝ, (Fin m → ℝ)) 𝓘(ℝ, (Fin (2 * m + 1) → ℝ)) ∞ F := by
  sorry

end LeeSmoothManifolds
end Dataset
