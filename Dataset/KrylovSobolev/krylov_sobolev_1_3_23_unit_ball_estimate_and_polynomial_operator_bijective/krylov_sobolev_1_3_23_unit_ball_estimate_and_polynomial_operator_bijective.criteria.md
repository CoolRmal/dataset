# Criteria: krylov_sobolev_1_3_23_unit_ball_estimate_and_polynomial_operator_bijective

**Statement:** [krylov_sobolev_1_3_23_unit_ball_estimate_and_polynomial_operator_bijective.md](krylov_sobolev_1_3_23_unit_ball_estimate_and_polynomial_operator_bijective.md) · **Lean:** [krylov_sobolev_1_3_23_unit_ball_estimate_and_polynomial_operator_bijective.lean](krylov_sobolev_1_3_23_unit_ball_estimate_and_polynomial_operator_bijective.lean) · **Context:** [krylov_sobolev_1_3_23_unit_ball_estimate_and_polynomial_operator_bijective.context.md](krylov_sobolev_1_3_23_unit_ball_estimate_and_polynomial_operator_bijective.context.md)

## What the theorem says

Part (i): if $u$ is $C^2$ on the closed unit ball and vanishes on the boundary sphere, then $u$
and its first derivatives are controlled by $\Delta u$ in $\mathcal{L}_2(B)$, with constant $4$.
Part (ii): the map $p \mapsto \Delta[(1-|x|^2)p]$ is a bijection of the space of polynomials of
total degree at most $n$ onto itself.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. In the assessment column, ✅ means the ground truth states the requirement and
◐ means it states it in a form that deliberately departs from the text — a narrower setting, a
stronger hypothesis, or an equivalent but not literal phrasing — with the reason given. A ◐ records
a decision, not an open defect; where a more literal rendering would be at least as good, the row
says so.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $B$ is the open unit ball centred at the origin. | ✅ `Metric.ball 0 1`, and the integrals use `volume.restrict (Metric.ball 0 1)`. |
| 2 | $u$ is twice continuously differentiable on the closed ball. | ✅ `ContDiffOn ℝ 2 u (Metric.closedBall 0 1)`. |
| 3 | $u$ vanishes on the boundary sphere. | ✅ `∀ x ∈ Metric.sphere 0 1, u x = 0`. |
| 4 | The constant in (i) is exactly $4$. | ✅ `4 * eLpNorm (Δ u) 2 _ ^ 2`. |
| 5 | The left side of (i) has $u$ and its first derivatives only. | ✅ `eLpNorm u … ^ 2 + ∑ i, eLpNorm (partialDeriv i u) … ^ 2`. |
| 6 | Part (ii) says $A$ maps degree $\le n$ into degree $\le n$ and is a bijection there. | ✅ `Set.BijOn A {p \| p.totalDegree ≤ n} {p \| p.totalDegree ≤ n}`, which forces both. |
| 7 | Part (ii) holds for every $n$. | ✅ `∀ n : ℕ`. |
| 8 | Both parts are asserted. | ✅ A conjunction. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Replacing the boundary condition by compact support inside $B$. | A strictly stronger hypothesis, so the theorem proved would be weaker. Krylov allows $u$ to be non-zero right up to the sphere. |
| 2 | Replacing $4$ by "there exists $N$". | The constant is explicit and comes from the specific multiplier $(2-\lvert x\rvert ^2)$ used in the proof. |
| 3 | Including second derivatives on the left of (i). | That is part (iii) of the exercise, which has the constant $5$ and is not formalized here. |
| 4 | Stating (ii) as injectivity only, or as a bijection of the space of all polynomials. | $A$ raises degree by $2$ and then lowers it by $2$; the content is that it is a bijection of each finite-dimensional piece. |
| 5 | Adding $d \ge 2$ as a hypothesis. | The hint mentions $d \ge 2$ for the proof technique, not for the statement. |
| 6 | Using `ContDiff ℝ 2 u` on all of $\mathbb{R}^d$. | The hypothesis is regularity on $\bar B$ only. |

## Notes on the ground truth

- `Δ` is Mathlib's Laplacian on functions, from `Mathlib/Analysis/InnerProductSpace/Laplacian.lean`.
- The open ball and the closed ball differ by a null set, so it makes no difference to the integrals which one carries the measure; the open ball is used because that is where the derivative is unambiguous.
- Part (ii) is expressed with `MvPolynomial.pderiv` twice per coordinate, which is the Laplacian on polynomials.
- Part (iii) of the exercise is omitted: it needs $W_2^2(B)$, a Sobolev space on a domain, which Mathlib does not have.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[krylov_sobolev_1_3_23_unit_ball_estimate_and_polynomial_operator_bijective.md](krylov_sobolev_1_3_23_unit_ball_estimate_and_polynomial_operator_bijective.md) and the background in [krylov_sobolev_1_3_23_unit_ball_estimate_and_polynomial_operator_bijective.context.md](krylov_sobolev_1_3_23_unit_ball_estimate_and_polynomial_operator_bijective.context.md),
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

- Requirement 4 with the explicit constant $4$ replaced by an unspecified one.
- Requirement 3 with the boundary condition dropped: the estimate is then false.
- Requirement 6 with $A$ not asserted to map $P_n$ into $P_n$, or invertibility claimed only for one $n$.

### Domain-specific pitfalls for this problem

- The left side of (i) involves $u$ and its first derivatives, squared in $\mathcal{L}_2(B)$; second derivatives do not appear.
- $u$ is $C^2$ on the *closed* ball while the norms are over the *open* ball.
- "Degree $\le n$" is total degree in $d$ variables.
- That $Ap$ again has degree $\le n$ is part of what must be stated.
- Both parts are asserted.
