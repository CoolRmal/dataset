import Dataset.EngelkingGeneralTopology.Defs

/-!
# `engelking_7_2_1_countable_sum_theorem` — 7.2.1

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `engelking_7_2_1_countable_sum_theorem.md`.
Quality rubric: `engelking_7_2_1_countable_sum_theorem.criteria.md`.
-/

open Set

namespace Dataset
namespace EngelkingGeneralTopology

universe u v w

/-- Engelking 7.2.1, the countable sum theorem for covering dimension. -/
theorem engelking_7_2_1_countable_sum_theorem
    {X : Type u} [TopologicalSpace X] [NormalSpace X] [T1Space X] {n : ℕ}
    (F : ℕ → Set X) (hclosed : ∀ j, IsClosed (F j)) (hunion : ⋃ j, F j = univ)
    (hdim :
      ∀ j, CoveringDimensionLE (F j) n) :
    CoveringDimensionLE X n := by
  sorry

end EngelkingGeneralTopology
end Dataset
