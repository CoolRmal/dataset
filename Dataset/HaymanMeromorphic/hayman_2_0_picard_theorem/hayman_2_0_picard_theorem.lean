import Dataset.HaymanMeromorphic.Defs

/-!
# `hayman_2_0_picard_theorem`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `hayman_2_0_picard_theorem.md`.
Quality rubric: `hayman_2_0_picard_theorem.criteria.md`.
-/

namespace Dataset
namespace HaymanMeromorphic

/-- Hayman §2.0, Picard's theorem as a special case of the second fundamental theorem: a
transcendental meromorphic function takes every value in the plane infinitely often, with at
most two exceptions. -/
theorem hayman_2_0_picard_theorem (f : ℂ → ℂ) (hf : Meromorphic f)
    (hnf : ∀ z, MeromorphicNFAt f z)
    (htr : ¬ ∃ p q : Polynomial ℂ, q ≠ 0 ∧ ∀ z, q.eval z ≠ 0 → f z = p.eval z / q.eval z) :
    ∃ a b : ℂ, {c : ℂ | ¬ {z : ℂ | f z = c}.Infinite} ⊆ {a, b} := by
  sorry

end HaymanMeromorphic
end Dataset
