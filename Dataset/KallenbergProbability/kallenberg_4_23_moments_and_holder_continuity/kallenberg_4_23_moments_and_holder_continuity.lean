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
# `kallenberg_4_23_moments_and_holder_continuity`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `kallenberg_4_23_moments_and_holder_continuity.md`.
Quality rubric: `kallenberg_4_23_moments_and_holder_continuity.criteria.md`.
-/

@[expose] public section

open Filter MeasureTheory ProbabilityTheory Set Topology
open scoped ENNReal MeasureTheory NNReal ProbabilityTheory Topology

namespace Dataset
namespace KallenbergProbability

/-- Kallenberg 4.23, the Kolmogorov--Loeve--Chentsov continuity theorem. -/
theorem kallenberg_4_23_moments_and_holder_continuity
    {Ω S : Type*} [MeasurableSpace Ω] [MetricSpace S] [MeasurableSpace S]
    [BorelSpace S] [CompleteSpace S]
    {d : ℕ} (μ : Measure Ω) [IsProbabilityMeasure μ]
    (X : (Fin d → ℝ) → Ω → S) (hX : ∀ t, AEMeasurable (X t) μ)
    {a b : ℝ} (ha : 0 < a) (hb : 0 < b)
    (hmoment : ∃ C : ℝ, 0 ≤ C ∧ ∀ s t,
      ∫⁻ ω, ENNReal.ofReal ((dist (X s ω) (X t ω)) ^ a) ∂μ ≤
        ENNReal.ofReal (C * ‖s - t‖ ^ ((d : ℝ) + b))) :
    ∃ Y : (Fin d → ℝ) → Ω → S,
      (∀ t, X t =ᵐ[μ] Y t) ∧
        ∀ p : ℝ, ∀ hp : p ∈ Ioo 0 (b / a),
          ∀ᵐ ω ∂μ, IsLocallyHolder ⟨p, hp.1.le⟩ (fun t ↦ Y t ω) := by
  sorry

end KallenbergProbability
end Dataset
