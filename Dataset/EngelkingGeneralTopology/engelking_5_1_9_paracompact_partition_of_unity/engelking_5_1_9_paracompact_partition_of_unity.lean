import Dataset.EngelkingGeneralTopology.Defs
import Mathlib.Topology.Compactness.Compact
import Mathlib.Topology.Compactness.Paracompact
import Mathlib.Topology.ContinuousMap.Compact
import Mathlib.Topology.LocallyFinite
import Mathlib.Topology.Metrizable.Basic
import Mathlib.Topology.PartitionOfUnity
import Mathlib.Topology.Compactification.StoneCech
import Mathlib.Topology.Separation.CompletelyRegular
import Mathlib.Tactic.TFAE

/-!
# `engelking_5_1_9_paracompact_partition_of_unity` — 5.1.9

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `engelking_5_1_9_paracompact_partition_of_unity.md`.
Quality rubric: `engelking_5_1_9_paracompact_partition_of_unity.criteria.md`.
-/

open Function Set TopologicalSpace Topology

namespace Dataset
namespace EngelkingGeneralTopology

universe u v w

/-- Engelking 5.1.9, paracompactness via partitions of unity. -/
theorem engelking_5_1_9_paracompact_partition_of_unity
    {X : Type u} [TopologicalSpace X] [T2Space X] :
    let locallyFinitePartition := ∀ (ι : Type v) (U : ι → Set X), IsOpenCover U →
      ∃ ρ : PartitionOfUnity ι X, ρ.IsSubordinate U
    let partition := ∀ (ι : Type v) (U : ι → Set X), IsOpenCover U →
      ∃ ρ : ι → C(X, ℝ), 0 ≤ ρ ∧ (∀ x, HasSum (fun i ↦ ρ i x) 1) ∧
        ∀ i, tsupport (ρ i) ⊆ U i
    List.TFAE [ParacompactSpace X, locallyFinitePartition, partition] := by
  sorry

end EngelkingGeneralTopology
end Dataset
