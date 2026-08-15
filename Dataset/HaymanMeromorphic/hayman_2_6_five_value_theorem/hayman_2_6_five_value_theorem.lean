import Dataset.HaymanMeromorphic.Defs

/-!
# `hayman_2_6_five_value_theorem`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `hayman_2_6_five_value_theorem.md`.
Quality rubric: `hayman_2_6_five_value_theorem.criteria.md`.
-/

open Filter MeasureTheory Set ValueDistribution
open scoped Topology

namespace Dataset
namespace HaymanMeromorphic

/-- Hayman 2.6, Nevanlinna's five-value theorem: two meromorphic functions that share five
distinct values, ignoring multiplicity, are equal or both constant. -/
theorem hayman_2_6_five_value_theorem (f₁ f₂ : ℂ → ℂ)
    (h₁ : Meromorphic f₁) (h₂ : Meromorphic f₂)
    (a : Fin 5 → ℂ) (ha : Function.Injective a)
    (hE : ∀ ν, {z : ℂ | f₁ z = a ν} = {z : ℂ | f₂ z = a ν}) :
    f₁ = f₂ ∨ ((∃ c₁ : ℂ, ∀ z, f₁ z = c₁) ∧ ∃ c₂ : ℂ, ∀ z, f₂ z = c₂) := by
  sorry

end HaymanMeromorphic
end Dataset
