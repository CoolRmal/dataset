# Criteria: niven_zuckerman_11_2_divisor_bound

**Statement:** [niven_zuckerman_11_2_divisor_bound.md](niven_zuckerman_11_2_divisor_bound.md) · **Lean:** [niven_zuckerman_11_2_divisor_bound.lean](niven_zuckerman_11_2_divisor_bound.lean)

A short, sharp inequality: the *number* of divisors, not their sum, bounded by $2\sqrt n$ for every $n \ge 1$. The bound is attained in spirit at $n=1$ ($\tau=1\le2$) and the hypothesis $n \ge 1$ is needed because `Nat.divisors 0 = ∅` would make the statement vacuously true at `0` while the intended reading is that `0` is excluded.

Legend: ✅ ground truth satisfies the criterion · ⚠️ ground truth acceptable but improvable · ❗ trap — known/likely model error to check in candidate statements.

| # | Category | Criterion / potential error | Assessment of ground truth |
|---|----------|-----------------------------|----------------------------|
| 1 | Faithful encoding | $\tau(n)$ is the number of positive divisors, mathlib's `n.divisors.card`, not `σ(n)` and not the number of prime factors. | ✅ `(n.divisors.card : ℝ) ≤ 2 * Real.sqrt n`. ❗ Predicted error: `ArithmeticFunction.sigma 0` unfolded incorrectly, or `n.primeFactors.card`. |
| 2 | Hypothesis completeness | `1 ≤ n` is required; `Nat.divisors 0 = ∅` makes `n = 0` a degenerate case. | ✅ `hn : 1 ≤ n`. |
| 3 | Mathlib conventions | The inequality is between reals, so the divisor count must be cast; `Real.sqrt` is the real square root, junk-free for `n ≥ 0`. | ✅ Both casts explicit. |
| 4 | Junk values | `Real.sqrt` of a negative number is `0`; the argument here is a cast natural, so this cannot bite. | ✅ Safe. |
