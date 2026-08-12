# I. Niven and H. S. Zuckerman, *An Introduction to the Theory of Numbers*, Third Edition, Theorem 10.15

- **Source:** I. Niven and H. S. Zuckerman, *An Introduction to the Theory of Numbers*, Third Edition
- **Domain:** Number theory
- **Lean declaration:** `Dataset.NivenZuckermanNumberTheory.niven_zuckerman_10_15_mod_five_coefficients` ([niven_zuckerman_10_15_mod_five_coefficients.lean](niven_zuckerman_10_15_mod_five_coefficients.lean))
- **Criteria:** [niven_zuckerman_10_15_mod_five_coefficients.criteria.md](niven_zuckerman_10_15_mod_five_coefficients.criteria.md)

## Statement

**Theorem 10.15.** For $0 \le x < 1$ we have $x\phi(x)^4 = \sum_{m=1}^{\infty}b_mx^m$ where the $b_m$ are integers and $b_m \equiv 0 \pmod 5$ if $m \equiv 0 \pmod 5$.

**Notation.** Here $\phi(x) = \prod_{n=1}^{\infty}(1-x^n)$ is Euler's product, convergent for $0 \le x < 1$, and $p(n)$ denotes the number of partitions of $n$.
