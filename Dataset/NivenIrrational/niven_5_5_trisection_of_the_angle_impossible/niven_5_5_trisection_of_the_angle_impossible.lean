module

public import Dataset.NivenIrrational.Defs
public import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic

/-!
# `niven_5_5_trisection_of_the_angle_impossible`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `niven_5_5_trisection_of_the_angle_impossible.md`.
Quality rubric: `niven_5_5_trisection_of_the_angle_impossible.criteria.md`.
-/

@[expose] public section

open Set

namespace Dataset
namespace NivenIrrational

/-- Niven §5.5: the angle cannot be trisected — a `20°` angle is not constructible from a
`60°` angle, because `cos 20°` is not a constructible length. -/
theorem niven_5_5_trisection_of_the_angle_impossible :
    ¬ IsConstructible (Real.cos (Real.pi / 9)) := by
  sorry

end NivenIrrational
end Dataset
