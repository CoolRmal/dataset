# Criteria: niven_2_4_rational_iff_periodic_decimal

**Statement:** [niven_2_4_rational_iff_periodic_decimal.md](niven_2_4_rational_iff_periodic_decimal.md) · **Lean:** [niven_2_4_rational_iff_periodic_decimal.lean](niven_2_4_rational_iff_periodic_decimal.lean) · **Context:** [niven_2_4_rational_iff_periodic_decimal.context.md](niven_2_4_rational_iff_periodic_decimal.context.md)

## What the theorem says

Write a number between $0$ and $1$ as a decimal $0.d_0d_1d_2\ldots$. The theorem says the number is
rational exactly when that string of digits eventually repeats. One direction is long division: the
remainders come from a finite set, so a remainder must recur and the digits repeat from there. The
other direction sums a geometric series. Niven's §2.5 explains that a decimal that terminates is
just one that repeats the digit $0$ forever, so "terminating or infinite periodic" is a single
condition: eventually periodic.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The statement is an equivalence: rational implies eventually periodic, and eventually periodic implies rational. | ✅ The `↔` in `(∃ q : ℚ, x = q) ↔ EventuallyPeriodic (decimalDigit x)`. |
| 2 | The left side says $x$ equals some rational number. | ✅ `∃ q : ℚ, x = q`, with `q` cast to `ℝ`. |
| 3 | The $k$-th digit after the point is $\lfloor 10^{k+1}x\rfloor \bmod 10$. | ✅ `decimalDigit x k = (⌊(10 : ℝ) ^ (k + 1) * x⌋).toNat % 10` in `Defs.lean`. |
| 4 | Eventual periodicity: there is a starting index $N$ and a period $p$ such that $d_{k+p} = d_k$ for all $k \ge N$. | ✅ `EventuallyPeriodic d := ∃ N p, 0 < p ∧ ∀ k, N ≤ k → d (k + p) = d k`. |
| 5 | The period must be strictly positive. | ✅ `0 < p` inside `EventuallyPeriodic`. |
| 6 | The repetition is only required from some point on, not from the first digit. | ✅ The `N ≤ k` guard. This is what lets $1/6 = 0.1666\ldots$ count. |
| 7 | Terminating decimals are covered, not treated as a separate case. | ✅ A terminating expansion has $d_k = 0$ for large $k$, which satisfies `EventuallyPeriodic` with $p = 1$. No disjunction is needed. |
| 8 | $x$ is a non-negative real. | ✅ `hx : 0 ≤ x`. The digit formula $\lfloor 10^{k+1}x\rfloor \bmod 10$ is the $k$-th digit after the point for every $x \ge 0$, so no normalisation to $[0,1)$ is needed and the statement covers an arbitrary fraction $a/b \ge 0$, as the book does. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Stating only one implication instead of the `↔`. | Half the theorem. Niven proves both, and periodic $\Rightarrow$ rational is the direction people forget. |
| 2 | Allowing the period to be $0$. | With $p = 0$ the condition $d_{k+0} = d_k$ holds for every sequence whatsoever, so the right side becomes true for all $x$ and the equivalence is false — $x = \sqrt2/2$ would come out rational. |
| 3 | Requiring the digits to repeat from index $0$ (purely periodic). | False for $x = 1/6 = 0.1666\ldots$, which is rational but whose first digit never recurs. |
| 4 | Dropping the assumption that $x$ is non-negative. | `Int.toNat` sends every negative integer to $0$, so for $x < 0$ every digit is $0$ and the sequence is eventually periodic for free. The equivalence then claims $-\sqrt2$ is rational. |
| 5 | Defining the digit as $\lfloor 10^k x\rfloor \bmod 10$. | Off by one: this names $d_{k-1}$, and its $k=0$ entry is always $0$. Eventual periodicity happens to survive a shift, so the theorem stays true, but the object being described is not the book's digit sequence. |
| 6 | Writing the right side as "terminating or periodic" with "periodic" meaning purely periodic. | Misses the mixed expansions like $0.1666\ldots$, which neither terminate nor repeat from the start. §2.5 exists precisely to collapse the two cases into one. |
| 7 | Taking digits valued in `ℤ` or allowing values outside $0,\ldots,9$. | The `% 10` is what makes these digits; without it the sequence is $\lfloor 10^{k+1}x\rfloor$, which grows and is never periodic. |

## Notes on the ground truth

- `decimalDigit` and `EventuallyPeriodic` live in `Defs.lean` because Mathlib has neither. Both are
  plain definitions with no side conditions.
- The rational side is written `∃ q : ℚ, x = q` rather than `¬ Irrational x`; the two are the same
  condition, but the positive form matches the book's phrasing.
- The `.md` file records in its Notation block that a terminating expansion is the one repeating
  $0$, so the reader knows why the right side is a single condition.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[niven_2_4_rational_iff_periodic_decimal.md](niven_2_4_rational_iff_periodic_decimal.md) and the background in [niven_2_4_rational_iff_periodic_decimal.context.md](niven_2_4_rational_iff_periodic_decimal.context.md),
not against the ground-truth Lean file: a candidate spelled differently but
mathematically equivalent to the text loses nothing. The scale is defined in
[GRADING.md](../../GRADING.md); the numbers below are this problem's instance of it.

| Band | Points | This problem |
|---|---|---|
| A. Completeness | 50 | The requirement table above has 8 rows, so each row is worth 6.2 points: full credit if the candidate states it in any equivalent form, half for a harmless strengthening or weakening, none if it is absent. |
| B. Semantic fidelity | 20 | Junk values, `ℝ` vs `ℝ≥0∞`, coercions, quantifier order, a.e. vs everywhere — see the pitfalls below. |
| C. Mathlib-concept correctness | 15 | The Mathlib notion must mean the textbook notion, with the typeclass assumptions it needs. |
| D. Non-degeneracy | 10 | Not vacuous, not trivial, not a strictly weaker theorem. |
| E. Hygiene | 5 | No needless definitions, redundant conjuncts or unused hypotheses. |

**Every row of the *Mistakes to check for* table above is a defect.** Charge each one to the band it belongs to and deduct there.

### Fatal — any of these caps the total at 25

- Requirement 5 with the period allowed to be $0$: every sequence is then "periodic" and the statement collapses.
- Requirement 6 with periodicity required from the first digit.
- Requirement 1 with only one direction.

### Domain-specific pitfalls for this problem

- Terminating expansions are not a separate case: they are eventually periodic with repeating digit $0$.
- The digit function is $\lfloor 10^{k+1}x\rfloor \bmod 10$; a different indexing shifts every digit.
- "Rational" means equal to some element of $\mathbb{Q}$ after coercion, not "is a quotient of integers" in some ad-hoc sense.
- The hypothesis $x \in [0,1)$ is what makes the digit formula the expansion.
