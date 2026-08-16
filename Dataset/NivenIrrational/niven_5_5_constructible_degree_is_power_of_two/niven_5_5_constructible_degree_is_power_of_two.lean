import Dataset.NivenIrrational.Defs

/-!
# `niven_5_5_constructible_degree_is_power_of_two`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `niven_5_5_constructible_degree_is_power_of_two.md`.
Quality rubric: `niven_5_5_constructible_degree_is_power_of_two.criteria.md`.
-/

namespace Dataset
namespace NivenIrrational

/-- Niven, the Theorem on Geometric Constructions: every length constructible by straightedge
and compass from a unit segment is an algebraic number whose degree over `ℚ` is a power of
`2`. -/
theorem niven_5_5_constructible_degree_is_power_of_two (x : ℝ) (hx : IsConstructible x) :
    IsAlgebraic ℚ x ∧ ∃ k : ℕ, Module.finrank ℚ (Algebra.adjoin ℚ ({x} : Set ℝ)) = 2 ^ k := by
  sorry

end NivenIrrational
end Dataset
