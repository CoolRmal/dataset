module

public import Dataset.KrylovSobolev.Defs
public import Mathlib.Analysis.SpecialFunctions.Pow.NNReal
public import Mathlib.MeasureTheory.Function.LpSeminorm.Basic

/-!
# `krylov_sobolev_1_5_1_multiplicative_inequality`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `krylov_sobolev_1_5_1_multiplicative_inequality.md`.
Quality rubric: `krylov_sobolev_1_5_1_multiplicative_inequality.criteria.md`.
-/

@[expose] public section

open Filter Function MeasureTheory Set Topology
open scoped ContDiff ENNReal Topology

namespace Dataset
namespace KrylovSobolev

/-- Krylov 1.5.1, the multiplicative inequality
`‖u_x‖_{𝓛_p} ≤ N ‖u‖_{𝓛_p}^{1/2} ‖u_{xx}‖_{𝓛_p}^{1/2}` on `ℝ^d` and on the half space. -/
theorem krylov_sobolev_1_5_1_multiplicative_inequality {d : ℕ} [NeZero d] (p : ℝ)
    (hp : 1 ≤ p) (Ω : TopologicalSpace.Opens (EuclideanSpace ℝ (Fin d)))
    (hΩ : Ω = ⊤ ∨ Ω = upperHalfSpace d) :
    ∃ N : ℝ≥0∞, N ≠ (∞ : ℝ≥0∞) ∧
      ∀ (u : EuclideanSpace ℝ (Fin d) → ℝ) (D : (Fin d → ℕ) → EuclideanSpace ℝ (Fin d) → ℝ),
        MemSobolevOn (ENNReal.ofReal p) 2 Ω u → IsSobolevFamilyOn 2 Ω u D →
        eLpNorm (gradNorm D) (ENNReal.ofReal p) (volume.restrict Ω) ≤
          N * eLpNorm u (ENNReal.ofReal p) (volume.restrict Ω) ^ (2⁻¹ : ℝ) *
            eLpNorm (hessNorm D) (ENNReal.ofReal p) (volume.restrict Ω) ^ (2⁻¹ : ℝ) := by
  sorry

end KrylovSobolev
end Dataset
