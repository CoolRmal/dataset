# Criteria: krylov_sobolev_1_4_8_two_dim_measurable_coeff_L2_estimate

**Statement:** [krylov_sobolev_1_4_8_two_dim_measurable_coeff_L2_estimate.md](krylov_sobolev_1_4_8_two_dim_measurable_coeff_L2_estimate.md) · **Lean:** [krylov_sobolev_1_4_8_two_dim_measurable_coeff_L2_estimate.lean](krylov_sobolev_1_4_8_two_dim_measurable_coeff_L2_estimate.lean) · **Context:** [krylov_sobolev_1_4_8_two_dim_measurable_coeff_L2_estimate.context.md](krylov_sobolev_1_4_8_two_dim_measurable_coeff_L2_estimate.context.md)

## What the theorem says

In the plane, take a symmetric matrix of coefficients that is only measurable — not continuous —
and squeezed between $\mu|\xi|^2$ and $\nu|\xi|^2$. Build the operator
$Lu = a^{ij}u_{x^ix^j} - \lambda(a^{11}+a^{22})u$. Then every $C^2$ function with compact support
obeys a single inequality that controls $u$, its first derivatives and its second derivatives at
once, with the explicit constant $\nu^2/\mu^4$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The dimension is exactly $2$. | ✅ Everything is indexed by `Fin 2`. |
| 2 | The coefficients are measurable and symmetric: $a^{ij} = a^{ji}$. | ✅ `ha` and `hsymm`. |
| 3 | Ellipticity (5) is two-sided and holds for every $x$ and every $\xi$. | ✅ `hlb` and `hub`, both quantified over `x` and `ξ`. |
| 4 | $\lambda > 0$, $\mu > 0$, $\nu > 0$. | ✅ `hlam`, `hμ`, `hν`. |
| 5 | $u \in C_0^2$, i.e. twice continuously differentiable on all of $\mathbb{R}^2$ and compactly supported. | ✅ `ContDiff ℝ 2 u` and `HasCompactSupport u`. |
| 6 | The zeroth-order term of $L$ is $\lambda(a^{11}+a^{22})u$, i.e. $\lambda\,(\mathrm{tr}\,a)\,u$. | ✅ `lam * (a 0 0 x + a 1 1 x) * u x`. |
| 7 | The left side has all three groups, with weights $\lambda^2$, $2\lambda$ and $1$. | ✅ All three summands are present with those weights. |
| 8 | The second-derivative sum runs over all four ordered pairs $(j,k)$, so the mixed derivative is counted twice. | ✅ `∑ j, ∑ k, …`. |
| 9 | The constant is exactly $\nu^2/\mu^4$. | ✅ `ENNReal.ofReal (ν ^ 2 / μ ^ 4)`, not an existential. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Writing the zeroth-order term as $\lambda u$ instead of $\lambda(a^{11}+a^{22})u$. | A different operator. The trace factor is what makes the constant come out as $\nu^2/\mu^4$. |
| 2 | Summing the second derivatives over $j \le k$ only. | Halves the mixed term, so the inequality asserted is not the printed one. |
| 3 | Replacing $\nu^2/\mu^4$ by "there exists a constant $N$". | Much weaker. The exercise asks for this constant. |
| 4 | Adding $\mu \le \nu$ as a hypothesis. | It already follows from (5), so adding it is redundant clutter — harmless mathematically but not the printed hypothesis. |
| 5 | Assuming only the lower bound $\mu\lvert \xi\rvert ^2 \le a^{ij}\xi^i\xi^j$. | The upper bound by $\nu$ is what the constant $\nu^2$ refers to; without it the statement is false. |
| 6 | Assuming the coefficients are continuous or smooth. | The point of the exercise is that measurability suffices. |
| 7 | Stating the inequality between real numbers without saying $\|Lu\|_{\mathcal{L}_2}$ is finite. | Since $a$ is only measurable, finiteness should not be presupposed. Stating the inequality in `ℝ≥0∞` avoids the issue entirely. |

## Notes on the ground truth

- The norms are `eLpNorm _ 2 volume`, valued in `ℝ≥0∞`, so no finiteness is assumed anywhere.
- $|\xi|^2$ is written `∑ i, ξ i ^ 2` with `ξ : Fin 2 → ℝ`; this is the same number as `‖ξ‖ ^ 2` on `EuclideanSpace ℝ (Fin 2)` but avoids coordinate-projection noise.
- Krylov's indices $1,2$ become Lean's `0, 1 : Fin 2`, so $a^{11} + a^{22}$ is `a 0 0 x + a 1 1 x`.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[krylov_sobolev_1_4_8_two_dim_measurable_coeff_L2_estimate.md](krylov_sobolev_1_4_8_two_dim_measurable_coeff_L2_estimate.md) and the background in [krylov_sobolev_1_4_8_two_dim_measurable_coeff_L2_estimate.context.md](krylov_sobolev_1_4_8_two_dim_measurable_coeff_L2_estimate.context.md),
not against the ground-truth Lean file: a candidate spelled differently but
mathematically equivalent to the text loses nothing. The scale is defined in
[GRADING.md](../../GRADING.md); the numbers below are this problem's instance of it.

| Band | Points | This problem |
|---|---|---|
| A. Completeness | 50 | The requirement table above has 9 rows, so each row is worth 5.6 points: full credit if the candidate states it in any equivalent form, half for a harmless strengthening or weakening, none if it is absent. |
| B. Semantic fidelity | 20 | Junk values, `ℝ` vs `ℝ≥0∞`, coercions, quantifier order, a.e. vs everywhere — see the pitfalls below. |
| C. Mathlib-concept correctness | 15 | The Mathlib notion must mean the textbook notion, with the typeclass assumptions it needs. |
| D. Non-degeneracy | 10 | Not vacuous, not trivial, not a strictly weaker theorem. |
| E. Hygiene | 5 | No needless definitions, redundant conjuncts or unused hypotheses. |

**Every row of the *Mistakes to check for* table above is a defect.** Charge each one to the band it belongs to and deduct there.

### Fatal — any of these caps the total at 25

- Requirement 6 with the zeroth-order term taken as $\lambda u$ instead of $\lambda(a^{11}+a^{22})u$.
- Requirement 9 with the explicit constant $\nu^2/\mu^4$ replaced by an unspecified one.
- Requirement 7 with any of the three weights on the left wrong.

### Domain-specific pitfalls for this problem

- The shift involves the trace of the coefficient matrix, so it is $x$-dependent.
- The second-derivative sum is over ordered pairs, counting mixed derivatives twice.
- The coefficients are only measurable; assuming continuity states a different (easier) exercise.
- The ellipticity bound is two-sided, with both $\mu$ and $\nu$ used in the constant.
- The dimension is exactly $2$.
