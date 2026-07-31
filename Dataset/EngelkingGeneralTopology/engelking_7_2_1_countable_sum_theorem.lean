module

public import Dataset.EngelkingGeneralTopology.Defs
public import Mathlib.Topology.Compactness.Compact
public import Mathlib.Topology.Compactness.Paracompact
public import Mathlib.Topology.ContinuousMap.Compact
public import Mathlib.Topology.LocallyFinite
public import Mathlib.Topology.Metrizable.Basic
public import Mathlib.Topology.PartitionOfUnity
public import Mathlib.Topology.Compactification.StoneCech
public import Mathlib.Topology.Separation.CompletelyRegular
public import Mathlib.Tactic.TFAE

/-!
# `engelking_7_2_1_countable_sum_theorem` — 7.2.1

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `engelking_7_2_1_countable_sum_theorem.md`.
Quality rubric: `engelking_7_2_1_countable_sum_theorem.criteria.md`.
-/

@[expose] public section

open Function Set TopologicalSpace Topology

namespace Dataset
namespace EngelkingGeneralTopology

universe u v w

/-- Engelking 7.2.1, the countable sum theorem for covering dimension. -/
theorem engelking_7_2_1_countable_sum_theorem
    {X : Type u} [TopologicalSpace X] [NormalSpace X] {n : ℕ}
    (hcover : ∃ F : ℕ → Set X, (∀ j, IsClosed (F j)) ∧ ⋃ j, F j = univ ∧
      ∀ j, CoveringDimensionLE (F j) n) :
    CoveringDimensionLE X n := by
  sorry

end EngelkingGeneralTopology
end Dataset
