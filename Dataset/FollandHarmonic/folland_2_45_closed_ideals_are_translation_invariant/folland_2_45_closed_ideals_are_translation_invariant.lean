import Dataset.FollandHarmonic.Defs

/-!
# `folland_2_45_closed_ideals_are_translation_invariant`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `folland_2_45_closed_ideals_are_translation_invariant.md`.
Quality rubric: `folland_2_45_closed_ideals_are_translation_invariant.criteria.md`.
-/

open MeasureTheory

namespace Dataset
namespace FollandHarmonic

/-- Folland 2.45: a closed subspace of `L¹(G)` is a left ideal exactly when it is closed under
left translations, and a right ideal exactly when it is closed under right translations. -/
theorem folland_2_45_closed_ideals_are_translation_invariant {G : Type*} [Group G]
    [TopologicalSpace G] [IsTopologicalGroup G]
    [LocallyCompactSpace G] [MeasurableSpace G] [BorelSpace G]
    (μ : Measure G) [μ.IsHaarMeasure] [μ.Regular]
    (I : Submodule ℂ (Lp ℂ 1 μ)) (hclosed : IsClosed (I : Set (Lp ℂ 1 μ))) :
    ((∀ f : Lp ℂ 1 μ, ∀ g ∈ I, L1conv μ f g ∈ I) ↔
        ∀ y : G, ∀ g ∈ I, L1leftTranslate μ y g ∈ I) ∧
      ((∀ f : Lp ℂ 1 μ, ∀ g ∈ I, L1conv μ g f ∈ I) ↔
        ∀ y : G, ∀ g ∈ I, L1rightTranslate μ y g ∈ I) := by
  sorry

end FollandHarmonic
end Dataset
