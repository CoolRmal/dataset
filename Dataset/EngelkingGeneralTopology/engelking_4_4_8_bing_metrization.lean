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
# `engelking_4_4_8_bing_metrization` — 4.4.8

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `engelking_4_4_8_bing_metrization.md`.
Quality rubric: `engelking_4_4_8_bing_metrization.criteria.md`.
-/

@[expose] public section

open Function Set TopologicalSpace Topology

namespace Dataset
namespace EngelkingGeneralTopology

universe u v w

/-- Engelking 4.4.8, the Bing metrization theorem. -/
theorem engelking_4_4_8_bing_metrization
    {X : Type u} [TopologicalSpace X] [T1Space X] :
    MetrizableSpace X ↔ RegularSpace X ∧ HasSigmaDiscreteBase X := by
  sorry

end EngelkingGeneralTopology
end Dataset
