import Dataset.BogachevGaussian.Defs
import Mathlib.Analysis.LocallyConvex.WithSeminorms
import Mathlib.MeasureTheory.Measure.MutuallySingular

/-!
# `bogachev_gaussian_2_5_2_zero_one_law`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `bogachev_gaussian_2_5_2_zero_one_law.md`.
Quality rubric: `bogachev_gaussian_2_5_2_zero_one_law.criteria.md`.
-/

open MeasureTheory ProbabilityTheory Set
open scoped ENNReal NNReal

namespace Dataset
namespace BogachevGaussian

/-- Bogachev 2.5.2: a measurable set invariant under all Cameron–Martin shifts has measure
`0` or `1`, and a measurable function invariant under all such shifts is a.e. constant. -/
theorem bogachev_gaussian_2_5_2_zero_one_law {E : Type*} [AddCommGroup E] [Module ℝ E] [TopologicalSpace E]
    [IsTopologicalAddGroup E] [ContinuousSMul ℝ E] [LocallyConvexSpace ℝ E]
    [MeasurableSpace E] [BorelSpace E] (γ : Measure E) [IsGaussian γ] :
    (∀ A : Set E, MeasurableSet A → (∀ h ∈ cameronMartinSpace γ, γ ((fun x ↦ x + h) '' A) = γ A) →
        γ A = 0 ∨ γ A = 1) ∧
      ∀ f : E → ℝ, Measurable f →
        (∀ h ∈ cameronMartinSpace γ, ∀ᵐ x ∂γ, f (x + h) = f x) →
        ∃ c : ℝ, ∀ᵐ x ∂γ, f x = c := by
  sorry

end BogachevGaussian
end Dataset
