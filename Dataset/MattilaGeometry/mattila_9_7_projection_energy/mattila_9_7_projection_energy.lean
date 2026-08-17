import Dataset.MattilaGeometry.Defs

/-!
# `mattila_9_7_projection_energy` — 9.7

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `mattila_9_7_projection_energy.md`.
Quality rubric: `mattila_9_7_projection_energy.criteria.md`.
-/

open MeasureTheory
open scoped ENNReal

namespace Dataset
namespace MattilaGeometry

universe u

/-- Mattila 9.7, the projection-energy theorem. -/
theorem mattila_9_7_projection_energy
    {n m : ℕ}
    (γ : Measure (Grassmannian n m)) (hγ : IsInvariantGrassmannianMeasure γ) :
    ∃ c : ℝ≥0∞, c < ∞ ∧
      ∀ μ : Measure (EuclideanSpace ℝ (Fin n)),
      ∀ _ : IsFiniteMeasureOnCompacts μ, ∀ _ : Measure.InnerRegular μ, μ ≠ 0 → IsCompact μ.support →
      rieszEnergy (m : ℝ) μ < ∞ →
      (∀ᵐ V ∂γ,
        Measure.map (fun x ↦ V.1.orthogonalProjectionOnto x) μ ≪ μH[(m : ℝ)]) ∧
      ∃ density : ∀ V : Grassmannian n m, V.1 → ℝ≥0∞,
        (∀ᵐ V ∂γ, Measure.map (fun x ↦ V.1.orthogonalProjectionOnto x) μ =
          μH[(m : ℝ)].withDensity (density V)) ∧
        ∫⁻ V, ∫⁻ x, density V x ^ (2 : ℝ) ∂μH[(m : ℝ)] ∂γ <
          c * rieszEnergy (m : ℝ) μ := by
  sorry

end MattilaGeometry
end Dataset
