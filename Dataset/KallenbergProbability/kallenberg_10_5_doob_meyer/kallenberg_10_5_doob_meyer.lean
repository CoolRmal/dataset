import Dataset.KallenbergProbability.Defs

/-!
# `kallenberg_10_5_doob_meyer`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `kallenberg_10_5_doob_meyer.md`.
Quality rubric: `kallenberg_10_5_doob_meyer.criteria.md`.
-/

open MeasureTheory Set
open scoped NNReal

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
