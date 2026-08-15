module

public import Dataset.BogachevGaussian.Defs
public import Mathlib.Analysis.LocallyConvex.Basic

/-!
# `bogachev_gaussian_4_6_1_correlation_convex_strip`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `bogachev_gaussian_4_6_1_correlation_convex_strip.md`.
Quality rubric: `bogachev_gaussian_4_6_1_correlation_convex_strip.criteria.md`.
-/

@[expose] public section

open MeasureTheory ProbabilityTheory Set
open scoped ENNReal NNReal

namespace Dataset
namespace BogachevGaussian

/-- Bogachev 4.6.1, the Gaussian correlation inequality for an absolutely convex set and a
symmetric strip. -/
theorem bogachev_gaussian_4_6_1_correlation_convex_strip {n : ℕ}
    (γ : Measure (EuclideanSpace ℝ (Fin n))) [IsGaussian γ] (hcentered : ∫ x, x ∂γ = 0)
    (A : Set (EuclideanSpace ℝ (Fin n))) (hA : MeasurableSet A) (hconv : Convex ℝ A)
    (hbal : Balanced ℝ A) (f : EuclideanSpace ℝ (Fin n) →L[ℝ] ℝ) (c : ℝ) :
    γ A * γ {x | |f x| ≤ c} ≤ γ (A ∩ {x | |f x| ≤ c}) := by
  sorry

end BogachevGaussian
end Dataset
