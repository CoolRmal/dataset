import Dataset.FollandHarmonic.Defs

/-!
# `folland_2_29_unimodular_of_compact_commutator_quotient`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `folland_2_29_unimodular_of_compact_commutator_quotient.md`.
Quality rubric: `folland_2_29_unimodular_of_compact_commutator_quotient.criteria.md`.
-/

open MeasureTheory

namespace Dataset
namespace FollandHarmonic

/-- Folland 2.29: a locally compact group whose quotient by the closed commutator subgroup is
compact is unimodular. -/
theorem folland_2_29_unimodular_of_compact_commutator_quotient {G : Type*} [Group G]
    [TopologicalSpace G] [IsTopologicalGroup G] [LocallyCompactSpace G]
    [CompactSpace (G ⧸ (commutator G).topologicalClosure)] :
    IsUnimodular G := by
  sorry

end FollandHarmonic
end Dataset
