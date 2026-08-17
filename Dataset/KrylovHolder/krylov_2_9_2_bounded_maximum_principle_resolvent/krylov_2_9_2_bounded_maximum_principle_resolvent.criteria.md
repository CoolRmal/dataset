# Criteria: krylov_2_9_2_bounded_maximum_principle_resolvent

**Statement:** [krylov_2_9_2_bounded_maximum_principle_resolvent.md](krylov_2_9_2_bounded_maximum_principle_resolvent.md) · **Lean:** [krylov_2_9_2_bounded_maximum_principle_resolvent.lean](krylov_2_9_2_bounded_maximum_principle_resolvent.lean) · **Context:** [krylov_2_9_2_bounded_maximum_principle_resolvent.context.md](krylov_2_9_2_bounded_maximum_principle_resolvent.context.md)

## What the theorem says

Let $L$ be the second-order operator $a^{ij}D_{ij} + b^iD_i + c$ whose coefficient matrix
$a(x)$ is symmetric and nonnegative definite at every point (Sec. 2.9's standing assumption —
no uniform ellipticity), whose coefficients $a$ and $b$ are bounded, and whose zeroth-order
coefficient satisfies $c \le -\lambda$ for some $\lambda > 0$. If $u$ is bounded and
continuous on $\bar\Omega$, twice differentiable inside $\Omega$, and vanishes on the boundary
(when there is one), then $u$ is controlled by $Lu$ with the explicit constant $\lambda^{-1}$:
$\sup u^+ \le \lambda^{-1}\sup (Lu)^-$ and $\sup\lvert u\rvert \le \lambda^{-1}\sup\lvert Lu\rvert$.
No equation is imposed on $u$; this is an a priori bound.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $\Omega$ is open. | ✅ `hΩ : IsOpen Ω`. Krylov says "domain"; connectedness is dropped, which only makes the theorem stronger. |
| 2 | $u$ is twice continuously differentiable inside $\Omega$ and continuous up to $\bar\Omega$. | ✅ `huDiff : ContDiffOn ℝ 2 u Ω` and `huContinuous : ContinuousOn u (closure Ω)`. Since $\Omega$ is open, the classical iterated derivatives inside `secondOrderOperator` are genuine on $\Omega$. |
| 3 | $u$ is bounded on $\Omega$. | ✅ `huBounded : Bornology.IsBounded (u '' Ω)`. Together with continuity on the closure this gives boundedness on $\bar\Omega$, as the text asks. |
| 4 | $u = 0$ on $\partial\Omega$, stated so that the case $\Omega = \mathbb{R}^d$ (no boundary) is allowed rather than excluded. | ✅ `huBoundary : ∀ x ∈ frontier Ω, u x = 0`; when $\Omega = \mathbb{R}^d$ the frontier is empty and the hypothesis is simply not used. |
| 5 | The matrix $a(x)$ is symmetric at every point. | ✅ `hsym : ∀ x i j, a x i j = a x j i` — one half of Sec. 2.9's standing assumption. |
| 6 | The matrix $a(x)$ is nonnegative definite at every point (the quadratic form $\sum_{ij} a^{ij}(x)\xi_i\xi_j$ is $\ge 0$), and *only* nonnegative definite — no uniform-ellipticity constant. | ✅ `hnonneg : ∀ x (ξ : Fin d → ℝ), 0 ≤ ∑ i, ∑ j, a x i j * ξ i * ξ j`. No ellipticity constant appears anywhere in the statement. |
| 7 | The coefficients $a$ and $b$ are bounded uniformly in $x$. | ✅ `haBounded : ∃ C : ℝ, ∀ x i j, \|a x i j\| ≤ C` and `hbBounded : ∃ C : ℝ, ∀ x i, \|b x i\| ≤ C`. No bound is placed on $c$, matching the text. |
| 8 | $\lambda > 0$. | ✅ `hlam : 0 < lam`. |
| 9 | The zeroth-order coefficient obeys $c(x) \le -\lambda$ at every point. | ✅ `hc : ∀ x, c x ≤ -lam`. |
| 10 | $L$ is the second-order operator built from the given coefficient arrays, $Lu = a^{ij}D_{ij}u + b^iD_iu + cu$ with summation over repeated indices. | ✅ the conclusion applies `secondOrderOperator a b c`, which unfolds to `∑ i, ∑ j, a x i j * directionalDerivativeList [i, j] u x + ∑ i, b x i * directionalDerivativeList [i] u x + c x * u x`. |
| 11 | Both inequalities appear, with the correct one-sided quantities: the negative part $(Lu)^-$ on the right of the first, the absolute values in the second, and $\lambda^{-1}$ as an explicit constant in both. | ✅ `functionSupNorm Ω (fun x ↦ max (u x) 0) ≤ (ENNReal.ofReal lam)⁻¹ * functionSupNorm Ω (fun x ↦ max (-(secondOrderOperator a b c u x)) 0)` and `functionSupNorm Ω u ≤ (ENNReal.ofReal lam)⁻¹ * functionSupNorm Ω (secondOrderOperator a b c u)`. |
| 12 | The suprema are taken over $\Omega$ and must stay meaningful when the family is unbounded. | ✅ `functionSupNorm Ω v = ⨆ x : Ω, ENNReal.ofReal \|v x\|` lands in `ℝ≥0∞`, so an unbounded family gives `∞` and an empty $\Omega$ gives `0 ≤ 0`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Omitting the nonnegative definiteness of $a$ (Sec. 2.9's standing assumption, printed before the theorem rather than inside it). | Without $a \ge 0$ the statement is false. Take $d = 1$, $\Omega = (0,1)$, $a \equiv -1$, $b \equiv 0$, $c \equiv -\lambda$ with $0 < \lambda \le \pi^2$, and $u(x) = \sin(\pi x)$. Then $Lu = -u'' - \lambda u = (\pi^2 - \lambda)\sin(\pi x) \ge 0$ on $\Omega$, so $(Lu)^- \equiv 0$, yet $\sup_\Omega u^+ = 1$: the first estimate fails (at $\lambda = \pi^2$ both do). |
| 2 | Demanding uniform ellipticity — $\kappa\lVert\xi\rVert^2 \le \sum_{ij} a^{ij}(x)\xi_i\xi_j$ for some $\kappa > 0$ — instead of mere nonnegativity. | Sec. 2.9 asks only for degenerate ellipticity ($a \ge 0$ as a quadratic form). Uniform ellipticity excludes admissible operators — e.g. $a \equiv 0$, where the theorem is still asserted — so the candidate proves a strictly weaker theorem than the printed one. |
| 3 | Asking $u$ to be bounded and continuous only on $\Omega$, not on $\bar\Omega$. | The statement becomes false. On $\Omega = (0,1)$ with $a \equiv 1$, $b \equiv 0$, $c \equiv -\lambda$, let $u(x) = e^{\sqrt{\lambda}\,x}$ inside and redefine $u(0) = u(1) = 0$ pointwise. Then $Lu = u'' - \lambda u \equiv 0$ on $\Omega$, $u$ is bounded, $C^2$ inside, and vanishes on $\partial\Omega$, yet $\sup_\Omega\lvert u\rvert = e^{\sqrt{\lambda}} > 0 = \lambda^{-1}\sup_\Omega\lvert Lu\rvert$. Continuity up to the boundary is what rules this out. |
| 4 | Dropping the boundedness of $u$. | The statement becomes false. On $\Omega = \mathbb{R}$ take $a \equiv 1$, $b \equiv 0$, $c \equiv -1$ (so $\lambda = 1$) and $u(x) = e^x$. Then $Lu = u'' - u \equiv 0$, and the claim would read $\sup\lvert u\rvert = \infty \le 1^{-1}\cdot 0$. |
| 5 | Dropping $c \le -\lambda$, or allowing $\lambda \le 0$. | The factor $\lambda^{-1}$ is exactly what the sign condition buys. With $c$ of arbitrary sign there is no bound: $u = \sin x$ on $\mathbb{R}$ with $a \equiv 1$, $b \equiv 0$, $c \equiv 1$ has $Lu = u'' + u = 0$, so $\sup\lvert u\rvert = 1$ and $\sup\lvert Lu\rvert = 0$. |
| 6 | Putting $(Lu)^+$ on the right of the first estimate instead of $(Lu)^-$. | The first estimate bounds where $u$ is large and positive, which is driven by where $Lu$ is negative. With $(Lu)^+$ the inequality is false. Using $\lvert Lu\rvert$ there is true but strictly weaker than the printed statement. |
| 7 | Writing the estimates with real-valued `sSup`. | A real `sSup` over an unbounded set returns $0$. If $\sup_\Omega\lvert Lu\rvert = \infty$ the right side collapses to $0$ and the second estimate becomes a false claim rather than a trivial one. |
| 8 | Adding "$\partial\Omega \ne \emptyset$" as a hypothesis, or excluding $\Omega = \mathbb{R}^d$. | Krylov explicitly allows the boundaryless case; excluding it drops part of the theorem. |
| 9 | Assuming an equation such as $Lu = f$. | No equation is assumed. The theorem is an a priori bound valid for every admissible $u$, and imposing an equation makes it a different, weaker statement. |
| 10 | Assuming $c$ bounded (e.g. "all coefficients are bounded"). | The text bounds only $a$ and $b$; $c$ is constrained solely from above and may be unbounded below ($c(x) = -1 - x^2$ is admissible). Bounding $c$ restricts the theorem to a strictly smaller class of operators. |

## Notes on the ground truth

- The operator is the concrete `secondOrderOperator a b c`, whose derivatives are classical
  iterated `fderiv`s (`directionalDerivativeList`). Where a function is not differentiable,
  `fderiv` silently returns $0$, but `huDiff` together with `hΩ : IsOpen Ω` makes every
  derivative entering the suprema over $\Omega$ genuine.
- `hnonneg` is exactly Sec. 2.9's degenerate ellipticity: the quadratic form
  $\sum_{ij} a^{ij}(x)\xi_i\xi_j$ is nonnegative for every $x$ and $\xi$. No ellipticity
  constant appears anywhere; a uniform $\kappa > 0$ would restrict the theorem (mistake 2).
- `hsym` is the other half of the standing assumption. It is nearly harmless mathematically —
  on $C^2$ functions $D_{ij} = D_{ji}$, so the operator only sees the symmetric part of $a$ —
  but it is what the book assumes, and a candidate stating it in any equivalent form is faithful.
- Boundedness is hypothesized for $a$ and $b$ only. For $c$ the text gives just the one-sided
  bound $c \le -\lambda$, and the Lean statement follows it: $c$ may be unbounded below.
- `functionSupNorm Ω (fun x ↦ max (u x) 0)` really is $\sup_\Omega u^+$, since the inner
  absolute value is applied to a quantity that is already nonnegative.
- `(ENNReal.ofReal lam)⁻¹` is finite and nonzero because `hlam : 0 < lam`, so neither the
  `ofReal` nor the inverse produces a junk value in the conclusion.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[krylov_2_9_2_bounded_maximum_principle_resolvent.md](krylov_2_9_2_bounded_maximum_principle_resolvent.md) and the background in [krylov_2_9_2_bounded_maximum_principle_resolvent.context.md](krylov_2_9_2_bounded_maximum_principle_resolvent.context.md),
not against the ground-truth Lean file: a candidate spelled differently but
mathematically equivalent to the text loses nothing. The scale is defined in
[GRADING.md](../../GRADING.md); the numbers below are this problem's instance of it.

| Band | Points | This problem |
|---|---|---|
| A. Completeness | 50 | The requirement table above has 12 rows, so each row is worth 4.2 points: full credit if the candidate states it in any equivalent form, half for a harmless strengthening or weakening, none if it is absent. |
| B. Semantic fidelity | 20 | Junk values, `ℝ` vs `ℝ≥0∞`, coercions, quantifier order, a.e. vs everywhere — see the pitfalls below. |
| C. Mathlib-concept correctness | 15 | The Mathlib notion must mean the textbook notion, with the typeclass assumptions it needs. |
| D. Non-degeneracy | 10 | Not vacuous, not trivial, not a strictly weaker theorem. |
| E. Hygiene | 5 | No needless definitions, redundant conjuncts or unused hypotheses. |

**Every row of the *Mistakes to check for* table above is a defect.** Charge each one to the band it belongs to and deduct there.

### Fatal — any of these caps the total at 25

- Requirement 9 with $c \le 0$ instead of $c \le -\lambda$ with $\lambda>0$: the estimate is then false.
- Requirement 6 with the nonnegative definiteness of $a$ dropped: the statement is false (mistake 1's counterexample).
- Requirement 3 with the boundedness of $u$ dropped.
- Requirement 2 with the continuity of $u$ weakened from $\bar\Omega$ to $\Omega$ only: the statement is false (mistake 3's counterexample).
- Requirement 11 with $(Lu)^-$ read as $-(Lu)$ or as $\min$, rather than as the nonnegative negative part.

### Domain-specific pitfalls for this problem

- $t^- = \max(-t,0)$ is nonnegative; getting its sign wrong reverses the first inequality.
- Junk value — supremum: the suprema are over $\Omega$ and must remain meaningful for an unbounded family, so they belong in an extended-real type or must come with a boundedness hypothesis.
- The boundary condition is conditional on $\partial\Omega \ne \emptyset$, so the whole-space case must be admitted.
- Both the one-sided and the two-sided estimate are asserted.
- Only nonnegativity of $a(x)$ is assumed — the symmetric matrix may be degenerate or even zero; no uniform-ellipticity constant belongs in the statement.
- Boundedness of the coefficients $a$ and $b$ is a hypothesis; boundedness of $c$ is not.
- $u$ lives on $\bar\Omega$: bounded and continuous up to the boundary, twice differentiable only inside.
