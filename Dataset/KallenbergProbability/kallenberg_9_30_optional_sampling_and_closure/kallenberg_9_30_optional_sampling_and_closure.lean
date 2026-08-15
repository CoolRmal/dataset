import Dataset.KallenbergProbability.Defs
import Mathlib.MeasureTheory.Function.ConvergenceInDistribution
import Mathlib.MeasureTheory.Function.UniformIntegrable
import Mathlib.MeasureTheory.Measure.Prokhorov
import Mathlib.Probability.BrownianMotion.Basic
import Mathlib.Probability.Distributions.Gaussian.Real
import Mathlib.Probability.Kernel.Disintegration.StandardBorel
import Mathlib.Probability.Martingale.Basic
import Mathlib.Probability.Moments.Variance
import Mathlib.Probability.Process.Predictable
import Mathlib.Probability.Process.Stopping
import Mathlib.Topology.MetricSpace.HolderNorm
import Mathlib.Tactic.TFAE

/-!
# `kallenberg_9_30_optional_sampling_and_closure`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `kallenberg_9_30_optional_sampling_and_closure.md`.
Quality rubric: `kallenberg_9_30_optional_sampling_and_closure.criteria.md`.
-/

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
        ∃ terminalValue : Ω → ℝ, Integrable terminalValue μ ∧
          (∀ᵐ ω ∂μ, Tendsto (fun t ↦ X t ω) atTop (𝓝 (terminalValue ω))) ∧
          ∀ τ' : Ω → WithTop ℝ≥0, IsStoppingTime ℱ τ' →
            Integrable (stoppedValueWithLimit X terminalValue τ') μ ∧
            ∀ σ' : Ω → WithTop ℝ≥0, ∀ hσ' : IsStoppingTime ℱ σ',
              stoppedValueWithLimit X terminalValue (fun ω ↦ min (σ' ω) (τ' ω)) ≤ᵐ[μ]
                μ[stoppedValueWithLimit X terminalValue τ' | hσ'.measurableSpace]) := by
  sorry

end KallenbergProbability
end Dataset
