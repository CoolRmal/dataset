module

public import Dataset.FollandHarmonic.Defs


/-!
# `folland_4_67_synthesis_from_thin_boundary`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `folland_4_67_synthesis_from_thin_boundary.md`.
Quality rubric: `folland_4_67_synthesis_from_thin_boundary.criteria.md`.
-/

@[expose] public section

open Filter MeasureTheory Set Topology
open scoped ENNReal NNReal Topology

namespace Dataset
namespace FollandHarmonic

/-- Folland 4.67: if the spectrum of `f` contains the hull of a closed ideal `I` and the two
boundaries meet in a set containing no nonempty perfect set, then `f` belongs to `I`. -/
theorem folland_4_67_synthesis_from_thin_boundary {G : Type*} [CommGroup G]
    [TopologicalSpace G] [IsTopologicalGroup G]
    [LocallyCompactSpace G] [MeasurableSpace G] [BorelSpace G]
    (μ : Measure G) [μ.IsHaarMeasure]
    (I : Submodule ℂ (G → ℂ)) (hclosed : IsLpClosed 1 μ (I : Set (G → ℂ)))
    (hmem : ∀ f ∈ I, Integrable f μ)
    (hideal : ∀ g : G → ℂ, Integrable g μ → ∀ f ∈ I, groupConv μ g f ∈ I)
    (f : G → ℂ) (hf : Integrable f μ) (hspec : hull μ I ⊆ hull μ {f})
    (hthin : ∀ P : Set (PontryaginDual G), P.Nonempty → Perfect P →
      ¬ P ⊆ frontier (hull μ I) ∩ frontier (hull μ {f})) :
    f ∈ I := by
  sorry

end FollandHarmonic
end Dataset
