# Context: niven_zuckerman_10_14_euler_product_prime_power

**Statement:** [niven_zuckerman_10_14_euler_product_prime_power.md](niven_zuckerman_10_14_euler_product_prime_power.md) · **Criteria:** [niven_zuckerman_10_14_euler_product_prime_power.criteria.md](niven_zuckerman_10_14_euler_product_prime_power.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Euler products modulo a prime

**Euler's product and partitions.** $\phi(x) = \prod_{n=1}^{\infty}(1-x^n)$ converges for $0 \le x < 1$,
and $1/\phi(x) = \sum_{n\ge0}p(n)x^n$ is the generating function of the partition function $p(n)$ — the
number of ways of writing $n$ as a sum of positive integers, order irrelevant, with $p(0)=1$. All the
identities in this chapter are identities of **real-valued functions on $[0,1)$**, not formal power series,
so convergence is part of what they assert.

**The identity** $\dfrac{\phi(x^p)}{\phi(x)^p} = 1 + p\sum_{i\ge1}a_ix^i$ with **integer** $a_i$. Read it
carefully: $\phi(x^p)$ on top — the argument is raised to the $p$-th power — and $\phi(x)^p$ on the bottom
— the value is raised to the $p$-th power. The constant term on the right is exactly $1$ and the series
starts at $i = 1$; the explicit factor $p$ in front of the series is the content (it is what makes the
quotient $\equiv 1 \bmod p$ coefficientwise).

**One sequence for all $x$.** The coefficients $a_i$ do not depend on $x$: the existential over the
sequence comes before the quantifier over $x$.

**$p$ is prime**, and $x$ ranges over $[0,1)$ where the product converges.
