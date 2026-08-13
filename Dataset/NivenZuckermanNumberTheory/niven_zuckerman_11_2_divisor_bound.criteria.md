# Criteria: niven_zuckerman_11_2_divisor_bound

**Statement:** [niven_zuckerman_11_2_divisor_bound.md](niven_zuckerman_11_2_divisor_bound.md) · **Lean:** [niven_zuckerman_11_2_divisor_bound.lean](niven_zuckerman_11_2_divisor_bound.lean)

## What the theorem says

For a positive integer $n$, let $\tau(n)$ count how many positive integers divide $n$. The lemma
says $\tau(n) \le 2\sqrt{n}$. The reason is that divisors come in pairs $d$ and $n/d$, and in each
pair at least one member is at most $\sqrt{n}$, so there are at most $\sqrt n$ small divisors and at
most $\sqrt n$ large ones.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $\tau(n)$ is the *number* of positive divisors of $n$. | ✅ `n.divisors.card`, the size of mathlib's finset of positive divisors. |
| 2 | The hypothesis $n \ge 1$. | ✅ `hn : 1 ≤ n`. |
| 3 | The bound is $2\sqrt n$, with the constant $2$ written out. | ✅ `2 * Real.sqrt n`. |
| 4 | The square root is the real one, so the comparison happens in $\mathbb{R}$ and the divisor count is cast. | ✅ `(n.divisors.card : ℝ) ≤ 2 * Real.sqrt n`. |
| 5 | The inequality is non-strict and holds for every such $n$. | ✅ `≤`, with `n` universally quantified. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Using the *sum* of divisors $\sigma(n)$ instead of the count. | Badly false: $\sigma(n) \ge n$, which outgrows $2\sqrt n$ immediately ($\sigma(6) = 12 > 2\sqrt6$). |
| 2 | Using the number of distinct prime factors, `n.primeFactors.card`. | A different function. It satisfies a far smaller bound, so this states something else. |
| 3 | Replacing $2\sqrt n$ by "there is a constant $C$ with $\tau(n) \le C\sqrt n$". | Strictly weaker. The lemma names the constant $2$, and the constant is what later arguments use. |
| 4 | Weakening to "for all sufficiently large $n$". | The lemma holds for every $n \ge 1$ with no threshold. |
| 5 | Stating the inequality entirely in $\mathbb{N}$, e.g. `n.divisors.card ≤ 2 * Nat.sqrt n`. | `Nat.sqrt` rounds down, so this is a different assertion from the printed one, not a translation of it. Do not treat it as equivalent. |
| 6 | Writing the bound as $2\sqrt{n}$ but comparing `Real.sqrt (n.divisors.card)` or otherwise applying the root to the wrong quantity. | The root belongs to $n$; applying it elsewhere gives an unrelated inequality. |

## Notes on the ground truth

- `Real.sqrt` of a negative number is $0$ in Lean, but its argument here is a cast natural number,
  so that convention can never be reached.
- The hypothesis `1 ≤ n` is there for fidelity to the printed statement, not to keep the Lean claim
  true. Lean sets `Nat.divisors 0 = ∅`, so at $n = 0$ both sides would be $0$ and the inequality
  would still hold — but $0$ is divisible by every positive integer, so its "divisor count" in the
  book's sense is not $0$, and the printed lemma rightly excludes it.
- `n.divisors.card` and `ArithmeticFunction.sigma 0 n` denote the same number; either spelling is
  acceptable.
- The bound is never attained, but the printed relation is `≤`, so a candidate must not silently
  strengthen it to `<`.
