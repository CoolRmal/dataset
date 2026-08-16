import Mathlib.NumberTheory.Real.Irrational

/-!
# `niven_C_5_transcendentals_uncountable`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `niven_C_5_transcendentals_uncountable.md`.
Quality rubric: `niven_C_5_transcendentals_uncountable.criteria.md`.
-/

namespace Dataset
namespace NivenIrrational

/-- Niven, Theorem C.5: the set of real transcendental numbers is uncountable. -/
theorem niven_C_5_transcendentals_uncountable :
    ¬ {x : ℝ | Transcendental ℚ x}.Countable := by
  sorry

end NivenIrrational
end Dataset
