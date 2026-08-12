# Criteria: niven_6_2_unique_nearest_integer

**Statement:** [niven_6_2_unique_nearest_integer.md](niven_6_2_unique_nearest_integer.md) · **Lean:** [niven_6_2_unique_nearest_integer.lean](niven_6_2_unique_nearest_integer.lean)

The content is **uniqueness**, and irrationality is exactly what supplies it: at $\alpha = n+\tfrac12$ two integers are equally close, and that is the only obstruction. A candidate that states only existence has dropped the theorem.

Legend: ✅ ground truth satisfies the criterion · ⚠️ ground truth acceptable but improvable · ❗ trap — known/likely model error to check in candidate statements.

| # | Category | Criterion / potential error | Assessment of ground truth |
|---|----------|-----------------------------|----------------------------|
| 1 | Conclusion completeness | `∃!`, not `∃`. Existence alone holds for every real. | ✅ `∃! m : ℤ, …`. ❗ Highest-value trap. |
| 2 | Hypothesis completeness | Irrationality is needed only to break the tie at half-integers; it is the book's hypothesis. | ✅ `ha : Irrational a`. ⚠️ The weaker `a - ⌊a⌋ ≠ 1/2` would suffice, so the statement is not sharp — but it is what the book says. |
| 3 | Faithful encoding | The bounds are **strict** on both sides: `-1/2 < α - m < 1/2`. | ✅ Both strict. ❗ Predicted error: a half-open interval, which would destroy uniqueness at half-integers even though the hypothesis excludes them. |
| 4 | Mathlib conventions | `m : ℤ` cast into `ℝ`; mathlib's `round` gives the witness but the statement should not mention it. | ✅ Stated without reference to `round`. |
