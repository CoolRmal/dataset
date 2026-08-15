# Context: niven_zuckerman_11_8_few_prime_factors_density_zero

**Statement:** [niven_zuckerman_11_8_few_prime_factors_density_zero.md](niven_zuckerman_11_8_few_prime_factors_density_zero.md) · **Criteria:** [niven_zuckerman_11_8_few_prime_factors_density_zero.criteria.md](niven_zuckerman_11_8_few_prime_factors_density_zero.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Sets of integers with few prime factors

**Two different densities, both in play in this chapter.**

- The **asymptotic (natural) density** of $A \subseteq \mathbb{N}$ is
  $\delta(A) = \lim_{n\to\infty}A(n)/n$, **when the limit exists**; $A(n)$ counts the elements of $A$ in
  $1 \le a \le n$. Asserting $\delta(A) = c$ therefore asserts both that the limit exists and that it
  equals $c$.
- The **Schnirelmann density** is $d(A) = \inf_{n\ge1}A(n)/n$ — an infimum over *all* $n \ge 1$, which
  always exists and is very sensitive to small $n$ (if $1 \notin A$ then $d(A) = 0$).

They are different numbers and different notions; confusing them changes every statement in which they
appear.

**"Divisible by $k$ or fewer **distinct** prime factors"** counts primes without multiplicity: $2^{100}$
has one distinct prime factor. The bound $k$ is **fixed before $A$**, so it is uniform over the set.

**The conclusion** is that the **asymptotic** density of $A$ exists and equals $0$ — both parts.

**$A$ is arbitrary** beyond the prime-factor condition: no finiteness, no closure properties.
