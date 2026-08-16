import Dataset.MattilaGeometry.Defs

/-!
# `mattila_18_1_besicovitch_federer_projection` — 18.1

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `mattila_18_1_besicovitch_federer_projection.md`.
Quality rubric: `mattila_18_1_besicovitch_federer_projection.criteria.md`.
-/

open MeasureTheory
open scoped ENNReal

namespace Dataset
namespace MattilaGeometry

universe u

/-- Mattila 18.1, the Besicovitch--Federer projection theorem. -/
theorem mattila_18_1_besicovitch_federer_projection
    {n m : ℕ}
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
