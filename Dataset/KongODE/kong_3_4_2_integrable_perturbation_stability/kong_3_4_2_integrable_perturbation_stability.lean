import Dataset.KongODE.Defs

/-!
# `kong_3_4_2_integrable_perturbation_stability`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `kong_3_4_2_integrable_perturbation_stability.md`.
Quality rubric: `kong_3_4_2_integrable_perturbation_stability.criteria.md`.
-/

open scoped Matrix

namespace Dataset
namespace KongODE

/-- Kong 3.4.2, stability under an integrable small perturbation. -/
theorem kong_3_4_2_integrable_perturbation_stability
    {n : ℕ} {A : ℝ → Matrix (Fin n) (Fin n) ℝ} (hA : Continuous A)
    {r : ℝ → (Fin n → ℝ) → (Fin n → ℝ)} {p : ℝ → ℝ}
    (hr : IntegrableSmallPerturbation p r) :
    (UniformlyStableLinearEquation A →
      UniformlyStableZeroSolution (fun t x ↦ A t *ᵥ x + r t x)) ∧
    (UniformlyStableLinearEquation A → AsymptoticallyStableLinearEquation A →
      AsymptoticallyStableZeroSolution (fun t x ↦ A t *ᵥ x + r t x)) := by
  sorry

end KongODE
end Dataset
