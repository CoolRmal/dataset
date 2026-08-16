import Dataset.FollandHarmonic.Defs

/-!
# `folland_1_18_wiener_inverse_of_absolutely_convergent_series`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `folland_1_18_wiener_inverse_of_absolutely_convergent_series.md`.
Quality rubric: `folland_1_18_wiener_inverse_of_absolutely_convergent_series.criteria.md`.
-/

namespace Dataset
namespace FollandHarmonic

/-- Folland 1.18, Wiener's theorem: if an absolutely convergent Fourier series never vanishes,
its reciprocal again has an absolutely convergent Fourier series. -/
theorem folland_1_18_wiener_inverse_of_absolutely_convergent_series (a : ℤ → ℂ)
    (ha : Summable fun n ↦ ‖a n‖)
    (hne : ∀ θ : ℝ, (∑' n : ℤ, a n * Complex.exp (n * θ * Complex.I)) ≠ 0) :
    ∃ b : ℤ → ℂ, (Summable fun n ↦ ‖b n‖) ∧ ∀ θ : ℝ,
      (∑' n : ℤ, b n * Complex.exp (n * θ * Complex.I)) *
        (∑' n : ℤ, a n * Complex.exp (n * θ * Complex.I)) = 1 := by
  sorry

end FollandHarmonic
end Dataset
