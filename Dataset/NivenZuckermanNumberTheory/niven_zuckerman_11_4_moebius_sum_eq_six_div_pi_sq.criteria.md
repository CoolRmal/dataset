# Criteria: niven_zuckerman_11_4_moebius_sum_eq_six_div_pi_sq

**Statement:** [niven_zuckerman_11_4_moebius_sum_eq_six_div_pi_sq.md](niven_zuckerman_11_4_moebius_sum_eq_six_div_pi_sq.md) · **Lean:** [niven_zuckerman_11_4_moebius_sum_eq_six_div_pi_sq.lean](niven_zuckerman_11_4_moebius_sum_eq_six_div_pi_sq.lean)

## What the theorem says

Summing the Möbius function divided by $n^2$ over all positive integers gives exactly $6/\pi^2$.
This is the previous theorem — that this series is the reciprocal of $\sum 1/n^2$ — combined with
Euler's evaluation $\sum 1/n^2 = \pi^2/6$. The number $6/\pi^2 \approx 0.6079$ reappears in
Theorem 11.5 as the density of the square-free integers.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The summand is $\mu(n)/n^2$, with $\mu$ the Möbius function cast from $\mathbb{Z}$ to $\mathbb{R}$. | ✅ `(ArithmeticFunction.moebius n : ℝ) / (n : ℝ) ^ 2`. |
| 2 | The sum runs over $n \ge 1$, with $n = 0$ excluded explicitly. | ✅ `if n = 0 then 0 else …` inside the `∑'`. |
| 3 | The value is exactly $6/\pi^2$ — a named number, not an unspecified constant. | ✅ `= 6 / Real.pi ^ 2`. |
| 4 | The equation is between real numbers. | ✅ Everything is `ℝ`-valued; `Real.pi` is the real $\pi$. |
| 5 | It is $6/\pi^2$, not $\pi^2/6$: the sum is less than $1$. | ✅ `6 / Real.pi ^ 2` in that order. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Stating $\sum 1/n^2 = \pi^2/6$ instead. | That is the Basel problem, an ingredient of the proof and already in mathlib (`basel_sum`). It is not the corollary being asked for. |
| 2 | Writing the conclusion as "there is a constant $c$ with $\sum \mu(n)/n^2 = c$". | Says only that the series converges. The point is the value. |
| 3 | Inverting the value to $\pi^2/6$. | Off by a factor of $(\pi^2/6)^2 \approx 2.7$; the sum is about $0.608$, not $1.645$. |
| 4 | Dropping the `n = 0` guard. | The first term becomes $\mu(0)/0$. Lean's division by zero returns $0$, so the total is unchanged — but the statement then relies on that convention instead of saying the sum starts at $1$. |
| 5 | Replacing $\mu(n)$ by $\lvert\mu(n)\rvert$. | That series equals $\zeta(2)/\zeta(4) = 15/\pi^2$, a different number. |
| 6 | Using an exponent other than $2$. | $\sum \mu(n)/n^s = 1/\zeta(s)$ in general; only $s=2$ gives $6/\pi^2$. |

## Notes on the ground truth

- Mathlib's `∑'` gives a non-summable family the value $0$, and $0 \ne 6/\pi^2$, so the stated
  equation already rules out the degenerate reading. A candidate that also asserts `Summable` is
  more informative and should be accepted.
- This corollary is Theorem 11.3 combined with the Basel evaluation. Both ingredients being
  available in mathlib is fine — a candidate may derive it any way it likes, as long as the
  statement it writes down is the one above.
- Summing over `ℕ+` or over `{n : ℕ // 0 < n}` is an equally faithful way to start at $n = 1$.
