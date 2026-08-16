import Mathlib.NumberTheory.Real.Irrational

/-!
# `niven_3_5_sqrt_two_add_sqrt_three_irrational`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `niven_3_5_sqrt_two_add_sqrt_three_irrational.md`.
Quality rubric: `niven_3_5_sqrt_two_add_sqrt_three_irrational.criteria.md`.
-/

namespace Dataset
namespace NivenIrrational

/-- Niven §3.5: `√2 + √3` is irrational. -/
theorem niven_3_5_sqrt_two_add_sqrt_three_irrational :
    Irrational (Real.sqrt 2 + Real.sqrt 3) := by
  sorry

end NivenIrrational
end Dataset
