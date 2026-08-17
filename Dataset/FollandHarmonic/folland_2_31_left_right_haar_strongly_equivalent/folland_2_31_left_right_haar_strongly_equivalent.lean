import Dataset.FollandHarmonic.Defs
import Mathlib.MeasureTheory.Group.ModularCharacter

/-!
# `folland_2_31_left_right_haar_strongly_equivalent`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `folland_2_31_left_right_haar_strongly_equivalent.md`.
Quality rubric: `folland_2_31_left_right_haar_strongly_equivalent.criteria.md`.
-/

open MeasureTheory
open scoped ENNReal NNReal

namespace Dataset
namespace FollandHarmonic

/-- Folland 2.31: a left Haar measure `λ` and its associated right Haar measure
`ρ E = λ E⁻¹` are strongly equivalent, with `dρ(x) = Δ(x⁻¹) dλ(x)`. -/
theorem folland_2_31_left_right_haar_strongly_equivalent {G : Type*} [Group G]
    [TopologicalSpace G] [IsTopologicalGroup G]
    [LocallyCompactSpace G] [MeasurableSpace G] [BorelSpace G]
    (lam : Measure G) [lam.IsHaarMeasure] :
    StronglyEquivalent lam (lam.map (·⁻¹)) ∧
      ∀ E : Set G, MeasurableSet E →
        (lam.map (·⁻¹)) E =
          ∫⁻ x in E, ((Measure.modularCharacterFun x : ℝ≥0) : ℝ≥0∞) ∂lam := by
  sorry

end FollandHarmonic
end Dataset
