# Criteria: niven_5_3_log_two_pow_five_pow_irrational

**Statement:** [niven_5_3_log_two_pow_five_pow_irrational.md](niven_5_3_log_two_pow_five_pow_irrational.md) · **Lean:** [niven_5_3_log_two_pow_five_pow_irrational.lean](niven_5_3_log_two_pow_five_pow_irrational.lean)

The hypothesis is that $c$ and $d$ are **different**: $\log(2^c5^d)$ is rational precisely when $c = d$, since then the argument is $10^c$. Dropping `c ≠ d` makes the statement false, and it is the only hypothesis, so it is the whole trap.

Legend: ✅ ground truth satisfies the criterion · ⚠️ ground truth acceptable but improvable · ❗ trap — known/likely model error to check in candidate statements.

| # | Category | Criterion / potential error | Assessment of ground truth |
|---|----------|-----------------------------|----------------------------|
| 1 | Hypothesis completeness | `c ≠ d` is essential: at `c = d` the number is `log₁₀(10^c) = c`, a rational. | ✅ `hcd : c ≠ d`. ❗ Highest-value trap. |
| 2 | Faithful encoding / base | All logarithms in the book are base `10`; mathlib's `Real.log` is natural, so `Real.logb 10` is required. | ✅ `Real.logb 10 (2 ^ c * 5 ^ d)`. ❗ Predicted error: `Real.log`, which gives a different (also irrational, but unrelated) number. |
| 3 | Faithful encoding | `c` and `d` range over non-negative integers, including `0`. | ✅ `c d : ℕ`. |
| 4 | Junk values | `Real.logb b x` is junk for `x ≤ 0`; here the argument `2^c · 5^d` is positive. | ✅ Safe. |
