# Criteria: niven_5_5_duplication_of_the_cube_impossible

**Statement:** [niven_5_5_duplication_of_the_cube_impossible.md](niven_5_5_duplication_of_the_cube_impossible.md) · **Lean:** [niven_5_5_duplication_of_the_cube_impossible.lean](niven_5_5_duplication_of_the_cube_impossible.lean) · **Context:** [niven_5_5_duplication_of_the_cube_impossible.context.md](niven_5_5_duplication_of_the_cube_impossible.context.md)

## What the theorem says

Doubling a cube of side $1$ means building a side of length $\sqrt[3]{2}$, since that is the number
whose cube is $2$. That number is a root of $x^3 - 2$, which has no rational root, so its degree over
$\mathbb{Q}$ is $3$. Three is not a power of $2$, so by the Theorem on Geometric Constructions the
length cannot be built with straightedge and compass. The cube cannot be duplicated.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The number in question is the real cube root of $2$. | ✅ `(2 : ℝ) ^ ((1 : ℝ) / 3)`, a real base with a real exponent, so this is `Real.rpow`. |
| 2 | The conclusion is that this length is **not** constructible. | ✅ `¬ IsConstructible …`. |
| 3 | "Constructible" is the straightedge-and-compass class: rationals, closed under the field operations and square roots of non-negative constructed lengths. | ✅ `IsConstructible` from `Defs.lean`, the same predicate used by the degree theorem. |
| 4 | The statement is unconditional — no hypotheses. | ✅ The theorem takes no arguments. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Concluding `Irrational ((2 : ℝ) ^ ((1 : ℝ)/3))`. | True, but far weaker and it does not settle the construction problem. Plenty of irrational lengths, such as $\sqrt2$, are constructible. |
| 2 | Writing the exponent with natural-number or integer division, e.g. `(2 : ℝ) ^ (1 / 3 : ℕ)`. | `1 / 3` is $0$ there, so the expression is $2^0 = 1$. The statement then claims $1$ is not constructible, which is false. |
| 3 | Using a complex cube root, or "some root of $X^3 - 2$". | The other two roots are not real and are not lengths. The problem is about a segment. |
| 4 | Stating instead that the degree of $\sqrt[3]{2}$ over $\mathbb{Q}$ is $3$. | That is the reason, not the claim. §5.5 asks whether the cube can be doubled, and the answer is the non-constructibility. |
| 5 | Stating `¬ IsConstructible 2` or `¬ IsConstructible (2^3)`. | $2$ is rational, hence constructible, so the statement is false. Doubling the *volume* corresponds to the cube root of the ratio, not the ratio. |
| 6 | Asserting that no cube can be duplicated for any starting side. | The impossibility is scale-free, but the printed statement is about the unit cube and the single length $\sqrt[3]{2}$. |

## Notes on the ground truth

- The Lean file records the conclusion, not Niven's route to it. The degree-$3$ computation and the
  appeal to the Theorem on Geometric Constructions live in the `.md` statement and in the companion
  problem `niven_5_5_constructible_degree_is_power_of_two`.
- `Real.rpow` with base $2 > 0$ is the ordinary real power, so there is no default-value hazard in
  `(2 : ℝ) ^ ((1 : ℝ) / 3)`.
- `IsConstructible` is shared with the other three construction problems; no new machinery is
  introduced here.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[niven_5_5_duplication_of_the_cube_impossible.md](niven_5_5_duplication_of_the_cube_impossible.md) and the background in [niven_5_5_duplication_of_the_cube_impossible.context.md](niven_5_5_duplication_of_the_cube_impossible.context.md),
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

- Requirement 1 with a number other than the real cube root of $2$.
- Requirement 3 with a "constructible" class that is not the straightedge-and-compass one.

### Domain-specific pitfalls for this problem

- The cube root must be the real one; a complex cube root is a different number.
- Junk value — real powers: $2^{1/3}$ written with `Real.rpow` is fine for a positive base, but a `zpow`/`nrpow` mix-up would change the number.
- The statement is unconditional and about one specific length.
- "Constructible" must be the same class used in the general theorem, or the corollary does not follow from it.
