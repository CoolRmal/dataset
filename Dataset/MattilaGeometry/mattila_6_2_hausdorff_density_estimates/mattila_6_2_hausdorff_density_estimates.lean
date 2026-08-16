import Dataset.MattilaGeometry.Defs

/-!
# `mattila_6_2_hausdorff_density_estimates` — 6.2

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `mattila_6_2_hausdorff_density_estimates.md`.
Quality rubric: `mattila_6_2_hausdorff_density_estimates.criteria.md`.
-/

open MeasureTheory
open scoped ENNReal

namespace Dataset
namespace MattilaGeometry

universe u

/-- Mattila 6.2, upper Hausdorff-density estimates. -/
theorem mattila_6_2_hausdorff_density_estimates
    {n : ℕ} {s : ℝ} {A : Set (EuclideanSpace ℝ (Fin n))} (hs : 0 < s)
    (hA : μH[s] A < ∞) :
    (∀ᵐ x ∂μH[s], x ∈ A →
      ENNReal.ofReal (2 ^ (-s)) ≤ upperHausdorffDensity s A x ∧
        upperHausdorffDensity s A x ≤ 1) ∧
      (NullMeasurableSet A μH[s] → ∀ᵐ x ∂μH[s], x ∉ A → upperHausdorffDensity s A x = 0) := by
  sorry

end MattilaGeometry
end Dataset
