import Mathlib.MeasureTheory.Measure.Hausdorff

/-!
# `mattila_8_19_compact_subsets_of_finite_hausdorff_measure` — 8.19

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `mattila_8_19_compact_subsets_of_finite_hausdorff_measure.md`.
Quality rubric: `mattila_8_19_compact_subsets_of_finite_hausdorff_measure.criteria.md`.
-/

open scoped ENNReal MeasureTheory

namespace Dataset
namespace MattilaGeometry

universe u

/-- Mattila 8.19, finite-measure compact subsets approximate Hausdorff measure. -/
theorem mattila_8_19_compact_subsets_of_finite_hausdorff_measure
    {X : Type u} [MetricSpace X] [CompactSpace X] [MeasurableSpace X] [BorelSpace X]
    {s : ℝ} :
    μH[s] (Set.univ : Set X) =
      ⨆ C : Set X, ⨆ (_ : IsCompact C), ⨆ (_ : μH[s] C < ∞), μH[s] C := by
  sorry

end MattilaGeometry
end Dataset
