module

public import Dataset.GrafakosFourier.Defs
public import Mathlib.Analysis.Distribution.SchwartzSpace.Fourier
public import Mathlib.Analysis.Fourier.AddCircle
public import Mathlib.MeasureTheory.Function.LpSeminorm.Basic
public import Mathlib.MeasureTheory.Integral.Bochner.Basic

/-!
# `grafakos_1_3_4_riesz_thorin_interpolation`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `grafakos_1_3_4_riesz_thorin_interpolation.md`.
Quality rubric: `grafakos_1_3_4_riesz_thorin_interpolation.criteria.md`.
-/

@[expose] public section

open Filter Function MeasureTheory Metric Set
open scoped ENNReal FourierTransform SchwartzMap Topology

namespace Dataset
namespace GrafakosFourier

universe u v

/-- Grafakos 1.3.4, the Riesz-Thorin interpolation theorem. -/
theorem grafakos_1_3_4_riesz_thorin_interpolation
    {X : Type u} {Y : Type v} [MeasurableSpace X] [MeasurableSpace Y]
    (μ : Measure X) (ν : Measure Y) (T : (X → ℂ) →ₗ[ℂ] (Y → ℂ))
    {p₀ p₁ q₀ q₁ p q : ℝ≥0∞} {θ : ℝ} {M₀ M₁ : ℝ≥0∞}
    (hθ : 0 < θ ∧ θ < 1)
    (hexponents : 1 ≤ p₀ ∧ 1 ≤ p₁ ∧ 1 ≤ q₀ ∧ 1 ≤ q₁)
    (hM₀ : M₀ < ∞) (hM₁ : M₁ < ∞)
    (hp : p⁻¹ = ENNReal.ofReal (1 - θ) * p₀⁻¹ + ENNReal.ofReal θ * p₁⁻¹)
    (hq : q⁻¹ = ENNReal.ofReal (1 - θ) * q₀⁻¹ + ENNReal.ofReal θ * q₁⁻¹)
    (h₀ : HasStrongType μ ν T p₀ q₀ M₀)
    (h₁ : HasStrongType μ ν T p₁ q₁ M₁) :
    HasStrongType μ ν T p q
      (ENNReal.rpow M₀ (1 - θ) * ENNReal.rpow M₁ θ) := by
  sorry

end GrafakosFourier
end Dataset
