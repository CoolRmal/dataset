import Mathlib.Probability.Process.LocalProperty
import Mathlib.MeasureTheory.Function.ConvergenceInDistribution
import Mathlib.Probability.BrownianMotion.Basic
import Mathlib.Probability.Kernel.Disintegration.StandardBorel
import Mathlib.Topology.MetricSpace.HolderNorm

/-!
# Shared definitions for the KallenbergProbability problems

Custom notions used by the statement files in `Dataset/KallenbergProbability/` that are
not already supplied by Mathlib. Each problem file that needs them imports
this module.
-/

open Filter MeasureTheory ProbabilityTheory Set
open scoped ENNReal NNReal

namespace Dataset
namespace KallenbergProbability

/-- A kernel is finite at almost every parameter value. -/
def IsAEBoundedKernel {S T : Type*} [MeasurableSpace S] [MeasurableSpace T]
    (ν : Measure S) (κ : Kernel S T) : Prop :=
  ∀ᵐ s ∂ν, κ s univ < ∞

/-- A kernel admits one positive measurable function with finite fiber integrals. -/
def IsSigmaFiniteKernel {S T : Type*} [MeasurableSpace S] [MeasurableSpace T]
    (κ : Kernel S T) : Prop :=
  ∃ f : S × T → ℝ≥0∞, Measurable f ∧ (∀ s t, 0 < f (s, t)) ∧
    ∀ s, ∫⁻ t, f (s, t) ∂κ s < ∞

/-- A process is locally Hölder continuous on every closed ball. -/
def IsLocallyHolder {D S : Type*} [PseudoMetricSpace D] [PseudoMetricSpace S]
    [Zero D] (p : ℝ≥0) (x : D → S) : Prop :=
  ∀ R : ℝ, 0 < R → ∃ C : ℝ≥0, HolderOnWith C p x (Metric.closedBall 0 R)

/-- A process is a local martingale when stopped along a localization sequence. -/
def IsLocalMartingale {Ω ι : Type*} [MeasurableSpace Ω] [LinearOrder ι] [Nonempty ι]
    [OrderBot ι] [TopologicalSpace ι] [OrderTopology ι] (X : ι → Ω → ℝ)
    (ℱ : Filtration ι ‹MeasurableSpace Ω›) (μ : Measure Ω) : Prop :=
  Adapted ℱ X ∧ ∃ τ : ℕ → Ω → WithTop ι,
    ProbabilityTheory.IsLocalizingSequence ℱ τ μ ∧
      ∀ n, Martingale (fun t ω ↦ stoppedProcess X (τ n) t ω - X (⊥ : ι) ω) ℱ μ

/-- A process is a local submartingale when stopped along a localization sequence. -/
def IsLocalSubmartingale {Ω ι : Type*} [MeasurableSpace Ω] [LinearOrder ι] [Nonempty ι]
    [OrderBot ι] [TopologicalSpace ι] [OrderTopology ι] (X : ι → Ω → ℝ)
    (ℱ : Filtration ι ‹MeasurableSpace Ω›) (μ : Measure Ω) : Prop :=
  Adapted ℱ X ∧ ∃ τ : ℕ → Ω → WithTop ι,
    ProbabilityTheory.IsLocalizingSequence ℱ τ μ ∧
      ∀ n, Submartingale
        (fun t ω ↦ stoppedProcess X (τ n) t ω - X (⊥ : ι) ω) ℱ μ

/-- Local integrability obtained by stopping along a localization sequence. -/
def IsLocallyIntegrableProcess {Ω ι : Type*} [MeasurableSpace Ω] [LinearOrder ι] [Nonempty ι]
    [TopologicalSpace ι] [OrderTopology ι] (X : ι → Ω → ℝ)
    (ℱ : Filtration ι ‹MeasurableSpace Ω›) (μ : Measure Ω) : Prop :=
  ∃ τ : ℕ → Ω → WithTop ι,
    ProbabilityTheory.IsLocalizingSequence ℱ τ μ ∧
      ∀ n t, Integrable (stoppedProcess X (τ n) t) μ

/-- A stopped value which uses the terminal limit when the stopping time is infinite. -/
def stoppedValueWithLimit {Ω ι E : Type*}
    (X : ι → Ω → E) (terminalValue : Ω → E) (τ : Ω → WithTop ι) : Ω → E :=
  fun ω ↦ (τ ω).recTopCoe (terminalValue ω) fun t ↦ X t ω

/-- A vector Brownian motion has independent one-dimensional Brownian coordinates. -/
def IsBrownianVector {Ω : Type*} [MeasurableSpace Ω] {d : ℕ}
    (B : Ω → C(ℝ≥0, Fin d → ℝ)) (μ : Measure Ω) : Prop :=
  (∀ i, IsBrownianReal (fun t ω ↦ B ω t i) μ) ∧
    ∀ times : Finset ℝ≥0,
      iIndepFun (fun i ω (t : times) ↦ B ω t i) μ

end KallenbergProbability
end Dataset
