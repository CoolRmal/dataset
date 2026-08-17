import Dataset.EngelkingGeneralTopology.Defs

/-!
# `engelking_5_1_9_paracompact_partition_of_unity` — 5.1.9

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `engelking_5_1_9_paracompact_partition_of_unity.md`.
Quality rubric: `engelking_5_1_9_paracompact_partition_of_unity.criteria.md`.
-/

namespace Dataset
namespace EngelkingGeneralTopology

universe u v w

/-- Engelking 5.1.9, paracompactness via partitions of unity. -/
theorem engelking_5_1_9_paracompact_partition_of_unity
    {X : Type u} [TopologicalSpace X] [T1Space X] :
    let locallyFinitePartition := ∀ (ι : Type u) (U : ι → Set X), IsOpenCover U →
      ∃ ρ : PartitionOfUnity ι X, ρ.IsSubordinate U
    let partition := ∀ (ι : Type u) (U : ι → Set X), IsOpenCover U →
      ∃ ρ : ι → C(X, ℝ), 0 ≤ ρ ∧ (∀ x, HasSum (fun i ↦ ρ i x) 1) ∧
        ∀ i, tsupport (ρ i) ⊆ U i
    List.TFAE [T2Space X ∧ ParacompactSpace X, locallyFinitePartition, partition] := by
  sorry

end EngelkingGeneralTopology
end Dataset
