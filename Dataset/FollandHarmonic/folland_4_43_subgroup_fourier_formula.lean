module

public import Dataset.FollandHarmonic.Defs


/-!
# `folland_4_43_subgroup_fourier_formula`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `folland_4_43_subgroup_fourier_formula.md`.
Quality rubric: `folland_4_43_subgroup_fourier_formula.criteria.md`.
-/

@[expose] public section

open Filter MeasureTheory Set Topology
open scoped ENNReal FourierTransform NNReal Topology

namespace Dataset
namespace FollandHarmonic

/-- Folland 4.43 (4.44): integrating `f` over a coset of a closed subgroup `H` equals
integrating its Fourier transform over the annihilator `H⊥`. -/
theorem folland_4_43_subgroup_fourier_formula {G : Type*} [CommGroup G]
    [TopologicalSpace G] [IsTopologicalGroup G]
    [LocallyCompactSpace G] [MeasurableSpace G] [BorelSpace G]
    (μ : Measure G) [μ.IsHaarMeasure]
    (H : Subgroup G) (hH : IsClosed (H : Set G))
    [LocallyCompactSpace H] [MeasurableSpace (annihilator G H)]
    [BorelSpace (annihilator G H)] [LocallyCompactSpace (annihilator G H)] :
    ∃ (ν : Measure H) (σ : Measure (annihilator G H)), ν.IsHaarMeasure ∧ σ.IsHaarMeasure ∧
      ∀ f : G → ℂ, Continuous f → HasCompactSupport f →
        Integrable (fun ξ : annihilator G H ↦ dualFourier μ f ξ) σ →
        ∀ x : G, ∫ y : H, f (x * y) ∂ν =
          ∫ ξ : annihilator G H, dualFourier μ f ξ * ((ξ : PontryaginDual G) x : ℂ) ∂σ := by
  sorry

end FollandHarmonic
end Dataset
