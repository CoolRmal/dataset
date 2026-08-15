import Dataset.KrylovHolder.Defs
import Mathlib.Analysis.Calculus.ContDiff.Basic
import Mathlib.Analysis.Calculus.IteratedDeriv.Defs
import Mathlib.MeasureTheory.Integral.Bochner.Basic
import Mathlib.MeasureTheory.Measure.Haar.NormedSpace
import Mathlib.MeasureTheory.Measure.Hausdorff

/-!
# `krylov_4_5_1_variable_coefficient_global_solvability`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `krylov_4_5_1_variable_coefficient_global_solvability.md`.
Quality rubric: `krylov_4_5_1_variable_coefficient_global_solvability.criteria.md`.
-/

open Filter Function MeasureTheory Set Topology
open scoped ENNReal Topology

namespace Dataset
namespace KrylovHolder

/-- Krylov 4.5.1, global solvability for variable coefficients. -/
theorem krylov_4_5_1_variable_coefficient_global_solvability
    {d m k : ℕ} {δ : ℝ}
    {L : (EuclideanSpace ℝ (Fin d) → ℝ) → EuclideanSpace ℝ (Fin d) → ℝ}
    (hm : 0 < m) (hδ : 0 < δ ∧ δ < 1)
    (hL : VariableCoefficientEllipticOperator m L)
    (hcoeff : OperatorCoefficientsHolder m (k + δ) L) :
    ∃ lam₀ : ℝ, 0 < lam₀ ∧ ∀ lam : ℝ, lam₀ ≤ lam →
      ∀ f, HolderOn (k + δ) univ f →
        ∃! u, HolderOn (k + m + δ) univ u ∧ ShiftedEllipticEquation L lam u f := by
  sorry

end KrylovHolder
end Dataset
