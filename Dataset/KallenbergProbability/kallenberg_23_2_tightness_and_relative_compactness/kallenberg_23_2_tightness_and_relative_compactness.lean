module

public import Mathlib.MeasureTheory.Function.ConvergenceInDistribution
public import Mathlib.MeasureTheory.Function.UniformIntegrable
public import Mathlib.MeasureTheory.Measure.Prokhorov
public import Mathlib.Probability.BrownianMotion.Basic
public import Mathlib.Probability.Distributions.Gaussian.Real
public import Mathlib.Probability.Kernel.Disintegration.StandardBorel
public import Mathlib.Probability.Martingale.Basic
public import Mathlib.Probability.Moments.Variance
public import Mathlib.Probability.Process.Predictable
public import Mathlib.Probability.Process.Stopping
public import Mathlib.Topology.MetricSpace.HolderNorm
public import Mathlib.Tactic.TFAE

/-!
# `kallenberg_23_2_tightness_and_relative_compactness`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `kallenberg_23_2_tightness_and_relative_compactness.md`.
Quality rubric: `kallenberg_23_2_tightness_and_relative_compactness.criteria.md`.
-/

@[expose] public section

open Filter MeasureTheory ProbabilityTheory Set Topology
open scoped ENNReal MeasureTheory NNReal ProbabilityTheory Topology

namespace Dataset
namespace KallenbergProbability

/-- Kallenberg 23.2, Prohorov's tightness and relative-compactness theorem. -/
theorem kallenberg_23_2_tightness_and_relative_compactness
    {S : Type*} [MetricSpace S] [MeasurableSpace S] [BorelSpace S]
    (Ξ : Set (ProbabilityMeasure S)) :
    let tight := IsTightMeasureSet {((ν : ProbabilityMeasure S) : Measure S) | ν ∈ Ξ}
    let relativelyCompact := IsCompact (closure Ξ)
    (tight → relativelyCompact) ∧
      ((TopologicalSpace.SeparableSpace S ∧ CompleteSpace S) →
        (tight ↔ relativelyCompact)) := by
  sorry

end KallenbergProbability
end Dataset
