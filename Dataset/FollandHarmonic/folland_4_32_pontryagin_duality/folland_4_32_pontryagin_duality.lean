import Mathlib.Topology.Algebra.PontryaginDual

/-!
# `folland_4_32_pontryagin_duality`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `folland_4_32_pontryagin_duality.md`.
Quality rubric: `folland_4_32_pontryagin_duality.criteria.md`.
-/

namespace Dataset
namespace FollandHarmonic

/-- Folland 4.32, the Pontrjagin duality theorem: the evaluation map `Φ x ξ = ξ x` from a
locally compact abelian group to its double dual is an isomorphism of topological groups. -/
theorem folland_4_32_pontryagin_duality {G : Type*} [CommGroup G] [TopologicalSpace G]
    [IsTopologicalGroup G] [LocallyCompactSpace G] [T2Space G] :
    ∃ Φ : ContinuousMulEquiv G (PontryaginDual (PontryaginDual G)),
      ∀ (x : G) (ξ : PontryaginDual G), Φ x ξ = ξ x := by
  sorry

end FollandHarmonic
end Dataset
