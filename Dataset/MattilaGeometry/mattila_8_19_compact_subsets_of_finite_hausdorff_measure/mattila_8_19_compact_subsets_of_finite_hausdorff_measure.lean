import Mathlib.Analysis.InnerProductSpace.Projection.Submodule
import Mathlib.MeasureTheory.Measure.Hausdorff
import Mathlib.MeasureTheory.Measure.Decomposition.Lebesgue
import Mathlib.MeasureTheory.Measure.Haar.NormedSpace
import Mathlib.MeasureTheory.Measure.Regular
import Mathlib.MeasureTheory.Measure.Support
import Mathlib.Topology.MetricSpace.HausdorffDimension
import Mathlib.Tactic.TFAE

/-!
# `mattila_8_19_compact_subsets_of_finite_hausdorff_measure` — 8.19

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `mattila_8_19_compact_subsets_of_finite_hausdorff_measure.md`.
Quality rubric: `mattila_8_19_compact_subsets_of_finite_hausdorff_measure.criteria.md`.
-/

open Filter Function MeasureTheory Metric Set Topology
open scoped ENNReal MeasureTheory NNReal Topology

namespace Dataset
namespace MattilaGeometry

universe u

/-- Mattila 8.19, finite-measure compact subsets approximate Hausdorff measure. -/
theorem mattila_8_19_compact_subsets_of_finite_hausdorff_measure
    {X : Type u} [MetricSpace X] [CompactSpace X] [MeasurableSpace X] [BorelSpace X]
    {s : ℝ} (hs : 0 < s) :
    μH[s] (Set.univ : Set X) =
      ⨆ C : Set X, ⨆ (_ : IsCompact C), ⨆ (_ : μH[s] C < ∞), μH[s] C := by
  sorry

end MattilaGeometry
end Dataset
