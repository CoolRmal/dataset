import Dataset.KrylovHolder.Defs

/-!
# `krylov_2_3_1_green_poisson_representation`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `krylov_2_3_1_green_poisson_representation.md`.
Quality rubric: `krylov_2_3_1_green_poisson_representation.criteria.md`.
-/

open InnerProductSpace Laplacian MeasureTheory

namespace Dataset
namespace KrylovHolder

/-- Krylov 2.3.1, the Green-Poisson representation formula. -/
theorem krylov_2_3_1_green_poisson_representation
    {d : ℕ} {Ω : Set (EuclideanSpace ℝ (Fin d))}
    {K h G H : EuclideanSpace ℝ (Fin d) → EuclideanSpace ℝ (Fin d) → ℝ}
    {f g u : EuclideanSpace ℝ (Fin d) → ℝ}
    (hd : 0 < d) (hK : IsLaplaceFundamentalSolution K)
    (boundaryMeasure : Measure (EuclideanSpace ℝ (Fin d)))
    (hmeasure : boundaryMeasure = μH[((d : ℝ) - 1)].restrict (frontier Ω))
    (normal : EuclideanSpace ℝ (Fin d) → EuclideanSpace ℝ (Fin d))
    (hnormal : IsOutwardUnitNormal Ω normal)
    (hΩ : GreensIdentityDomain Ω boundaryMeasure normal)
    (hcorrector : ∀ x ∈ Ω, ContDiffOn ℝ 2 (h x) (closure Ω))
    (hharmonic : ∀ x ∈ Ω, ∀ y ∈ Ω, Δ (h x) y = 0)
    (hboundary : ∀ x ∈ Ω, ∀ y ∈ frontier Ω, h x y = K x y)
    (hgreen : ∀ x y, G x y = K x y - h x y)
    (hgreenHarmonic : ∀ x ∈ Ω, HarmonicOnNhd (G x) (Ω \ {x}))
    (hgreenBoundary : ∀ x ∈ Ω, ∀ y ∈ frontier Ω, G x y = 0)
    (hpoisson : ∀ x ∈ Ω, ∀ y ∈ frontier Ω,
      H x y = fderivWithin ℝ (G x) (closure Ω) y (normal y))
    (hGintegrable : ∀ x ∈ Ω, IntegrableOn (fun y ↦ G x y * f y) Ω)
    (hHintegrable : ∀ x ∈ Ω, Integrable (fun y ↦ H x y * g y) boundaryMeasure)
    (huSmooth : ContDiffOn ℝ 2 u (closure Ω))
    (huEquation : ∀ x ∈ Ω, Δ u x = f x)
    (huBoundary : ∀ x ∈ frontier Ω, u x = g x) :
    ∀ x ∈ Ω, u x = (∫ y in Ω, G x y * f y) +
      ∫ y, H x y * g y ∂boundaryMeasure := by
  sorry

end KrylovHolder
end Dataset
