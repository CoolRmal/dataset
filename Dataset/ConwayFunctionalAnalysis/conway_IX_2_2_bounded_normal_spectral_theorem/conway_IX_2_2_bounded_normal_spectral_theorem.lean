import Dataset.ConwayFunctionalAnalysis.Defs

/-!
# `conway_IX_2_2_bounded_normal_spectral_theorem` — IX.2.2

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `conway_IX_2_2_bounded_normal_spectral_theorem.md`.
Quality rubric: `conway_IX_2_2_bounded_normal_spectral_theorem.criteria.md`.
-/

open MeasureTheory

namespace Dataset
namespace ConwayFunctionalAnalysis

universe u

/-- Conway IX.2.2, the spectral theorem for bounded normal operators. -/
theorem conway_IX_2_2_bounded_normal_spectral_theorem
    {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]
    (T : H →L[ℂ] H) (hnormal : IsStarNormal T) :
    ∃! E : ProjectionValuedMeasure H,
      E.toFun (spectrum ℂ T) = ContinuousLinearMap.id ℂ H ∧
      (∃ scalarMeasure : H → H → ComplexMeasure ℂ,
        (∀ x y : H, ∀ B : Set ℂ, MeasurableSet B →
          scalarMeasure x y B = inner ℂ (E.toFun B x) y) ∧
        ∀ x y : H, inner ℂ (T x) y =
          ∫ᵛ z, star z ∂[ContinuousLinearMap.mul ℝ ℂ; scalarMeasure x y]) ∧
      (∀ G : Set ℂ, G.Nonempty →
        (∃ O : Set ℂ, IsOpen O ∧ G = O ∩ spectrum ℂ T) → E.toFun G ≠ 0) ∧
      ∀ A : H →L[ℂ] H,
        (A.comp T = T.comp A ∧ A.comp T.adjoint = T.adjoint.comp A) ↔
          ∀ Δ : Set ℂ, MeasurableSet Δ → A.comp (E.toFun Δ) = (E.toFun Δ).comp A := by
  sorry

end ConwayFunctionalAnalysis
end Dataset
