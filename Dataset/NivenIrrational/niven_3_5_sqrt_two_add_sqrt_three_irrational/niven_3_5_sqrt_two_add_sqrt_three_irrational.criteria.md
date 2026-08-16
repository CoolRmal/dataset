# Criteria: niven_3_5_sqrt_two_add_sqrt_three_irrational

**Statement:** [niven_3_5_sqrt_two_add_sqrt_three_irrational.md](niven_3_5_sqrt_two_add_sqrt_three_irrational.md) · **Lean:** [niven_3_5_sqrt_two_add_sqrt_three_irrational.lean](niven_3_5_sqrt_two_add_sqrt_three_irrational.lean) · **Context:** [niven_3_5_sqrt_two_add_sqrt_three_irrational.context.md](niven_3_5_sqrt_two_add_sqrt_three_irrational.context.md)

## What the theorem says

The single number $\sqrt2+\sqrt3$ is irrational: it is not equal to any fraction. This does not
follow from the irrationality of $\sqrt2$ and $\sqrt3$ separately — a sum of two irrational numbers
can easily be rational, as $\sqrt2 + (-\sqrt2) = 0$ shows. Niven's proof squares twice: if
$\sqrt2+\sqrt3 = r$ were rational then $5 + 2\sqrt6 = r^2$, so $\sqrt6$ would be rational, which it
is not.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The claim is about the one number $\sqrt2+\sqrt3$, not about its two summands. | ✅ `Irrational (Real.sqrt 2 + Real.sqrt 3)` — the whole sum sits inside `Irrational`. |
| 2 | "Irrational" means: equal to no rational number. | ✅ Mathlib's `Irrational x`, which unfolds to `x ∉ Set.range ((↑) : ℚ → ℝ)`. |
| 3 | Both square roots are real square roots of the positive integers $2$ and $3$. | ✅ `Real.sqrt 2` and `Real.sqrt 3`. |
| 4 | The statement is unconditional — no hypotheses. | ✅ The theorem takes no arguments. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Stating `Irrational (Real.sqrt 2) ∧ Irrational (Real.sqrt 3)`. | A weaker and different claim. It does not give the sum: irrationality is not preserved by addition, since $\sqrt2 + (-\sqrt2) = 0$. |
| 2 | Assuming a lemma of the form "irrational plus irrational is irrational". | No such lemma exists, and it is false. Mathlib's `Irrational.add_rat` needs one side rational. |
| 3 | Writing $\sqrt{2+3} = \sqrt5$. | A different number. Also irrational, but not the exercise. |
| 4 | Using `Nat.sqrt` or integer square root. | `Nat.sqrt 2 = 1` and `Nat.sqrt 3 = 1`, so the claim becomes `Irrational 2`, which is false and would not even be provable. |
| 5 | Claiming `Transcendental ℚ (Real.sqrt 2 + Real.sqrt 3)`. | False. The number is a root of $x^4 - 10x^2 + 1$, so it is algebraic of degree $4$. |
| 6 | Stating that $\sqrt2+\sqrt3 \ne q$ for one particular rational $q$. | Irrationality quantifies over all rationals; a single instance says almost nothing. |

## Notes on the ground truth

- `Real.sqrt` is total in Mathlib and returns $0$ for negative inputs. Here both arguments are
  positive, so no default value is in play.
- The statement is deliberately bare: no minimal polynomial, no degree, no mention of $\sqrt6$. Those
  belong to the proof, not to what §3.5 asserts.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[niven_3_5_sqrt_two_add_sqrt_three_irrational.md](niven_3_5_sqrt_two_add_sqrt_three_irrational.md) and the background in [niven_3_5_sqrt_two_add_sqrt_three_irrational.context.md](niven_3_5_sqrt_two_add_sqrt_three_irrational.context.md),
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

- Requirement 1 with the claim made about $\sqrt2$ and $\sqrt3$ separately.
- Requirement 2 with "irrational" replaced by a weaker or different predicate.

### Domain-specific pitfalls for this problem

- Junk value — `Real.sqrt`: the square root of a negative number is $0$ in Lean; harmless here because $2$ and $3$ are positive, but a candidate that computes with a symbolic root must ensure it is the non-negative one.
- Irrationality is non-membership in the image of $\mathbb{Q}$, not "the number is not a quotient of two integers I can name".
- The theorem takes no hypotheses.
