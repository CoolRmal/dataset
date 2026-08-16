import Dataset.NikolskiOperators.Defs

/-!
# `nikolski_B_7_2_1_adamyan_arov_krein` — 7.2.1

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `nikolski_B_7_2_1_adamyan_arov_krein.md`.
Quality rubric: `nikolski_B_7_2_1_adamyan_arov_krein.criteria.md`.
-/

namespace Dataset
namespace NikolskiOperators

/-- Nikol'ski, Part B, Theorem 7.2.1 (Adamyan–Arov–Krein). -/
theorem nikolski_B_7_2_1_adamyan_arov_krein
    {a : ℕ → ℂ} {φ : {z : ℂ // ‖z‖ = 1} → ℂ} {n : ℕ} :
    HasBoundedHankelSymbol a φ →
      hankelApproximationNumber a n = hankelRankApproximationDistance a n ∧
        hankelRankApproximationDistance a n = rationalPlusHInfinityDistance φ n ∧
        rationalPlusHInfinityDistance φ n = finiteBlaschkeHankelDistance φ n := by
  sorry

end NikolskiOperators
end Dataset
