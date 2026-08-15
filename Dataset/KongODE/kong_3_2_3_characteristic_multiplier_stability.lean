module

public import Dataset.KongODE.Defs
public import Mathlib.Analysis.Calculus.ContDiff.Defs
public import Mathlib.Analysis.ODE.PicardLindelof
public import Mathlib.Analysis.Normed.Algebra.MatrixExponential
public import Mathlib.LinearAlgebra.Matrix.NonsingularInverse
public import Mathlib.LinearAlgebra.Matrix.Charpoly.Basic
public import Mathlib.MeasureTheory.Integral.IntervalIntegral.Basic

/-!
# `kong_3_2_3_characteristic_multiplier_stability`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `kong_3_2_3_characteristic_multiplier_stability.md`.
Quality rubric: `kong_3_2_3_characteristic_multiplier_stability.criteria.md`.
-/

@[expose] public section

open Filter Function MeasureTheory Set Topology
open scoped ENNReal Matrix NNReal Topology

namespace Dataset
namespace KongODE

/-- Kong 3.2.3, stability in terms of characteristic multipliers. -/
theorem kong_3_2_3_characteristic_multiplier_stability
    {n : ℕ} {A : ℝ → Matrix (Fin n) (Fin n) ℝ} {μ : Fin n → ℂ}
    {V : Matrix (Fin n) (Fin n) ℂ} {ω : ℝ}
    (hω : 0 < ω) (hA : Continuous A) (hperiodic : PeriodicLinearEquation ω A)
    (hV : IsPeriodTransitionMatrix ω A V) (hμ : CharacteristicMultipliers V μ) :
    (UniformlyStableLinearEquation A ↔
      ∀ i, ‖μ i‖ ≤ 1 ∧ (‖μ i‖ = 1 → InDiagonalJordanBlock V (μ i))) ∧
    (AsymptoticallyStableLinearEquation A ↔ ∀ i, ‖μ i‖ < 1) ∧
    (UnstableLinearEquation A ↔
      ∃ i, 1 < ‖μ i‖ ∨ (‖μ i‖ = 1 ∧ ¬InDiagonalJordanBlock V (μ i))) := by
  sorry

end KongODE
end Dataset
