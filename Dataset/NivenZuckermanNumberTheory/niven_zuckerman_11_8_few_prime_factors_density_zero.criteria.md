# Criteria: niven_zuckerman_11_8_few_prime_factors_density_zero

**Statement:** [niven_zuckerman_11_8_few_prime_factors_density_zero.md](niven_zuckerman_11_8_few_prime_factors_density_zero.md) · **Lean:** [niven_zuckerman_11_8_few_prime_factors_density_zero.lean](niven_zuckerman_11_8_few_prime_factors_density_zero.lean)

The conclusion is that the **asymptotic** density is zero. This book uses **two** densities with confusingly similar notation: the asymptotic density $\delta(A) = \lim A(n)/n$ of Definition 11.1 and the Schnirelmann density $d(A) = \inf_{n\ge1}A(n)/n$ of Definition 11.2, which satisfy $d(A) \le \delta(A)$. Picking the wrong one is the characteristic error in this chapter. The hypothesis bounds the number of *distinct* prime factors, not the number of prime factors with multiplicity — the set of prime powers has one distinct prime factor and is covered.

Legend: ✅ ground truth satisfies the criterion · ⚠️ ground truth acceptable but improvable · ❗ trap — known/likely model error to check in candidate statements.

| # | Category | Criterion / potential error | Assessment of ground truth |
|---|----------|-----------------------------|----------------------------|
| 1 | Semantic closeness / which density | $\delta(A) = 0$ is Definition 11.1's asymptotic density, since §11.3 is titled "Sets of Density Zero" and follows §11.2 on natural density. | ✅ `HasNaturalDensity A 0`. ❗ Highest-value trap: `schnirelmannDensity A = 0`, which is far weaker (it holds as soon as `1 ∉ A`). |
| 2 | Faithful encoding | "Divisible by $k$ or fewer distinct prime factors" is `n.primeFactors.card ≤ k`, counting distinct primes. | ✅ mathlib's `Nat.primeFactors` is a `Finset` of distinct primes. ❗ Predicted error: `Nat.factors.length`, which counts with multiplicity and gives a different (false) hypothesis. |
| 3 | Hypothesis completeness | `k` is a fixed positive integer, quantified before `A`. | ✅ `(k : ℕ) (hk : 1 ≤ k) (A : Set ℕ)` in that order. ❗ Predicted error: allowing `k` to depend on `n`. |
| 4 | Junk values | `Nat.primeFactors 0 = ∅` and `Nat.primeFactors 1 = ∅`, so `0` and `1` satisfy the hypothesis for every `k`; they contribute nothing to the density. | ⚠️ Harmless, but worth noting that the hypothesis does not exclude them. |
