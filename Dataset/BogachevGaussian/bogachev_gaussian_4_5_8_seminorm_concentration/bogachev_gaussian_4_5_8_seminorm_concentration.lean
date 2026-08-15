import Dataset.BogachevGaussian.Defs
import Mathlib.Analysis.LocallyConvex.WithSeminorms
import Mathlib.Analysis.Seminorm

/-!
# `bogachev_gaussian_4_5_8_seminorm_concentration`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `bogachev_gaussian_4_5_8_seminorm_concentration.md`.
Quality rubric: `bogachev_gaussian_4_5_8_seminorm_concentration.criteria.md`.
-/

open MeasureTheory ProbabilityTheory Set
open scoped ENNReal NNReal

namespace Dataset
namespace BogachevGaussian

/-- Bogachev 4.5.8: a measurable seminorm concentrates around its mean at a Gaussian rate
governed by its gauge on the Cameron–Martin unit ball. -/
theorem bogachev_gaussian_4_5_8_seminorm_concentration {E : Type*} [AddCommGroup E] [Module ℝ E] [TopologicalSpace E]
    [IsTopologicalAddGroup E] [ContinuousSMul ℝ E] [LocallyConvexSpace ℝ E]
    [MeasurableSpace E] [BorelSpace E] (γ : Measure E) [IsGaussian γ]
    (f : Seminorm ℝ E) (hf : Measurable f) (c : ℝ) (hc : 0 < c)
    (hgauge : cameronMartinGauge γ f ≤ ENNReal.ofReal c) (t : ℝ) (ht : 0 ≤ t) :
    γ {x | t < |f x - ∫ y, f y ∂γ|} ≤
      2 * ENNReal.ofReal (Real.exp (-(2 * t ^ 2 / (Real.pi ^ 2 * c ^ 2)))) := by
  sorry

end BogachevGaussian
end Dataset
