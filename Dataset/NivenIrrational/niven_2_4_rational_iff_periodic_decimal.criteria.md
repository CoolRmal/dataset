# Criteria: niven_2_4_rational_iff_periodic_decimal

**Statement:** [niven_2_4_rational_iff_periodic_decimal.md](niven_2_4_rational_iff_periodic_decimal.md) · **Lean:** [niven_2_4_rational_iff_periodic_decimal.lean](niven_2_4_rational_iff_periodic_decimal.lean)

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
| 8 | $x$ is real and lies in $[0,1)$. | ⚠️ `hx : x ∈ Ico (0 : ℝ) 1`. The digit formula is correct for every $x \ge 0$, so `0 ≤ x` alone would do and would be closer to the book, which states the result for an arbitrary fraction $a/b$. Restricting to $[0,1)$ is a normalisation: the integer part contributes no digits after the point. |

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
