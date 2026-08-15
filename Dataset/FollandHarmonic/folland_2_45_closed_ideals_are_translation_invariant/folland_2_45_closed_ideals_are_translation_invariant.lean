module

public import Dataset.FollandHarmonic.Defs


/-!
# `folland_2_45_closed_ideals_are_translation_invariant`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `folland_2_45_closed_ideals_are_translation_invariant.md`.
Quality rubric: `folland_2_45_closed_ideals_are_translation_invariant.criteria.md`.
-/

@[expose] public section

open Filter MeasureTheory Set Topology
open scoped ENNReal NNReal Topology

namespace Dataset
namespace FollandHarmonic

/-- Folland 2.45: a closed subspace of `𝓛¹(G)` is a left (right) ideal precisely when it is
closed under left (right) translations. -/
theorem folland_2_45_closed_ideals_are_translation_invariant {G : Type*} [Group G]
    [TopologicalSpace G] [IsTopologicalGroup G]
    [LocallyCompactSpace G] [MeasurableSpace G] [BorelSpace G]
    (μ : Measure G) [μ.IsHaarMeasure]
    (I : Submodule ℂ (G → ℂ)) (hclosed : IsLpClosed 1 μ (I : Set (G → ℂ)))
    (hmem : ∀ f ∈ I, Integrable f μ) :
    ((∀ g : G → ℂ, Integrable g μ → ∀ f ∈ I, groupConv μ g f ∈ I) ↔
        ∀ (y : G), ∀ f ∈ I, leftTranslate y f ∈ I) ∧
      ((∀ g : G → ℂ, Integrable g μ → ∀ f ∈ I, groupConv μ f g ∈ I) ↔
        ∀ (y : G), ∀ f ∈ I, rightTranslate y f ∈ I) := by
  sorry

end FollandHarmonic
end Dataset
