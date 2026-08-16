import Dataset.NivenIrrational.Defs

/-!
# `niven_5_5_duplication_of_the_cube_impossible`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `niven_5_5_duplication_of_the_cube_impossible.md`.
Quality rubric: `niven_5_5_duplication_of_the_cube_impossible.criteria.md`.
-/

namespace Dataset
namespace NivenIrrational

/-- Niven §5.5: the cube cannot be duplicated — `2^(1/3)` is not a constructible length. -/
theorem niven_5_5_duplication_of_the_cube_impossible :
    ¬ IsConstructible ((2 : ℝ) ^ ((1 : ℝ) / 3)) := by
  sorry

end NivenIrrational
end Dataset
