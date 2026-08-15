import Dataset.MattilaGeometry.Defs
import Mathlib.Analysis.InnerProductSpace.Projection.Submodule
import Mathlib.MeasureTheory.Measure.Hausdorff
import Mathlib.MeasureTheory.Measure.Decomposition.Lebesgue
import Mathlib.MeasureTheory.Measure.Haar.NormedSpace
import Mathlib.MeasureTheory.Measure.Regular
import Mathlib.MeasureTheory.Measure.Support
import Mathlib.Topology.MetricSpace.HausdorffDimension
import Mathlib.Tactic.TFAE

/-!
# `mattila_18_1_besicovitch_federer_projection` — 18.1

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `mattila_18_1_besicovitch_federer_projection.md`.
Quality rubric: `mattila_18_1_besicovitch_federer_projection.criteria.md`.
-/

open Filter Function MeasureTheory Metric Set Topology
open scoped ENNReal MeasureTheory NNReal Topology

namespace Dataset
namespace MattilaGeometry

universe u

/-- Mattila 18.1, the Besicovitch--Federer projection theorem. -/
theorem mattila_18_1_besicovitch_federer_projection
    {n m : ℕ} (hm : 0 < m) (hmn : m < n)
    (γ : Measure (Grassmannian n m)) (hγ : IsInvariantGrassmannianMeasure γ)
    {A : Set (EuclideanSpace ℝ (Fin n))} (hA : NullMeasurableSet A μH[(m : ℝ)]) (hAfin : μH[(m : ℝ)] A < ∞) :
    (RectifiableSet n m A ↔ ∀ B : Set (EuclideanSpace ℝ (Fin n)),
      MeasurableSet B → B ⊆ A → 0 < μH[(m : ℝ)] B →
        ∀ᵐ V ∂γ, 0 < μH[(m : ℝ)] ((fun x ↦ V.1.orthogonalProjectionOnto x) '' B)) ∧
      (PurelyUnrectifiableSet n m A ↔
        ∀ᵐ V ∂γ, μH[(m : ℝ)] ((fun x ↦ V.1.orthogonalProjectionOnto x) '' A) = 0) := by
  sorry

end MattilaGeometry
end Dataset
