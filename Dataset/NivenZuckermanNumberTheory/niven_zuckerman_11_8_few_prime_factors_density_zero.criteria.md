# Criteria: niven_zuckerman_11_8_few_prime_factors_density_zero

**Statement:** [niven_zuckerman_11_8_few_prime_factors_density_zero.md](niven_zuckerman_11_8_few_prime_factors_density_zero.md) · **Lean:** [niven_zuckerman_11_8_few_prime_factors_density_zero.lean](niven_zuckerman_11_8_few_prime_factors_density_zero.lean)

## What the theorem says

Fix a positive integer $k$ once and for all. Suppose $A$ is a set of integers with the property that
every member of $A$ has at most $k$ *different* prime divisors — repeats do not count, so $2^{100}$
has just one. The theorem says $A$ is thin: the proportion of the integers up to $n$ that lie in $A$
tends to $0$. Typical integers have about $\log\log n$ distinct prime factors, so any fixed bound
$k$ catches almost nothing.

Be careful: this chapter uses two different densities with similar names. The one meant here is the
asymptotic density $\delta(A) = \lim A(n)/n$ of Definition 11.1, a genuine limit. The Schnirelmann
density $d(A) = \inf_{n\ge1} A(n)/n$ of Definition 11.2 is an infimum and is generally smaller.
Choosing the wrong one is the characteristic error in this chapter.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $k$ is a fixed positive integer chosen before $A$, so the bound is uniform over the set. | ✅ `(k : ℕ) (hk : 1 ≤ k) (A : Set ℕ)` in that order. |
| 2 | $A$ is an arbitrary set of naturals; no finiteness or structure is assumed. | ✅ `(A : Set ℕ)`. |
| 3 | Every element of $A$ has at most $k$ distinct prime factors. | ✅ `hA : ∀ n ∈ A, n.primeFactors.card ≤ k`, and `Nat.primeFactors` is a finset of distinct primes. |
| 4 | The conclusion is that the asymptotic density of $A$ exists and equals $0$. | ✅ `HasNaturalDensity A 0`, i.e. `Tendsto (fun n ↦ (countingFunction A n : ℝ) / n) atTop (𝓝 0)`. |
| 5 | $A(n)$ counts the elements of $A$ in the range $1 \le a \le n$, and the ratio is a real division by $n$. | ✅ `countingFunction` from `Defs.lean`, cast to `ℝ`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Concluding `schnirelmannDensity A = 0` because that is the density mathlib provides. | This is the highest-value trap. Schnirelmann density is an infimum, and mathlib's `schnirelmannDensity_eq_zero_of_one_notMem` shows it is already $0$ for any set missing $1$. The conclusion would then be nearly free and would say almost nothing about how thin $A$ is. |
| 2 | Counting prime factors with multiplicity, e.g. the length of `Nat.primeFactorsList`. | A stronger hypothesis, hence a weaker theorem. The powers of $2$ have one distinct prime factor but unboundedly many with multiplicity, so they would fall outside the hypothesis even though the book covers them. |
| 3 | Letting $k$ depend on the element, e.g. `∀ n ∈ A, ∃ k, n.primeFactors.card ≤ k`. | Every integer satisfies that, so the hypothesis is empty and the conclusion is false: take $A = \mathbb{N}$, whose density is $1$. |
| 4 | Quantifying $k$ after $A$ in a way that lets the choice of $k$ vary, or omitting $k$ entirely. | The bound must be one fixed number for the whole set; that uniformity is what forces the density to vanish. |
| 5 | Concluding only that $A \ne \mathbb{N}$, that $A$ has positive-density complement, or that the density is *at most* some small number. | All far weaker than "the limit exists and is $0$". |
| 6 | Replacing the limit by a `limsup`, or by an inequality $\limsup A(n)/n \le 0$ that is never tied to convergence. | The theorem asserts the limit exists and is $0$; the `limsup` form drops that. |

## Notes on the ground truth

- Mathlib has no asymptotic-density API, so `HasNaturalDensity` and `countingFunction` are defined
  in `Defs.lean` as an explicit `Tendsto`. Writing the limit out by hand is equally acceptable.
- `Nat.primeFactors 0 = ∅` and `Nat.primeFactors 1 = ∅`, so $0$ and $1$ satisfy the hypothesis for
  every $k$. This is harmless: `countingFunction` ignores $0$, and one extra element changes
  $A(n)/n$ by at most $1/n$.
- The hypothesis `1 ≤ k` matches the book's "fixed positive integer" but is not needed for the
  conclusion: with $k = 0$ the set $A$ is contained in $\{0,1\}$, whose density is also $0$.
- Proving the theorem for the largest such set, $\{n : \omega(n) \le k\}$, gives the general case by
  comparison, so a candidate stating it for that specific set rather than for an arbitrary $A$ is
  making an equivalent claim. The printed version quantifies over $A$, so prefer that form.
