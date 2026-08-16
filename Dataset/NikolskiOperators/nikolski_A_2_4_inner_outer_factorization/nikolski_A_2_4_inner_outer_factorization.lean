import Dataset.NikolskiOperators.Defs

/-!
# `nikolski_A_2_4_inner_outer_factorization` — 2.4.1

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `nikolski_A_2_4_inner_outer_factorization.md`.
Quality rubric: `nikolski_A_2_4_inner_outer_factorization.criteria.md`.
-/

namespace Dataset
namespace NikolskiOperators

/--
Nikol'ski, *Operators, Functions, and Systems*, Volume 1, Part A, Theorem 2.4.1:
inner-outer factorization in `H²`.
-/
theorem nikolski_A_2_4_inner_outer_factorization
    {f : ℂ → ℂ} (hf : HardyClass 2 f)
    (hnonzero : ∃ z ∈ Metric.ball (0 : ℂ) 1, f z ≠ 0) :
    ∃ θ g : ℂ → ℂ, InnerFunction θ ∧ OuterFunction 2 g ∧
      (∀ z ∈ Metric.ball (0 : ℂ) 1, f z = θ z * g z) ∧
      (∀ θ' g' : ℂ → ℂ, InnerFunction θ' → OuterFunction 2 g' →
        (∀ z ∈ Metric.ball (0 : ℂ) 1, f z = θ' z * g' z) →
          ∃ c : ℂ, ‖c‖ = 1 ∧ ∀ z ∈ Metric.ball (0 : ℂ) 1,
            θ' z = c * θ z ∧ g' z = star c * g z) ∧
      ∀ M : Set (ℂ → ℂ), IsShiftGenerated f M → M = InnerMultiples θ := by
  sorry

end NikolskiOperators
end Dataset
