import Dataset.KongODE.Defs

/-!
# `kong_3_2_3_characteristic_multiplier_stability`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `kong_3_2_3_characteristic_multiplier_stability.md`.
Quality rubric: `kong_3_2_3_characteristic_multiplier_stability.criteria.md`.
-/

namespace Dataset
namespace KongODE

/-- Kong 3.2.3, stability in terms of characteristic multipliers. -/
theorem kong_3_2_3_characteristic_multiplier_stability
    {n : ℕ} {A : ℝ → Matrix (Fin n) (Fin n) ℝ} {μ : Fin n → ℂ}
    {V : Matrix (Fin n) (Fin n) ℂ} {ω : ℝ}
    (hω : 0 < ω) (hA : Continuous A) (hperiodic : Function.Periodic A ω)
    (hV : IsPeriodTransitionMatrix ω A V) (hμ : CharacteristicMultipliers V μ) :
    (UniformlyStableLinearEquation A ↔
      ∀ i, ‖μ i‖ ≤ 1 ∧ (‖μ i‖ = 1 → InDiagonalJordanBlock V (μ i))) ∧
    (AsymptoticallyStableLinearEquation A ↔ ∀ i, ‖μ i‖ < 1) ∧
    (UnstableLinearEquation A ↔
      ∃ i, 1 < ‖μ i‖ ∨ (‖μ i‖ = 1 ∧ ¬InDiagonalJordanBlock V (μ i))) := by
  sorry

end KongODE
end Dataset
