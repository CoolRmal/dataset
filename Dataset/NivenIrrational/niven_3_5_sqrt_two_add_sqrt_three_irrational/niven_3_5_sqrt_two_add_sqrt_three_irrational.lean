module

public import Dataset.NivenIrrational.Defs

/-!
# `niven_3_5_sqrt_two_add_sqrt_three_irrational`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `niven_3_5_sqrt_two_add_sqrt_three_irrational.md`.
Quality rubric: `niven_3_5_sqrt_two_add_sqrt_three_irrational.criteria.md`.
-/

@[expose] public section

open Set

namespace Dataset
namespace NivenIrrational

/-- Niven §3.5: `√2 + √3` is irrational. -/
theorem niven_3_5_sqrt_two_add_sqrt_three_irrational :
    Irrational (Real.sqrt 2 + Real.sqrt 3) := by
  sorry

end NivenIrrational
end Dataset
