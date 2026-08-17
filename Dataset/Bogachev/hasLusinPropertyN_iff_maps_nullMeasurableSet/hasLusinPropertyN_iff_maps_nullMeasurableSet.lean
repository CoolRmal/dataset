import Dataset.Bogachev.Defs

/-!
# `hasLusinPropertyN_iff_maps_nullMeasurableSet` — 3.6.9

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `hasLusinPropertyN_iff_maps_nullMeasurableSet.md`.
Quality rubric: `hasLusinPropertyN_iff_maps_nullMeasurableSet.criteria.md`.
-/

open MeasureTheory

namespace Dataset
namespace Bogachev

/-- **Theorem 3.6.9.**
Let `F : ℝⁿ → ℝⁿ` be Lebesgue measurable. Then
`HasLusinPropertyN F volume volume` (the project definition) holds if and only if `F`
sends every Lebesgue measurable set to a Lebesgue measurable set.
-/
theorem hasLusinPropertyN_iff_maps_nullMeasurableSet
    {n : ℕ} {F : (Fin n → ℝ) → (Fin n) → ℝ} (hF : NullMeasurable F volume) :
    HasLusinPropertyN F volume volume ↔
      ∀ A : Set (Fin n → ℝ),
        NullMeasurableSet A volume → NullMeasurableSet (F '' A) volume := by
  sorry

end Bogachev
end Dataset
