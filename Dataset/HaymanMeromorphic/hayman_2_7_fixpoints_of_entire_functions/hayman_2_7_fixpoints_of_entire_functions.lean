import Dataset.HaymanMeromorphic.Defs

/-!
# `hayman_2_7_fixpoints_of_entire_functions`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `hayman_2_7_fixpoints_of_entire_functions.md`.
Quality rubric: `hayman_2_7_fixpoints_of_entire_functions.criteria.md`.
-/

namespace Dataset
namespace HaymanMeromorphic

/-- Hayman 2.7 (I. N. Baker): a transcendental entire function has infinitely many fix-points
of exact order `n` for every `n`, with at most one exception. -/
theorem hayman_2_7_fixpoints_of_entire_functions (f : ℂ → ℂ)
    (hf : IsTranscendentalEntire f) (iter : ℕ → ℂ → ℂ)
    (h₁ : ∀ z, iter 1 z = f z) (hstep : ∀ n z, iter (n + 1) z = f (iter n z)) :
    {n : ℕ | 1 ≤ n ∧
      ¬ {z : ℂ | iter n z = z ∧ ∀ m, 1 ≤ m → m < n → iter m z ≠ z}.Infinite}.Subsingleton := by
  sorry

end HaymanMeromorphic
end Dataset
