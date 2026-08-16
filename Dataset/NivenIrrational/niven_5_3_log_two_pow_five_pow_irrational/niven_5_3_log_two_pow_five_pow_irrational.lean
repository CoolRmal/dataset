import Dataset.NivenIrrational.Defs
import Mathlib.NumberTheory.Real.Irrational

/-!
# `niven_5_3_log_two_pow_five_pow_irrational`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `niven_5_3_log_two_pow_five_pow_irrational.md`.
Quality rubric: `niven_5_3_log_two_pow_five_pow_irrational.criteria.md`.
-/

namespace Dataset
namespace NivenIrrational

/-- Niven §5.3, Example 3: if `c` and `d` are distinct non-negative integers then
`log₁₀ (2^c · 5^d)` is irrational. -/
theorem niven_5_3_log_two_pow_five_pow_irrational (c d : ℕ) (hcd : c ≠ d) :
    Irrational (Real.logb 10 (2 ^ c * 5 ^ d)) := by
  sorry

end NivenIrrational
end Dataset
