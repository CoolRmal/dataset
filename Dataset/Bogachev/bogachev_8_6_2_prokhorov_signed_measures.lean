module

public import Dataset.Bogachev.Defs
public import Mathlib.Analysis.Calculus.ContDiff.Basic
public import Mathlib.Analysis.Convex.Function
public import Mathlib.Analysis.Normed.Module.FiniteDimension
public import Mathlib.MeasureTheory.Constructions.Polish.Basic
public import Mathlib.MeasureTheory.Function.UniformIntegrable
public import Mathlib.MeasureTheory.Integral.Prod
public import Mathlib.MeasureTheory.Measure.NullMeasurable
public import Mathlib.MeasureTheory.Measure.ProbabilityMeasure
public import Mathlib.MeasureTheory.Measure.Regular
public import Mathlib.MeasureTheory.Measure.Tight
public import Mathlib.MeasureTheory.VectorMeasure.Basic
public import Mathlib.MeasureTheory.VectorMeasure.Decomposition.Jordan

/-!
# `bogachev_8_6_2_prokhorov_signed_measures` — 8.6.2

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `bogachev_8_6_2_prokhorov_signed_measures.md`.
Quality rubric: `bogachev_8_6_2_prokhorov_signed_measures.criteria.md`.
-/

@[expose] public section

open Filter MeasureTheory ProbabilityTheory Set Topology
open scoped BoundedContinuousFunction ENNReal MeasureTheory NNReal ProbabilityTheory Topology

namespace Dataset
namespace Bogachev

/-- Bogachev 8.6.2, Prokhorov compactness for finite signed measures. -/
theorem bogachev_8_6_2_prokhorov_signed_measures
    {X : Type*} [MetricSpace X] [CompleteSpace X]
    [MeasurableSpace X] [BorelSpace X] (S : Set (SignedMeasure X)) :
    (SecondCountableTopology X →
      (relatively_sequentially_weakly_compact_signed S ↔
        IsTightMeasureSet ((fun s : SignedMeasure X ↦ s.totalVariation) '' S) ∧
          UniformlyBoundedInTotalVariation S)) ∧
      ((∀ s ∈ S, IsTightMeasureSet {s.totalVariation}) →
        (relatively_sequentially_weakly_compact_signed S ↔
          IsTightMeasureSet ((fun s : SignedMeasure X ↦ s.totalVariation) '' S) ∧
            UniformlyBoundedInTotalVariation S)) := by
  sorry

end Bogachev
end Dataset
