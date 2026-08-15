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
# `engelking_8_4_13_smirnov_proximity_compactification` — 8.4.13

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `engelking_8_4_13_smirnov_proximity_compactification.md`.
Quality rubric: `engelking_8_4_13_smirnov_proximity_compactification.criteria.md`.
-/

open Function Set TopologicalSpace Topology

namespace Dataset
namespace EngelkingGeneralTopology

universe u v w

/-- Engelking 8.4.13, Smirnov's compactification-proximity correspondence. -/
theorem engelking_8_4_13_smirnov_proximity_compactification
    {X : Type u} [TopologicalSpace X] [T35Space X] :
    (∀ (K : Type v) (tK : TopologicalSpace K) (e : X → K),
      @IsCompactification X K _ tK e →
        ∃ p : Proximity X, @IsAssignedProximity X K _ tK e p) ∧
    (∀ p : Proximity X, ∃ (K : Type v) (_ : TopologicalSpace K) (e : X → K),
      IsCompactification e ∧ IsAssignedProximity e p) ∧
    ∀ (K L : Type v) (_ : TopologicalSpace K) (_ : TopologicalSpace L)
      (e : X → K) (f : X → L) (p : Proximity X),
        IsCompactification e → IsCompactification f →
        IsAssignedProximity e p → IsAssignedProximity f p →
        EquivalentCompactifications e f := by
  sorry

end EngelkingGeneralTopology
end Dataset
