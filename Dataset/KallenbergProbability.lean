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
# Hard probability statements from Kallenberg

Ten statement-only formalizations selected from Olav Kallenberg,
*Foundations of Modern Probability*, third edition.
-/

open Filter MeasureTheory ProbabilityTheory Set Topology

open scoped ENNReal MeasureTheory NNReal ProbabilityTheory Topology

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

/-- A sequence of stopping times increases to infinity almost surely. -/
def LocalizesToInfinity {Ω ι : Type*} [MeasurableSpace Ω] [LinearOrder ι]
    [TopologicalSpace ι] [OrderTopology ι] (τ : ℕ → Ω → WithTop ι)
    (μ : Measure Ω) : Prop :=
  (∀ n, τ n ≤ τ (n + 1)) ∧ ∀ᵐ ω ∂μ, Tendsto (fun n ↦ τ n ω) atTop atTop

/-- A process is a local martingale when stopped along a localization sequence. -/
def IsLocalMartingale {Ω ι : Type*} [MeasurableSpace Ω] [LinearOrder ι] [Nonempty ι]
    [OrderBot ι] [TopologicalSpace ι] [OrderTopology ι] (X : ι → Ω → ℝ)
    (ℱ : Filtration ι ‹MeasurableSpace Ω›) (μ : Measure Ω) : Prop :=
  ∃ τ : ℕ → Ω → WithTop ι,
    (∀ n, IsStoppingTime ℱ (τ n)) ∧ LocalizesToInfinity τ μ ∧
      ∀ n, Martingale (fun t ω ↦ stoppedProcess X (τ n) t ω - X (⊥ : ι) ω) ℱ μ

/-- A process is a local submartingale when stopped along a localization sequence. -/
def IsLocalSubmartingale {Ω ι : Type*} [MeasurableSpace Ω] [LinearOrder ι] [Nonempty ι]
    [OrderBot ι] [TopologicalSpace ι] [OrderTopology ι] (X : ι → Ω → ℝ)
    (ℱ : Filtration ι ‹MeasurableSpace Ω›) (μ : Measure Ω) : Prop :=
  ∃ τ : ℕ → Ω → WithTop ι,
    (∀ n, IsStoppingTime ℱ (τ n)) ∧ LocalizesToInfinity τ μ ∧
      ∀ n, Submartingale
        (fun t ω ↦ stoppedProcess X (τ n) t ω - X (⊥ : ι) ω) ℱ μ

/-- Local integrability obtained by stopping along a localization sequence. -/
def IsLocallyIntegrableProcess {Ω ι : Type*} [MeasurableSpace Ω] [LinearOrder ι] [Nonempty ι]
    [TopologicalSpace ι] [OrderTopology ι] (X : ι → Ω → ℝ)
    (ℱ : Filtration ι ‹MeasurableSpace Ω›) (μ : Measure Ω) : Prop :=
  ∃ τ : ℕ → Ω → WithTop ι,
    (∀ n, IsStoppingTime ℱ (τ n)) ∧ LocalizesToInfinity τ μ ∧
      ∀ n t, Integrable (stoppedProcess X (τ n) t) μ

/-- A vector Brownian motion has independent one-dimensional Brownian coordinates. -/
def IsBrownianVector {Ω : Type*} [MeasurableSpace Ω] {d : ℕ}
    (B : Ω → C(ℝ≥0, Fin d → ℝ)) (μ : Measure Ω) : Prop :=
  (∀ i, IsBrownianReal (fun t ω ↦ B ω t i) μ) ∧
    ∀ times : Finset ℝ≥0,
      iIndepFun (fun i ω (t : times) ↦ B ω t i) μ

/-- Kallenberg 3.4, disintegration of a sigma-finite measure. -/
theorem kallenberg_3_4_disintegration
    {S T : Type*} [MeasurableSpace S] [MeasurableSpace T] [StandardBorelSpace T]
    (ρ : Measure (S × T)) [SigmaFinite ρ] :
    (∃ (ν : Measure S) (κ : Kernel S T), SigmaFinite ν ∧ IsSFiniteKernel κ ∧
      IsSigmaFiniteKernel κ ∧ ν ≪ ρ.fst ∧ ρ.fst ≪ ν ∧ ν ⊗ₘ κ = ρ) ∧
    (∀ (ν ν' : Measure S) (κ κ' : Kernel S T),
      SigmaFinite ν → IsSFiniteKernel κ → IsSigmaFiniteKernel κ →
      ν ≪ ρ.fst → ρ.fst ≪ ν → ν ⊗ₘ κ = ρ →
      SigmaFinite ν' → IsSFiniteKernel κ' → IsSigmaFiniteKernel κ' →
      ν' ≪ ρ.fst → ρ.fst ≪ ν' → ν' ⊗ₘ κ' = ρ →
      ∃ c : S → ℝ≥0∞, Measurable c ∧ ν' = ν.withDensity c ∧
        ∀ᵐ s ∂ν, κ s = c s • κ' s) ∧
    ((∃ (ν : Measure S) (κ : Kernel S T), SigmaFinite ν ∧ IsSFiniteKernel κ ∧
      IsSigmaFiniteKernel κ ∧ ν ≪ ρ.fst ∧ ρ.fst ≪ ν ∧ ν ⊗ₘ κ = ρ ∧
      IsAEBoundedKernel ν κ) ↔ SigmaFinite ρ.fst) ∧
    (SigmaFinite ρ.fst → ∃ κ : Kernel S T, IsMarkovKernel κ ∧ ρ.fst ⊗ₘ κ = ρ) := by
  sorry

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

/-- Kallenberg 5.25, the portmanteau theorem. -/
theorem kallenberg_5_25_portmanteau
    {Ω Ω' S : Type*} [MeasurableSpace Ω] [MeasurableSpace Ω']
    [MetricSpace S] [MeasurableSpace S] [BorelSpace S]
    (μ : Measure Ω) (μ' : Measure Ω') [IsProbabilityMeasure μ]
    [IsProbabilityMeasure μ'] (ξn : ℕ → Ω → S) (ξ : Ω' → S)
    (hξn : ∀ n, AEMeasurable (ξn n) μ) (hξ : AEMeasurable ξ μ') :
    let lawsConverge := TendstoInDistribution ξn atTop ξ (fun _ ↦ μ) μ'
    let openLowerBound := ∀ G : Set S, IsOpen G →
      μ' (ξ ⁻¹' G) ≤ liminf (fun n ↦ μ (ξn n ⁻¹' G)) atTop
    let closedUpperBound := ∀ F : Set S, IsClosed F →
      limsup (fun n ↦ μ (ξn n ⁻¹' F)) atTop ≤ μ' (ξ ⁻¹' F)
    let continuitySets := ∀ B : Set S, MeasurableSet B → μ' (ξ ⁻¹' frontier B) = 0 →
      Tendsto (fun n ↦ μ (ξn n ⁻¹' B)) atTop (𝓝 (μ' (ξ ⁻¹' B)))
    List.TFAE [lawsConverge, openLowerBound, closedUpperBound, continuitySets] := by
  sorry

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

/-- Kallenberg 10.5, the Doob--Meyer decomposition. -/
theorem kallenberg_10_5_doob_meyer
    {Ω : Type*} [MeasurableSpace Ω] (μ : Measure Ω) [IsProbabilityMeasure μ]
    (ℱ : Filtration ℝ≥0 ‹MeasurableSpace Ω›) [ℱ.IsRightContinuous]
    (X : ℝ≥0 → Ω → ℝ) (hX : Adapted ℱ X)
    (hXright : ∀ᵐ ω ∂μ, ∀ t,
      ContinuousWithinAt (fun s ↦ X s ω) (Ici t) t) :
    IsLocalSubmartingale X ℱ μ ↔
      ∃ M A : ℝ≥0 → Ω → ℝ,
        (∀ t, X t =ᵐ[μ] M t + A t) ∧ IsLocalMartingale M ℱ μ ∧
        IsLocallyIntegrableProcess A ℱ μ ∧ IsStronglyPredictable ℱ A ∧
        (∀ᵐ ω ∂μ, Monotone fun t ↦ A t ω) ∧
        (∀ᵐ ω ∂μ, ∀ t, ContinuousWithinAt (fun s ↦ A s ω) (Ici t) t) ∧
        A 0 =ᵐ[μ] 0 ∧
        ∀ M' A' : ℝ≥0 → Ω → ℝ,
          (∀ t, X t =ᵐ[μ] M' t + A' t) → IsLocalMartingale M' ℱ μ →
          IsLocallyIntegrableProcess A' ℱ μ → IsStronglyPredictable ℱ A' →
          (∀ᵐ ω ∂μ, Monotone fun t ↦ A' t ω) →
          (∀ᵐ ω ∂μ, ∀ t, ContinuousWithinAt (fun s ↦ A' s ω) (Ici t) t) →
          A' 0 =ᵐ[μ] 0 → (∀ t, M t =ᵐ[μ] M' t) ∧ ∀ t, A t =ᵐ[μ] A' t := by
  sorry

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

/-- Kallenberg 23.6, Donsker's functional central limit theorem. -/
theorem kallenberg_23_6_functional_central_limit
    {Ω Ω' : Type*} [MeasurableSpace Ω] [MeasurableSpace Ω'] {d : ℕ}
    [MeasurableSpace C(ℝ≥0, Fin d → ℝ)] [BorelSpace C(ℝ≥0, Fin d → ℝ)]
    (μ : Measure Ω) (μ' : Measure Ω') [IsProbabilityMeasure μ]
    [IsProbabilityMeasure μ'] (ξ : ℕ → Ω → (Fin d → ℝ))
    (X : ℕ → Ω → C(ℝ≥0, Fin d → ℝ)) (B : Ω' → C(ℝ≥0, Fin d → ℝ))
    (hξmeas : ∀ n, AEMeasurable (ξ n) μ)
    (hiid : iIndepFun ξ μ ∧ ∀ n, IdentDistrib (ξ n) (ξ 0) μ μ)
    (hsecondMoment : ∀ i, MemLp (fun ω ↦ ξ 0 ω i) 2 μ)
    (hmean : ∀ i, ∫ ω, ξ 0 ω i ∂μ = 0)
    (hcovariance : ∀ i j, ∫ ω, ξ 0 ω i * ξ 0 ω j ∂μ = if i = j then 1 else 0)
    (hX : ∀ n, 0 < n → ∀ ω t i,
      X n ω t i = (Real.sqrt (n : ℝ))⁻¹ *
        ((∑ k ∈ Finset.Icc 1 ⌊(n : ℝ) * (t : ℝ)⌋₊, ξ k ω i) +
          ((n : ℝ) * (t : ℝ) - ⌊(n : ℝ) * (t : ℝ)⌋₊) *
            ξ (⌊(n : ℝ) * (t : ℝ)⌋₊ + 1) ω i))
    (hXmeas : ∀ n, AEMeasurable (X n) μ)
    (hB : IsBrownianVector B μ') :
    TendstoInDistribution X atTop B (fun _ ↦ μ) μ' := by
  sorry

end KallenbergProbability
end Dataset
