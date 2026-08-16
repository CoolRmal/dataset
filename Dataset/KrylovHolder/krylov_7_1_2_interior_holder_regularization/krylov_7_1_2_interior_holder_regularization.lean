import Dataset.KrylovHolder.Defs

/-!
# `krylov_7_1_2_interior_holder_regularization`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `krylov_7_1_2_interior_holder_regularization.md`.
Quality rubric: `krylov_7_1_2_interior_holder_regularization.criteria.md`.
-/

namespace Dataset
namespace KrylovHolder

/-- Krylov 7.1.2, interior Holder regularization. -/
theorem krylov_7_1_2_interior_holder_regularization
    {d m k : ℕ} {δ lam : ℝ} {Ω : Set (EuclideanSpace ℝ (Fin d))}
    {L : (EuclideanSpace ℝ (Fin d) → ℝ) → EuclideanSpace ℝ (Fin d) → ℝ}
    {u f : EuclideanSpace ℝ (Fin d) → ℝ}
    (hδ : 0 < δ ∧ δ < 1) (hΩ : IsOpen Ω)
    (hL : VariableCoefficientEllipticOperator m L)
    (hcoeff : OperatorCoefficientsHolder m (k + δ) L)
    (hu : HolderLocallyOn (m + δ) Ω u)
    (hLu : ShiftedEllipticEquationOn Ω L lam u f) (hf : HolderLocallyOn (k + δ) Ω f) :
    HolderLocallyOn (k + m + δ) Ω u := by
  sorry

end KrylovHolder
end Dataset
