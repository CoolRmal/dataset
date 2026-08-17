import Dataset.KrylovHolder.Defs

/-!
# `krylov_4_2_1_better_regular_data_better_regular_solution`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `krylov_4_2_1_better_regular_data_better_regular_solution.md`.
Quality rubric: `krylov_4_2_1_better_regular_data_better_regular_solution.criteria.md`.
-/

open Set
open scoped ENNReal

namespace Dataset
namespace KrylovHolder

/-- Krylov 4.2.1, improved regularity and the high-parameter Schauder estimate. -/
theorem krylov_4_2_1_better_regular_data_better_regular_solution
    {d m k : ℕ} {δ κ K K₁ : ℝ} {a : (Fin d → ℕ) → EuclideanSpace ℝ (Fin d) → ℂ}
    (hm : 2 ≤ m) (hδ : 0 < δ ∧ δ < 1) (hK₁ : 1 ≤ K₁) (ha : UniformlyElliptic m κ a)
    (haK : ∀ α, krylovHolderNorm 0 δ univ (a α) ≤ ENNReal.ofReal K)
    (haK₁ : ∀ α, krylovHolderNorm k δ univ (a α) ≤ ENNReal.ofReal K₁) :
    (∀ (lam : ℝ) (u : EuclideanSpace ℝ (Fin d) → ℂ),
      MemHolderSpace m δ univ u →
        MemHolderSpace k δ univ (lambdaScaledOperator m a lam u) →
          MemHolderSpace (k + m) δ univ u) ∧
      ∃ lam₀ N₀ : ℝ, 0 ≤ lam₀ ∧ 0 < N₀ ∧
        (∀ lam : ℝ, lam₀ ≤ |lam| → ∀ u, MemHolderSpace m δ univ u →
          holderSeminorm m δ univ u +
              ENNReal.ofReal |lam| ^ ((m : ℝ) + δ) * supSeminorm 0 univ u ≤
            ENNReal.ofReal N₀ *
              (holderSeminorm 0 δ univ (lambdaScaledOperator m a lam u) +
                ENNReal.ofReal |lam| ^ δ *
                  supSeminorm 0 univ (lambdaScaledOperator m a lam u))) ∧
        ∃ N : ℝ, 0 < N ∧ ∀ lam : ℝ, lam₀ ≤ |lam| →
          ∀ u, MemHolderSpace (k + m) δ univ u →
            holderSeminorm (k + m) δ univ u +
                ENNReal.ofReal |lam| ^ (((k + m : ℕ) : ℝ) + δ) *
                  supSeminorm 0 univ u ≤
              ENNReal.ofReal N *
                (holderSeminorm k δ univ (lambdaScaledOperator m a lam u) +
                  ENNReal.ofReal |lam| ^ ((k : ℝ) + δ) *
                    supSeminorm 0 univ (lambdaScaledOperator m a lam u)) := by
  sorry

end KrylovHolder
end Dataset
