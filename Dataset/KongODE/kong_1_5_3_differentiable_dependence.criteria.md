# Criteria: kong_1_5_3_differentiable_dependence

**Statement:** [kong_1_5_3_differentiable_dependence.md](kong_1_5_3_differentiable_dependence.md) · **Lean:** [kong_1_5_3_differentiable_dependence.lean](kong_1_5_3_differentiable_dependence.lean)

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
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $D$ is an **open** subset of $\mathbb{R} \times \mathbb{R}^n \times \mathbb{R}^k$. | ✅ `hD : IsOpen D`. |
| 2 | $f$ is continuous on $D$ and has continuous partial derivatives in $x$ and in $\mu$ there. | ⚠️ `hf : ContDiffOn ℝ 1 (fun p ↦ f p.1 p.2.1 p.2.2) D` also demands differentiability in $t$, which Kong does not assume. It is a stronger hypothesis, so the formalized theorem is weaker than the printed one. A faithful version would assume `ContinuousOn` of $f$ plus `ContinuousOn` of the two partial derivatives. |
| 3 | For every initial datum $(t_0, x_0, \mu) \in D$ there is an **open interval** of existence containing $t_0$, and it may depend on that datum. | ✅ `I : ℝ → (Fin n → ℝ) → (Fin k → ℝ) → Set ℝ` with `IsOpen (I t₀ x₀ μ)`, `(I t₀ x₀ μ).OrdConnected` and `t₀ ∈ I t₀ x₀ μ`. |
| 4 | On that interval the function solves $x' = f(t,x;\mu)$ and satisfies $x(t_0) = x_0$. | ✅ `IsTrajectoryOn (I t₀ x₀ μ) (fun t y ↦ f t y μ) (fun t ↦ x t t₀ x₀ μ)` and `x t₀ t₀ x₀ μ = x₀`. |
| 5 | The solution stays in $D$, and every competitor in the uniqueness clause is required to stay in $D$ too. | ✅ `(∀ t ∈ I t₀ x₀ μ, (t, x t t₀ x₀ μ, μ) ∈ D)` and the same guard as a hypothesis on `y`. |
| 6 | The solution is unique on that interval. | ✅ `∀ y, IsTrajectoryOn … y → y t₀ = x₀ → … → Set.EqOn y (fun t ↦ x t t₀ x₀ μ) (I t₀ x₀ μ)`. |
| 7 | The flow is $C^1$ jointly in $(t, t_0, x_0, \mu)$ on the set where it is defined. | ✅ `ContDiffOn ℝ 1 (fun p ↦ x p.1 p.2.1 p.2.2.1 p.2.2.2) flowDomain` where `flowDomain = {p \| p.1 ∈ I p.2.1 p.2.2.1 p.2.2.2}`. |
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

## Notes on the ground truth

- Differentiability of the flow is carried by the `ContDiffOn ℝ 1 … flowDomain` clause, and the three variational conclusions are then written with `fderiv`. Part (b) cannot degenerate (the junk value $0$ is not the identity when $n \ge 1$), but part (a) leans on that clause. A formulation using `HasFDerivAt` — asserting differentiability and naming the derivative in one breath — would be free of that hazard.
- The `fderiv` used is the ambient one, not `fderivWithin D`. That is legitimate only because $D$ is open, which is why row 1 of the mistakes table matters twice over.
- Derivatives with values in $\mathbb{R}^{n\times n}$ and $\mathbb{R}^{n\times k}$ are written as continuous linear maps rather than `Matrix`, with `.comp` playing the role of the matrix product $Jz$. This is the idiomatic choice and is equivalent.
- "Open interval" is expressed as `IsOpen` together with `OrdConnected`. Mathlib has no packaged flow-domain API for time-dependent fields, so `flowDomain` is assembled by hand.
