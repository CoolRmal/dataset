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
# `engelking_5_1_9_paracompact_partition_of_unity` — 5.1.9

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `engelking_5_1_9_paracompact_partition_of_unity.md`.
Quality rubric: `engelking_5_1_9_paracompact_partition_of_unity.criteria.md`.
-/

@[expose] public section

open Function Set TopologicalSpace Topology

namespace Dataset
namespace EngelkingGeneralTopology

universe u v w

/-- Engelking 5.1.9, paracompactness via partitions of unity. -/
theorem engelking_5_1_9_paracompact_partition_of_unity
    {X : Type u} [TopologicalSpace X] [T1Space X] :
    let locallyFinitePartition := ∀ (ι : Type v) (U : ι → Set X), IsOpenCover U →
      ∃ ρ : PartitionOfUnity ι X, ρ.IsSubordinate U
    let partition := ∀ (ι : Type v) (U : ι → Set X), IsOpenCover U →
      ∃ ρ : ι → C(X, ℝ), 0 ≤ ρ ∧ (∀ x, HasSum (fun i ↦ ρ i x) 1) ∧
        ∀ i, tsupport (ρ i) ⊆ U i
    List.TFAE [ParacompactSpace X, locallyFinitePartition, partition] := by
  sorry

end EngelkingGeneralTopology
end Dataset
