import Dataset.KrylovSobolev.Defs
import Mathlib.MeasureTheory.Function.LpSpace.Basic
import Mathlib.MeasureTheory.Measure.Haar.InnerProductSpace

/-!
# `krylov_sobolev_1_1_13_const_coeff_operator_range_dense`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `krylov_sobolev_1_1_13_const_coeff_operator_range_dense.md`.
Quality rubric: `krylov_sobolev_1_1_13_const_coeff_operator_range_dense.criteria.md`.
-/

open Filter Function MeasureTheory Set Topology
open scoped ContDiff ENNReal Laplacian NNReal SchwartzMap Topology

namespace Dataset
namespace KrylovSobolev

/-- Krylov Exercise 1.1.13: for complex numbers `a^α`, not all zero, indexed by the
multi-indices with `|α| ≤ m` (`m ≥ 1`), the image `L C_0^∞` of the operator
`L = ∑_{|α| ≤ m} a^α D^α` is everywhere dense in `L_p(ℝ^d)` for every `p ∈ [2, ∞)`. -/
theorem krylov_sobolev_1_1_13_const_coeff_operator_range_dense {d m : ℕ} (hm : 1 ≤ m)
    (P : MvPolynomial (Fin d) ℂ) (hP : P ≠ 0) (hPm : P.totalDegree ≤ m) (p : ℝ≥0∞)
    [Fact (1 ≤ p)] (hp2 : 2 ≤ p) (hp : p ≠ ⊤) :
    Dense {g : Lp ℂ p (volume : Measure (EuclideanSpace ℝ (Fin d))) |
      ∃ φ : EuclideanSpace ℝ (Fin d) → ℂ, ContDiff ℝ (∞ : ℕ∞ω) φ ∧ HasCompactSupport φ ∧
        (fun x ↦ ∑ α ∈ P.support, P.coeff α * multiDeriv (⇑α) φ x) =ᵐ[volume] ⇑g} := by
  sorry

end KrylovSobolev
end Dataset
