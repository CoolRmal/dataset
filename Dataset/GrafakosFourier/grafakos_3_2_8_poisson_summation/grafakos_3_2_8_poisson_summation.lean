module

public import Mathlib.Analysis.Distribution.SchwartzSpace.Fourier
public import Mathlib.Analysis.Fourier.AddCircle
public import Mathlib.MeasureTheory.Function.LpSeminorm.Basic
public import Mathlib.MeasureTheory.Integral.Bochner.Basic

/-!
# `grafakos_3_2_8_poisson_summation`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `grafakos_3_2_8_poisson_summation.md`.
Quality rubric: `grafakos_3_2_8_poisson_summation.criteria.md`.
-/

@[expose] public section

open Filter Function MeasureTheory Metric Set
open scoped ENNReal FourierTransform SchwartzMap Topology

namespace Dataset
namespace GrafakosFourier

universe u v

/-- Grafakos 3.2.8, the Poisson summation formula. -/
theorem grafakos_3_2_8_poisson_summation
    {n : ℕ} {f : EuclideanSpace ℝ (Fin n) → ℂ}
    (hcont : Continuous f) (hint : Integrable f)
    (hdecay : ∃ C δ : ℝ, 0 < C ∧ 0 < δ ∧ ∀ x,
      ‖f x‖ ≤ C * (1 + ‖x‖) ^ (-(n : ℝ) - δ))
    (hsummable :
      Summable fun m : Fin n → ℤ ↦ 𝓕 f ((WithLp.toLp 2 fun i ↦ (m i : ℝ)))) :
    (∀ x : EuclideanSpace ℝ (Fin n),
      ∑' m : Fin n → ℤ, 𝓕 f ((WithLp.toLp 2 fun i ↦ (m i : ℝ))) *
          Complex.exp (2 * Real.pi * Complex.I * (∑ i, (m i : ℂ) * (x i : ℂ))) =
        ∑' k : Fin n → ℤ, f (x + (WithLp.toLp 2 fun i ↦ (k i : ℝ)))) ∧
      (∑' m : Fin n → ℤ, 𝓕 f ((WithLp.toLp 2 fun i ↦ (m i : ℝ)))) =
        ∑' k : Fin n → ℤ, f ((WithLp.toLp 2 fun i ↦ (k i : ℝ))) := by
  sorry

end GrafakosFourier
end Dataset
