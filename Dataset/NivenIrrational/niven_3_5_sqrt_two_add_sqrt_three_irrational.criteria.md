# Criteria: niven_3_5_sqrt_two_add_sqrt_three_irrational

**Statement:** [niven_3_5_sqrt_two_add_sqrt_three_irrational.md](niven_3_5_sqrt_two_add_sqrt_three_irrational.md) · **Lean:** [niven_3_5_sqrt_two_add_sqrt_three_irrational.lean](niven_3_5_sqrt_two_add_sqrt_three_irrational.lean)

A single clean irrationality claim. What makes it more than a warm-up is that neither summand's irrationality implies the sum's — the standard proof squares twice and uses the rational root theorem — so a candidate that reduces it to `Irrational (√2)` plus a closure lemma has not proved the theorem.

Legend: ✅ ground truth satisfies the criterion · ⚠️ ground truth acceptable but improvable · ❗ trap — known/likely model error to check in candidate statements.

| # | Category | Criterion / potential error | Assessment of ground truth |
|---|----------|-----------------------------|----------------------------|
| 1 | Semantic closeness | The sum of two irrationals need not be irrational (`√2 + (-√2)`), so this cannot follow from irrationality of the summands alone. | ✅ Stated directly about the sum. ❗ Predicted error: assuming an `Irrational.add` lemma that does not exist. |
| 2 | Mathlib conventions | `Irrational` is mathlib's predicate `x ∉ Set.range ((↑) : ℚ → ℝ)`. | ✅ Reused rather than re-defined. |
| 3 | Faithful encoding | `Real.sqrt 2 + Real.sqrt 3`, with mathlib's `Real.sqrt`, which is junk-free for non-negative arguments. | ✅ As written. |
| 4 | Conclusion completeness | The claim is irrationality, not algebraicity or degree. | ✅ Exactly `Irrational`. |
