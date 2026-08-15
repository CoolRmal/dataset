import Dataset.HaymanMeromorphic.Defs

/-!
# `hayman_3_4_derivative_deficiency_bound`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `hayman_3_4_derivative_deficiency_bound.md`.
Quality rubric: `hayman_3_4_derivative_deficiency_bound.criteria.md`.
-/

open Filter MeasureTheory Set ValueDistribution
open scoped Topology

namespace Dataset
namespace HaymanMeromorphic

/-- Hayman 3.4: for a transcendental meromorphic `f` and `ψ = f^{(l)}`, the finite values carry
total `Θ` at most `1 + 1/(l+1)`; in particular `ψ` takes every finite value infinitely often
with at most one exception. -/
theorem hayman_3_4_derivative_deficiency_bound (f : ℂ → ℂ) (hf : Meromorphic f)
    (htr : ¬ ∃ p q : Polynomial ℂ, q ≠ 0 ∧ ∀ z, q.eval z ≠ 0 → f z = p.eval z / q.eval z)
    (l : ℕ) (hl : 1 ≤ l) (ψ : ℂ → ℂ) (hψ : ψ = iteratedDeriv l f) :
    (∀ s : Finset ℂ, (∑ a ∈ s, nevanlinnaTheta ψ a) ≤ 1 + 1 / (l + 1 : ℝ)) ∧
      {a : ℂ | ¬ {z : ℂ | ψ z = a}.Infinite}.Subsingleton := by
  sorry

end HaymanMeromorphic
end Dataset
