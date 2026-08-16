import Dataset.FollandHarmonic.Defs
import Mathlib.Topology.Algebra.PontryaginDual

/-!
# `folland_4_81_almost_periodic_characterization`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `folland_4_81_almost_periodic_characterization.md`.
Quality rubric: `folland_4_81_almost_periodic_characterization.criteria.md`.
-/

namespace Dataset
namespace FollandHarmonic

universe u

/-- Folland 4.81: for a bounded continuous function on a locally compact group, being a uniform
limit of trigonometric polynomials is the same as being uniformly almost periodic. -/
theorem folland_4_81_almost_periodic_characterization {G : Type u} [CommGroup G]
    [TopologicalSpace G] [IsTopologicalGroup G]
    [LocallyCompactSpace G] (f : G → ℂ) (hf : Continuous f) (hbdd : ∃ C : ℝ, ∀ x, ‖f x‖ ≤ C) :
    letI extendsToBohr :=
      ∃ (K : Type u) (_ : CommGroup K) (_ : TopologicalSpace K) (_ : IsTopologicalGroup K)
        (_ : CompactSpace K) (_ : T2Space K) (ι : G →* K),
        IsBohrCompactification ι ∧
          ∃ F : K → ℂ, Continuous F ∧ ∀ x : G, F (ι x) = f x
    letI uniformLimitOfCharacters :=
      ∀ ε : ℝ, 0 < ε → ∃ (s : Finset (PontryaginDual G)) (c : PontryaginDual G → ℂ),
        ∀ x, ‖f x - ∑ ξ ∈ s, c ξ * (ξ x : ℂ)‖ < ε
    List.TFAE [extendsToBohr, uniformLimitOfCharacters, IsUniformlyAlmostPeriodic f] := by
  sorry

end FollandHarmonic
end Dataset
