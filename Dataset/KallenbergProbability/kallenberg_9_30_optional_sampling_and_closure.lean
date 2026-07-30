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
# `kallenberg_9_30_optional_sampling_and_closure`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `kallenberg_9_30_optional_sampling_and_closure.md`.
Quality rubric: `kallenberg_9_30_optional_sampling_and_closure.criteria.md`.
-/

@[expose] public section

open Filter MeasureTheory ProbabilityTheory Set Topology
open scoped ENNReal MeasureTheory NNReal ProbabilityTheory Topology

namespace Dataset
namespace KallenbergProbability

/-- Kallenberg 9.30, optional sampling and its uniform-integrability extension. -/
theorem kallenberg_9_30_optional_sampling_and_closure
    {Ω : Type*} [MeasurableSpace Ω] (μ : Measure Ω) [IsProbabilityMeasure μ]
    (ℱ : Filtration ℝ≥0 ‹MeasurableSpace Ω›) [ℱ.IsRightContinuous]
    (X : ℝ≥0 → Ω → ℝ)
    (hX : Submartingale X ℱ μ)
    (hXright : ∀ᵐ ω ∂μ, ∀ t,
      ContinuousWithinAt (fun s ↦ X s ω) (Ici t) t)
    (σ τ : Ω → WithTop ℝ≥0) (hσ : IsStoppingTime ℱ σ) (hτ : IsStoppingTime ℱ τ)
    (hτbounded : ∃ u : ℝ≥0, ∀ᵐ ω ∂μ, τ ω ≤ u) :
    Integrable (stoppedValue X τ) μ ∧
      stoppedValue X (fun ω ↦ min (σ ω) (τ ω)) ≤ᵐ[μ]
        μ[stoppedValue X τ | hσ.measurableSpace] ∧
      (UniformIntegrable (fun t ω ↦ max (X t ω) 0) 1 μ ↔
        ∀ τ' : Ω → WithTop ℝ≥0, IsStoppingTime ℱ τ' →
          Integrable (stoppedValue X τ') μ ∧
          ∀ σ' : Ω → WithTop ℝ≥0, ∀ hσ' : IsStoppingTime ℱ σ',
            stoppedValue X (fun ω ↦ min (σ' ω) (τ' ω)) ≤ᵐ[μ]
              μ[stoppedValue X τ' | hσ'.measurableSpace]) := by
  sorry

end KallenbergProbability
end Dataset
