# I. Niven and H. S. Zuckerman, *An Introduction to the Theory of Numbers*, Third Edition, Theorem 11.8 (sets of density zero)

- **Source:** I. Niven and H. S. Zuckerman, *An Introduction to the Theory of Numbers*, Third Edition
- **Domain:** Number theory
- **Lean declaration:** `Dataset.NivenZuckermanNumberTheory.niven_zuckerman_11_8_few_prime_factors_density_zero` ([niven_zuckerman_11_8_few_prime_factors_density_zero.lean](niven_zuckerman_11_8_few_prime_factors_density_zero.lean))
- **Criteria:** [niven_zuckerman_11_8_few_prime_factors_density_zero.criteria.md](niven_zuckerman_11_8_few_prime_factors_density_zero.criteria.md)

## Statement

**Theorem 11.8.** Let $k$ be a fixed positive integer. If each integer in a set $A$ is divisible by $k$ or fewer distinct prime factors, then $\delta(A) = 0$.

**Notation.** **Definition 11.1.** If $A$ is a set of positive integers and $A(n)$ denotes the number of elements of $A$ not exceeding $n$, the *asymptotic* (or natural) density of $A$ is $\delta(A) = \lim_{n\to\infty} A(n)/n$ when the limit exists. **Definition 11.2.** The *Schnirelmann density* $d(A)$ of a set $A$ of non-negative integers is $d(A) = \inf_{n\ge1} A(n)/n$. **Definition 11.3.** Assume $0 \in A$ and $0 \in B$. The sum $A + B$ is the collection of all integers of the form $a + b$ where $a \in A$ and $b \in B$.
