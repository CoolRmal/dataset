module

public import Dataset.NivenZuckermanNumberTheory.Defs

/-!
# `niven_zuckerman_11_8_few_prime_factors_density_zero`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `niven_zuckerman_11_8_few_prime_factors_density_zero.md`.
Quality rubric: `niven_zuckerman_11_8_few_prime_factors_density_zero.criteria.md`.
-/

@[expose] public section

open Filter
open scoped Topology

namespace Dataset
namespace NivenZuckermanNumberTheory

/-- Niven–Zuckerman 11.8: a set of integers each of which is divisible by at most `k` distinct
primes has natural density zero. -/
theorem niven_zuckerman_11_8_few_prime_factors_density_zero (k : ℕ) (hk : 1 ≤ k)
    (A : Set ℕ) (hA : ∀ n ∈ A, n.primeFactors.card ≤ k) :
    HasNaturalDensity A 0 := by
  sorry

end NivenZuckermanNumberTheory
end Dataset
