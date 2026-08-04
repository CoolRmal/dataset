module

public import Dataset.KallenbergProbability.Defs
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
# `kallenberg_10_5_doob_meyer`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `kallenberg_10_5_doob_meyer.md`.
Quality rubric: `kallenberg_10_5_doob_meyer.criteria.md`.
-/

@[expose] public section

open Filter MeasureTheory ProbabilityTheory Set Topology
open scoped ENNReal MeasureTheory NNReal ProbabilityTheory Topology

namespace Dataset
namespace KallenbergProbability

/-- Kallenberg 10.5, the Doob--Meyer decomposition. -/
theorem kallenberg_10_5_doob_meyer
    {Ω : Type*} [MeasurableSpace Ω] (μ : Measure Ω) [IsProbabilityMeasure μ]
    (ℱ : Filtration ℝ≥0 ‹MeasurableSpace Ω›) [ℱ.IsRightContinuous]
    (X : ℝ≥0 → Ω → ℝ) (hX : Adapted ℱ X)
    (hXright : ∀ᵐ ω ∂μ, ∀ t,
      ContinuousWithinAt (fun s ↦ X s ω) (Ici t) t) :
    IsLocalSubmartingale X ℱ μ ↔
      ∃ M A : ℝ≥0 → Ω → ℝ,
        (∀ᵐ ω ∂μ, ∀ t, X t ω = M t ω + A t ω) ∧ IsLocalMartingale M ℱ μ ∧
        IsLocallyIntegrableProcess A ℱ μ ∧ IsStronglyPredictable ℱ A ∧
        (∀ᵐ ω ∂μ, Monotone fun t ↦ A t ω) ∧
        (∀ᵐ ω ∂μ, ∀ t, ContinuousWithinAt (fun s ↦ A s ω) (Ici t) t) ∧
        A 0 =ᵐ[μ] 0 ∧
        ∀ M' A' : ℝ≥0 → Ω → ℝ,
          (∀ᵐ ω ∂μ, ∀ t, X t ω = M' t ω + A' t ω) → IsLocalMartingale M' ℱ μ →
          IsLocallyIntegrableProcess A' ℱ μ → IsStronglyPredictable ℱ A' →
          (∀ᵐ ω ∂μ, Monotone fun t ↦ A' t ω) →
          (∀ᵐ ω ∂μ, ∀ t, ContinuousWithinAt (fun s ↦ A' s ω) (Ici t) t) →
          A' 0 =ᵐ[μ] 0 → (∀ᵐ ω ∂μ, ∀ t, M t ω = M' t ω) ∧
            ∀ᵐ ω ∂μ, ∀ t, A t ω = A' t ω := by
  sorry

end KallenbergProbability
end Dataset
