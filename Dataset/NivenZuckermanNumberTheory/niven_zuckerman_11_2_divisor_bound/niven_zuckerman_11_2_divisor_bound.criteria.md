# Criteria: niven_zuckerman_11_2_divisor_bound

**Statement:** [niven_zuckerman_11_2_divisor_bound.md](niven_zuckerman_11_2_divisor_bound.md) · **Lean:** [niven_zuckerman_11_2_divisor_bound.lean](niven_zuckerman_11_2_divisor_bound.lean) · **Context:** [niven_zuckerman_11_2_divisor_bound.context.md](niven_zuckerman_11_2_divisor_bound.context.md)

## What the theorem says

For a positive integer $n$, let $\tau(n)$ count how many positive integers divide $n$. The lemma
says $\tau(n) \le 2\sqrt{n}$. The reason is that divisors come in pairs $d$ and $n/d$, and in each
pair at least one member is at most $\sqrt{n}$, so there are at most $\sqrt n$ small divisors and at
most $\sqrt n$ large ones.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

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

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[niven_zuckerman_11_2_divisor_bound.md](niven_zuckerman_11_2_divisor_bound.md) and the background in [niven_zuckerman_11_2_divisor_bound.context.md](niven_zuckerman_11_2_divisor_bound.context.md),
not against the ground-truth Lean file: a candidate spelled differently but
mathematically equivalent to the text loses nothing. The scale is defined in
[GRADING.md](../../GRADING.md); the numbers below are this problem's instance of it.

| Band | Points | This problem |
|---|---|---|
| A. Completeness | 50 | The requirement table above has 5 rows, so each row is worth 10.0 points: full credit if the candidate states it in any equivalent form, half for a harmless strengthening or weakening, none if it is absent. |
| B. Semantic fidelity | 20 | Junk values, `ℝ` vs `ℝ≥0∞`, coercions, quantifier order, a.e. vs everywhere — see the pitfalls below. |
| C. Mathlib-concept correctness | 15 | The Mathlib notion must mean the textbook notion, with the typeclass assumptions it needs. |
| D. Non-degeneracy | 10 | Not vacuous, not trivial, not a strictly weaker theorem. |
| E. Hygiene | 5 | No needless definitions, redundant conjuncts or unused hypotheses. |

**Every row of the *Mistakes to check for* table above is a defect.** Charge each one to the band it belongs to and deduct there.

### Fatal — any of these caps the total at 25

- Requirement 1 with the sum of divisors instead of their count.
- Requirement 3 with a constant other than $2$.

### Domain-specific pitfalls for this problem

- $\tau$ is the count of divisors; $\sigma$ is their sum.
- The inequality is between a natural number cast to $\mathbb{R}$ and $2\sqrt n$.
- The hypothesis is $n \ge 1$; at $n = 0$ the divisor set is conventionally different.
- The inequality is non-strict.
