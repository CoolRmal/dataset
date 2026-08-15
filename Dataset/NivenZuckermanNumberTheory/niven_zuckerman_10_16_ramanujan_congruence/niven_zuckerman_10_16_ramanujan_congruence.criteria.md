# Criteria: niven_zuckerman_10_16_ramanujan_congruence

**Statement:** [niven_zuckerman_10_16_ramanujan_congruence.md](niven_zuckerman_10_16_ramanujan_congruence.md) · **Lean:** [niven_zuckerman_10_16_ramanujan_congruence.lean](niven_zuckerman_10_16_ramanujan_congruence.lean) · **Context:** [niven_zuckerman_10_16_ramanujan_congruence.context.md](niven_zuckerman_10_16_ramanujan_congruence.context.md)

## What the theorem says

Let $p(n)$ be the number of ways of writing $n$ as a sum of positive integers, where the order of
the summands does not matter. Ramanujan's congruence says that whenever $n$ leaves remainder $4$ on
division by $5$, the number $p(n)$ is divisible by $5$. The first case is $p(4) = 5$, then
$p(9) = 30$, $p(14) = 135$, and so on forever. The statement is short but the result is deep; it is
the payoff of Theorems 10.14 and 10.15.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. In the assessment column, ✅ means the ground truth states the requirement and
◐ means it states it in a form that deliberately departs from the text — a narrower setting, a
stronger hypothesis, or an equivalent but not literal phrasing — with the reason given. A ◐ records
a decision, not an open defect; where a more literal rendering would be at least as good, the row
says so.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $p(n)$ is the number of partitions of $n$ — all partitions, with repeats allowed among the parts. | ✅ `partitionCount n`, defined in `Defs.lean` as `Nat.card (Nat.Partition n)`, mathlib's type of partitions of `n`. |
| 2 | The claim is about the arithmetic progression $5m+4$. | ✅ `partitionCount (5 * m + 4)`. |
| 3 | The conclusion is divisibility by $5$. | ✅ `… % 5 = 0`. |
| 4 | It holds for every natural number $m$, with no side condition — including $m = 0$, the case $p(4) = 5$. | ✅ `(m : ℕ)` is a bare universally quantified variable. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Adding a hypothesis such as `1 ≤ m` or `0 < m`. | Drops the very first instance, $p(4) = 5$, which the book's statement includes. |
| 2 | Shifting the residue: $p(5m)$, $p(5m+1)$, $p(5m+2)$ or $p(5m+3)$. | All false. For example $p(5) = 7$ and $p(6) = 11$, neither divisible by $5$. |
| 3 | Counting partitions into *distinct* parts, or into odd parts, instead of all partitions. | A different counting function. The congruence is specific to the unrestricted partition function. |
| 4 | Using a factorisation-flavoured function such as `Nat.factorization` or the divisor count in place of $p(n)$. | Not the partition function at all; the resulting claim is unrelated and false. |
| 5 | Defining a home-made partition count as `Nat.card` of a set that is not finite — for instance sequences of parts that may include zeros, or lists rather than multisets up to reordering. | Lean's `Nat.card` returns $0$ for an infinite type, and $5$ divides $0$, so the statement would hold for free without saying anything. |
| 6 | Stating the congruence for one fixed $m$ instead of all $m$. | A single numeric instance, not the theorem. |

## Notes on the ground truth

- Mathlib supplies `Fintype (Nat.Partition n)` for every `n`, so `Nat.card (Nat.Partition n)` is a
  genuine finite count and never the $0$ that `Nat.card` returns on infinite types.
- `partitionCount` is a thin wrapper we added in `Defs.lean` purely so the statement reads like the
  book. A candidate writing `Nat.card (Nat.Partition (5 * m + 4))` directly is equally good.
- `% 5 = 0` on naturals is one of several equally faithful spellings; `Nat.ModEq 5 _ 0`,
  `5 ∣ partitionCount (5 * m + 4)`, and the same divisibility cast into `ℤ` should all be accepted.
- The letter $p$ is overloaded in this chapter: a prime in Theorem 10.14, the partition function
  here. Only the partition function occurs in this statement.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[niven_zuckerman_10_16_ramanujan_congruence.md](niven_zuckerman_10_16_ramanujan_congruence.md) and the background in [niven_zuckerman_10_16_ramanujan_congruence.context.md](niven_zuckerman_10_16_ramanujan_congruence.context.md),
not against the ground-truth Lean file: a candidate spelled differently but
mathematically equivalent to the text loses nothing. The scale is defined in
[GRADING.md](../../GRADING.md); the numbers below are this problem's instance of it.

| Band | Points | This problem |
|---|---|---|
| A. Completeness | 50 | The requirement table above has 4 rows, so each row is worth 12.5 points: full credit if the candidate states it in any equivalent form, half for a harmless strengthening or weakening, none if it is absent. |
| B. Semantic fidelity | 20 | Junk values, `ℝ` vs `ℝ≥0∞`, coercions, quantifier order, a.e. vs everywhere — see the pitfalls below. |
| C. Mathlib-concept correctness | 15 | The Mathlib notion must mean the textbook notion, with the typeclass assumptions it needs. |
| D. Non-degeneracy | 10 | Not vacuous, not trivial, not a strictly weaker theorem. |
| E. Hygiene | 5 | No needless definitions, redundant conjuncts or unused hypotheses. |

**Every row of the *Mistakes to check for* table above is a defect.** Charge each one to the band it belongs to and deduct there.

### Fatal — any of these caps the total at 25

- Requirement 1 with a partition-counting function that orders the parts (compositions) rather than partitions.
- Requirement 2 with a progression other than $5m+4$.
- Requirement 4 with $m = 0$ excluded.

### Domain-specific pitfalls for this problem

- Partitions are unordered; counting ordered sums gives compositions and a different function.
- $p(0) = 1$ by convention, and the progression starts at $n = 4$.
- The congruence holds for every $m$, with no positivity hypothesis.
