import Dataset.BogachevGaussian.Defs

/-!
# `bogachev_gaussian_2_7_2_feldman_hajek`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `bogachev_gaussian_2_7_2_feldman_hajek.md`.
Quality rubric: `bogachev_gaussian_2_7_2_feldman_hajek.criteria.md`.
-/

open MeasureTheory ProbabilityTheory

namespace Dataset
namespace BogachevGaussian

/-- Bogachev 2.7.2, the Hájek–Feldman dichotomy: two Gaussian measures on one and the same
space are either equivalent or mutually singular. -/
theorem bogachev_gaussian_2_7_2_feldman_hajek {E : Type*} [AddCommGroup E] [Module ℝ E] [TopologicalSpace E]
    [IsTopologicalAddGroup E] [ContinuousSMul ℝ E] [LocallyConvexSpace ℝ E]
    [MeasurableSpace E] [BorelSpace E] (μ ν : Measure E)
    [IsGaussian μ] [IsGaussian ν] : Equivalent μ ν ∨ μ ⟂ₘ ν := by
  sorry

end BogachevGaussian
end Dataset
