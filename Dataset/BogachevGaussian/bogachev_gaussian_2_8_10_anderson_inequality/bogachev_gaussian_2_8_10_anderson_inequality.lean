import Dataset.BogachevGaussian.Defs
import Mathlib.Analysis.LocallyConvex.WithSeminorms
import Mathlib.Analysis.LocallyConvex.Basic

/-!
# `bogachev_gaussian_2_8_10_anderson_inequality`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `bogachev_gaussian_2_8_10_anderson_inequality.md`.
Quality rubric: `bogachev_gaussian_2_8_10_anderson_inequality.criteria.md`.
-/

open MeasureTheory ProbabilityTheory Set
open scoped ENNReal NNReal

namespace Dataset
namespace BogachevGaussian

/-- Bogachev 2.8.10, Anderson's inequality: for a centered Gaussian measure the measure of a
translate of an absolutely convex set is largest at the centre, and decreases monotonically
along the translation. -/
theorem bogachev_gaussian_2_8_10_anderson_inequality {E : Type*} [AddCommGroup E] [Module ℝ E] [TopologicalSpace E]
    [IsTopologicalAddGroup E] [ContinuousSMul ℝ E] [LocallyConvexSpace ℝ E]
    [MeasurableSpace E] [BorelSpace E] (γ : Measure E) [IsGaussian γ]
    (hcentered : ∀ f : StrongDual ℝ E, γ[f] = 0) (A : Set E) (hA : MeasurableSet A) (hconv : Convex ℝ A)
    (hbal : Balanced ℝ A) (a : E) :
    γ ((fun x ↦ x + a) '' A) ≤ γ A ∧
      ∀ t ∈ Icc (0 : ℝ) 1, γ ((fun x ↦ x + a) '' A) ≤ γ ((fun x ↦ x + t • a) '' A) := by
  sorry

end BogachevGaussian
end Dataset
