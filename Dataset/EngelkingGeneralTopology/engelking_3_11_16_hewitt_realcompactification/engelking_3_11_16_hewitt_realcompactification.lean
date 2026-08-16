import Dataset.EngelkingGeneralTopology.Defs

/-!
# `engelking_3_11_16_hewitt_realcompactification` — 3.11.16

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `engelking_3_11_16_hewitt_realcompactification.md`.
Quality rubric: `engelking_3_11_16_hewitt_realcompactification.criteria.md`.
-/

open Set Topology

namespace Dataset
namespace EngelkingGeneralTopology

universe u v w

/-- Engelking 3.11.16, existence and uniqueness of the Hewitt realcompactification. -/
theorem engelking_3_11_16_hewitt_realcompactification
    {X : Type u} [TopologicalSpace X] [T35Space X] :
    ∃ (Y : Type u) (tY : TopologicalSpace Y) (ν : X → Y),
      @IsRealcompact Y tY ∧ @IsEmbedding X Y _ tY ν ∧ closure (range ν) = univ ∧
        (∀ f : X → ℝ, Continuous f →
          ∃ g : Y → ℝ, @Continuous Y ℝ tY _ g ∧ g ∘ ν = f) ∧
        (∀ (Z : Type u) (tZ : TopologicalSpace Z), @IsRealcompact Z tZ →
          ∀ f : X → Z, @Continuous X Z _ tZ f →
            ∃ g : Y → Z, @Continuous Y Z tY tZ g ∧ g ∘ ν = f) ∧
        ∀ (Z : Type u) (tZ : TopologicalSpace Z) (ζ : X → Z),
          @IsRealcompact Z tZ → @IsEmbedding X Z _ tZ ζ → closure (range ζ) = univ →
          (∀ f : X → ℝ, Continuous f →
            ∃ g : Z → ℝ, @Continuous Z ℝ tZ _ g ∧ g ∘ ζ = f) →
          ∃ h : @Homeomorph Y Z tY tZ, h ∘ ν = ζ := by
  sorry

end EngelkingGeneralTopology
end Dataset
