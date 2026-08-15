# Criteria: niven_zuckerman_11_3_moebius_zeta_product

**Statement:** [niven_zuckerman_11_3_moebius_zeta_product.md](niven_zuckerman_11_3_moebius_zeta_product.md) · **Lean:** [niven_zuckerman_11_3_moebius_zeta_product.lean](niven_zuckerman_11_3_moebius_zeta_product.lean) · **Context:** [niven_zuckerman_11_3_moebius_zeta_product.context.md](niven_zuckerman_11_3_moebius_zeta_product.context.md)

## What the theorem says

Two infinite series are involved, both summed over the positive integers: $\sum \mu(n)/n^2$, where
$\mu$ is the Möbius function, and $\sum 1/n^2$, which is $\zeta(2)$. The theorem says that when you
multiply the two sums together you get exactly $1$. Put differently, the Möbius series is the
reciprocal of $\zeta(2)$. Both series converge, the second absolutely and the first because
$\lvert \mu(n)\rvert \le 1$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The first series is $\sum \mu(n)/n^2$ with $\mu$ the Möbius function. | ✅ `(ArithmeticFunction.moebius n : ℝ) / (n : ℝ) ^ 2`. |
| 2 | The second series is $\sum 1/n^2$. | ✅ `1 / (n : ℝ) ^ 2`. |
| 3 | Both series start at $n = 1$; the $n = 0$ term must be excluded, not just left to Lean's conventions. | ✅ Each summand is wrapped in `if n = 0 then 0 else …`. |
| 4 | The assertion is that the *product of the two sums* equals $1$. | ✅ `(∑' …) * (∑' …) = 1`, a single equation. |
| 5 | The Möbius function is integer-valued and must be cast into $\mathbb{R}$ before dividing. | ✅ `(ArithmeticFunction.moebius n : ℝ)`. |
| 6 | The exponent is $2$ in both series. | ✅ `^ 2` in both. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Stating the Dirichlet-convolution identity $\mu * \zeta = 1$ for arithmetic functions instead. | That is a statement about coefficient-wise convolution, not about the numerical values of two convergent series, and it is already in mathlib as `ArithmeticFunction.moebius_mul_coe_zeta`. It is a different theorem. |
| 2 | Dropping the `n = 0` guard and summing $\mu(n)/n^2$ over all of $\mathbb{N}$. | The $n = 0$ term becomes $\mu(0)/0$, and Lean gives division by zero the value $0$, so the number happens to come out right. The equation is then true only because of a convention the book never mentions; the guard says what is meant. |
| 3 | Giving the value as $6/\pi^2$ or $\pi^2/6$. | That is Corollary 11.4, the next result. Theorem 11.3 is the reciprocal relation between the two series and does not evaluate either one. |
| 4 | Using an exponent other than $2$, or a general complex $s$. | The printed statement is the single case $s = 2$; a general-$s$ version is a different (harder) claim about a half-plane of convergence. |
| 5 | Replacing $\mu(n)$ by $\lvert \mu(n)\rvert$ or by the Liouville function. | $\sum \lvert\mu(n)\rvert/n^2 = \zeta(2)/\zeta(4)$, so the product is not $1$. |
| 6 | Writing the claim as $\sum \mu(n)/n^2 = 1 / \sum 1/n^2$ without knowing the denominator is nonzero. | Lean makes division by zero equal $0$, so this form quietly depends on $\zeta(2) \ne 0$; the product form avoids the issue. |

## Notes on the ground truth

- Mathlib's `∑'` runs over the whole index type and gives a non-summable family the value $0$. Here
  that cannot be exploited: if either family failed to be summable its sum would be $0$ and the
  product would be $0$, not $1$. So the stated equation already carries the convergence of both
  series. A candidate that adds explicit `Summable` hypotheses or conjuncts is more informative and
  should be accepted.
- Summing over a positive index type instead — `∑' n : ℕ+` or `∑' n : {n : ℕ // 0 < n}` — is a
  faithful way to start at $n = 1$ and should also be accepted. What must not happen is an
  unguarded sum over `ℕ` whose first term is silently a division by zero.
- `ArithmeticFunction.moebius` is mathlib's $\mu$: it is $0$ on non-squarefree arguments and
  $(-1)^k$ on a product of $k$ distinct primes, with $\mu(1) = 1$.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[niven_zuckerman_11_3_moebius_zeta_product.md](niven_zuckerman_11_3_moebius_zeta_product.md) and the background in [niven_zuckerman_11_3_moebius_zeta_product.context.md](niven_zuckerman_11_3_moebius_zeta_product.context.md),
not against the ground-truth Lean file: a candidate spelled differently but
mathematically equivalent to the text loses nothing. The scale is defined in
[GRADING.md](../../GRADING.md); the numbers below are this problem's instance of it.

| Band | Points | This problem |
|---|---|---|
| A. Completeness | 50 | The requirement table above has 6 rows, so each row is worth 8.3 points: full credit if the candidate states it in any equivalent form, half for a harmless strengthening or weakening, none if it is absent. |
| B. Semantic fidelity | 20 | Junk values, `ℝ` vs `ℝ≥0∞`, coercions, quantifier order, a.e. vs everywhere — see the pitfalls below. |
| C. Mathlib-concept correctness | 15 | The Mathlib notion must mean the textbook notion, with the typeclass assumptions it needs. |
| D. Non-degeneracy | 10 | Not vacuous, not trivial, not a strictly weaker theorem. |
| E. Hygiene | 5 | No needless definitions, redundant conjuncts or unused hypotheses. |

**Every row of the *Mistakes to check for* table above is a defect.** Charge each one to the band it belongs to and deduct there.

### Fatal — any of these caps the total at 25

- Requirement 3 with the $n=0$ term left to a division-by-zero convention rather than excluded.
- Requirement 4 with a claim about one sum rather than about the product.
- Requirement 6 with a different exponent.

### Domain-specific pitfalls for this problem

- Junk value — division: $1/0 = 0$ in Lean, so the $n = 0$ term must be handled explicitly rather than relied upon.
- The Möbius function is $\mathbb{Z}$-valued and needs a cast.
- Both series must be summable for the product statement to be about genuine sums.
- The assertion is about the product of the two sums.
