import Dataset.NivenZuckermanNumberTheory.Defs

/-!
# `niven_zuckerman_10_14_euler_product_prime_power`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `niven_zuckerman_10_14_euler_product_prime_power.md`.
Quality rubric: `niven_zuckerman_10_14_euler_product_prime_power.criteria.md`.
-/

namespace Dataset
namespace NivenZuckermanNumberTheory

/-- Niven–Zuckerman 10.14: for a prime `p` the ratio `φ(xᵖ)/φ(x)ᵖ` of Euler products is
`1 + p ∑ aᵢ xⁱ` with integer coefficients `aᵢ`. -/
theorem niven_zuckerman_10_14_euler_product_prime_power (p : ℕ) (hp : p.Prime) :
    ∃ a : ℕ → ℤ, ∀ x : ℝ, 0 ≤ x → x < 1 →
      eulerProduct (x ^ p) / eulerProduct x ^ p =
        1 + p * ∑' i : ℕ, a (i + 1) * x ^ (i + 1) := by
  sorry

end NivenZuckermanNumberTheory
end Dataset
