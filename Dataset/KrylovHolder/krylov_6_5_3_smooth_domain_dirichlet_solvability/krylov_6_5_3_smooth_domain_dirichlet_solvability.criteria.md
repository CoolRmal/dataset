# Criteria: krylov_6_5_3_smooth_domain_dirichlet_solvability

**Statement:** [krylov_6_5_3_smooth_domain_dirichlet_solvability.md](krylov_6_5_3_smooth_domain_dirichlet_solvability.md) · **Lean:** [krylov_6_5_3_smooth_domain_dirichlet_solvability.lean](krylov_6_5_3_smooth_domain_dirichlet_solvability.lean) · **Context:** [krylov_6_5_3_smooth_domain_dirichlet_solvability.context.md](krylov_6_5_3_smooth_domain_dirichlet_solvability.context.md)

## What the theorem says

This is classical Schauder solvability of the Dirichlet problem. On a bounded domain of class
$C^{k+2+\delta}$ (Definition 6.1.6: boundary-straightening maps with uniformly controlled Hölder
norms and Lipschitz inverses), with $L = a^{ij}D_{ij} + b^iD_i + c$ a second-order operator whose
real coefficients are defined on all of $\mathbb{R}^d$, $a$ symmetric, $c \le 0$, uniformly
elliptic with constant $\kappa > 0$, and globally bounded by $|a,b,c|_{k+\delta} \le K$, every
pair of data — $f$ in $C^{k+\delta}(\Omega)$ and $g$ in $C^{k+2+\delta}(\bar\Omega)$ — admits
exactly one solution $u$ in $C^{k+2+\delta}(\bar\Omega)$ of $Lu = f$ inside $\Omega$ with $u = g$
on the boundary. Both the regularity of the solution and the uniqueness live on the closure.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $k \ge 0$ is an integer and $0 < \delta < 1$. | ✅ `k : ℕ`, `hδ : 0 < δ ∧ δ < 1`. |
| 2 | $\Omega$ is a bounded, nonempty, open set of class $C^{k+2+\delta}$ in the sense of Definition 6.1.6 — boundary-straightening maps with uniform bounds, not a smoothness assumption. | ✅ `hΩ : IsDomainOfClass (k + 2) δ Ω`: `IsOpen Ω ∧ Bornology.IsBounded Ω ∧ Ω.Nonempty` plus one pair `K₀ ρ₀ > 0` serving every `x₀ ∈ frontier Ω`, a bijection `ψ` of `Metric.ball x₀ ρ₀` onto an open `D` with two-sided inverse `φ`, `ψ x₀ = 0`, `Ω` mapped into `{y | 0 < y j}` and the boundary onto `D ∩ {y | y j = 0}`, `supSeminorm s … ≤ K₀` for every `s ≤ k + 2` and `holderSeminorm (k + 2) δ … ≤ K₀` for both `ψ` and `φ`, and `φ` Lipschitz with constant `K₀`. |
| 3 | $L$ is the explicit second-order operator $a^{ij}D_{ij}u + b^iD_iu + cu$ with **real** coefficients defined on all of $\mathbb{R}^d$ and $a$ symmetric. | ✅ `a : EuclideanSpace ℝ (Fin d) → Fin d → Fin d → ℝ`, `b`, `c` likewise real-valued and total; the equation uses `secondOrderOperator a b c`, which is $\sum_{ij} a^{ij}D_iD_ju + \sum_i b^iD_iu + cu$ with classical iterated derivatives; `hsym : ∀ x i j, a x i j = a x j i`. |
| 4 | Uniform ellipticity with a single constant $\kappa > 0$: $a^{ij}(x)\xi_i\xi_j \ge \kappa|\xi|^2$ for all $x, \xi$. | ✅ `hκ : 0 < κ` and `hell : ∀ x ξ, κ * ‖ξ‖ ^ 2 ≤ ∑ i, ∑ j, a x i j * ξ i * ξ j`, with `κ` fixed before `x` and `ξ`. |
| 5 | The zeroth-order coefficient satisfies $c \le 0$ everywhere. | ✅ `hc : ∀ x, c x ≤ 0`. |
| 6 | The global bound $\lvert a,b,c\rvert_{k+\delta} \le K$ on $\mathbb{R}^d$: the coefficients lie in $C^{k+\delta}(\mathbb{R}^d)$ with one constant $K$, not merely on $\bar\Omega$ or on compact subsets. | ✅ `haK : ∀ i j, krylovHolderNorm k δ Set.univ (fun x ↦ a x i j) ≤ ENNReal.ofReal K`, `hbK` per `i`, and `hcK` for `c` — Krylov's norm $\lvert\cdot\rvert_{k+\delta}$ over `Set.univ` $= \mathbb{R}^d$, per coefficient entry. |
| 7 | The data are $f \in C^{k+\delta}(\Omega)$ and $g \in C^{k+2+\delta}(\bar\Omega)$ — note the asymmetry between the open set and the closure. | ✅ `HolderOn (k + δ) Ω f` and `HolderOn (k + 2 + δ) (closure Ω) g`. `HolderOn` demands `ContDiffOn` through the integer part plus a finite gauge whose derivatives are taken **within** the set, so it genuinely constrains `g` at boundary points. |
| 8 | Existence of a solution in $C^{k+2+\delta}(\bar\Omega)$ — the space over the **closure**, so regularity holds up to the boundary. | ✅ `∃ u, HolderOn (k + 2 + δ) (closure Ω) u ∧ …`: `ContDiffOn ℝ (k + 2) u (closure Ω)` plus a finite within-`closure Ω` Hölder gauge, so $u$ is classical up to $\partial\Omega$ and in particular continuous on $\bar\Omega$. |
| 9 | The solution solves the problem: $Lu = f$ in $\Omega$ and $u = g$ on $\partial\Omega$. | ✅ `(∀ x ∈ Ω, secondOrderOperator a b c u x = f x) ∧ (∀ x ∈ frontier Ω, u x = g x)`. |
| 10 | Uniqueness within the same class $C^{k+2+\delta}(\bar\Omega)$, stated on the set where the problem lives. | ✅ `∀ v, HolderOn (k + 2 + δ) (closure Ω) v → (∀ x ∈ Ω, secondOrderOperator a b c v x = f x) → (∀ x ∈ frontier Ω, v x = g x) → Set.EqOn v u (closure Ω)`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Requiring the boundary to be smooth — a $C^\infty$ defining function, a `ContDiff ℝ ∞` (or `⊤`) parametrization, a smooth-manifold boundary — instead of class $C^{k+2+\delta}$. | Theorem 6.5.3 assumes only the Definition 6.1.6 structure: straightening maps with $[\psi]_s, [\psi^{-1}]_s \le K_0$ for $s \in [0, k+2+\delta]$ and a Lipschitz inverse. $C^\infty$ domains are a strict subfamily, so the candidate proves a restricted theorem — the smooth case is the separate Corollary 6.5.4. Worse, in current mathlib `⊤` in the smoothness exponent means `ω`, real-analytic, restricting further still. |
| 2 | Placing the solution or the uniqueness competitors in $C^{k+2+\delta}$ of the **open** $\Omega$ instead of $\bar\Omega$. | Up-to-the-boundary regularity is the content of the theorem, and uniqueness within the open-set class is false: with $\Omega$ the unit ball, $L = \Delta$ and $f = g = 0$, both $u \equiv 0$ and $v = \mathbf{1}_\Omega$ qualify — $v$ is locally constant on the open set $\Omega$, so it is smooth there with finite gauge, harmonic there, and equal to $0$ on the frontier — yet $v \ne u$ on $\Omega$. The same counterexample kills any notion of "solution" that omits continuity up to $\bar\Omega$: Lean functions are total, so boundary values would otherwise be free parameters unconnected to the interior. |
| 3 | Omitting the sign condition on the zeroth-order coefficient. | Without $c \le 0$ the operator can have a Dirichlet eigenvalue. Take $L = \Delta + \lambda_1$ on the unit ball with $\lambda_1$ its first Dirichlet eigenvalue, and $f = g = 0$: the eigenfunction $\varphi_1$ and $0$ are both smooth solutions, so uniqueness fails. |
| 4 | Stating ellipticity pointwise ($a(x)$ positive definite at each $x$) without the uniform constant, or quantifying $\kappa$ after $x$. | The standing assumption is one $\kappa > 0$ for all $x$ and $\xi$; with ellipticity allowed to degenerate the Schauder estimates and the solvability both fail. "Each point has its own $\kappa$" is a different, weaker hypothesis. |
| 5 | Taking the coefficient bound $\lvert a,b,c\rvert_{k+\delta} \le K$ only on compact subsets of $\Omega$, or dropping the bound on $b$ or $c$. | This is a global (up to the boundary) theorem resting on the Chapter 6 standing assumption of a single bound $K$ on all of $\mathbb{R}^d$. A compact-subsets reading turns the statement toward the interior regularity theorem 7.1.2 — a different theorem, wrong here. |
| 6 | Stating uniqueness as a bare `∃!` over global functions. | That would compare $u$ and $v$ at points outside $\bar\Omega$, where the problem asserts nothing, so no solution could ever be unique. `Set.EqOn … (closure Ω)` is the right notion. |
| 7 | Dropping the uniqueness clause, or dropping the regularity hypothesis on the competitor $v$. | Existence alone is a weaker theorem, and uniqueness genuinely fails in a larger regularity class — mistake 2's indicator function is the witness. |
| 8 | Encoding "$u \in C^{k+2+\delta}(\bar\Omega)$" as finiteness of the Hölder gauge alone, without requiring the derivatives to exist. | The gauge is built from within-set derivatives, which return $0$ off the differentiability locus, so a bounded nowhere-differentiable function has a finite gauge. Without the differentiability clause the conclusion would not deliver a classical solution. |
| 9 | Building the closure-space derivatives (for $g$ or for $u$) from the global `fderiv` rather than derivatives within $\bar\Omega$. | At a boundary point the global `fderiv` of a function differentiable only within $\bar\Omega$ is the junk value $0$, so every constraint the space places at the boundary silently evaporates and the membership claims become vacuous exactly where they matter. |

## Notes on the ground truth

- The operator is spelled out as `secondOrderOperator a b c` — $\sum_{ij} a^{ij}D_iD_ju + \sum_i b^iD_iu + cu$ with classical iterated derivatives — so the coefficients are the data of the problem and each Chapter 6 standing assumption is its own hypothesis. The equation is imposed only at points of the open $\Omega$, where the global `fderiv` inside `secondOrderOperator` agrees with the within-$\bar\Omega$ derivatives of the solution class, so no junk value fires.
- `IsDomainOfClass (k + 2) δ Ω` is Definition 6.1.6 with $r = k+2+\delta$: the boundary is flattened into a coordinate hyperplane `{y | y j = 0}` (a relabelling of Krylov's $\{y^d = 0\}$), and the bounds `supSeminorm s … ≤ K₀` for every `s ≤ k + 2` together with `holderSeminorm (k + 2) δ … ≤ K₀`, for both `ψ` and its inverse, render "$[\psi]_{s} + [\psi^{-1}]_{s} \le K_0$ for every $s \in [0,r]$" up to a factor $2$ in $K_0$ — harmless since $K_0$ is only required to exist.
- The book's single bound $\lvert a,b,c\rvert_{k+\delta} \le K$ is rendered per coefficient entry (`haK`, `hbK`, `hcK`), each against the same `K`. Per-entry and bundled bounds agree up to a dimension-dependent constant, so a candidate may combine the entries into one norm without loss.
- `krylovHolderNorm` and `holderGauge` take values in `ℝ≥0∞`, so the bounds read `≤ ENNReal.ofReal K` and finiteness is part of the hypothesis — no junk conversion. There is no explicit `0 < K`: for $K \le 0$ the bounds force $a \equiv 0$, contradicting ellipticity, so the hypotheses are jointly unsatisfiable and nothing true is lost; a candidate that assumes `0 < K` (as the text's "$K > 0$" invites) loses nothing either.
- `HolderOn r (closure Ω)` unfolds to `ContDiffOn` through the integer part of `r` plus finiteness of a gauge whose derivatives are taken within the set (`multiDerivativeWithin`, built from `fderivWithin`), so it constrains behavior at boundary points; with the global `fderiv` it would be silently vacuous there. Since $0 < \delta < 1$, the decomposition $r = (k+2) + \delta$ inside `HolderOn` is forced.
- The uniqueness conclusion is `Set.EqOn v u (closure Ω)`, genuinely stronger than agreement on $\Omega$ alone; for functions continuous on $\bar\Omega$ the two are equivalent, and the closure form is what the theorem means.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[krylov_6_5_3_smooth_domain_dirichlet_solvability.md](krylov_6_5_3_smooth_domain_dirichlet_solvability.md) and the background in [krylov_6_5_3_smooth_domain_dirichlet_solvability.context.md](krylov_6_5_3_smooth_domain_dirichlet_solvability.context.md),
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

- Requirement 5 with the sign condition $c \le 0$ dropped: uniqueness fails.
- Requirement 7 with $g$ required only on the open set rather than on $\bar\Omega$.
- Requirement 2 with the boundary regularity dropped entirely (nothing beyond open, bounded, nonempty).
- Requirements 8–10 with the solution or uniqueness class taken on the open $\Omega$ rather than $\bar\Omega$: uniqueness fails (mistake 2).

### Domain-specific pitfalls for this problem

- "Smooth domain" in the theorem's traditional heading means class $C^{k+2+\delta}$ in the sense of Definition 6.1.6 — tied to the same $k$ and $\delta$ as the solution space. Requiring $C^\infty$ restricts the theorem (that case is Corollary 6.5.4).
- The straightening constants $K_0, \rho_0$ are uniform: one pair, chosen before the boundary point. Letting them depend on $x_0$ is a different (weaker) condition.
- The zeroth-order coefficient's sign is a hypothesis, and the coefficient bound is one constant $K$ on all of $\mathbb{R}^d$.
- $f$ lives on $\Omega$ and $g$ on $\bar\Omega$; the closure matters.
- The regularity gain is exactly two derivatives, and it holds up to the boundary: the solution class is $C^{k+2+\delta}(\bar\Omega)$, not $C^{k+2+\delta}(\Omega)$.
- The solution is classical and continuous up to the boundary, so the boundary condition constrains actual values of a function continuous on $\bar\Omega$.
- Uniqueness is relative to the same class $C^{k+2+\delta}(\bar\Omega)$ and asserted on $\bar\Omega$.
