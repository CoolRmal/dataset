# Context: niven_zuckerman_11_2_divisor_bound

**Statement:** [niven_zuckerman_11_2_divisor_bound.md](niven_zuckerman_11_2_divisor_bound.md) · **Criteria:** [niven_zuckerman_11_2_divisor_bound.criteria.md](niven_zuckerman_11_2_divisor_bound.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## A bound on the divisor function

**$\tau(n)$ counts the positive divisors of $n$** — the number of them, not their sum (that is $\sigma$).

**The bound** $\tau(n) \le 2\sqrt n$ holds for every $n \ge 1$, with the explicit constant $2$ and a
**non-strict** inequality. The comparison happens in $\mathbb{R}$, since $\sqrt n$ is real, so the count
must be cast.

**The proof idea** is the divisor pairing $d \leftrightarrow n/d$ across $\sqrt n$, which is where the
factor $2$ comes from.
