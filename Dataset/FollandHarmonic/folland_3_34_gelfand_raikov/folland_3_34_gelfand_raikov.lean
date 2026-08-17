import Dataset.FollandHarmonic.Defs

/-!
# `folland_3_34_gelfand_raikov`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `folland_3_34_gelfand_raikov.md`.
Quality rubric: `folland_3_34_gelfand_raikov.criteria.md`.
-/

namespace Dataset
namespace FollandHarmonic

universe u

/-- Folland 3.34, the Gelfand–Raikov theorem: the irreducible unitary representations of a
locally compact group separate its points. -/
theorem folland_3_34_gelfand_raikov {G : Type u} [Group G] [TopologicalSpace G]
    [IsTopologicalGroup G] [LocallyCompactSpace G] [T2Space G]
    (x y : G) (hxy : x ≠ y) :
    ∃ (H : Type u) (_ : NormedAddCommGroup H) (_ : InnerProductSpace ℂ H)
      (_ : CompleteSpace H) (_ : Nontrivial H) (π : UnitaryRepresentation G H),
      π.Irreducible ∧ π.toFun x ≠ π.toFun y := by
  sorry

end FollandHarmonic
end Dataset
