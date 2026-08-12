module

public import Dataset.NivenZuckermanNumberTheory.Defs

/-!
# `niven_zuckerman_10_15_mod_five_coefficients`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `niven_zuckerman_10_15_mod_five_coefficients.md`.
Quality rubric: `niven_zuckerman_10_15_mod_five_coefficients.criteria.md`.
-/

@[expose] public section

open Filter
open scoped Topology

namespace Dataset
namespace NivenZuckermanNumberTheory

/-- Niven–Zuckerman 10.15: writing `x φ(x)⁴ = ∑ bₘ xᵐ`, the coefficients `bₘ` are integers and
are divisible by `5` whenever `5 ∣ m`. -/
theorem niven_zuckerman_10_15_mod_five_coefficients
    (φ : ℝ → ℝ) (hφ : ∀ x : ℝ, 0 ≤ x → x < 1 →
      Tendsto (fun m ↦ ∏ n ∈ Finset.Icc 1 m, (1 - x ^ n)) atTop (𝓝 (φ x))) :
    ∃ b : ℕ → ℤ, (∀ m : ℕ, m % 5 = 0 → (5 : ℤ) ∣ b m) ∧
      ∀ x : ℝ, 0 ≤ x → x < 1 → x * φ x ^ 4 = ∑' m : ℕ, (b m : ℝ) * x ^ m := by
  sorry

end NivenZuckermanNumberTheory
end Dataset
