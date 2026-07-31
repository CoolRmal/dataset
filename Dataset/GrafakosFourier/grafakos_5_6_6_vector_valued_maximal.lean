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
theorem grafakos_5_6_6_vector_valued_maximal
    {n : ℕ} {p r : ℝ} (hp : 1 < p) (hr : 1 < r) :
    let ellNorm := fun (f : ℕ → EuclideanSpace ℝ (Fin n) → ℂ) x ↦
      ENNReal.rpow (∑' j, ENNReal.rpow ‖f j x‖ₑ r) (1 / r)
    let maximalNorm := fun (f : ℕ → EuclideanSpace ℝ (Fin n) → ℂ) x ↦
      ENNReal.rpow (∑' j, ENNReal.rpow (hardyLittlewoodMaximal n (f j) x) r) (1 / r)
    ∃ Cn Cp : ℝ≥0∞, Cn < ∞ ∧ Cp < ∞ ∧
      (∀ f : ℕ → EuclideanSpace ℝ (Fin n) → ℂ, ∀ α : ℝ, 0 < α →
        volume {x | ENNReal.ofReal α < maximalNorm f x} ≤
          Cn * ENNReal.ofReal (1 + 1 / (r - 1)) / ENNReal.ofReal α *
            ENNReal.rpow (∫⁻ x, ellNorm f x) 1) ∧
      ∀ f : ℕ → EuclideanSpace ℝ (Fin n) → ℂ,
        ENNReal.rpow (∫⁻ x, ENNReal.rpow (maximalNorm f x) p) (1 / p) ≤
          Cp * ENNReal.rpow (∫⁻ x, ENNReal.rpow (ellNorm f x) p) (1 / p) := by
  sorry

end GrafakosFourier
end Dataset
