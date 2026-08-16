import Dataset.NivenZuckermanNumberTheory.Defs

/-!
# `niven_zuckerman_10_15_mod_five_coefficients`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `niven_zuckerman_10_15_mod_five_coefficients.md`.
Quality rubric: `niven_zuckerman_10_15_mod_five_coefficients.criteria.md`.
-/

open Filter
open scoped Topology

namespace Dataset
namespace NivenZuckermanNumberTheory

/-- Niven–Zuckerman 10.15: writing `x φ(x)⁴ = ∑ bₘ xᵐ`, the coefficients `bₘ` are integers and
are divisible by `5` whenever `5 ∣ m`. -/
theorem niven_zuckerman_10_15_mod_five_coefficients :
    ∃ b : ℕ → ℤ, (∀ m : ℕ, m % 5 = 0 → (5 : ℤ) ∣ b m) ∧
      ∀ x : ℝ, 0 ≤ x → x < 1 →
        x * eulerProduct x ^ 4 = ∑' m : ℕ, b m * x ^ m := by
  sorry

end NivenZuckermanNumberTheory
end Dataset
