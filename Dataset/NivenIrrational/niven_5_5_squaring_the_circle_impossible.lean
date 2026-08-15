module

public import Dataset.NivenIrrational.Defs
public import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic

/-!
# `niven_5_5_squaring_the_circle_impossible`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `niven_5_5_squaring_the_circle_impossible.md`.
Quality rubric: `niven_5_5_squaring_the_circle_impossible.criteria.md`.
-/

@[expose] public section

open Set

namespace Dataset
namespace NivenIrrational

/-- Niven §5.5: the circle cannot be squared — granted that `π` is transcendental, `√π` is not
a constructible length. -/
theorem niven_5_5_squaring_the_circle_impossible (hpi : Transcendental ℚ Real.pi) :
    ¬ IsConstructible (Real.sqrt Real.pi) := by
  sorry

end NivenIrrational
end Dataset
