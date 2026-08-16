# Criteria: krylov_2_9_2_bounded_maximum_principle_resolvent

**Statement:** [krylov_2_9_2_bounded_maximum_principle_resolvent.md](krylov_2_9_2_bounded_maximum_principle_resolvent.md) · **Lean:** [krylov_2_9_2_bounded_maximum_principle_resolvent.lean](krylov_2_9_2_bounded_maximum_principle_resolvent.lean) · **Context:** [krylov_2_9_2_bounded_maximum_principle_resolvent.context.md](krylov_2_9_2_bounded_maximum_principle_resolvent.context.md)

## What the theorem says

Let $L$ be a second-order operator $a^{ij}D_{ij} + b^iD_i + c$ whose coefficients are bounded and
whose zeroth-order coefficient satisfies $c \le -\lambda$ for some $\lambda > 0$. If $u$ is bounded
and continuous on $\bar\Omega$, twice differentiable inside $\Omega$, and vanishes on the boundary
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
| 2 | $u$ is twice continuously differentiable inside $\Omega$ and continuous up to $\bar\Omega$. | ✅ `huDiff : ContDiffOn ℝ 2 u Ω` and `huContinuous : ContinuousOn u (closure Ω)`. Since $\Omega$ is open, this makes the second derivatives inside `multiDerivative` genuine. |
| 3 | $u$ is bounded on $\Omega$. | ✅ `huBounded : Bornology.IsBounded (u '' Ω)`. |
| 4 | $u = 0$ on $\partial\Omega$, stated so that the case $\Omega = \mathbb{R}^d$ (no boundary) is allowed rather than excluded. | ✅ `huBoundary : ∀ x ∈ frontier Ω, u x = 0`; when $\Omega = \mathbb{R}^d$ the frontier is empty and the hypothesis is simply not used. |
| 5 | $\lambda > 0$. | ✅ `hlam : 0 < lam`. |
| 6 | $L$ is a second-order differential operator given by coefficients, and the zero multi-index really appears among its terms. | ✅ `SecondOrderEllipticOperator L lam` supplies `data : EllipticOperatorData 2 L` together with `∃ zeroIndex ∈ data.terms, ∀ i, zeroIndex i = 0`. |
| 7 | The zeroth-order coefficient obeys $c(x) \le -\lambda$ at every point. | ✅ `∀ x, data.coefficient zeroIndex x ≤ -lam` inside `SecondOrderEllipticOperator`. |
| 8 | All coefficients are bounded uniformly in $x$. | ✅ `∃ C : ℝ, ∀ α ∈ data.terms, ∀ x, \|data.coefficient α x\| ≤ C`. |
| 9 | Both inequalities appear, with the correct one-sided quantities: the negative part $(Lu)^-$ on the right of the first, the absolute values in the second, and $\lambda^{-1}$ as an explicit constant in both. | ✅ `functionSupNorm Ω (fun x ↦ max (u x) 0) ≤ (ENNReal.ofReal lam)⁻¹ * functionSupNorm Ω (fun x ↦ max (-(L u x)) 0)` and `functionSupNorm Ω u ≤ (ENNReal.ofReal lam)⁻¹ * functionSupNorm Ω (L u)`. |
| 10 | The suprema are taken over $\Omega$ and must stay meaningful when the family is unbounded. | ✅ `functionSupNorm Ω v = ⨆ x : Ω, ENNReal.ofReal \|v x\|` lands in `ℝ≥0∞`, so an unbounded family gives `∞` and an empty $\Omega$ gives `0 ≤ 0`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Dropping the boundedness of $u$. | The statement becomes false. On $\Omega = \mathbb{R}$ take $Lu = u'' - u$ (which fits with $\lambda = 1$) and $u(x) = e^x$. Then $Lu \equiv 0$, and the claim would read $\sup\lvert u\rvert = \infty \le 1^{-1}\cdot 0$. |
| 2 | Bounding the coefficient at the zero multi-index without requiring that multi-index to belong to the operator's term set. | The coefficient function is total, but only its values on `terms` enter the formula for $L$. A bound off `terms` says nothing at all about $L$, so the hypothesis would be empty. |
| 3 | Dropping $c \le -\lambda$, or allowing $\lambda \le 0$. | The factor $\lambda^{-1}$ is exactly what the sign condition buys. With $c$ of arbitrary sign there is no bound: $u = \sin x$ on $\mathbb{R}$ with $Lu = u'' + u = 0$ has $\sup\lvert u\rvert = 1$ and $\sup\lvert Lu\rvert = 0$. |
| 4 | Putting $(Lu)^+$ on the right of the first estimate instead of $(Lu)^-$. | The first estimate bounds where $u$ is large and positive, which is driven by where $Lu$ is negative. With $(Lu)^+$ the inequality is false. Using $\lvert Lu\rvert$ there is true but strictly weaker than the printed statement. |
| 5 | Writing the estimates with real-valued `sSup`. | A real `sSup` over an unbounded set returns $0$. If $\sup_\Omega\lvert Lu\rvert = \infty$ the right side collapses to $0$ and the second estimate becomes a false claim rather than a trivial one. |
| 6 | Adding "$\partial\Omega \ne \emptyset$" as a hypothesis, or excluding $\Omega = \mathbb{R}^d$. | Krylov explicitly allows the boundaryless case; excluding it drops part of the theorem. |
| 7 | Assuming an equation such as $Lu = f$. | No equation is assumed. The theorem is an a priori bound valid for every admissible $u$, and imposing an equation makes it a different, weaker statement. |

## Notes on the ground truth

- `SecondOrderEllipticOperator` is built on `EllipticOperatorData 2 L`, which carries a positive ellipticity constant and the bound $\kappa\lVert\xi\rVert^2 \le \sum_{\lvert\alpha\rvert = 2} a^\alpha(x)\xi^\alpha$. Krylov's maximum principle needs only degenerate ellipticity ($a \ge 0$ as a quadratic form). Assuming full uniform ellipticity only restricts the theorem, so it stays true, but it is more than the text asks for.
- The uniform coefficient bound also covers $c$. That is harmless, because $c \le -\lambda$ is only a one-sided condition.
- `EllipticOperatorData.formula` is quantified over *all* input functions, including nowhere-differentiable ones where `multiDerivative` returns $0$. So $L$ is pinned down as literally the junk-extended differential expression, rather than as an operator that merely agrees with it on $C^2$ functions.
- `functionSupNorm Ω (fun x ↦ max (u x) 0)` really is $\sup_\Omega u^+$, since the inner absolute value is applied to a quantity that is already nonnegative.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[krylov_2_9_2_bounded_maximum_principle_resolvent.md](krylov_2_9_2_bounded_maximum_principle_resolvent.md) and the background in [krylov_2_9_2_bounded_maximum_principle_resolvent.context.md](krylov_2_9_2_bounded_maximum_principle_resolvent.context.md),
not against the ground-truth Lean file: a candidate spelled differently but
mathematically equivalent to the text loses nothing. The scale is defined in
[GRADING.md](../../GRADING.md); the numbers below are this problem's instance of it.

| Band | Points | This problem |
|---|---|---|
| A. Completeness | 50 | The requirement table above has 10 rows, so each row is worth 5.0 points: full credit if the candidate states it in any equivalent form, half for a harmless strengthening or weakening, none if it is absent. |
| B. Semantic fidelity | 20 | Junk values, `ℝ` vs `ℝ≥0∞`, coercions, quantifier order, a.e. vs everywhere — see the pitfalls below. |
| C. Mathlib-concept correctness | 15 | The Mathlib notion must mean the textbook notion, with the typeclass assumptions it needs. |
| D. Non-degeneracy | 10 | Not vacuous, not trivial, not a strictly weaker theorem. |
| E. Hygiene | 5 | No needless definitions, redundant conjuncts or unused hypotheses. |

**Every row of the *Mistakes to check for* table above is a defect.** Charge each one to the band it belongs to and deduct there.

### Fatal — any of these caps the total at 25

- Requirement 7 with $c \le 0$ instead of $c \le -\lambda$ with $\lambda>0$: the estimate is then false.
- Requirement 3 with the boundedness of $u$ dropped.
- Requirement 9 with $(Lu)^-$ read as $-(Lu)$ or as $\min$, rather than as the nonnegative negative part.

### Domain-specific pitfalls for this problem

- $t^- = \max(-t,0)$ is nonnegative; getting its sign wrong reverses the first inequality.
- Junk value — supremum: the suprema are over $\Omega$ and must remain meaningful for an unbounded family, so they belong in an extended-real type or must come with a boundedness hypothesis.
- The boundary condition is conditional on $\partial\Omega \ne \emptyset$, so the whole-space case must be admitted.
- Both the one-sided and the two-sided estimate are asserted.
- Boundedness of the coefficients $a$ and $b$ is a hypothesis.
