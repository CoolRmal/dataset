import Mathlib.Analysis.InnerProductSpace.Projection.Submodule
import Mathlib.MeasureTheory.Measure.Hausdorff
import Mathlib.MeasureTheory.Measure.Decomposition.Lebesgue
import Mathlib.MeasureTheory.Measure.Haar.NormedSpace
import Mathlib.MeasureTheory.Measure.Regular
import Mathlib.MeasureTheory.Measure.Support
import Mathlib.Topology.MetricSpace.HausdorffDimension
import Mathlib.Tactic.TFAE

/-!
# `mattila_14_10_marstrand_density_integer` — 14.10

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `mattila_14_10_marstrand_density_integer.md`.
Quality rubric: `mattila_14_10_marstrand_density_integer.criteria.md`.
-/

open Filter Function MeasureTheory Metric Set Topology
open scoped ENNReal MeasureTheory NNReal Topology

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
    ∃ m : ℕ, s = m := by
  sorry

end MattilaGeometry
end Dataset
