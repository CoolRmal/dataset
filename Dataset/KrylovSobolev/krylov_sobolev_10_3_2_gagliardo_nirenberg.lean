module

public import Dataset.KrylovSobolev.Defs
public import Mathlib.Analysis.SpecialFunctions.Pow.NNReal
public import Mathlib.MeasureTheory.Function.LpSeminorm.Basic

/-!
# `krylov_sobolev_10_3_2_gagliardo_nirenberg`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `krylov_sobolev_10_3_2_gagliardo_nirenberg.md`.
Quality rubric: `krylov_sobolev_10_3_2_gagliardo_nirenberg.criteria.md`.
-/

@[expose] public section

open Filter Function MeasureTheory Set Topology
open scoped ContDiff ENNReal Topology

namespace Dataset
namespace KrylovSobolev

/-- Krylov 10.3.2, the Gagliardo–Nirenberg theorem: `W_1^1(Ω) ⊆ 𝓛_{d/(d-1)}(Ω)` with
`‖u‖_{𝓛_{d/(d-1)}} ≤ ∏_j ‖D_j u‖_{𝓛₁}^{1/d}`, for `Ω = ℝ^d` or `Ω = ℝ^d_+`. -/
theorem krylov_sobolev_10_3_2_gagliardo_nirenberg {d : ℕ} [NeZero d]
    (Ω : TopologicalSpace.Opens (EuclideanSpace ℝ (Fin d)))
    (hΩ : Ω = ⊤ ∨ Ω = upperHalfSpace d) (u : EuclideanSpace ℝ (Fin d) → ℝ)
    (D : (Fin d → ℕ) → EuclideanSpace ℝ (Fin d) → ℝ) (hu : MemSobolevOn 1 1 Ω u)
    (hD : IsSobolevFamilyOn 1 Ω u D) :
    MemLp u ((d : ℝ≥0∞) / ((d : ℝ≥0∞) - 1)) (volume.restrict Ω) ∧
      eLpNorm u ((d : ℝ≥0∞) / ((d : ℝ≥0∞) - 1)) (volume.restrict Ω) ≤
        ∏ j, eLpNorm (D (Pi.single j 1)) 1 (volume.restrict Ω) ^ ((d : ℝ)⁻¹) := by
  sorry

end KrylovSobolev
end Dataset
