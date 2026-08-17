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
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $0 < \delta < 1$. | ✅ `hδ : 0 < δ ∧ δ < 1`. |
| 2 | The datum lies in the parabolic Hölder space $C^{\delta/2,\,\delta}$: $\delta$-Hölder in $x$, $(\delta/2)$-Hölder in $t$. | ✅ `ParabolicHolderOn δ univ f`, which asserts the two slice-wise conditions **and** a single constant $C$ with the sup bound $|f| \le C$ and the joint quotient $|f(p)-f(q)| \le C(\|p_x-q_x\|^\delta + |p_t-q_t|^{\delta/2})$ over the whole domain. |
| 3 | The solution lies in $C^{1+\delta/2,\,2+\delta}$. | ✅ `ParabolicHolderOn (2 + δ) univ u`: the slice-wise clauses give $C^{2+\delta}$ in $x$ and $C^{1+\delta/2}$ in $t$, and the mixed clause decomposes $2+\delta = k + \delta'$ with $k = 2$, $\delta' = \delta$, imposing one constant uniform over the domain: sup bounds on $u$, $D_xu$, $D_x^2u$, $u_t$, the anisotropic $(\delta,\delta/2)$ quotients on the top-order data $D_x^2u$ and $u_t$, and the exponent-$(1+\delta)/2$ time quotient on $D_xu$ — the right data for $C^{1+\delta/2,\,2+\delta}$. |
| 4 | The equation is $\Delta u - u_t - u = f$, with $\Delta$ acting in the space variables only. | ✅ `ShiftedHeatEquation u f : ∀ t x, laplacian (fun y ↦ u (t, y)) x - deriv (fun s ↦ u (s, x)) t - u (t, x) = f (t, x)`; the Laplacian is applied to the frozen-time slice. |
| 5 | The zeroth-order shift $-u$ is present. | ✅ The `- u (t, x)` summand. |
| 6 | The equation holds pointwise everywhere on $\mathbb{R}^{d+1}$, classically. | ✅ `∀ t x, …`, with `univ` used for both the datum and the solution. |
| 7 | Existence **and** uniqueness, with uniqueness relative to the same regularity class. | ✅ `∃! u, ParabolicHolderOn (2 + δ) univ u ∧ ShiftedHeatEquation u f`. On the whole space, `∃!` on global functions is the right notion. |
| 8 | The regularity assumption must accompany the equation, so that `Δ` and `deriv` are the classical objects. | ✅ `ParabolicHolderOn` supplies `ContDiffOn ℝ 2` in $x$ and `ContDiffOn ℝ 1` in $t$ on `univ`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Dropping the $-u$ term and writing $\Delta u - u_t = f$. | Uniqueness then fails on the whole space: $u \equiv 1$ and $u \equiv 0$ both solve it with $f = 0$, and both are as smooth as required. The shift is exactly what Krylov's $-u$ buys. |
| 2 | Turning $-u_t$ into $+u_t$. | That is the backward heat equation, which is ill-posed; the theorem asserted would be false. |
| 3 | Using $\delta$ rather than $\delta/2$ for the time exponent, or $1+\delta$ rather than $1+\delta/2$. | The parabolic scaling gives time half the weight of space. With the wrong exponents both the hypothesis and the conclusion describe different function spaces. |
| 4 | Asserting existence only, or stating uniqueness without re-imposing the regularity on the competitor. | Uniqueness genuinely fails in a larger class, so the regularity has to appear in the uniqueness clause. |
| 5 | Stating the PDE for a merely continuous or merely measurable $u$. | `Δ` and `deriv` return $0$ wherever the function is not differentiable. Any nowhere-differentiable $u$ would then "solve" the equation with $f = -u$, so the equation alone constrains nothing. |
| 6 | Adding an initial condition, or restricting to $t \ge 0$. | The theorem is posed on all of $\mathbb{R}^{d+1}$, with no initial surface and no boundary; the uniqueness is two-sided in time. |
| 7 | Letting $\Delta$ act on all $d+1$ variables. | $\Delta$ is the spatial Laplacian only; including $\partial_t^2$ would give an elliptic operator in space-time, a different equation. |
| 8 | Imposing the joint Hölder quotient of exponent $r$ on $u$ itself when $r > 1$ — e.g. requiring $|u(p)-u(q)| \le C(\|p_x-q_x\|^{2+\delta} + |p_t-q_t|^{1+\delta/2})$ for the solution class. | A Hölder quotient with exponent $>1$ forces every derivative to vanish, so the "class" contains only constant functions and the asserted $\exists!$ fails for every nonconstant $f$. The exponents must fall on the top-order derivatives, never on $u$ itself. An earlier version of the ground truth had exactly this defect in `ParabolicHolderOn`'s mixed clause; the current definition incorporates the repair. |

## Notes on the ground truth

- `ParabolicHolderOn r Q u` now encodes Krylov's $\lvert u\rvert_{r/2,\,r}$ data directly. Besides the two slice-wise conjuncts — `HolderOn r` on each time slice and `HolderOnReal (r/2)` on each spatial fibre, which carry the `ContDiffOn` clauses that make the derivatives classical — its mixed clause decomposes $r = k + \delta'$ with $0 \le \delta' < 1$ and demands a *single* constant $C$, uniform over $Q$: sup bounds on every spatial derivative of order $\le k$ and every time derivative of parabolic weight $2j \le k$, the anisotropic $(\delta',\delta'/2)$ quotients of the top-order data ($\lvert\alpha\rvert = k$ and $2j = k$), and the exponent-$(1+\delta')/2$ time quotient on the spatial derivatives of order $k-1$. At $r = 2+\delta$ this is exactly $u$, $D_xu$, $D_x^2u$, $u_t$ bounded, $D_x^2u$ and $u_t$ Hölder-$(\delta,\delta/2)$, and $D_xu$ Hölder-$(1+\delta)/2$ in $t$; at $r = \delta$ the top order is $u$ itself and the clause is the joint $(\delta,\delta/2)$ quotient. An earlier version instead imposed the exponent-$r$ joint quotient on $u$ itself, which forces local constancy for $r > 1$; the current definition incorporates the repair (see mistake 8).
- `HolderOnReal r I u` contributes no supremum bound of its own, but the mixed clause's sup bounds on the time derivatives of parabolic weight $\le k$ close that gap: $u(t,x) = t$ is not `ParabolicHolderOn` at any $r$, since $\lvert u\rvert \le C$ fails on `univ`.
- The parts of `ParabolicHolderOn` are written in different styles: `HolderOnReal` uses mathlib's `HolderOnWith` and `iteratedDeriv`, whereas the spatial `holderGauge` and the mixed clause hand-roll their difference quotients (the mixed clause from the global `multiDerivative`/`iteratedDeriv`, classical objects on `univ`).
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
