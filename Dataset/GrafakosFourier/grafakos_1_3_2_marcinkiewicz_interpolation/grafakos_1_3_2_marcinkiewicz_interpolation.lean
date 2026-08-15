module

public import Dataset.GrafakosFourier.Defs
public import Mathlib.Analysis.Distribution.SchwartzSpace.Fourier
public import Mathlib.Analysis.Fourier.AddCircle
public import Mathlib.MeasureTheory.Function.LpSeminorm.Basic
public import Mathlib.MeasureTheory.Integral.Bochner.Basic

/-!
# `grafakos_1_3_2_marcinkiewicz_interpolation`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `grafakos_1_3_2_marcinkiewicz_interpolation.md`.
Quality rubric: `grafakos_1_3_2_marcinkiewicz_interpolation.criteria.md`.
-/

@[expose] public section

open Filter Function MeasureTheory Metric Set
open scoped ENNReal FourierTransform SchwartzMap Topology

namespace Dataset
namespace GrafakosFourier

universe u v

/-- Grafakos 1.3.2, the Marcinkiewicz interpolation theorem. -/
theorem grafakos_1_3_2_marcinkiewicz_interpolation
    {X : Type u} {Y : Type v} [MeasurableSpace X] [MeasurableSpace Y]
    (μ : Measure X) (ν : Measure Y) [SigmaFinite μ]
    (T : (X → ℂ) → Y → ℂ) {p₀ p₁ p : ℝ} {A₀ A₁ : ℝ≥0∞}
    (hp : 0 < p₀ ∧ p₀ < p ∧ p < p₁)
    (hA₀ : A₀ < ∞) (hA₁ : A₁ < ∞)
    (hT : IsSublinearOperator T) (h₀ : HasWeakType μ ν T p₀ A₀)
    (h₁ : HasWeakType μ ν T p₁ A₁)
    (hmeas : ∀ f, AEStronglyMeasurable f μ → AEStronglyMeasurable (T f) ν) :
    HasStrongType μ ν T (ENNReal.ofReal p) (ENNReal.ofReal p)
      (2 * ENNReal.rpow
        (ENNReal.ofReal (p / (p - p₀) + p / (p₁ - p))) (1 / p) *
          ENNReal.rpow A₀ ((p₀ / p) * ((p₁ - p) / (p₁ - p₀))) *
            ENNReal.rpow A₁ ((p₁ / p) * ((p - p₀) / (p₁ - p₀)))) := by
  sorry

end GrafakosFourier
end Dataset
