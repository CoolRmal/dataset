# Criteria: niven_5_3_log_two_pow_five_pow_irrational

**Statement:** [niven_5_3_log_two_pow_five_pow_irrational.md](niven_5_3_log_two_pow_five_pow_irrational.md) · **Lean:** [niven_5_3_log_two_pow_five_pow_irrational.lean](niven_5_3_log_two_pow_five_pow_irrational.lean) · **Context:** [niven_5_3_log_two_pow_five_pow_irrational.context.md](niven_5_3_log_two_pow_five_pow_irrational.context.md)

## What the theorem says

Take two whole numbers $c$ and $d$, both allowed to be $0$, and require only that they are
different. Then the base-$10$ logarithm of $2^c 5^d$ is irrational. The reason the numbers must
differ is that $2^c5^c = 10^c$, whose logarithm is the integer $c$. Once $c \ne d$, unique
factorisation blocks any rational value: if $\log_{10}(2^c5^d) = a/b$ then $2^{cb}5^{db} = 10^a =
2^a5^a$, forcing $cb = a = db$ and hence $c = d$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $c$ and $d$ are non-negative integers, $0$ included. | ✅ `(c d : ℕ)`. |
| 2 | $c$ and $d$ are different. | ✅ `hcd : c ≠ d`. |
| 3 | The logarithm is to base $10$. | ✅ `Real.logb 10`. |
| 4 | The argument of the logarithm is $2^c \cdot 5^d$, a real number. | ✅ `(2 ^ c * 5 ^ d : ℝ)`, with `c` on the $2$ and `d` on the $5$. |
| 5 | The conclusion is irrationality of that logarithm. | ✅ `Irrational (Real.logb 10 (2 ^ c * 5 ^ d))`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Dropping `c ≠ d`. | Flatly false. At $c = d = 1$ the number is $\log_{10} 10 = 1$, a rational. This is the only hypothesis in the problem, so losing it loses everything. |
| 2 | Using `Real.log`, the natural logarithm. | A different number. $\ln(2^c5^d)$ is also irrational (for $c$ or $d$ nonzero), but it is not what §5.3 asks about, and at $c = d$ it stays irrational, so the hypothesis would no longer be doing its job. |
| 3 | Requiring $c > 0$ and $d > 0$. | Weakens the statement. The book says non-negative; the case $c = 0$, $d = 1$ gives $\log_{10} 5$, which is one of the intended instances. |
| 4 | Replacing `c ≠ d` by `c < d` or `d < c`. | Only half the cases, unless the statement is symmetric in a way that is spelled out. The book's hypothesis is inequality. |
| 5 | Writing the argument as $2^c + 5^d$ or as $(2 \cdot 5)^{cd}$. | Different numbers. The second is $10^{cd}$, whose logarithm is the integer $cd$. |
| 6 | Concluding `Irrational (Real.logb 10 2 ^ c * 5 ^ d)`. | A precedence slip: this is $(\log_{10} 2)^c \cdot 5^d$, not the logarithm of the product. |
| 7 | Restating the conclusion as "$\log_{10}(2^c5^d)$ is not an integer". | Strictly weaker. Irrationality rules out all fractions, not just whole numbers. |

## Notes on the ground truth

- `Real.logb b x` returns a default value when $x \le 0$, but the argument here is $2^c5^d > 0$, so
  the statement is about the genuine logarithm.
- The exponents are natural numbers, matching "non-negative integers" in the text. The same claim
  holds for integer exponents, but the book's hypothesis is the one formalized.
- Irrationality is Mathlib's `Irrational`, not a hand-rolled "not of the form $a/b$".

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[niven_5_3_log_two_pow_five_pow_irrational.md](niven_5_3_log_two_pow_five_pow_irrational.md) and the background in [niven_5_3_log_two_pow_five_pow_irrational.context.md](niven_5_3_log_two_pow_five_pow_irrational.context.md),
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

- Requirement 2 with the hypothesis $c \ne d$ dropped: false, since $\log 10^c = c$.
- Requirement 3 with the natural logarithm in place of the base-$10$ one.

### Domain-specific pitfalls for this problem

- The base is $10$; `Real.log` is the natural logarithm and `Real.logb 10` is the intended one.
- Junk value — `Real.log`: the logarithm of a non-positive number is $0$ in Lean, which is harmless here because $2^c5^d > 0$.
- $c$ and $d$ range over the non-negative integers, $0$ included.
- The conclusion is irrationality, not transcendence.
