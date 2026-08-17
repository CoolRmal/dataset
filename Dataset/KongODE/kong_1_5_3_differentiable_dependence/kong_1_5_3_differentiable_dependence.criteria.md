# Criteria: kong_1_5_3_differentiable_dependence

**Statement:** [kong_1_5_3_differentiable_dependence.md](kong_1_5_3_differentiable_dependence.md) · **Lean:** [kong_1_5_3_differentiable_dependence.lean](kong_1_5_3_differentiable_dependence.lean) · **Context:** [kong_1_5_3_differentiable_dependence.context.md](kong_1_5_3_differentiable_dependence.context.md)

## What the theorem says

Consider $x' = f(t, x; \mu)$ with initial condition $x(t_0) = x_0$, where $\mu$ is a parameter
vector. If $f$ and its partial derivatives in $x$ and in $\mu$ are continuous on the open set $D$,
then the problem has a unique solution $x(t; t_0, x_0, \mu)$, and this solution depends on
$t_0$, $x_0$ and $\mu$ in a continuously differentiable way. Moreover the three partial derivatives
of the solution with respect to $\mu$, $x_0$ and $t_0$ can be computed: each solves the same linear
equation $z' = J z$ driven by the Jacobian $J = \partial f/\partial x$ taken along the solution, only
with different starting data — $0$ plus an extra forcing term $\partial f/\partial \mu$ for the
$\mu$-derivative, the identity matrix for the $x_0$-derivative, and $-f(t_0, x_0; \mu)$ for the
$t_0$-derivative.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $D$ is an **open** subset of $\mathbb{R} \times \mathbb{R}^n \times \mathbb{R}^k$. | ✅ `hD : IsOpen D`. |
| 2 | $f$ is continuous on $D$ and has continuous partial derivatives in $x$ and in $\mu$ there. | ✅ `ContinuousOn f D` together with differentiability in $x$ and in $\mu$ at each point of $D$ and `ContinuousOn` of those two partial derivatives. No differentiability in $t$ is assumed, matching Kong. |
| 3 | For every initial datum $(t_0, x_0, \mu) \in D$ there is an **open interval** of existence containing $t_0$, and it may depend on that datum. | ✅ `I : ℝ → (Fin n → ℝ) → (Fin k → ℝ) → Set ℝ` with `IsOpen (I t₀ x₀ μ)`, `(I t₀ x₀ μ).OrdConnected` and `t₀ ∈ I t₀ x₀ μ`. |
| 4 | On that interval the function solves $x' = f(t,x;\mu)$ and satisfies $x(t_0) = x_0$. | ✅ `IsTrajectoryOn (I t₀ x₀ μ) (fun t y ↦ f t y μ) (fun t ↦ x t t₀ x₀ μ)` and `x t₀ t₀ x₀ μ = x₀`. |
| 5 | The solution stays in $D$, and every competitor in the uniqueness clause is required to stay in $D$ too. | ✅ `(∀ t ∈ I t₀ x₀ μ, (t, x t t₀ x₀ μ, μ) ∈ D)` and the same guard as a hypothesis on `y`. |
| 6 | The solution is unique on that interval. | ✅ `∀ y, IsTrajectoryOn … y → y t₀ = x₀ → … → Set.EqOn y (fun t ↦ x t t₀ x₀ μ) (I t₀ x₀ μ)`. |
| 7 | The flow is $C^1$ jointly in $(t, t_0, x_0, \mu)$ on the set where it is defined, and that set is open. | ✅ `IsOpen flowDomain ∧ ContDiffOn ℝ 1 (fun p ↦ x p.1 p.2.1 p.2.2.1 p.2.2.2) flowDomain` where `flowDomain = {p \| p.1 ∈ I p.2.1 p.2.2.1 p.2.2.2}`. |
| 8 | (a) $\partial x/\partial\mu$ starts at $0$ and solves $z' = Jz + \partial f/\partial\mu$, both evaluated along the solution. | ✅ `z t₀ = 0` and `HasDerivAt z ((fderiv ℝ (fun y ↦ f t y μ) (x t t₀ x₀ μ)).comp (z t) + fderiv ℝ (fun η ↦ f t (x t t₀ x₀ μ) η) μ) t`. |
| 9 | (b) $\partial x/\partial x_0$ starts at the identity matrix and solves $z' = Jz$. | ✅ `z t₀ = ContinuousLinearMap.id ℝ (Fin n → ℝ)` and `HasDerivAt z ((fderiv ℝ (fun y ↦ f t y μ) (x t t₀ x₀ μ)).comp (z t)) t`. |
| 10 | (c) $\partial x/\partial t_0$ starts at $-f(t_0,x_0;\mu)$ and solves $z' = Jz$, with $J$ applied to a vector. | ✅ `z t₀ = -f t₀ x₀ μ` and `HasDerivAt z ((fderiv ℝ (fun y ↦ f t y μ) (x t t₀ x₀ μ)) (z t)) t`. |
| 11 | In all three, $J$ is the derivative of $f$ in $x$ taken at the point $x(t;t_0,x_0,\mu)$ on the solution, not at a fixed point. | ✅ Every occurrence is `fderiv ℝ (fun y ↦ f t y μ) (x t t₀ x₀ μ)`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Omitting `IsOpen D`. | The statement then becomes false. Take $n = k = 1$, $f \equiv 1$ (smooth everywhere, so the regularity hypothesis holds for any $D$) and $D = \mathbb{R} \times \{0\} \times \{0\}$. The requirement that the solution stay in $D$ forces $x \equiv 0$ on a nonempty open interval, so its derivative is $0$; but the equation demands derivative $1$. |
| 2 | Giving all three variational problems the same initial value $0$. | Only (a) starts at $0$. (b) starts at the identity and (c) at $-f(t_0,x_0;\mu)$; with the wrong starting values the conclusions are simply false. |
| 3 | Evaluating $\partial f/\partial x$ at $x_0$, or at some fixed point, instead of along the solution. | $J$ is a time-dependent matrix; freezing it turns the variational equation into a constant-coefficient equation with a different solution. |
| 4 | Keeping only existence, uniqueness and part (b). | Kong states four things: existence and uniqueness, $C^1$ dependence, and all three variational problems. Each is separate content. |
| 5 | Dropping the requirement that the competitor `y` stays in $D$. | Uniqueness is then false: `f` is a total function whose values outside $D$ are unconstrained, so a competitor can leave $D$ and follow those arbitrary values. |
| 6 | Stating the three conclusions purely with `fderiv`/`deriv` and no separate differentiability claim. | `fderiv` returns `0` where the function is not differentiable. Part (a) would then be satisfied for free by the junk value $0$ whenever $\partial f/\partial\mu = 0$, no matter how badly behaved the flow is. |
| 7 | Using a single interval of existence, the same for all initial data. | The interval genuinely shrinks near the boundary of $D$; a uniform interval is false. |
| 8 | Asserting `ContDiffOn` of the flow on its domain without asserting that domain open, while writing the variational conclusions with the ambient `fderiv`/`deriv`. | On a non-open set `ContDiffOn` does not yield ambient differentiability, so the ambient `fderiv` in the conclusions could be the junk value `0` and the variational claims would assert nothing — mistake 6's hazard through the back door. The ground truth incorporates the repair: `IsOpen flowDomain` is asserted alongside the `ContDiffOn` clause, so the ambient derivatives of the flow are honest. |

## Notes on the ground truth

- Differentiability of the flow is carried by the `IsOpen flowDomain ∧ ContDiffOn ℝ 1 … flowDomain` clause, and the three variational conclusions are then written with `fderiv`. Because the flow's domain is asserted open, `ContDiffOn` there yields honest ambient differentiability at every point of the domain, so those `fderiv`s cannot silently be the junk value $0$. A formulation using `HasFDerivAt` — asserting differentiability and naming the derivative in one breath — is an equally good spelling.
- The `fderiv` of $f$ itself is the ambient one, not `fderivWithin D`. That is legitimate only because $D$ is open, which is why row 1 of the mistakes table matters twice over; the ambient derivatives of the flow are likewise legitimate only because `IsOpen flowDomain` is part of the statement (mistake 8).
- Derivatives with values in $\mathbb{R}^{n\times n}$ and $\mathbb{R}^{n\times k}$ are written as continuous linear maps rather than `Matrix`, with `.comp` playing the role of the matrix product $Jz$. This is the idiomatic choice and is equivalent.
- "Open interval" is expressed as `IsOpen` together with `OrdConnected`. Mathlib has no packaged flow-domain API for time-dependent fields, so `flowDomain` is assembled by hand.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[kong_1_5_3_differentiable_dependence.md](kong_1_5_3_differentiable_dependence.md) and the background in [kong_1_5_3_differentiable_dependence.context.md](kong_1_5_3_differentiable_dependence.context.md),
not against the ground-truth Lean file: a candidate spelled differently but
mathematically equivalent to the text loses nothing. The scale is defined in
[GRADING.md](../../GRADING.md); the numbers below are this problem's instance of it.

| Band | Points | This problem |
|---|---|---|
| A. Completeness | 50 | The requirement table above has 11 rows, so each row is worth 4.5 points: full credit if the candidate states it in any equivalent form, half for a harmless strengthening or weakening, none if it is absent. |
| B. Semantic fidelity | 20 | Junk values, `ℝ` vs `ℝ≥0∞`, coercions, quantifier order, a.e. vs everywhere — see the pitfalls below. |
| C. Mathlib-concept correctness | 15 | The Mathlib notion must mean the textbook notion, with the typeclass assumptions it needs. |
| D. Non-degeneracy | 10 | Not vacuous, not trivial, not a strictly weaker theorem. |
| E. Hygiene | 5 | No needless definitions, redundant conjuncts or unused hypotheses. |

**Every row of the *Mistakes to check for* table above is a defect.** Charge each one to the band it belongs to and deduct there.

### Fatal — any of these caps the total at 25

- Requirement 11 with $J$ evaluated at the initial point rather than along the solution.
- Requirement 10 with the sign of the initial value $-f(t_0,x_0;\mu)$ wrong.
- Requirement 8 with the inhomogeneous term of the $\mu$-variational equation dropped.

### Domain-specific pitfalls for this problem

- The three variational equations share a coefficient and are distinguished only by their initial data; getting one initial value wrong states a different theorem.
- $\partial x/\partial x_0$ is matrix-valued, with initial value the identity matrix.
- The domain $D$ is open, and the interval of existence is open.
- $C^1$ dependence is joint in all four arguments.
- Every solution and competitor must stay inside $D$.
