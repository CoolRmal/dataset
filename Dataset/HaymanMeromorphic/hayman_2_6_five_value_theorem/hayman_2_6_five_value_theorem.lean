import Dataset.HaymanMeromorphic.Defs

/-!
# `hayman_2_6_five_value_theorem`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `hayman_2_6_five_value_theorem.md`.
Quality rubric: `hayman_2_6_five_value_theorem.criteria.md`.
-/

namespace Dataset
namespace HaymanMeromorphic

/-- Hayman 2.6, Nevanlinna's five-value theorem: two meromorphic functions that share five
distinct values, ignoring multiplicity, are equal or both constant. -/
theorem hayman_2_6_five_value_theorem (f₁ f₂ : ℂ → ℂ)
    (h₁ : Meromorphic f₁) (h₂ : Meromorphic f₂)
    (a : Fin 5 → ℂ) (ha : Function.Injective a)
    (hE : ∀ ν, {z : ℂ | 0 < meromorphicOrderAt (fun w ↦ f₁ w - a ν) z} =
      {z : ℂ | 0 < meromorphicOrderAt (fun w ↦ f₂ w - a ν) z}) :
    f₁ =ᶠ[Filter.codiscrete ℂ] f₂ ∨ ((∃ c₁ : ℂ, ∀ z, f₁ z = c₁) ∧ ∃ c₂ : ℂ, ∀ z, f₂ z = c₂) := by
  sorry

end HaymanMeromorphic
end Dataset
