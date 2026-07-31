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
# `mattila_18_1_besicovitch_federer_projection` — 18.1

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `mattila_18_1_besicovitch_federer_projection.md`.
Quality rubric: `mattila_18_1_besicovitch_federer_projection.criteria.md`.
-/

@[expose] public section

open Filter Function MeasureTheory Metric Set Topology
open scoped ENNReal MeasureTheory NNReal Topology

namespace Dataset
namespace MattilaGeometry

universe u

/-- Mattila 18.1, the Besicovitch--Federer projection theorem. -/
theorem mattila_18_1_besicovitch_federer_projection
    {n m : ℕ} (hm : 0 < m) (hmn : m < n) [MeasurableSpace (Grassmannian n m)]
    (γ : Measure (Grassmannian n m)) (hγ : IsInvariantGrassmannianMeasure γ)
    {A : Set (EuclideanSpace ℝ (Fin n))} (hA : MeasurableSet A) (hAfin : μH[(m : ℝ)] A < ∞) :
    (RectifiableSet n m A ↔ ∀ B : Set (EuclideanSpace ℝ (Fin n)),
      MeasurableSet B → B ⊆ A → 0 < μH[(m : ℝ)] B →
        ∀ᵐ V ∂γ, 0 < μH[(m : ℝ)] ((fun x ↦ V.1.orthogonalProjectionOnto x) '' B)) ∧
      (PurelyUnrectifiableSet n m A ↔
        ∀ᵐ V ∂γ, μH[(m : ℝ)] ((fun x ↦ V.1.orthogonalProjectionOnto x) '' A) = 0) := by
  sorry

end MattilaGeometry
end Dataset
