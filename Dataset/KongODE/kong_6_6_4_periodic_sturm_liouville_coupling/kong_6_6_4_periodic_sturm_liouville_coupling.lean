import Dataset.KongODE.Defs

/-!
# `kong_6_6_4_periodic_sturm_liouville_coupling`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `kong_6_6_4_periodic_sturm_liouville_coupling.md`.
Quality rubric: `kong_6_6_4_periodic_sturm_liouville_coupling.criteria.md`.
-/

open Filter

namespace Dataset
namespace KongODE

/-- Kong 6.6.4, coupling of periodic, Dirichlet, and Neumann spectra. -/
theorem kong_6_6_4_periodic_sturm_liouville_coupling
    {p q w : ℝ → ℝ} {a b : ℝ}
    (hSL : PeriodicSturmLiouvilleData p q w a b) :
    ∃ lam μ ν : ℕ → ℝ, (∀ n, lam n ≤ lam (n + 1)) ∧ Tendsto lam atTop atTop ∧
      ν 0 ≤ lam 0 ∧
      (∀ n, lam (2 * n) < μ (2 * n) ∧ lam (2 * n) < ν (2 * n + 1) ∧
        μ (2 * n) < lam (2 * n + 1) ∧ ν (2 * n + 1) < lam (2 * n + 1) ∧
        lam (2 * n + 1) ≤ μ (2 * n + 1) ∧ lam (2 * n + 1) ≤ ν (2 * n + 2) ∧
        μ (2 * n + 1) ≤ lam (2 * n + 2) ∧ ν (2 * n + 2) ≤ lam (2 * n + 2)) ∧
      (∀ eigVal, (∃ y, IsSturmLiouvilleEigenfunction p q w a b eigVal
        (periodicBoundary p a b) y) ↔ ∃ n, lam n = eigVal) ∧
      (∀ eigVal, (∃ y, IsSturmLiouvilleEigenfunction p q w a b eigVal
        (dirichletBoundary a b) y) ↔ ∃ n, μ n = eigVal) ∧
      (∀ eigVal, (∃ y, IsSturmLiouvilleEigenfunction p q w a b eigVal
        (neumannBoundary a b) y) ↔ ∃ n, ν n = eigVal) ∧
      (∀ y, IsSturmLiouvilleEigenfunction p q w a b (lam 0)
        (periodicBoundary p a b) y → {x ∈ Set.Icc a b | y x = 0} = ∅) ∧
      (∀ y₁ y₂, IsSturmLiouvilleEigenfunction p q w a b (lam 0)
        (periodicBoundary p a b) y₁ →
        IsSturmLiouvilleEigenfunction p q w a b (lam 0)
          (periodicBoundary p a b) y₂ →
          ∃ c : ℝ, Set.EqOn y₂ (c • y₁) (Set.Icc a b)) ∧
      (∀ n, (∃ i j, lam n = μ i ∧ lam n = ν j) ↔
        ∃ y₁ y₂, IsSturmLiouvilleEigenfunction p q w a b (lam n)
          (periodicBoundary p a b) y₁ ∧
          IsSturmLiouvilleEigenfunction p q w a b (lam n)
            (periodicBoundary p a b) y₂ ∧
          ¬∃ c : ℝ, Set.EqOn y₂ (c • y₁) (Set.Icc a b)) ∧
      ∀ n, (∀ y, IsSturmLiouvilleEigenfunction p q w a b (lam (2 * n + 1))
        (periodicBoundary p a b) y →
          {x ∈ Set.Ico a b | y x = 0}.ncard = 2 * n + 2) ∧
        ∀ y, IsSturmLiouvilleEigenfunction p q w a b (lam (2 * n + 2))
          (periodicBoundary p a b) y →
            {x ∈ Set.Ico a b | y x = 0}.ncard = 2 * n + 2 := by
  sorry

end KongODE
end Dataset
