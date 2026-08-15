# I. Niven and H. S. Zuckerman, *An Introduction to the Theory of Numbers*, Third Edition, Theorem 10.14

- **Source:** I. Niven and H. S. Zuckerman, *An Introduction to the Theory of Numbers*, Third Edition
- **Domain:** Number theory
- **Lean declaration:** `Dataset.NivenZuckermanNumberTheory.niven_zuckerman_10_14_euler_product_prime_power` ([niven_zuckerman_10_14_euler_product_prime_power.lean](niven_zuckerman_10_14_euler_product_prime_power.lean))
- **Criteria:** [niven_zuckerman_10_14_euler_product_prime_power.criteria.md](niven_zuckerman_10_14_euler_product_prime_power.criteria.md)
- **Context:** [niven_zuckerman_10_14_euler_product_prime_power.context.md](niven_zuckerman_10_14_euler_product_prime_power.context.md)

## Statement

**Theorem 10.14.** If $p$ is a prime and $0 \le x < 1$ then

$$\frac{\phi(x^p)}{\phi(x)^p} = 1 + p\sum_{i=1}^{\infty}a_ix^i$$

where the $a_i$ are integers.

**Notation.** Here $\phi(x) = \prod_{n=1}^{\infty}(1-x^n)$ is Euler's product, convergent for $0 \le x < 1$, and $p(n)$ denotes the number of partitions of $n$.
