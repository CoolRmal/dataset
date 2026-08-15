module

public import Dataset.LeeSmoothManifolds.Defs
public import Mathlib.Geometry.Manifold.Algebra.LieGroup
public import Mathlib.Geometry.Manifold.ContMDiffMFDeriv
public import Mathlib.Geometry.Manifold.Immersion
public import Mathlib.Geometry.Manifold.SmoothApprox
public import Mathlib.Geometry.Manifold.Submersion
public import Mathlib.Geometry.Manifold.WhitneyEmbedding
public import Mathlib.MeasureTheory.Measure.Haar.NormedSpace

/-!
# `lee_8_10_regular_level_set_theorem`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `lee_8_10_regular_level_set_theorem.md`.
Quality rubric: `lee_8_10_regular_level_set_theorem.criteria.md`.
-/

@[expose] public section

open Function MeasureTheory Set Topology
open scoped ContDiff Manifold Topology

namespace Dataset
namespace LeeSmoothManifolds

universe u v

/-- Lee 8.10, the regular level-set theorem. -/
theorem lee_8_10_regular_level_set_theorem
    {m n : ℕ} {M : Type u} {N : Type v}
    [TopologicalSpace M] [ChartedSpace ((Fin m → ℝ)) M]
    [IsManifold 𝓘(ℝ, (Fin m → ℝ)) ∞ M]
    [TopologicalSpace N] [ChartedSpace ((Fin n → ℝ)) N]
    [IsManifold 𝓘(ℝ, (Fin n → ℝ)) ∞ N]
    {Φ : M → N} {c : N}
    (hΦ : ContMDiff 𝓘(ℝ, (Fin m → ℝ)) 𝓘(ℝ, (Fin n → ℝ)) ∞ Φ)
    (hc : RegularValue (m := m) (n := n) Φ c) :
    IsClosed {p | Φ p = c} ∧
      EmbeddedSubmanifoldOfCodimension (m := m) {p | Φ p = c} n := by
  sorry

end LeeSmoothManifolds
end Dataset
