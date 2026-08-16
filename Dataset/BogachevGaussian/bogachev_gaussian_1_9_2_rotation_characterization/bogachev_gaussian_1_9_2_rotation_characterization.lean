import Dataset.BogachevGaussian.Defs

/-!
# `bogachev_gaussian_1_9_2_rotation_characterization`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `bogachev_gaussian_1_9_2_rotation_characterization.md`.
Quality rubric: `bogachev_gaussian_1_9_2_rotation_characterization.criteria.md`.
-/

open MeasureTheory ProbabilityTheory

namespace Dataset
namespace BogachevGaussian

/-- Bogachev 1.9.2: a random vector in `ℝⁿ` is centered Gaussian exactly when every
rotation of a pair of independent copies of it is again a pair of independent copies. -/
theorem bogachev_gaussian_1_9_2_rotation_characterization {n : ℕ}
    (μ : Measure (EuclideanSpace ℝ (Fin n))) [IsProbabilityMeasure μ] :
    (IsGaussian μ ∧ ∫ x, x ∂μ = 0) ↔
      ∀ φ : ℝ, (μ.prod μ).map
          (fun p ↦ (Real.sin φ • p.1 + Real.cos φ • p.2,
            Real.cos φ • p.1 - Real.sin φ • p.2)) = μ.prod μ := by
  sorry

end BogachevGaussian
end Dataset
