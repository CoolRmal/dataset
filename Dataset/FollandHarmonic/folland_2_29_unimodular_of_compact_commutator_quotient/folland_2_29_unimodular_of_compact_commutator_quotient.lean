module

public import Dataset.FollandHarmonic.Defs
public import Mathlib.MeasureTheory.Group.ModularCharacter
public import Mathlib.GroupTheory.Commutator.Basic
public import Mathlib.Topology.Algebra.Group.Basic

/-!
# `folland_2_29_unimodular_of_compact_commutator_quotient`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `folland_2_29_unimodular_of_compact_commutator_quotient.md`.
Quality rubric: `folland_2_29_unimodular_of_compact_commutator_quotient.criteria.md`.
-/

@[expose] public section

open Filter MeasureTheory Set Topology
open scoped ENNReal NNReal Topology

namespace Dataset
namespace FollandHarmonic

/-- Folland 2.29: a locally compact group whose quotient by the closed commutator subgroup is
compact is unimodular. -/
theorem folland_2_29_unimodular_of_compact_commutator_quotient {G : Type*} [Group G]
    [TopologicalSpace G] [IsTopologicalGroup G] [LocallyCompactSpace G]
    (hcpt : CompactSpace (G ⧸ (commutator G).topologicalClosure)) (x : G) :
    Measure.modularCharacterFun x = 1 := by
  sorry

end FollandHarmonic
end Dataset
