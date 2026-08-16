import Dataset.KallenbergProbability.Defs

/-!
# `kallenberg_3_4_disintegration`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `kallenberg_3_4_disintegration.md`.
Quality rubric: `kallenberg_3_4_disintegration.criteria.md`.
-/

open MeasureTheory ProbabilityTheory
open scoped ENNReal

namespace Dataset
namespace KallenbergProbability

/-- Kallenberg 3.4, disintegration of a sigma-finite measure. -/
theorem kallenberg_3_4_disintegration
    {S T : Type*} [MeasurableSpace S] [MeasurableSpace T] [StandardBorelSpace T]
    (ρ : Measure (S × T)) [SigmaFinite ρ] :
    (∃ (ν : Measure S) (κ : Kernel S T), SigmaFinite ν ∧ IsSFiniteKernel κ ∧
      IsSigmaFiniteKernel κ ∧ ν ≪ ρ.fst ∧ ρ.fst ≪ ν ∧ ν ⊗ₘ κ = ρ) ∧
    (∀ (ν ν' : Measure S) (κ κ' : Kernel S T),
      SigmaFinite ν → IsSFiniteKernel κ → IsSigmaFiniteKernel κ →
      ν ≪ ρ.fst → ρ.fst ≪ ν → ν ⊗ₘ κ = ρ →
      SigmaFinite ν' → IsSFiniteKernel κ' → IsSigmaFiniteKernel κ' →
      ν' ≪ ρ.fst → ρ.fst ≪ ν' → ν' ⊗ₘ κ' = ρ →
      ∃ c : S → ℝ≥0∞, Measurable c ∧ ν' = ν.withDensity c ∧
        ∀ᵐ s ∂ν, κ s = c s • κ' s) ∧
    ((∃ (ν : Measure S) (κ : Kernel S T), SigmaFinite ν ∧ IsSFiniteKernel κ ∧
      IsSigmaFiniteKernel κ ∧ ν ≪ ρ.fst ∧ ρ.fst ≪ ν ∧ ν ⊗ₘ κ = ρ ∧
      IsAEBoundedKernel ν κ) ↔ SigmaFinite ρ.fst) ∧
    (SigmaFinite ρ.fst → ∃ κ : Kernel S T, IsMarkovKernel κ ∧ ρ.fst ⊗ₘ κ = ρ) := by
  sorry

end KallenbergProbability
end Dataset
