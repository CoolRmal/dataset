import Dataset.KrylovHolder.Defs

/-!
# `krylov_3_7_2_constant_coefficient_holder_solvability`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `krylov_3_7_2_constant_coefficient_holder_solvability.md`.
Quality rubric: `krylov_3_7_2_constant_coefficient_holder_solvability.criteria.md`.
-/

open Set

namespace Dataset
namespace KrylovHolder

/-- Krylov 3.7.2, global Holder solvability for constant coefficients. -/
theorem krylov_3_7_2_constant_coefficient_holder_solvability
    {d m k : ℕ} {δ lam : ℝ}
    {L : (EuclideanSpace ℝ (Fin d) → ℝ) → EuclideanSpace ℝ (Fin d) → ℝ}
    (hm : 0 < m) (hδ : 0 < δ ∧ δ < 1) (hlam : 0 < lam)
    (hL : ConstantCoefficientEllipticOperator m L) :
    ∀ f, HolderOn (k + δ) univ f →
      ∃! u, HolderOn (k + m + δ) univ u ∧ ShiftedEllipticEquation L lam u f := by
  sorry

end KrylovHolder
end Dataset
