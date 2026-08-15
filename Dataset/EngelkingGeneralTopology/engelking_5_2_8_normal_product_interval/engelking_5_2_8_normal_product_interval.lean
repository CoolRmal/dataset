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
# `engelking_5_2_8_normal_product_interval` — 5.2.8

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `engelking_5_2_8_normal_product_interval.md`.
Quality rubric: `engelking_5_2_8_normal_product_interval.criteria.md`.
-/

open Function Set TopologicalSpace Topology

namespace Dataset
namespace EngelkingGeneralTopology

universe u v w

/-- Engelking 5.2.8, normality of a product with the closed unit interval. -/
theorem engelking_5_2_8_normal_product_interval
    {X : Type u} [TopologicalSpace X] [T1Space X] :
    (NormalSpace X ∧ IsCountablyParacompact X) ↔
      NormalSpace (X × Set.Icc (0 : ℝ) 1) := by
  sorry

end EngelkingGeneralTopology
end Dataset
