module

public import Dataset.NivenIrrational.Defs

/-!
# `niven_6_2_unique_nearest_integer`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `niven_6_2_unique_nearest_integer.md`.
Quality rubric: `niven_6_2_unique_nearest_integer.criteria.md`.
-/

@[expose] public section

open Set

namespace Dataset
namespace NivenIrrational

/-- Niven 6.2: to every irrational `α` there corresponds a unique integer `m` with
`-1/2 < α - m < 1/2`. -/
theorem niven_6_2_unique_nearest_integer (a : ℝ) (ha : Irrational a) :
    ∃! m : ℤ, -(1 / 2 : ℝ) < a - m ∧ a - m < 1 / 2 := by
  sorry

end NivenIrrational
end Dataset
