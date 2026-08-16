import Dataset.NikolskiOperators.Defs

/-!
# `nikolski_A_3_7_blaschke_zero_sets` — 3.7.1

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `nikolski_A_3_7_blaschke_zero_sets.md`.
Quality rubric: `nikolski_A_3_7_blaschke_zero_sets.criteria.md`.
-/

open scoped ENNReal

namespace Dataset
namespace NikolskiOperators

/--
Nikol'ski, *Operators, Functions, and Systems*, Volume 1, Part A, Section 3.7:
the zero sets of nontrivial Hardy-class functions are precisely Blaschke
sequences in the disk.
-/
theorem nikolski_A_3_7_blaschke_zero_sets
    {p : ℝ≥0∞} {a : ℕ → ℂ} (hp : p ≠ 0) :
    (∃ f : ℂ → ℂ, HardyClass p f ∧
      (∃ z ∈ Metric.ball (0 : ℂ) 1, f z ≠ 0) ∧ HasZeroSequence f a) ↔
      BlaschkeCondition a := by
  sorry

end NikolskiOperators
end Dataset
