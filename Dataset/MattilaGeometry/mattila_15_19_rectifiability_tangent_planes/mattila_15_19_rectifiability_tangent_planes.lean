import Dataset.MattilaGeometry.Defs

/-!
# `mattila_15_19_rectifiability_tangent_planes` — 15.19

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `mattila_15_19_rectifiability_tangent_planes.md`.
Quality rubric: `mattila_15_19_rectifiability_tangent_planes.criteria.md`.
-/

open MeasureTheory
open scoped ENNReal

namespace Dataset
namespace MattilaGeometry

universe u

/-- Mattila 15.19, rectifiability via linear approximation and tangent planes. -/
theorem mattila_15_19_rectifiability_tangent_planes
    {n m : ℕ} (hm : 1 ≤ m) {E : Set (EuclideanSpace ℝ (Fin n))}
    (hEmeas : NullMeasurableSet E μH[(m : ℝ)]) (hEfinite : μH[(m : ℝ)] E < ∞) :
    List.TFAE [RectifiableSet n m E, LinearlyApproximableSet n m E,
      ∀ᵐ a ∂μH[(m : ℝ)].restrict E,
        ∃! V : Grassmannian n m, IsApproximateTangentPlane (m := m) E a V,
      ∀ᵐ a ∂μH[(m : ℝ)].restrict E,
        ∃ V : Grassmannian n m, IsApproximateTangentPlane (m := m) E a V] := by
  sorry

end MattilaGeometry
end Dataset
