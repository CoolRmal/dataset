module

public import Dataset.BogachevGaussian.Defs
public import Mathlib.MeasureTheory.Measure.Prod

/-!
# `bogachev_gaussian_1_9_3_symmetric_tail_characterization`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `bogachev_gaussian_1_9_3_symmetric_tail_characterization.md`.
Quality rubric: `bogachev_gaussian_1_9_3_symmetric_tail_characterization.criteria.md`.
-/

@[expose] public section

open MeasureTheory ProbabilityTheory Set
open scoped ENNReal NNReal

namespace Dataset
namespace BogachevGaussian

/-- Bogachev 1.9.3: two independent random variables with a common symmetric distribution
whose normalized sum has no heavier tail than a single summand are Gaussian. -/
theorem bogachev_gaussian_1_9_3_symmetric_tail_characterization
    (μ : Measure ℝ) [IsProbabilityMeasure μ] [μ.IsNegInvariant]
    (htail : ∀ t : ℝ, 0 ≤ t →
      (μ.prod μ) {p : ℝ × ℝ | t ≤ |(p.1 + p.2) / √2|} ≤ μ {x : ℝ | t ≤ |x|}) :
    IsGaussian μ := by
  sorry

end BogachevGaussian
end Dataset
