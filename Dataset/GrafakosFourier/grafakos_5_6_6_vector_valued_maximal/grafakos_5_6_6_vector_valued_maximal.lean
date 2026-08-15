module

public import Dataset.GrafakosFourier.Defs
public import Mathlib.Analysis.Distribution.SchwartzSpace.Fourier
public import Mathlib.Analysis.Fourier.AddCircle
public import Mathlib.MeasureTheory.Function.LpSeminorm.Basic
public import Mathlib.MeasureTheory.Integral.Bochner.Basic

/-!
# `grafakos_5_6_6_vector_valued_maximal`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `grafakos_5_6_6_vector_valued_maximal.md`.
Quality rubric: `grafakos_5_6_6_vector_valued_maximal.criteria.md`.
-/

@[expose] public section

open Filter Function MeasureTheory Metric Set
open scoped ENNReal FourierTransform SchwartzMap Topology

namespace Dataset
namespace GrafakosFourier

universe u v

/-- Grafakos 5.6.6, the Fefferman-Stein vector-valued maximal inequalities. -/
theorem grafakos_5_6_6_vector_valued_maximal {n : ℕ} :
    let ellNorm := fun (r : ℝ) (f : ℕ → EuclideanSpace ℝ (Fin n) → ℂ) x ↦
      ENNReal.rpow (∑' j, ENNReal.rpow ‖f j x‖ₑ r) (1 / r)
    let maximalNorm := fun (r : ℝ) (f : ℕ → EuclideanSpace ℝ (Fin n) → ℂ) x ↦
      ENNReal.rpow (∑' j, ENNReal.rpow (hardyLittlewoodMaximal n (f j) x) r) (1 / r)
    ∃ Cn : ℝ≥0∞, Cn < ∞ ∧ ∀ p r : ℝ, 1 < p → 1 < r →
      (∀ f : ℕ → EuclideanSpace ℝ (Fin n) → ℂ, ∀ α : ℝ, 0 < α →
        volume {x | ENNReal.ofReal α < maximalNorm r f x} ≤
          Cn * ENNReal.ofReal (1 + 1 / (r - 1)) / ENNReal.ofReal α *
            ∫⁻ x, ellNorm r f x) ∧
      ∃ c : ℝ≥0∞, c < ∞ ∧ ∀ f : ℕ → EuclideanSpace ℝ (Fin n) → ℂ,
        ENNReal.rpow (∫⁻ x, ENNReal.rpow (maximalNorm r f x) p) (1 / p) ≤
          Cn * c * ENNReal.rpow (∫⁻ x, ENNReal.rpow (ellNorm r f x) p) (1 / p) := by
  sorry

end GrafakosFourier
end Dataset
