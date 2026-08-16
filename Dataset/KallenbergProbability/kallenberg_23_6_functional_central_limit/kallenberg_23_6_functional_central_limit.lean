import Dataset.KallenbergProbability.Defs
import Mathlib.MeasureTheory.Function.ConvergenceInDistribution
import Mathlib.Order.Filter.AtTopBot.Basic

/-!
# `kallenberg_23_6_functional_central_limit`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `kallenberg_23_6_functional_central_limit.md`.
Quality rubric: `kallenberg_23_6_functional_central_limit.criteria.md`.
-/

open MeasureTheory ProbabilityTheory Filter
open scoped NNReal

namespace Dataset
namespace KallenbergProbability

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
