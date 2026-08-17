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
    {d m k : ℕ} {δ κ K lam : ℝ} {Ω : Set (EuclideanSpace ℝ (Fin d))}
    {a : (Fin d → ℕ) → EuclideanSpace ℝ (Fin d) → ℂ}
    {u : EuclideanSpace ℝ (Fin d) → ℂ}
    (hm : 2 ≤ m) (hδ : 0 < δ ∧ δ < 1) (hΩ : IsOpen Ω)
    (ha : UniformlyElliptic m κ a)
    (haK : ∀ α, krylovHolderNorm k δ Set.univ (a α) ≤ ENNReal.ofReal K)
    (hu : MemHolderSpace m δ Ω u)
    (hLu : MemHolderSpace k δ Ω (lambdaScaledOperator m a lam u)) :
    MemHolderSpaceLoc (k + m) δ Ω u := by
  sorry

end KrylovHolder
end Dataset
