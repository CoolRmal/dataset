# Criteria: krylov_8_7_3_shifted_heat_holder_solvability

**Statement:** [krylov_8_7_3_shifted_heat_holder_solvability.md](krylov_8_7_3_shifted_heat_holder_solvability.md) · **Lean:** [krylov_8_7_3_shifted_heat_holder_solvability.lean](krylov_8_7_3_shifted_heat_holder_solvability.lean) · **Context:** [krylov_8_7_3_shifted_heat_holder_solvability.context.md](krylov_8_7_3_shifted_heat_holder_solvability.context.md)

## What the theorem says

On all of space-time $\mathbb{R}^{d+1}$, the shifted heat equation $\Delta u - u_t - u = f$ has
exactly one solution for each datum, in the parabolic Hölder scale: if $f$ is $\delta$-Hölder in the
space variable and $(\delta/2)$-Hölder in time, then there is a unique $u$ whose second space
derivatives and first time derivative exist and enjoy the same Hölder regularity. The parabolic
scaling gives the time direction half the weight of a space direction, so $2+\delta$ space
derivatives correspond to $1 + \delta/2$ time derivatives. There is no initial condition: both time
directions are included, and the $-u$ term is what makes the problem uniquely solvable.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. In the assessment column, ✅ means the ground truth states the requirement and
◐ means it states it in a form that deliberately departs from the text — a narrower setting, a
stronger hypothesis, or an equivalent but not literal phrasing — with the reason given. A ◐ records
a decision, not an open defect; where a more literal rendering would be at least as good, the row
says so.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $0 < \delta < 1$. | ✅ `hδ : 0 < δ ∧ δ < 1`. |
| 2 | The datum lies in the parabolic Hölder space $C^{\delta/2,\,\delta}$: $\delta$-Hölder in $x$, $(\delta/2)$-Hölder in $t$. | ✅ `ParabolicHolderOn δ univ f`, which asserts the two slice-wise conditions **and** a single constant $C$ with $|u(p)-u(q)| \le C(\|p_x-q_x\|^\delta + |p_t-q_t|^{\delta/2})$ over the whole domain. |
| 3 | The solution lies in $C^{1+\delta/2,\,2+\delta}$: two space derivatives and one time derivative, Hölder at the top order with the parabolic exponents. | ◐ `ParabolicHolderOn (2 + δ) univ u` gives `HolderOn (2+δ)` in $x$ and `HolderOnReal ((2+δ)/2)` in $t$, whose unique decomposition is $k = 1$, $\delta' = \delta/2$ — the right exponents, with the same slice-wise weakness. |
| 4 | The equation is $\Delta u - u_t - u = f$, with $\Delta$ acting in the space variables only. | ✅ `ShiftedHeatEquation u f : ∀ t x, laplacian (fun y ↦ u (t, y)) x - deriv (fun s ↦ u (s, x)) t - u (t, x) = f (t, x)`; the Laplacian is applied to the frozen-time slice. |
| 5 | The zeroth-order shift $-u$ is present. | ✅ The `- u (t, x)` summand. |
| 6 | The equation holds pointwise everywhere on $\mathbb{R}^{d+1}$, classically. | ✅ `∀ t x, …`, with `univ` used for both the datum and the solution. |
| 7 | Existence **and** uniqueness, with uniqueness relative to the same regularity class. | ✅ `∃! u, ParabolicHolderOn (2 + δ) univ u ∧ ShiftedHeatEquation u f`. On the whole space, `∃!` on global functions is the right notion. |
| 8 | The regularity assumption must accompany the equation, so that `laplacian` and `deriv` are the classical objects. | ✅ `ParabolicHolderOn` supplies `ContDiffOn ℝ 2` in $x$ and `ContDiffOn ℝ 1` in $t$ on `univ`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Dropping the $-u$ term and writing $\Delta u - u_t = f$. | Uniqueness then fails on the whole space: $u \equiv 1$ and $u \equiv 0$ both solve it with $f = 0$, and both are as smooth as required. The shift is exactly what Krylov's $-u$ buys. |
| 2 | Turning $-u_t$ into $+u_t$. | That is the backward heat equation, which is ill-posed; the theorem asserted would be false. |
| 3 | Using $\delta$ rather than $\delta/2$ for the time exponent, or $1+\delta$ rather than $1+\delta/2$. | The parabolic scaling gives time half the weight of space. With the wrong exponents both the hypothesis and the conclusion describe different function spaces. |
| 4 | Asserting existence only, or stating uniqueness without re-imposing the regularity on the competitor. | Uniqueness genuinely fails in a larger class, so the regularity has to appear in the uniqueness clause. |
| 5 | Stating the PDE for a merely continuous or merely measurable $u$. | `laplacian` and `deriv` return $0$ wherever the function is not differentiable. Any nowhere-differentiable $u$ would then "solve" the equation with $f = -u$, so the equation alone constrains nothing. |
| 6 | Adding an initial condition, or restricting to $t \ge 0$. | The theorem is posed on all of $\mathbb{R}^{d+1}$, with no initial surface and no boundary; the uniqueness is two-sided in time. |
| 7 | Letting $\Delta$ act on all $d+1$ variables. | $\Delta$ is the spatial Laplacian only; including $\partial_t^2$ would give an elliptic operator in space-time, a different equation. |

## Notes on the ground truth

- The main fidelity gap is the definition of the anisotropic spaces. Krylov's $\lvert u\rvert_{1+\delta/2,\,2+\delta}$ is a *single* finite quantity: $u$, $D_xu$, $D_x^2u$ and $u_t$ bounded on $\mathbb{R}^{d+1}$, with $D_x^2u$ and $u_t$ Hölder-$\delta$ in $x$ and Hölder-$\delta/2$ in $t$, all constants uniform in the other variable, plus a mixed condition on $D_xu$ (Hölder-$(1+\delta)/2$ in $t$). `ParabolicHolderOn r Q u` instead asks for `HolderOn r` on each time slice and `HolderOnReal (r/2)` on each spatial fibre, separately, with no uniformity across slices and no mixed condition. It is strictly weaker. The consequence is two-sided: the existence half claims less than the text, and the uniqueness half claims more, since it rules out competitors from a larger class.
- `HolderOnReal r I u` contributes no supremum bound at all, unlike `holderGauge`, which does include $\sup\lvert D^\alpha u\rvert$ for $\lvert\alpha\rvert \le k$. So $u(t,x) = t$ counts as "$C^{1+\delta/2}$ in $t$", and functions unbounded in time are admitted. Adding a bound on $u$ and its time derivatives would match the text.
- The two halves of `ParabolicHolderOn` are written in different styles: `HolderOnReal` uses mathlib's `HolderOnWith` and `iteratedDeriv`, whereas the spatial `holderGauge` hand-rolls its difference quotient.
- Points of $\mathbb{R}^{d+1}$ are `ℝ × EuclideanSpace ℝ (Fin d)` with time first, used consistently.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[krylov_8_7_3_shifted_heat_holder_solvability.md](krylov_8_7_3_shifted_heat_holder_solvability.md) and the background in [krylov_8_7_3_shifted_heat_holder_solvability.context.md](krylov_8_7_3_shifted_heat_holder_solvability.context.md),
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

- Requirement 5 with the zeroth-order shift $-u$ dropped: uniqueness then fails.
- Requirement 4 with $\Delta$ taken over all $d+1$ variables.
- Requirement 7 with existence only, or uniqueness only.

### Domain-specific pitfalls for this problem

- The Laplacian is spatial; the time derivative appears separately.
- The parabolic Hölder exponents are locked by the scaling: $(\delta/2,\delta)$ for the datum and $(1+\delta/2,2+\delta)$ for the solution.
- Junk value — `deriv`: the equation is meaningful only together with the regularity assumption that makes the derivatives exist.
- Uniqueness is within the stated class.
