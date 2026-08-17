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
    {d m k : ℕ} {δ lam : ℝ} {a : (Fin d → ℕ) → ℂ}
    (hm : 2 ≤ m) (hδ : 0 < δ ∧ δ < 1) (hlam : lam ≠ 0) (ha : IsElliptic m a) :
    ∀ f : EuclideanSpace ℝ (Fin d) → ℂ, MemHolderSpace k δ univ f →
      ∃! u, MemHolderSpace (k + m) δ univ u ∧
        ∀ x, lambdaScaledOperator m (fun α _ ↦ a α) lam u x = f x := by
  sorry

end KrylovHolder
end Dataset
