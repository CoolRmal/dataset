import Dataset.KongODE.Defs

open Set

/-!
# `kong_2_5_3_floquet_theorem`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `kong_2_5_3_floquet_theorem.md`.
Quality rubric: `kong_2_5_3_floquet_theorem.criteria.md`.
-/

namespace Dataset
namespace KongODE

/-- Kong 2.5.3, Floquet's theorem. -/
theorem kong_2_5_3_floquet_theorem
    {n : ℕ} {ω : ℝ} {A : ℝ → Matrix (Fin n) (Fin n) ℝ}
    {X : ℝ → Matrix (Fin n) (Fin n) ℝ}
    (hω : 0 < ω) (hper : PeriodicLinearEquation ω A)
    (hA : Continuous A) (hX : FundamentalMatrixSolution univ A X) :
    ∃ R : Matrix (Fin n) (Fin n) ℂ, ∃ P : ℝ → Matrix (Fin n) (Fin n) ℂ,
      (∀ i j, ContDiff ℝ 1 fun t ↦ P t i j) ∧ (∀ t, P (t + ω) = P t) ∧
        (∀ t, IsUnit (P t)) ∧
          ∀ t, (X t).map (algebraMap ℝ ℂ) = P t * NormedSpace.exp (t • R) := by
  sorry

end KongODE
end Dataset
