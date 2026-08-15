import Dataset.KongODE.Defs
import Mathlib.Analysis.Calculus.ContDiff.Defs
import Mathlib.Analysis.ODE.PicardLindelof
import Mathlib.Analysis.Normed.Algebra.MatrixExponential
import Mathlib.LinearAlgebra.Matrix.NonsingularInverse
import Mathlib.LinearAlgebra.Matrix.Charpoly.Basic
import Mathlib.MeasureTheory.Integral.IntervalIntegral.Basic

/-!
# `kong_3_4_2_integrable_perturbation_stability`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `kong_3_4_2_integrable_perturbation_stability.md`.
Quality rubric: `kong_3_4_2_integrable_perturbation_stability.criteria.md`.
-/

open Filter Function MeasureTheory Set Topology
open scoped ENNReal Matrix NNReal Topology

namespace Dataset
namespace KongODE

/-- Kong 3.4.2, stability under an integrable small perturbation. -/
theorem kong_3_4_2_integrable_perturbation_stability
    {n : ℕ} {A : ℝ → Matrix (Fin n) (Fin n) ℝ}
    {r : ℝ → (Fin n → ℝ) → (Fin n → ℝ)} {p : ℝ → ℝ}
    (hr : IntegrableSmallPerturbation p r) :
    (UniformlyStableLinearEquation A →
      UniformlyStableZeroSolution (fun t x ↦ A t *ᵥ x + r t x)) ∧
    (UniformlyStableLinearEquation A → AsymptoticallyStableLinearEquation A →
      AsymptoticallyStableZeroSolution (fun t x ↦ A t *ᵥ x + r t x)) := by
  sorry

end KongODE
end Dataset
