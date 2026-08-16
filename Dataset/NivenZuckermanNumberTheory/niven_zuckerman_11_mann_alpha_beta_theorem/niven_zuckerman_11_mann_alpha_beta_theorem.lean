import Mathlib.Combinatorics.Schnirelmann

/-!
# `niven_zuckerman_11_mann_alpha_beta_theorem`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `niven_zuckerman_11_mann_alpha_beta_theorem.md`.
Quality rubric: `niven_zuckerman_11_mann_alpha_beta_theorem.criteria.md`.
-/

namespace Dataset
namespace NivenZuckermanNumberTheory

/-- Niven–Zuckerman §11.4, the `αβ` theorem of H. B. Mann: the Schnirelmann density of a sum
set is at least the minimum of `1` and the sum of the densities. -/
theorem niven_zuckerman_11_mann_alpha_beta_theorem
    (A B : Set ℕ) [DecidablePred (· ∈ A)] [DecidablePred (· ∈ B)]
    [DecidablePred (· ∈ {n : ℕ | ∃ a ∈ A, ∃ b ∈ B, n = a + b})]
    (hA : (0 : ℕ) ∈ A) (hB : (0 : ℕ) ∈ B) :
    min 1 (schnirelmannDensity A + schnirelmannDensity B) ≤
      schnirelmannDensity {n : ℕ | ∃ a ∈ A, ∃ b ∈ B, n = a + b} := by
  sorry

end NivenZuckermanNumberTheory
end Dataset
