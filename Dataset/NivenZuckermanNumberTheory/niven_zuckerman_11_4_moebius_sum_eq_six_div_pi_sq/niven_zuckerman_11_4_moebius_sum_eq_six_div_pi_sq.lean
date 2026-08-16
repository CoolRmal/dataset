import Dataset.NivenZuckermanNumberTheory.Defs
import Mathlib.NumberTheory.ArithmeticFunction.Moebius

/-!
# `niven_zuckerman_11_4_moebius_sum_eq_six_div_pi_sq`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `niven_zuckerman_11_4_moebius_sum_eq_six_div_pi_sq.md`.
Quality rubric: `niven_zuckerman_11_4_moebius_sum_eq_six_div_pi_sq.criteria.md`.
-/

namespace Dataset
namespace NivenZuckermanNumberTheory

/-- Niven–Zuckerman, Corollary 11.4: `∑ μ(n)/n² = 6/π²`. -/
theorem niven_zuckerman_11_4_moebius_sum_eq_six_div_pi_sq :
    (∑' n : ℕ, (ArithmeticFunction.moebius n : ℝ) / n ^ 2) = 6 / Real.pi ^ 2 := by
  sorry

end NivenZuckermanNumberTheory
end Dataset
