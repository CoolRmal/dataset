import Dataset.Bogachev.Defs
import Mathlib.Analysis.Calculus.ContDiff.Basic
import Mathlib.Analysis.Convex.Function
import Mathlib.Analysis.Normed.Module.FiniteDimension
import Mathlib.MeasureTheory.Constructions.Polish.Basic
import Mathlib.MeasureTheory.Function.UniformIntegrable
import Mathlib.MeasureTheory.Integral.Prod
import Mathlib.MeasureTheory.Measure.NullMeasurable
import Mathlib.MeasureTheory.Measure.ProbabilityMeasure
import Mathlib.MeasureTheory.Measure.Regular
import Mathlib.MeasureTheory.Measure.Tight
import Mathlib.MeasureTheory.VectorMeasure.Basic
import Mathlib.MeasureTheory.VectorMeasure.Decomposition.Jordan

/-!
# `bogachev_8_6_2_prokhorov_signed_measures` — 8.6.2

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `bogachev_8_6_2_prokhorov_signed_measures.md`.
Quality rubric: `bogachev_8_6_2_prokhorov_signed_measures.criteria.md`.
-/

open Filter MeasureTheory ProbabilityTheory Set Topology
open scoped BoundedContinuousFunction ENNReal MeasureTheory NNReal ProbabilityTheory Topology

namespace Dataset
namespace Bogachev

/-- Bogachev 8.6.2, Prokhorov compactness for finite signed Borel measures.

Two claims with different hypotheses on `X`, which is why separability appears as an explicit
hypothesis of the first conjunct rather than as an instance on the theorem: for a *complete
separable* metric space the equivalence holds for every family, while for a merely complete
metric space it holds for families of tight measures. -/
theorem bogachev_8_6_2_prokhorov_signed_measures
    {X : Type*} [MetricSpace X] [CompleteSpace X]
    [MeasurableSpace X] [BorelSpace X] (S : Set (SignedMeasure X)) :
    (∀ _ : SecondCountableTopology X,
      relatively_sequentially_weakly_compact_signed S ↔
        IsTightMeasureSet ((fun s : SignedMeasure X ↦ s.totalVariation) '' S) ∧
          UniformlyBoundedInTotalVariation S) ∧
    ((∀ s ∈ S, IsTightMeasureSet {s.totalVariation}) →
      (relatively_sequentially_weakly_compact_signed S ↔
        IsTightMeasureSet ((fun s : SignedMeasure X ↦ s.totalVariation) '' S) ∧
          UniformlyBoundedInTotalVariation S)) := by
  sorry

end Bogachev
end Dataset
