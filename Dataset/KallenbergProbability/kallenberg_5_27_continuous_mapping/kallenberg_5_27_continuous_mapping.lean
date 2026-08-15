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
# `kallenberg_5_27_continuous_mapping`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `kallenberg_5_27_continuous_mapping.md`.
Quality rubric: `kallenberg_5_27_continuous_mapping.criteria.md`.
-/

@[expose] public section

open Filter MeasureTheory ProbabilityTheory Set Topology
open scoped ENNReal MeasureTheory NNReal ProbabilityTheory Topology

namespace Dataset
namespace KallenbergProbability

/-- Kallenberg 5.27, the continuous-mapping theorem. -/
theorem kallenberg_5_27_continuous_mapping
    {Ω Ω' S T : Type*} [MeasurableSpace Ω] [MeasurableSpace Ω']
    [MetricSpace S] [MeasurableSpace S] [BorelSpace S]
    [MetricSpace T] [MeasurableSpace T] [BorelSpace T]
    (μ : Measure Ω) (μ' : Measure Ω') [IsProbabilityMeasure μ]
    [IsProbabilityMeasure μ'] (C : Set S) (f : S → T) (fn : ℕ → S → T)
    (hfn : ∀ n, Measurable (fn n)) (hf : Measurable f)
    (hcontinuous : ∀ s : S, s ∈ C → ∀ sn : ℕ → S,
      Tendsto sn atTop (𝓝 s) → Tendsto (fun n ↦ fn n (sn n)) atTop (𝓝 (f s)))
    (ξn : ℕ → Ω → S) (ξ : Ω' → S)
    (hξ : TendstoInDistribution ξn atTop ξ (fun _ ↦ μ) μ')
    (hC : μ' (ξ ⁻¹' C) = 1) :
    TendstoInDistribution (fun n ω ↦ fn n (ξn n ω)) atTop (fun ω ↦ f (ξ ω))
        (fun _ ↦ μ) μ' ∧
      ∀ g : S → T, Measurable g →
        μ' (ξ ⁻¹' {s : S | ContinuousAt g s}) = 1 →
          TendstoInDistribution (fun n ω ↦ g (ξn n ω)) atTop (fun ω ↦ g (ξ ω))
            (fun _ ↦ μ) μ' := by
  sorry

end KallenbergProbability
end Dataset
