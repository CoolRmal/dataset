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
# `kallenberg_8_5_conditional_distributions`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `kallenberg_8_5_conditional_distributions.md`.
Quality rubric: `kallenberg_8_5_conditional_distributions.criteria.md`.
-/

open Filter MeasureTheory ProbabilityTheory Set Topology
open scoped ENNReal MeasureTheory NNReal ProbabilityTheory Topology

namespace Dataset
namespace KallenbergProbability

/-- Kallenberg 8.5, existence, uniqueness, and integration for conditional laws. -/
theorem kallenberg_8_5_conditional_distributions
    {Ω S T : Type*} [MeasurableSpace Ω] [MeasurableSpace S]
    [MeasurableSpace T] [StandardBorelSpace T] (μ : Measure Ω)
    [IsProbabilityMeasure μ] (ξ : Ω → S) (η : Ω → T)
    (hξ : Measurable ξ) (hη : Measurable η) :
    ∃ κ : Kernel S T, IsMarkovKernel κ ∧
      μ.map (fun ω ↦ (ξ ω, η ω)) = μ.map ξ ⊗ₘ κ ∧
      (∀ κ' : Kernel S T, IsMarkovKernel κ' →
        μ.map (fun ω ↦ (ξ ω, η ω)) = μ.map ξ ⊗ₘ κ' → κ =ᵐ[μ.map ξ] κ') ∧
      ∀ f : S → T → ℝ≥0∞, Measurable (Function.uncurry f) →
        ∀ A : Set S, MeasurableSet A →
          ∫⁻ ω in ξ ⁻¹' A, f (ξ ω) (η ω) ∂μ =
            ∫⁻ ω in ξ ⁻¹' A, ∫⁻ t, f (ξ ω) t ∂κ (ξ ω) ∂μ := by
  sorry

end KallenbergProbability
end Dataset
