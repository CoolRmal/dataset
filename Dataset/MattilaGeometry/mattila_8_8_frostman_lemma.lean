module

public import Dataset.MattilaGeometry.Defs
public import Mathlib.Analysis.InnerProductSpace.Projection.Submodule
public import Mathlib.MeasureTheory.Measure.Hausdorff
public import Mathlib.MeasureTheory.Measure.Decomposition.Lebesgue
public import Mathlib.MeasureTheory.Measure.Haar.NormedSpace
public import Mathlib.MeasureTheory.Measure.Regular
public import Mathlib.MeasureTheory.Measure.Support
public import Mathlib.Topology.MetricSpace.HausdorffDimension
public import Mathlib.Tactic.TFAE

/-!
# `mattila_8_8_frostman_lemma` — 8.8

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `mattila_8_8_frostman_lemma.md`.
Quality rubric: `mattila_8_8_frostman_lemma.criteria.md`.
-/

@[expose] public section

open Filter Function MeasureTheory Metric Set Topology
open scoped ENNReal MeasureTheory NNReal Topology

namespace Dataset
namespace MattilaGeometry

universe u

/-- Mattila 8.8, Frostman's lemma. -/
theorem mattila_8_8_frostman_lemma
    {n : ℕ} :
    ∃ c : ℝ≥0∞, 0 < c ∧ c < ∞ ∧
      ∀ (s : ℝ) (B : Set (EuclideanSpace ℝ (Fin n))),
        0 < s → MeasurableSet B →
          (0 < μH[s] B ↔ ∃ μ : Measure (EuclideanSpace ℝ (Fin n)),
            IsFiniteMeasure μ ∧ IsFiniteMeasureOnCompacts μ ∧ Measure.InnerRegular μ ∧
              μ ≠ 0 ∧ IsCompact μ.support ∧ μ.support ⊆ B ∧
              ∀ x : EuclideanSpace ℝ (Fin n), ∀ r : ℝ, 0 < r →
                μ (closedBall x r) < ENNReal.ofReal (r ^ s)) ∧
          (0 < μH[s] B → ∃ μ : Measure (EuclideanSpace ℝ (Fin n)),
            IsFiniteMeasure μ ∧ IsFiniteMeasureOnCompacts μ ∧ Measure.InnerRegular μ ∧
              μ ≠ 0 ∧ IsCompact μ.support ∧ μ.support ⊆ B ∧
              (∀ x : EuclideanSpace ℝ (Fin n), ∀ r : ℝ, 0 < r →
                μ (closedBall x r) < ENNReal.ofReal (r ^ s)) ∧
              c * hausdorffContent s B < μ B) := by
  sorry

end MattilaGeometry
end Dataset
