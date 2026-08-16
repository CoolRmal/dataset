import Dataset.GrafakosFourier.Defs

/-!
# `grafakos_2_1_6_hardy_littlewood_maximal`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `grafakos_2_1_6_hardy_littlewood_maximal.md`.
Quality rubric: `grafakos_2_1_6_hardy_littlewood_maximal.criteria.md`.
-/

open MeasureTheory
open scoped ENNReal

namespace Dataset
namespace GrafakosFourier

universe u v

/-- Grafakos 2.1.6, the Hardy-Littlewood maximal estimates. -/
theorem grafakos_2_1_6_hardy_littlewood_maximal {n : ℕ} :
    let operators := ({hardyLittlewoodMaximal n,
      hardyLittlewoodCenteredMaximal n} : Set ((EuclideanSpace ℝ (Fin n) → ℂ) →
        EuclideanSpace ℝ (Fin n) → ℝ≥0∞))
    (∀ M ∈ operators, ∀ f : EuclideanSpace ℝ (Fin n) → ℂ, MemLp f 1 volume →
      ∀ α : ℝ, 0 < α → volume {x | ENNReal.ofReal α < M f x} ≤
        ENNReal.ofReal (3 ^ n / α) *
          ∫⁻ x in {x | ENNReal.ofReal α < M f x}, ‖f x‖ₑ) ∧
    (∀ M ∈ operators, ∀ f : EuclideanSpace ℝ (Fin n) → ℂ, MemLp f 1 volume →
      ∀ α : ℝ, 0 < α → ENNReal.ofReal α * volume {x | ENNReal.ofReal α < M f x} ≤
        ENNReal.ofReal (3 ^ n) * eLpNorm f 1 volume) ∧
    ∀ M ∈ operators, ∀ p : ℝ, 1 < p → ∀ f : EuclideanSpace ℝ (Fin n) → ℂ,
      MemLp f (ENNReal.ofReal p) volume →
        ENNReal.rpow (∫⁻ x, ENNReal.rpow (M f x) p) (1 / p) ≤
          ENNReal.ofReal (3 ^ ((n : ℝ) / p) * p / (p - 1)) *
            eLpNorm f (ENNReal.ofReal p) volume := by
  sorry

end GrafakosFourier
end Dataset
