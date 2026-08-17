import Dataset.MattilaGeometry.Defs

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
    ((((n : ℝ≥0∞) + 1) / 2 < dimH A → 0 < volume (distanceSet A)) ∧
      (((n : ℝ≥0∞) - 1) / 2 ≤ dimH A ∧ dimH A ≤ ((n : ℝ≥0∞) + 1) / 2 →
        dimH A - ((n : ℝ≥0∞) - 1) / 2 ≤ dimH (distanceSet A))) := by
  sorry

end MattilaGeometry
end Dataset
