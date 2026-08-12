module

public import Dataset.FollandHarmonic.Defs


/-!
# `folland_4_54_spectral_synthesis_compact`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `folland_4_54_spectral_synthesis_compact.md`.
Quality rubric: `folland_4_54_spectral_synthesis_compact.criteria.md`.
-/

@[expose] public section

open Filter MeasureTheory Set Topology
open scoped ENNReal NNReal Topology

namespace Dataset
namespace FollandHarmonic

/-- Folland 4.54: on a compact abelian group every closed ideal of `𝓛¹(G)` is the kernel of its
hull, i.e. spectral synthesis always holds. -/
theorem folland_4_54_spectral_synthesis_compact {G : Type*} [CommGroup G]
    [TopologicalSpace G] [IsTopologicalGroup G]
    [LocallyCompactSpace G] [MeasurableSpace G] [BorelSpace G]
    (μ : Measure G) [μ.IsHaarMeasure] [CompactSpace G]
    (I : Submodule ℂ (G → ℂ)) (hclosed : IsLpClosed 1 μ (I : Set (G → ℂ)))
    (hmem : ∀ f ∈ I, Integrable f μ)
    (hideal : ∀ g : G → ℂ, Integrable g μ → ∀ f ∈ I, groupConv μ g f ∈ I) :
    kernel μ (hull μ I) = I := by
  sorry

end FollandHarmonic
end Dataset
