import Dataset.HaymanMeromorphic.Defs

/-!
# `hayman_2_4_deficiency_relation`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `hayman_2_4_deficiency_relation.md`.
Quality rubric: `hayman_2_4_deficiency_relation.criteria.md`.
-/

open Filter MeasureTheory Set ValueDistribution
open scoped Topology

namespace Dataset
namespace HaymanMeromorphic

/-- Hayman 2.4, Nevanlinna's theorem on deficient values: the values with `Θ(a) > 0` form a
countable set, and summing over them gives `∑ (δ(a) + θ(a)) ≤ ∑ Θ(a) ≤ 2`. -/
theorem hayman_2_4_deficiency_relation (f : ℂ → ℂ) (hf : Meromorphic f)
    (hadm : Tendsto (characteristic f ⊤) atTop atTop) :
    {a : ℂ | 0 < nevanlinnaTheta f a}.Countable ∧
      ∀ s : Finset ℂ, (∑ a ∈ s, (deficiency f (a : WithTop ℂ) + ramificationIndex f a)) ≤
          ∑ a ∈ s, nevanlinnaTheta f a ∧
        (∑ a ∈ s, nevanlinnaTheta f a) ≤ 2 := by
  sorry

end HaymanMeromorphic
end Dataset
