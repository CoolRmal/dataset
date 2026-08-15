module

public import Mathlib.Geometry.Manifold.Algebra.LieGroup
public import Mathlib.Geometry.Manifold.ContMDiffMFDeriv
public import Mathlib.Geometry.Manifold.Immersion
public import Mathlib.Geometry.Manifold.SmoothApprox
public import Mathlib.Geometry.Manifold.Submersion
public import Mathlib.Geometry.Manifold.WhitneyEmbedding
public import Mathlib.MeasureTheory.Measure.Haar.NormedSpace

/-!
# `lee_10_7_sards_theorem`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `lee_10_7_sards_theorem.md`.
Quality rubric: `lee_10_7_sards_theorem.criteria.md`.
-/

@[expose] public section

open Function MeasureTheory Set Topology
open scoped ContDiff Manifold Topology

namespace Dataset
namespace LeeSmoothManifolds

universe u v

/-- Lee 10.7, Sard's theorem. -/
theorem lee_10_7_sards_theorem
    {m n : ℕ} {M : Type u} {N : Type v}
    [TopologicalSpace M] [ChartedSpace ((Fin m → ℝ)) M]
    [IsManifold 𝓘(ℝ, (Fin m → ℝ)) ∞ M] [SecondCountableTopology M]
    [TopologicalSpace N] [ChartedSpace ((Fin n → ℝ)) N]
    [IsManifold 𝓘(ℝ, (Fin n → ℝ)) ∞ N] [SecondCountableTopology N]
    {F : M → N} (hF : ContMDiff 𝓘(ℝ, (Fin m → ℝ)) 𝓘(ℝ, (Fin n → ℝ)) ∞ F) :
    let critical := {p : M |
      ¬Manifold.IsSubmersionAt 𝓘(ℝ, (Fin m → ℝ)) 𝓘(ℝ, (Fin n → ℝ)) ∞ F p}
    ∀ ψ : OpenPartialHomeomorph N (Fin n → ℝ),
      ψ ∈ IsManifold.maximalAtlas 𝓘(ℝ, (Fin n → ℝ)) ∞ N →
        volume (ψ '' (F '' critical ∩ ψ.source)) = 0 := by
  sorry

end LeeSmoothManifolds
end Dataset
