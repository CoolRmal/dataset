# Criteria: niven_zuckerman_10_15_mod_five_coefficients

**Statement:** [niven_zuckerman_10_15_mod_five_coefficients.md](niven_zuckerman_10_15_mod_five_coefficients.md) · **Lean:** [niven_zuckerman_10_15_mod_five_coefficients.lean](niven_zuckerman_10_15_mod_five_coefficients.lean) · **Context:** [niven_zuckerman_10_15_mod_five_coefficients.context.md](niven_zuckerman_10_15_mod_five_coefficients.context.md)

## What the theorem says

Take Euler's product $\phi(x) = \prod_{n\ge1}(1-x^n)$, raise it to the fourth power, and multiply by
$x$. For $0 \le x < 1$ the result can be written as a power series $\sum_m b_m x^m$. The theorem
says two things about the coefficients: they are all whole numbers, and those whose index is a
multiple of $5$ are themselves multiples of $5$. Only the indices divisible by $5$ are claimed to
have this property — most of the other coefficients are not divisible by $5$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $\phi$ is Euler's product $\prod_{n\ge1}(1-x^n)$, not an arbitrary function. | ✅ `eulerProduct`, defined in `Defs.lean` by an infinite product. |
| 2 | The claim is made for every real $x$ with $0 \le x < 1$, where the product converges. | ✅ `∀ x : ℝ, 0 ≤ x → x < 1 → …`. |
| 3 | The function being expanded is $x\,\phi(x)^4$: the leading factor $x$ and the exponent $4$ are both part of it. | ✅ `x * φ x ^ 4`. |
| 4 | The coefficients are integers. | ✅ `∃ b : ℕ → ℤ`, cast to `ℝ` only inside the series. |
| 5 | The divisibility conclusion: if $5$ divides $m$ then $5$ divides $b_m$. | ✅ `∀ m : ℕ, m % 5 = 0 → (5 : ℤ) ∣ b m`. |
| 6 | The power-series identity itself: $x\phi(x)^4 = \sum_m b_m x^m$. | ✅ `x * φ x ^ 4 = ∑' m : ℕ, (b m : ℝ) * x ^ m`. |
| 7 | Both conclusions are about the *same* sequence $b$, and one sequence works for every $x$. | ✅ `∃ b : ℕ → ℤ, (divisibility) ∧ (∀ x, identity)` — the existential is outermost. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Claiming $5 \mid b_m$ for every $m$. | False. Expanding, $x\phi(x)^4 = x - 4x^2 + \dots$, so $b_1 = 1$. The divisibility is only claimed on indices that are multiples of $5$. |
| 2 | Dropping the leading factor $x$ and expanding $\phi(x)^4$ instead. | This shifts every index by one, so the mod-$5$ statement lands on the wrong coefficients and Theorem 10.16 no longer follows from it. |
| 3 | Using a different exponent, e.g. $x\phi(x)^5$ or $x\phi(x)$. | A different generating function; the pattern of coefficients divisible by $5$ is specific to the fourth power. |
| 4 | Real-valued coefficients, `∃ b : ℕ → ℝ`. | Then "$5$ divides $b_m$" is meaningless (every real is divisible by $5$ in $\mathbb{R}$), and the theorem evaporates. |
| 5 | Quantifying as `∀ x, ∃ b`. | Lets the coefficients depend on $x$, which is not a statement about a power series at all. |
| 6 | Reading the index condition as $m \equiv 4 \pmod 5$. | That residue belongs to Theorem 10.16, which is about $p(5m+4)$. Here the condition is $m \equiv 0 \pmod 5$. |
| 7 | Stating only the identity, with no divisibility clause. | Existence of an integer power-series expansion is routine; the mod-$5$ clause is the theorem. |

## Notes on the ground truth

- The Lean sum runs over all $m \ge 0$ while the book writes $\sum_{m\ge1}$. This costs nothing:
  $x\phi(x)^4$ has no constant term, so $b_0 = 0$ is forced by the identity, and the divisibility
  clause at $m = 0$ says $5 \mid 0$, which is true.
- `m % 5 = 0` on naturals is the same as $m \equiv 0 \pmod 5$; `5 ∣ m` or `Nat.ModEq` would be
  equally acceptable spellings.
- The identity holds on the whole interval $[0,1)$, which has accumulation points, so the sequence
  $b$ is uniquely determined — the existential is not hiding any freedom.
- Lean's `∑'` gives a non-summable family the value $0$. That cannot be abused here: if the series
  did not converge the right side would be $0$ and the identity would force $x\phi(x)^4 = 0$, which
  is false. A candidate that adds a `Summable` conjunct is more informative and should be accepted.
- As in Theorem 10.14, `φ` is a variable characterised by a hypothesis rather than a definition,
  because mathlib has no Euler partition product. Defining it by an infinite product is equally
  faithful.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[niven_zuckerman_10_15_mod_five_coefficients.md](niven_zuckerman_10_15_mod_five_coefficients.md) and the background in [niven_zuckerman_10_15_mod_five_coefficients.context.md](niven_zuckerman_10_15_mod_five_coefficients.context.md),
not against the ground-truth Lean file: a candidate spelled differently but
mathematically equivalent to the text loses nothing. The scale is defined in
[GRADING.md](../../GRADING.md); the numbers below are this problem's instance of it.

| Band | Points | This problem |
|---|---|---|
| A. Completeness | 50 | The requirement table above has 7 rows, so each row is worth 7.1 points: full credit if the candidate states it in any equivalent form, half for a harmless strengthening or weakening, none if it is absent. |
| B. Semantic fidelity | 20 | Junk values, `ℝ` vs `ℝ≥0∞`, coercions, quantifier order, a.e. vs everywhere — see the pitfalls below. |
| C. Mathlib-concept correctness | 15 | The Mathlib notion must mean the textbook notion, with the typeclass assumptions it needs. |
| D. Non-degeneracy | 10 | Not vacuous, not trivial, not a strictly weaker theorem. |
| E. Hygiene | 5 | No needless definitions, redundant conjuncts or unused hypotheses. |

**Every row of the *Mistakes to check for* table above is a defect.** Charge each one to the band it belongs to and deduct there.

### Fatal — any of these caps the total at 25

- Requirement 3 with the leading factor $x$ or the exponent $4$ wrong.
- Requirement 7 with the two conclusions about different sequences, or with the sequence depending on $x$.
- Requirement 5 with the divisibility asserted for all $m$ rather than for $m \equiv 0 \bmod 5$.

### Domain-specific pitfalls for this problem

- The expansion starts at $m = 1$ because of the leading factor $x$.
- The coefficients are integers; the divisibility is in $\mathbb{Z}$.
- Junk value — `tsum`: convergence must be part of the assertion.
- One sequence serves every $x$ in $[0,1)$.
