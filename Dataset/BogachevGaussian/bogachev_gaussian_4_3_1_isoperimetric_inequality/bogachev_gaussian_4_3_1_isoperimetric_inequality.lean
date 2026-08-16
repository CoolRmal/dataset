import Dataset.BogachevGaussian.Defs
import Mathlib.Probability.Distributions.Gaussian.Multivariate

/-!
# `bogachev_gaussian_4_3_1_isoperimetric_inequality`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `bogachev_gaussian_4_3_1_isoperimetric_inequality.md`.
Quality rubric: `bogachev_gaussian_4_3_1_isoperimetric_inequality.criteria.md`.
-/

open ProbabilityTheory
open scoped Pointwise

namespace Dataset
namespace BogachevGaussian

/-- Bogachev 4.3.1, the Gaussian isoperimetric inequality: enlarging a set by the ball of
radius `r` increases its Gaussian quantile by at least `r`. -/
theorem bogachev_gaussian_4_3_1_isoperimetric_inequality {n : ℕ}
    (A : Set (EuclideanSpace ℝ (Fin n))) (hA : MeasurableSet A) (r : ℝ) (hr : 0 ≤ r) :
    letI γ := stdGaussian (EuclideanSpace ℝ (Fin n))
    letI Φinv := quantile (gaussianReal 0 1)
    Φinv (γ A).toReal + (r : EReal) ≤
      Φinv (γ (A + Metric.closedBall (0 : EuclideanSpace ℝ (Fin n)) r)).toReal := by
  sorry

end BogachevGaussian
end Dataset
