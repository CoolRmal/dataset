module

public import Dataset.KrylovHolder.Defs
public import Mathlib.Analysis.Calculus.ContDiff.Basic
public import Mathlib.Analysis.Calculus.IteratedDeriv.Defs
public import Mathlib.MeasureTheory.Integral.Bochner.Basic
public import Mathlib.MeasureTheory.Measure.Haar.NormedSpace
public import Mathlib.MeasureTheory.Measure.Hausdorff

/-!
# `krylov_2_3_1_green_poisson_representation`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `krylov_2_3_1_green_poisson_representation.md`.
Quality rubric: `krylov_2_3_1_green_poisson_representation.criteria.md`.
-/

@[expose] public section

open Filter Function MeasureTheory Set Topology
open scoped ENNReal Topology

namespace Dataset
namespace KrylovHolder

/-- Krylov 2.3.1, the Green-Poisson representation formula. -/
theorem krylov_2_3_1_green_poisson_representation
    {d : ℕ} {Ω : Set (Fin d → ℝ)}
    {K h G H : (Fin d → ℝ) → (Fin d → ℝ) → ℝ} {f g u : (Fin d → ℝ) → ℝ}
    (hd : 0 < d) (hΩ : RegularBoundedDomain Ω)
    (boundaryMeasure : Measure (Fin d → ℝ))
    (hmeasure : boundaryMeasure = μH[((d : ℝ) - 1)].restrict (frontier Ω))
    (normal : (Fin d → ℝ) → (Fin d → ℝ))
    (hnormal : IsOutwardUnitNormal Ω normal)
    (hharmonic : ∀ x ∈ Ω, HarmonicIn Ω (h x))
    (hboundary : ∀ x ∈ Ω, ∀ y ∈ frontier Ω, h x y = K x y)
    (hgreen : ∀ x y, G x y = K x y - h x y)
    (hgreenHarmonic : ∀ x ∈ Ω, HarmonicIn (Ω \ {x}) (G x))
    (hgreenBoundary : ∀ x ∈ Ω, ∀ y ∈ frontier Ω, G x y = 0)
    (hpoisson : ∀ x ∈ Ω, ∀ y ∈ frontier Ω,
      H x y = -fderiv ℝ (G x) y (normal y))
    (hGintegrable : ∀ x ∈ Ω, IntegrableOn (fun y ↦ G x y * f y) Ω)
    (hHintegrable : ∀ x ∈ Ω, Integrable (fun y ↦ H x y * g y) boundaryMeasure)
    (hu : LaplaceDirichletSolution Ω f g u) :
    ∀ x ∈ Ω, u x = ∫ y in Ω, G x y * f y +
      ∫ y, H x y * g y ∂boundaryMeasure := by
  sorry

end KrylovHolder
end Dataset
