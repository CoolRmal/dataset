# Criteria: niven_zuckerman_10_14_euler_product_prime_power

**Statement:** [niven_zuckerman_10_14_euler_product_prime_power.md](niven_zuckerman_10_14_euler_product_prime_power.md) · **Lean:** [niven_zuckerman_10_14_euler_product_prime_power.lean](niven_zuckerman_10_14_euler_product_prime_power.lean) · **Context:** [niven_zuckerman_10_14_euler_product_prime_power.context.md](niven_zuckerman_10_14_euler_product_prime_power.context.md)

## What the theorem says

Euler's product $\phi(x) = \prod_{n\ge 1}(1-x^n)$ converges for $0 \le x < 1$. Fix a prime $p$ and
compare $\phi(x^p)$ with $\phi(x)^p$. The theorem says their ratio is $1$ plus $p$ times a power
series whose coefficients are whole numbers. In other words, expand the ratio as a power series:
the constant term is $1$, and every other coefficient is divisible by $p$. That divisibility is the
entire point of the theorem, and it is what makes Ramanujan's congruence work two theorems later.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. In the assessment column, ✅ means the ground truth states the requirement and
◐ means it states it in a form that deliberately departs from the text — a narrower setting, a
stronger hypothesis, or an equivalent but not literal phrasing — with the reason given. A ◐ records
a decision, not an open defect; where a more literal rendering would be at least as good, the row
says so.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $p$ is a prime. | ✅ `hp : p.Prime`. |
| 2 | The identity is claimed for every real $x$ with $0 \le x < 1$ — the range where Euler's product converges. | ✅ `∀ x : ℝ, 0 ≤ x → x < 1 → …`, and the same range appears in the hypothesis on `φ`. |
| 3 | $\phi$ is the Euler product $\prod_{n\ge 1}(1-x^n)$, not an arbitrary function. | ✅ `hφ` says the partial products `∏ n ∈ Finset.Icc 1 m, (1 - x ^ n)` converge to `φ x` as `m → ∞`. |
| 4 | The left side is $\phi(x^p)$ divided by $\phi(x)^p$: the $p$-th power is on the bottom, the substitution $x \mapsto x^p$ on the top. | ✅ `φ (x ^ p) / φ x ^ p`. |
| 5 | The coefficients are integers. | ✅ `∃ a : ℕ → ℤ`, cast to `ℝ` only where the series is formed. |
| 6 | The factor $p$ multiplying the series is explicit, and the constant term is exactly $1$. | ✅ `1 + p * ∑' i : ℕ, …`. |
| 7 | The series runs over $i \ge 1$; there is no $x^0$ term inside it. | ✅ `∑' i : ℕ, (a (i + 1) : ℝ) * x ^ (i + 1)` — the exponent starts at `1`. |
| 8 | One single sequence of coefficients works for all $x$ at once: the existential comes before the quantifier over $x$. | ✅ `∃ a : ℕ → ℤ, ∀ x : ℝ, …` in that order. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Writing `∃ a : ℕ → ℝ` instead of `∃ a : ℕ → ℤ`. | With real coefficients the statement is almost empty: any power series expansion would do. Integrality is the theorem. |
| 2 | Dropping the explicit factor $p$, e.g. writing $\phi(x^p)/\phi(x)^p = 1 + \sum a_i x^i$ with integer $a_i$. | This is the highest-value trap. Without the factored-out $p$ the statement no longer says the coefficients after the constant term are divisible by $p$, which is the whole content. |
| 3 | Putting the quantifiers as `∀ x, ∃ a`. | The coefficients would be allowed to change with $x$, and the claim collapses to something nearly trivial. |
| 4 | Swapping the two sides of the ratio: $\phi(x)^p/\phi(x^p)$, or writing $\phi(x^p)/\phi(x^p)$. | A different function, whose expansion is not $1 + p\sum a_i x^i$ with integer $a_i$. |
| 5 | Starting the power series at $i = 0$. | The printed sum starts at $i=1$. An $x^0$ term inside the sum would let a nonzero constant be hidden there, changing the assertion about the constant term. |
| 6 | Leaving `φ` an unconstrained function with no hypothesis tying it to $\prod (1-x^n)$. | Then the statement is false: pick any `φ` you like and the identity fails. |
| 7 | Narrowing the range to $0 < x < 1$. | The printed hypothesis includes $x = 0$, where $\phi(0) = 1$ and both sides equal $1$. |

## Notes on the ground truth

- Mathlib has no Euler partition product, so `φ` is a variable pinned down by the hypothesis `hφ`
  rather than defined. A candidate that instead defines `φ` by an infinite product (`tprod`, or a
  limit of partial products) is equally faithful.
- The statement never says $\phi(x) \ne 0$, and Lean gives $y/0$ the value $0$. On $0 \le x < 1$ the
  Euler product really is nonzero, so the identity is not being propped up by that convention — but
  a candidate that records $\phi(x) \ne 0$ on this range, or states the identity in the
  multiplication-only form $\phi(x^p) = \phi(x)^p\,(1 + p\sum a_i x^i)$, is more informative and
  should be accepted.
- Lean's `∑'` gives a non-summable family the value $0$. That cannot be exploited here: if the
  coefficient series failed to converge the right side would be exactly $1$, forcing the ratio to be
  identically $1$, which is false. Adding a `Summable` conjunct would still be an improvement.
- `a 0` is never used, since the series refers only to `a (i + 1)`. Its value is unconstrained and
  harmless.
- Careful with the letter $p$: in this chapter of the book it is both the prime here and the
  partition function $p(n)$ elsewhere. Only the prime occurs in this statement.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[niven_zuckerman_10_14_euler_product_prime_power.md](niven_zuckerman_10_14_euler_product_prime_power.md) and the background in [niven_zuckerman_10_14_euler_product_prime_power.context.md](niven_zuckerman_10_14_euler_product_prime_power.context.md),
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

- Requirement 8 with the coefficient sequence quantified after $x$.
- Requirement 4 with $\phi(x^p)$ and $\phi(x)^p$ interchanged.
- Requirement 6 with the explicit factor $p$ dropped.

### Domain-specific pitfalls for this problem

- The two occurrences of $p$ sit in different places: inside the argument on top, as an exponent of the value on the bottom.
- The coefficients are integers, cast to $\mathbb{R}$ only where the series is summed.
- Junk value — `tsum`: the series must be asserted convergent (or the identity read only where it converges), since an unsummable `tsum` is $0$.
- One coefficient sequence works for every $x \in [0,1)$.
- $\phi$ must be Euler's product, not an arbitrary function.
