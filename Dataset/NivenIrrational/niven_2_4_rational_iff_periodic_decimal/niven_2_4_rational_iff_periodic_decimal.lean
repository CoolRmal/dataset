import Dataset.NivenIrrational.Defs

/-!
# `niven_2_4_rational_iff_periodic_decimal`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `niven_2_4_rational_iff_periodic_decimal.md`.
Quality rubric: `niven_2_4_rational_iff_periodic_decimal.criteria.md`.
-/

open Set

namespace Dataset
namespace NivenIrrational

/-- Niven §2.4–2.5: a number in `[0,1)` is rational exactly when its decimal expansion is
terminating or eventually periodic (a terminating expansion being the periodic one with
repeating digit `0`). -/
theorem niven_2_4_rational_iff_periodic_decimal (x : ℝ) (hx : 0 ≤ x) :
    (∃ q : ℚ, x = q) ↔ EventuallyPeriodic (decimalDigit x) := by
  sorry

end NivenIrrational
end Dataset
