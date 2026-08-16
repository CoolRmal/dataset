import Dataset.BogachevGaussian.Defs
import Mathlib.Probability.Distributions.Gaussian.Multivariate

/-!
# `bogachev_gaussian_4_2_1_ehrhard_inequality`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `bogachev_gaussian_4_2_1_ehrhard_inequality.md`.
Quality rubric: `bogachev_gaussian_4_2_1_ehrhard_inequality.criteria.md`.
-/

open ProbabilityTheory Set
open scoped Pointwise

namespace Dataset
namespace BogachevGaussian

/-- Bogachev 4.2.1, Ehrhard's inequality: `Φ⁻¹ ∘ γₙ` is concave along Minkowski combinations
of convex sets. -/
theorem bogachev_gaussian_4_2_1_ehrhard_inequality {n : ℕ}
    (A B : Set (EuclideanSpace ℝ (Fin n))) (hA : Convex ℝ A) (hA' : A.Nonempty)
    (hB : Convex ℝ B) (hB' : B.Nonempty) (lam : ℝ) (hlam : lam ∈ Icc (0 : ℝ) 1) :
    letI γ := stdGaussian (EuclideanSpace ℝ (Fin n))
    letI Φinv := quantile (gaussianReal 0 1)
    (lam : EReal) * Φinv (γ A).toReal + (1 - lam : ℝ) * Φinv (γ B).toReal ≤
      Φinv (γ (lam • A + (1 - lam) • B)).toReal := by
  sorry

end BogachevGaussian
end Dataset
