import Mathlib.MeasureTheory.Measure.Haar.NormedSpace
import Mathlib.Topology.MetricSpace.HausdorffDimension

/-!
# `mattila_12_14_falconer_distance_set` — 12.14

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `mattila_12_14_falconer_distance_set.md`.
Quality rubric: `mattila_12_14_falconer_distance_set.criteria.md`.
-/

open MeasureTheory
open scoped ENNReal

namespace Dataset
namespace MattilaGeometry

universe u

/-- Mattila 12.14, Falconer's lower bounds for distance sets. -/
theorem mattila_12_14_falconer_distance_set
    {n : ℕ} (hn : 2 ≤ n) {A : Set (EuclideanSpace ℝ (Fin n))} (hA : MeasurableSet A) :
    let D := {r : ℝ | ∃ x ∈ A, ∃ y ∈ A, r = dist x y}
    ((((n : ℝ≥0∞) + 1) / 2 < dimH A → 0 < volume D) ∧
      (((n : ℝ≥0∞) - 1) / 2 < dimH A ∧ dimH A < ((n : ℝ≥0∞) + 1) / 2 →
        dimH A - ((n : ℝ≥0∞) - 1) / 2 < dimH D)) := by
  sorry

end MattilaGeometry
end Dataset
