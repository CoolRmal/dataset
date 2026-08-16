import Dataset.EngelkingGeneralTopology.Defs

/-!
# `engelking_5_3_10_strong_paracompactness` — 5.3.10

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `engelking_5_3_10_strong_paracompactness.md`.
Quality rubric: `engelking_5_3_10_strong_paracompactness.criteria.md`.
-/

namespace Dataset
namespace EngelkingGeneralTopology

universe u v w

/-- Engelking 5.3.10, four characterizations of strong paracompactness. -/
theorem engelking_5_3_10_strong_paracompactness
    {X : Type u} [TopologicalSpace X] [RegularSpace X] [T1Space X] :
    let closedLocallyFiniteStarFinite :=
      ∀ (ι : Type v) (U : ι → Set X), IsOpenCover U →
        ∃ (κ : Type v) (F : κ → Set X),
          IsClosedCover F ∧ Refines F U ∧ LocallyFinite F ∧ IsStarFiniteFamily F
    let closedLocallyFiniteStarCountable :=
      ∀ (ι : Type v) (U : ι → Set X), IsOpenCover U →
        ∃ (κ : Type v) (F : κ → Set X),
          IsClosedCover F ∧ Refines F U ∧ LocallyFinite F ∧ IsStarCountableFamily F
    let starCountableOpen := ∀ (ι : Type v) (U : ι → Set X), IsOpenCover U →
      ∃ (κ : Type v) (V : κ → Set X),
        IsOpenCover V ∧ Refines V U ∧ IsStarCountableFamily V
    List.TFAE [IsStronglyParacompact X, closedLocallyFiniteStarFinite,
      closedLocallyFiniteStarCountable, starCountableOpen] := by
  sorry

end EngelkingGeneralTopology
end Dataset
