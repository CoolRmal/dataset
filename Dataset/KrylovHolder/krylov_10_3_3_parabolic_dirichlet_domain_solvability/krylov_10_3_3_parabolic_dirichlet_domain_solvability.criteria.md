# Criteria: krylov_10_3_3_parabolic_dirichlet_domain_solvability

**Statement:** [krylov_10_3_3_parabolic_dirichlet_domain_solvability.md](krylov_10_3_3_parabolic_dirichlet_domain_solvability.md) · **Lean:** [krylov_10_3_3_parabolic_dirichlet_domain_solvability.lean](krylov_10_3_3_parabolic_dirichlet_domain_solvability.lean) · **Context:** [krylov_10_3_3_parabolic_dirichlet_domain_solvability.context.md](krylov_10_3_3_parabolic_dirichlet_domain_solvability.context.md)

## What the theorem says

On the **infinite** cylinder $Q = (-\infty,T)\times\Omega$ — where $T \in (-\infty,\infty]$ and
$\Omega$ is a bounded domain of class $C^{2+\delta}$ in the sense of Definition 6.1.6 — with $L$
a second-order operator acting in the space variables whose standing coefficients are real,
defined for all $(t,x)$, with $a$ symmetric, uniformly nondegenerate with constant $\kappa > 0$,
in $C^{\delta/2,\,\delta}$ of the whole space, and with $c \le 0$, the problem $Lu - u_t = f$ in
$Q$ with $u = g$ on the lateral surface $\partial'Q = (-\infty,T)\times\partial\Omega$ has exactly
one solution in $C^{1+\delta/2,\,2+\delta}(\bar Q)$. The cylinder is bottomless: there is no
initial surface and no initial condition, and the sign condition $c \le 0$ supplies the uniqueness
an initial condition would otherwise provide. The top $\{T\}\times\Omega$ (when $T$ is finite) is
excluded from $\partial'Q$: prescribing the terminal surface would make the problem run backwards
in time.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $0 < \delta < 1$. | ✅ `hδ : 0 < δ ∧ δ < 1`. |
| 2 | $\Omega$ is a bounded domain of class $C^{2+\delta}$ in the sense of Definition 6.1.6. | ✅ `hΩ : IsDomainOfClass 2 δ Ω`: open, bounded, nonempty, and every boundary point has a boundary-straightening map with `supSeminorm`/`holderSeminorm` bounds through order $2+\delta$ (for the map and its inverse) by one constant uniform over the boundary. |
| 3 | The space-time domain is the infinite cylinder $Q = (-\infty,T)\times\Omega$ with $T \in (-\infty,\infty]$ — not a general space-time domain, and not a finite cylinder. | ✅ `T : WithTop ℝ` and `Q = {p \| (p.1 : WithTop ℝ) < T ∧ p.2 ∈ Ω}`; for finite `T` the order-preserving coercion makes this `p.1 < T`, and for `T = ⊤` it makes `Q` all of $\mathbb{R}\times\Omega$. |
| 4 | The boundary condition $u = g$ is prescribed on the lateral surface $\partial'Q = (-\infty,T)\times\partial\Omega$ **only** — no initial-time cap, no top. | ✅ `lateralBoundary = {p \| (p.1 : WithTop ℝ) < T ∧ p.2 ∈ frontier Ω}`, and both the solution and every competitor satisfy `∀ p ∈ lateralBoundary, u p = g p`. |
| 5 | $L$ acts in the space variables with the shape $a^{ij}D_{ij}u + b^iD_iu + cu$, and the equation is $Lu - u_t = f$ at every point of $Q$, with $u_t$ taken along the time fibre through the point. | ✅ `∀ p ∈ Q, parabolicSecondOrderOperator a b c u p - deriv (fun s ↦ u (s, p.2)) p.1 = f p`; `parabolicSecondOrderOperator` differentiates the frozen-time slice `fun y ↦ u (p.1, y)` at `p.2`. |
| 6 | $a$ is symmetric and uniformly nondegenerate at every $(t,x)$: $\kappa\lVert\xi\rVert^2 \le \sum_{i,j} a^{ij}\xi_i\xi_j$ with $\kappa > 0$. | ✅ `hsym : ∀ p i j, a p i j = a p j i`, `hκ : 0 < κ`, `hell : ∀ p ξ, κ * ‖ξ‖ ^ 2 ≤ ∑ i, ∑ j, a p i j * ξ i * ξ j`. |
| 7 | $c \le 0$ everywhere. | ✅ `hc : ∀ p, c p ≤ 0`. |
| 8 | The coefficients $a^{ij}, b^i, c$ are real and belong to $C^{\delta/2,\,\delta}$ of the **whole space**. | ✅ real by the types (all coefficients land in `ℝ`); `haHolder : ∀ i j, ParabolicHolderOn δ Set.univ (fun p ↦ a p i j)`, `hbHolder : ∀ i, ParabolicHolderOn δ Set.univ (fun p ↦ b p i)`, `hcHolder : ParabolicHolderOn δ Set.univ c` — entrywise, on `Set.univ`. |
| 9 | The data are $f \in C^{\delta/2,\,\delta}(Q)$ and $g \in C^{1+\delta/2,\,2+\delta}(Q)$, universally quantified. | ✅ `∀ f g, ParabolicHolderOn δ Q f → ParabolicHolderOn (2 + δ) Q g → …`, exactly the printed classes on `Q`. |
| 10 | Existence of a solution in $C^{1+\delta/2,\,2+\delta}(\bar Q)$ — regular up to the closure — with the exponent bookkeeping right. | ✅ `∃ u, ParabolicHolderOn (2 + δ) (closure Q) u ∧ …`; `ParabolicHolderOn (2 + δ)` gives $C^{2+\delta}$ in $x$ and $C^{(2+\delta)/2} = C^{1+\delta/2}$ in $t$, and its gauge uses within-derivatives, so it is effective on the closure. |
| 11 | Uniqueness, stated on the set where the problem lives and only against competitors of the same regularity. | ✅ `∀ v, ParabolicHolderOn (2 + δ) (closure Q) v → (equation for v) → (boundary condition for v) → Set.EqOn v u (closure Q)`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Transcribing $Q$ as an arbitrary bounded space-time domain with a general "parabolic boundary" (e.g. the boundary points approachable from $Q$ at later times), possibly padded with a barrier or boundary-regularity condition. | That is a different statement, and one the book does not prove. Theorem 10.3.3 is stated (Sec. 10.1) for the infinite cylinder $(-\infty,T)\times\Omega$ over a bounded $C^{2+\delta}$ domain, and its proof uses that product structure. Whatever the truth value of a general-domain variant, formalizing it is formalizing a different theorem. This is the primary trap for this problem. |
| 2 | Omitting $c \le 0$. | On the bottomless cylinder the sign condition is essential, not cosmetic: let $\lambda_1 > 0$ be the principal Dirichlet eigenvalue of $-\Delta$ on $\Omega$ and $\varphi_1 \in C^{2+\delta}(\bar\Omega)$ its eigenfunction, and take $a = I$, $b = 0$, $c \equiv \lambda_1$. Then $u \equiv 0$ and the steady function $u(t,x) = \varphi_1(x)$ both lie in $C^{1+\delta/2,\,2+\delta}(\bar Q)$, solve $Lu - u_t = 0$ in $Q$, and vanish on $\partial'Q$ — so uniqueness fails and the statement without $c \le 0$ is **false** (falsity cap). |
| 3 | Using a finite cylinder $(t_0,T)\times\Omega$, or including an initial-time cap $\{t_0\}\times\Omega$ in $\partial'Q$. | The cylinder has no bottom: it extends to $t = -\infty$, and $\partial'Q = (-\infty,T)\times\partial\Omega$ is the lateral surface only. Adding a cap turns the statement into the initial–boundary value problem — a different theorem — and prescribes data on a set the text leaves free. |
| 4 | Prescribing $g$ on the whole topological boundary of $Q$. | For finite $T$ the frontier of $Q$ also contains the top cap $\{T\}\times\bar\Omega$; prescribing data there makes the problem run backwards in time, and no solution of the stated regularity exists in general. |
| 5 | Requiring the solution's regularity only on $Q$ instead of $\bar Q$ (no continuity up to the lateral boundary). | Lean functions are total, so the values on $\partial'Q$ would be unrelated to the interior and uniqueness collapses: with $a = I$, $b = 0$, $c = 0$, $f = 0$, $g = 0$, both $u \equiv 0$ and $v = \mathbf{1}_Q$ satisfy every clause — $v$ is locally constant on the open set $Q$ and vanishes on $\partial'Q$ — so no solution can be unique and the statement is false. |
| 6 | Imposing the coefficient hypotheses only on $Q$, or as slice-wise Hölder conditions with no constant uniform over $(t,x)$. | The standing assumptions of Chapter 10 are global: the coefficients are defined for all $(t,x)$, with symmetry, ellipticity and $\|a,b,c\|_{\delta/2,\delta} \le K$ on the whole space. The on-$Q$-only variant asserts a strengthened theorem the book does not prove; per-slice constants are strictly weaker than membership in $C^{\delta/2,\delta}$ and do not support the Schauder machinery. |
| 7 | Stating uniqueness as a bare `∃!` over global functions. | That compares values at points outside $\bar Q$, where nothing is asserted, so no solution could ever be unique. Uniqueness must be set-relative (`Set.EqOn` on $\bar Q$, or equivalently — by continuity of the class — on $Q$). |
| 8 | Applying the time derivative to the wrong slice, e.g. differentiating $t \mapsto u(t, x)$ at a point other than $p$, or differentiating in a space variable. | The equation is $Lu - u_t$ with $u_t$ taken along the time fibre through the point: `deriv (fun t ↦ u (t, p.2)) p.1`. |
| 9 | Writing the anisotropic class so that the joint exponent-$r$ quotient falls on $u$ itself for $r > 1$ — e.g. requiring $\lvert u(p)-u(q)\rvert \le C(\lVert p_x-q_x\rVert^{2+\delta} + \lvert p_t-q_t\rvert^{1+\delta/2})$. | An exponent $>1$ on the space increment forces $D_xu = 0$, so every member of the class is constant in $x$ on connected components of each slice. Existence then fails for any $g$ nonconstant in $x$ on the lateral surface (e.g. $\Omega$ a ball and $g(t,x) = x^1$), so the "theorem" is false. The exponents must fall on the top-order derivatives, never on $u$ itself. |
| 10 | Typing $T$ as a real number, or hard-coding $T = \infty$. | The text allows $T \in (-\infty,\infty]$. With `T : ℝ` the global-in-time case $Q = \mathbb{R}\times\Omega$ — the case the bottomless cylinder exists for — is lost; fixing $T = \infty$ loses every finite cylinder. Either restriction is a strictly weaker theorem. |

## Notes on the ground truth

- The parabolic Hölder class is shared with `krylov_8_7_3_shifted_heat_holder_solvability`. `ParabolicHolderOn r Q u` conjoins the slice-wise `HolderOn r` on each time slice `{x \mid (t,x) ∈ Q}` and `HolderOnReal (r/2)` on each spatial fibre `{t \mid (t,x) ∈ Q}` — which carry the `ContDiffOn` clauses — with a mixed clause requiring one constant $C$ uniform over $Q$: sup bounds on all derivatives of parabolic weight at most $k$ (where $r = k + \delta'$, $0 \le \delta' < 1$), the anisotropic $(\delta',\delta'/2)$ quotients of the top-order data, and the intermediate exponent-$(1+\delta')/2$ time quotient one spatial order down. So membership delivers the uniform bounds the Schauder theory needs and the exponent bookkeeping is correct.
- The operator is given directly by its coefficients: `parabolicSecondOrderOperator a b c` with `a`, `b`, `c` explicit arguments and entrywise hypotheses. There is no bundled abstract operator to unpack, so the symmetry, ellipticity, sign and Hölder hypotheses visibly attach to the same triple that forms the equation.
- The coefficient hypotheses are stated on `Set.univ`, whose time slices and spatial fibres are all of $\mathbb{R}^d$ and $\mathbb{R}$, so they render "the coefficients belong to $C^{\delta/2,\,\delta}$ of the whole space" literally. The constant $K$ is existentially quantified inside `ParabolicHolderOn` rather than named — equivalent to the printed $|a,b,c|_{\delta/2,\delta} \le K$.
- `IsDomainOfClass 2 δ Ω` is Definition 6.1.6: open, bounded, nonempty, with boundary-straightening maps (and inverses) whose seminorms through order $2+\delta$ are bounded by one constant uniformly over the boundary points. `frontier Ω` is the topological boundary $\partial\Omega$; since $\Omega$ is open it is disjoint from $\Omega$.
- `Set.EqOn v u (closure Q)` is sound here because both competitors are assumed in the class on `closure Q`, whose slice-wise clauses — built on within-derivatives — genuinely constrain the boundary values; agreement on the closure (including the top cap $\{T\}\times\bar\Omega$ when $T$ is finite) follows from agreement on $Q$ by continuity. A candidate asserting `Set.EqOn` on $Q$ or on $Q \cup \partial'Q$ instead is equivalent and loses nothing.
- No compatibility condition between $f$ and $g$ appears because the bottomless cylinder has no corner: there is no initial surface to meet the lateral one. This is precisely why Chapter 10 poses the Dirichlet problem on $(-\infty,T)\times\Omega$.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[krylov_10_3_3_parabolic_dirichlet_domain_solvability.md](krylov_10_3_3_parabolic_dirichlet_domain_solvability.md) and the background in [krylov_10_3_3_parabolic_dirichlet_domain_solvability.context.md](krylov_10_3_3_parabolic_dirichlet_domain_solvability.context.md),
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

- Requirement 3 with the infinite cylinder replaced by an arbitrary bounded space-time domain, or by a finite cylinder carrying an initial condition.
- Requirement 4 with the boundary condition imposed on the whole topological boundary of $Q$ rather than on the lateral surface $\partial'Q$.
- Requirement 6 with the ellipticity imposed in all $d+1$ variables, i.e. time treated as an elliptic direction.
- Requirement 10 with the two Hölder exponents chosen independently of the parabolic scaling.

### Domain-specific pitfalls for this problem

- The parabolic boundary of this cylinder is the lateral surface alone: there is no initial cap (time runs to $-\infty$), and the top is excluded — prescribing the top would over-determine a forward parabolic problem.
- On the bottomless cylinder $c \le 0$ does the work an initial condition would otherwise do; the $e^{\lambda t}$ substitution that absorbs a positive $c$ on finite cylinders is unavailable because $t$ is unbounded below.
- $L$ differentiates in $x$ only; $u_t$ is a separate term of the equation.
- Parabolic Hölder exponents come in the locked pairs $(\delta/2,\delta)$ and $(1+\delta/2, 2+\delta)$.
- Membership in a Hölder space requires the derivatives to exist, not just a gauge to be finite; `deriv` of a non-differentiable function is the junk value $0$.
- $T \in (-\infty,\infty]$ needs an extended-real (or two-case) treatment; typing $T$ as a plain real silently drops the case $Q = \mathbb{R}\times\Omega$.
- Uniqueness is relative to the same regularity class, stated set-relatively.
