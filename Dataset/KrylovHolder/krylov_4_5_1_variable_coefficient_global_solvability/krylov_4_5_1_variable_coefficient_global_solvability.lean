import Dataset.KrylovHolder.Defs

/-!
# `krylov_4_5_1_variable_coefficient_global_solvability`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `krylov_4_5_1_variable_coefficient_global_solvability.md`.
Quality rubric: `krylov_4_5_1_variable_coefficient_global_solvability.criteria.md`.
-/

open Set

namespace Dataset
namespace KrylovHolder

/-- Krylov 4.5.1, global solvability for variable coefficients. -/
theorem krylov_4_5_1_variable_coefficient_global_solvability
    {d m k : ℕ} {δ κ K : ℝ} {a : (Fin d → ℕ) → EuclideanSpace ℝ (Fin d) → ℂ}
    (hm : 2 ≤ m) (hδ : 0 < δ ∧ δ < 1) (ha : UniformlyElliptic m κ a)
    (haK : ∀ α, krylovHolderNorm 0 δ univ (a α) ≤ ENNReal.ofReal K)
    (hareg : ∀ α, MemHolderSpace k δ univ (a α)) :
    ∃ lam₀ N₀ : ℝ, 0 ≤ lam₀ ∧ 0 < N₀ ∧
      (∀ lam : ℝ, lam₀ ≤ |lam| → ∀ u, MemHolderSpace m δ univ u →
        holderSeminorm m δ univ u +
            ENNReal.ofReal |lam| ^ ((m : ℝ) + δ) * supSeminorm 0 univ u ≤
          ENNReal.ofReal N₀ *
            (holderSeminorm 0 δ univ (lambdaScaledOperator m a lam u) +
              ENNReal.ofReal |lam| ^ δ *
                supSeminorm 0 univ (lambdaScaledOperator m a lam u))) ∧
      ∀ lam : ℝ, lam₀ ≤ |lam| → ∀ f, MemHolderSpace k δ univ f →
        ∃! u, MemHolderSpace (k + m) δ univ u ∧
          ∀ x, lambdaScaledOperator m a lam u x = f x := by
  sorry

end KrylovHolder
end Dataset
