import Dataset.LeeSmoothManifolds.Defs
import Mathlib.Geometry.Manifold.Algebra.LieGroup
import Mathlib.Geometry.Manifold.ContMDiffMFDeriv
import Mathlib.Geometry.Manifold.Immersion
import Mathlib.Geometry.Manifold.SmoothApprox
import Mathlib.Geometry.Manifold.Submersion
import Mathlib.Geometry.Manifold.WhitneyEmbedding
import Mathlib.MeasureTheory.Measure.Haar.NormedSpace

/-!
# `lee_7_8_rank_theorem`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `lee_7_8_rank_theorem.md`.
Quality rubric: `lee_7_8_rank_theorem.criteria.md`.
-/

open Function MeasureTheory Set Topology
open scoped ContDiff Manifold Topology

namespace Dataset
namespace LeeSmoothManifolds

universe u v

/-- Lee 7.8, the (Fin rank → ℝ) theorem. -/
theorem lee_7_8_rank_theorem
    {m n k : ℕ} {U : Set ((Fin m → ℝ))} {V : Set ((Fin n → ℝ))}
    {F : (Fin m → ℝ) → (Fin n → ℝ)} {p : (Fin m → ℝ)}
    (hU : IsOpen U) (hV : IsOpen V) (hF : MapsTo F U V ∧ ContDiffOn ℝ ∞ F U)
    (hp : p ∈ U)
    (hk : k ≤ m ∧ k ≤ n) (hrank : EuclideanConstantRank U F k) :
    ∃ U₀ V₀, (IsOpen U₀ ∧ IsConnected U₀ ∧ p ∈ U₀ ∧ U₀ ⊆ U) ∧
      (IsOpen V₀ ∧ IsConnected V₀ ∧ F p ∈ V₀ ∧ V₀ ⊆ V) ∧
      MapsTo F U₀ V₀ ∧
      ∃ (sourceTarget : Set (Fin m → ℝ)) (targetTarget : Set (Fin n → ℝ))
        (φ : SmoothDiffeomorphismOn U₀ sourceTarget)
        (ψ : SmoothDiffeomorphismOn V₀ targetTarget),
        φ.toFun p = 0 ∧ ψ.toFun (F p) = 0 ∧
        ∀ x ∈ φ.toFun '' U₀, ψ.toFun (F (φ.invFun x)) =
          fun i ↦ if h : i.1 < k ∧ i.1 < m then x ⟨i.1, h.2⟩ else 0 := by
  sorry

end LeeSmoothManifolds
end Dataset
