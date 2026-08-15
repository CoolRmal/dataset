import Dataset.GrafakosFourier.Defs
import Mathlib.Analysis.Distribution.SchwartzSpace.Fourier
import Mathlib.Analysis.Fourier.AddCircle
import Mathlib.MeasureTheory.Function.LpSeminorm.Basic
import Mathlib.MeasureTheory.Integral.Bochner.Basic

/-!
# `grafakos_1_3_2_marcinkiewicz_interpolation`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `grafakos_1_3_2_marcinkiewicz_interpolation.md`.
Quality rubric: `grafakos_1_3_2_marcinkiewicz_interpolation.criteria.md`.
-/

open Filter Function MeasureTheory Metric Set
open scoped ENNReal FourierTransform SchwartzMap Topology

namespace Dataset
namespace GrafakosFourier

universe u v

/-- Grafakos 1.3.2, the Marcinkiewicz interpolation theorem. -/
theorem grafakos_1_3_2_marcinkiewicz_interpolation
    {X : Type u} {Y : Type v} [MeasurableSpace X] [MeasurableSpace Y]
    (μ : Measure X) (ν : Measure Y) [SigmaFinite μ]
    (T : (X → ℂ) → Y → ℂ) {p₀ p₁ p : ℝ≥0∞} {A₀ A₁ : ℝ≥0∞}
    (hp₀ : 0 < p₀) (hp₀p : p₀ < p) (hpp₁ : p < p₁)
    (hA₀ : A₀ < ∞) (hA₁ : A₁ < ∞)
    (hT : IsSublinearOperator T) (h₀ : HasWeakType μ ν T p₀ A₀)
    (h₁ : HasWeakType μ ν T p₁ A₁)
    (hmeas : ∀ f, AEStronglyMeasurable f μ → AEStronglyMeasurable (T f) ν) :
    letI r₀ := p₀.toReal
    letI r := p.toReal
    letI r₁ := p₁.toReal
    (p₁ ≠ ∞ → HasStrongType μ ν T p p
      (2 * ENNReal.rpow (ENNReal.ofReal (r / (r - r₀) + r / (r₁ - r))) (1 / r) *
        ENNReal.rpow A₀ ((r₀ / r) * ((r₁ - r) / (r₁ - r₀))) *
          ENNReal.rpow A₁ ((r₁ / r) * ((r - r₀) / (r₁ - r₀))))) ∧
    (p₁ = ∞ → HasStrongType μ ν T p p
      (2 * ENNReal.rpow (ENNReal.ofReal (r / (r - r₀))) (1 / r) *
        ENNReal.rpow A₀ (r₀ / r) * ENNReal.rpow A₁ (1 - r₀ / r))) := by
  sorry

end GrafakosFourier
end Dataset
