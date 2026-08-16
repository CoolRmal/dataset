import Mathlib.MeasureTheory.Group.ModularCharacter

/-!
# `folland_2_31_modular_inversion_formula`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `folland_2_31_modular_inversion_formula.md`.
Quality rubric: `folland_2_31_modular_inversion_formula.criteria.md`.
-/

open MeasureTheory
open scoped NNReal

namespace Dataset
namespace FollandHarmonic

/-- Folland 2.31: the inversion formula relating a left Haar measure to itself through the
modular function, `∫ f (x⁻¹) Δ(x⁻¹) dx = ∫ f dx`. -/
theorem folland_2_31_modular_inversion_formula {G : Type*} [Group G]
    [TopologicalSpace G] [IsTopologicalGroup G]
    [LocallyCompactSpace G] [MeasurableSpace G] [BorelSpace G]
    (μ : Measure G) [μ.IsHaarMeasure]
    (f : G → ℂ) (hf : Integrable f μ) :
    ∫ x, f x⁻¹ * ((Measure.modularCharacterFun x : ℝ≥0) : ℝ) ∂μ = ∫ x, f x ∂μ := by
  sorry

end FollandHarmonic
end Dataset
