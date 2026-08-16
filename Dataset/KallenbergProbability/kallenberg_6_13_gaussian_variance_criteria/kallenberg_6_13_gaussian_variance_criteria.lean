import Mathlib.MeasureTheory.Function.ConvergenceInDistribution
import Mathlib.Probability.BrownianMotion.Basic

/-!
# `kallenberg_6_13_gaussian_variance_criteria`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `kallenberg_6_13_gaussian_variance_criteria.md`.
Quality rubric: `kallenberg_6_13_gaussian_variance_criteria.criteria.md`.
-/

open Filter MeasureTheory ProbabilityTheory
open scoped Topology ENNReal

namespace Dataset
namespace KallenbergProbability

/-- Kallenberg 6.13, the Lindeberg--Feller Gaussian variance criterion. -/
theorem kallenberg_6_13_gaussian_variance_criteria
    {Ω Ω' : Type*} [MeasurableSpace Ω] [MeasurableSpace Ω']
    (μ : Measure Ω) (μ' : Measure Ω') [IsProbabilityMeasure μ]
    [IsProbabilityMeasure μ'] (k : ℕ → ℕ)
    (ξ : (n : ℕ) → Fin (k n) → Ω → ℝ) (hk : ∀ n, 0 < k n) (ζ : Ω' → ℝ)
    (hξmeas : ∀ n j, AEMeasurable (ξ n j) μ)
    (hξsq : ∀ n j, MemLp (ξ n j) 2 μ)
    (hcentered : ∀ n j, ∫ ω, ξ n j ω ∂μ = 0)
    (hindep : ∀ n, iIndepFun (ξ n) μ)
    (hvariance : Tendsto (fun n ↦ ∑ j, variance (ξ n j) μ) atTop (𝓝 1))
    (hζ : HasLaw ζ (gaussianReal 0 1) μ') :
    let sumConverges := TendstoInDistribution (fun n ω ↦ ∑ j, ξ n j ω) atTop ζ
      (fun _ ↦ μ) μ'
    let maximalVarianceVanishes := Tendsto
      (fun n ↦ Finset.univ.sup' (Finset.univ_nonempty_iff.mpr ⟨⟨0, hk n⟩⟩)
        fun j ↦ variance (ξ n j) μ) atTop (𝓝 0)
    -- truncated second moments as lower Lebesgue integrals: the integrand is non-negative and
    -- may a priori be non-integrable, where a Bochner integral would silently return 0
    let lindeberg := ∀ ε : ℝ, 0 < ε → Tendsto
      (fun n ↦ ∑ j, ∫⁻ ω, ENNReal.ofReal ((ξ n j ω) ^ 2) *
        Set.indicator {x : ℝ | ε < |x|} (fun _ ↦ (1 : ℝ≥0∞)) (ξ n j ω) ∂μ) atTop (𝓝 0)
    (sumConverges ∧ maximalVarianceVanishes) ↔ lindeberg := by
  sorry

end KallenbergProbability
end Dataset
