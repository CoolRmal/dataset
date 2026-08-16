import Mathlib.MeasureTheory.Measure.Haar.NormedSpace

/-!
# `mattila_14_10_marstrand_density_integer` — 14.10

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `mattila_14_10_marstrand_density_integer.md`.
Quality rubric: `mattila_14_10_marstrand_density_integer.criteria.md`.
-/

open Filter MeasureTheory Metric
open scoped ENNReal Topology

namespace Dataset
namespace MattilaGeometry

universe u

/-- Mattila 14.10, Marstrand's density theorem. -/
theorem mattila_14_10_marstrand_density_integer
    {n : ℕ} {s : ℝ} {μ : Measure (EuclideanSpace ℝ (Fin n))}
    (hs : 0 < s) (hμ : IsFiniteMeasureOnCompacts μ ∧ Measure.InnerRegular μ)
    (hdensity : ∃ E : Set (EuclideanSpace ℝ (Fin n)), 0 < μ E ∧ ∀ x ∈ E,
      ∃ θ : ℝ≥0∞, 0 < θ ∧ θ < ∞ ∧
        Tendsto (fun r : ℝ ↦ μ (closedBall x r) / ENNReal.ofReal ((2 * r) ^ s))
          (𝓝[>] 0) (𝓝 θ)) :
    ∃ m : ℤ, s = m := by
  sorry

end MattilaGeometry
end Dataset
