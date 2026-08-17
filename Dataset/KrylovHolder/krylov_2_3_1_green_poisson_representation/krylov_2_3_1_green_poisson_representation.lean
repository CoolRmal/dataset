import Dataset.KrylovHolder.Defs

/-!
# `krylov_2_3_1_green_poisson_representation`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `krylov_2_3_1_green_poisson_representation.md`.
Quality rubric: `krylov_2_3_1_green_poisson_representation.criteria.md`.
-/

open MeasureTheory

namespace Dataset
namespace KrylovHolder

/-- Krylov 2.3.1, the Green-Poisson representation formula. -/
theorem krylov_2_3_1_green_poisson_representation
    {d : ℕ} {Ω : Set (EuclideanSpace ℝ (Fin d))}
    {K h G H : EuclideanSpace ℝ (Fin d) → EuclideanSpace ℝ (Fin d) → ℝ}
    {f g u : EuclideanSpace ℝ (Fin d) → ℝ}
    (hd : 0 < d) (hΩsmooth : SmoothBoundedDomain Ω)
    (hK : IsLaplaceFundamentalSolution K)
    (boundaryMeasure : Measure (EuclideanSpace ℝ (Fin d)))
    (hmeasure : boundaryMeasure = μH[((d : ℝ) - 1)].restrict (frontier Ω))
    (normal : EuclideanSpace ℝ (Fin d) → EuclideanSpace ℝ (Fin d))
    (hnormal : IsOutwardUnitNormal Ω normal)
    (hharmonic : ∀ x ∈ Ω, HarmonicIn Ω (h x))
    (hcorrectorContinuous : ∀ x ∈ Ω, ContinuousOn (h x) (closure Ω))
    (hboundary : ∀ x ∈ Ω, ∀ y ∈ frontier Ω, h x y = K x y)
    (hgreen : ∀ x y, G x y = K x y - h x y)
    (hgreenHarmonic : ∀ x ∈ Ω, HarmonicIn (Ω \ {x}) (G x))
    (hgreenBoundary : ∀ x ∈ Ω, ∀ y ∈ frontier Ω, G x y = 0)
    (hpoisson : ∀ x ∈ Ω, ∀ y ∈ frontier Ω,
      H x y = -fderivWithin ℝ (G x) (closure Ω) y (normal y))
    (hGintegrable : ∀ x ∈ Ω, IntegrableOn (fun y ↦ G x y * f y) Ω)
    (hHintegrable : ∀ x ∈ Ω, Integrable (fun y ↦ H x y * g y) boundaryMeasure)
    (hu : LaplaceDirichletSolution Ω f g u) :
    ∀ x ∈ Ω, u x = (∫ y in Ω, G x y * f y) +
      ∫ y, H x y * g y ∂boundaryMeasure := by
  sorry

end KrylovHolder
end Dataset
