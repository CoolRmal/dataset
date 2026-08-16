import Dataset.NivenZuckermanNumberTheory.Defs

/-!
# `niven_zuckerman_11_2_divisor_bound`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `niven_zuckerman_11_2_divisor_bound.md`.
Quality rubric: `niven_zuckerman_11_2_divisor_bound.criteria.md`.
-/

namespace Dataset
namespace NivenZuckermanNumberTheory

/-- Niven–Zuckerman 11.2: the number of positive divisors of `n` is at most `2√n`. -/
theorem niven_zuckerman_11_2_divisor_bound (n : ℕ) (hn : 1 ≤ n) :
    (n.divisors.card : ℝ) ≤ 2 * Real.sqrt n := by
  sorry

end NivenZuckermanNumberTheory
end Dataset
