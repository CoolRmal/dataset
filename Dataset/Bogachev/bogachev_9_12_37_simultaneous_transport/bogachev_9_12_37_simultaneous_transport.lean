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
# `bogachev_9_12_37_simultaneous_transport` — 9.12.37

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `bogachev_9_12_37_simultaneous_transport.md`.
Quality rubric: `bogachev_9_12_37_simultaneous_transport.criteria.md`.
-/

@[expose] public section

open Filter MeasureTheory ProbabilityTheory Set Topology
open scoped BoundedContinuousFunction ENNReal MeasureTheory NNReal ProbabilityTheory Topology

namespace Dataset
namespace Bogachev

/-- Bogachev 9.12.37, simultaneous transport of finitely many atomless measures. -/
theorem bogachev_9_12_37_simultaneous_transport
    {X : Type*} [MeasurableSpace X] [TopologicalSpace X] [T2Space X] [SouslinSpace X]
    [BorelSpace X] {n : ℕ} (μ : Fin n → Measure X) [∀ i, IsProbabilityMeasure (μ i)]
    (ν : Measure X) [IsProbabilityMeasure ν]
    (hμ : ∀ i, is_atomless_measure (μ i)) :
    ∃ T : X → X, ∀ i, MeasurePreserving T (μ i) ν := by
  sorry

end Bogachev
end Dataset
