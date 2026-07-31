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
# `kallenberg_6_13_gaussian_variance_criteria`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `kallenberg_6_13_gaussian_variance_criteria.md`.
Quality rubric: `kallenberg_6_13_gaussian_variance_criteria.criteria.md`.
-/

@[expose] public section

open Filter MeasureTheory ProbabilityTheory Set Topology
open scoped ENNReal MeasureTheory NNReal ProbabilityTheory Topology

namespace Dataset
namespace KallenbergProbability

/-- Kallenberg 6.13, the Lindeberg--Feller Gaussian variance criterion. -/
theorem kallenberg_6_13_gaussian_variance_criteria
    {Ω Ω' : Type*} [MeasurableSpace Ω] [MeasurableSpace Ω']
    (μ : Measure Ω) (μ' : Measure Ω') [IsProbabilityMeasure μ]
    [IsProbabilityMeasure μ'] (k : ℕ → ℕ)
    (ξ : (n : ℕ) → Fin (k n + 1) → Ω → ℝ) (ζ : Ω' → ℝ)
    (hξmeas : ∀ n j, AEMeasurable (ξ n j) μ)
    (hξsq : ∀ n j, MemLp (ξ n j) 2 μ)
    (hcentered : ∀ n j, ∫ ω, ξ n j ω ∂μ = 0)
    (hindep : ∀ n, iIndepFun (ξ n) μ)
    (hvariance : Tendsto (fun n ↦ ∑ j, variance (ξ n j) μ) atTop (𝓝 1))
    (hζ : HasLaw ζ (gaussianReal 0 1) μ') :
    let sumConverges := TendstoInDistribution (fun n ω ↦ ∑ j, ξ n j ω) atTop ζ
      (fun _ ↦ μ) μ'
    let maximalVarianceVanishes := Tendsto
      (fun n ↦ Finset.univ.sup' (Finset.univ_nonempty_iff.mpr inferInstance)
        fun j ↦ variance (ξ n j) μ) atTop (𝓝 0)
    let lindeberg := ∀ ε : ℝ, 0 < ε → Tendsto
      (fun n ↦ ∑ j, ∫ ω, (ξ n j ω) ^ 2 * (Set.indicator
        {x : ℝ | ε < |x|} (fun _ ↦ (1 : ℝ))) (ξ n j ω) ∂μ) atTop (𝓝 0)
    (sumConverges ∧ maximalVarianceVanishes) ↔ lindeberg := by
  sorry

end KallenbergProbability
end Dataset
