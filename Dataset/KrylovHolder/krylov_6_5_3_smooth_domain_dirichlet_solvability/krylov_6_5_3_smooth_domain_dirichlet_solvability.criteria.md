# Criteria: krylov_6_5_3_smooth_domain_dirichlet_solvability

**Statement:** [krylov_6_5_3_smooth_domain_dirichlet_solvability.md](krylov_6_5_3_smooth_domain_dirichlet_solvability.md) · **Lean:** [krylov_6_5_3_smooth_domain_dirichlet_solvability.lean](krylov_6_5_3_smooth_domain_dirichlet_solvability.lean) · **Context:** [krylov_6_5_3_smooth_domain_dirichlet_solvability.context.md](krylov_6_5_3_smooth_domain_dirichlet_solvability.context.md)

## What the theorem says

This is classical Schauder solvability of the Dirichlet problem. On a bounded domain with smooth
boundary, with $L$ a second-order uniformly elliptic operator whose coefficients are Hölder of order
$k+\delta$ and whose zeroth-order coefficient is nonpositive, every pair of data — $f$ in
$C^{k+\delta}(\Omega)$ and $g$ in $C^{k+2+\delta}(\bar\Omega)$ — admits exactly one solution
$u$ in $C^{k+2+\delta}(\Omega)$ of $Lu = f$ inside $\Omega$ with $u = g$ on the boundary.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $k \ge 0$ is an integer and $0 < \delta < 1$. | ✅ `k : ℕ`, `hδ : 0 < δ ∧ δ < 1`. |
| 2 | $\Omega$ is a bounded, nonempty, open set whose boundary is smooth. | ✅ `hΩ : SmoothBoundedDomain Ω`: a `RegularBoundedDomain` together with a $C^\infty$ defining function $\rho$ with $\Omega = \{\rho < 0\}$ and $\nabla\rho \ne 0$ on the boundary. |
| 3 | $L$ is a second-order operator given by coefficients, uniformly elliptic, with all coefficients bounded. | ✅ `hL : SecondOrderEllipticOperator L 0` supplies an `EllipticOperatorData 2 L` with `principalSymbol`, `ellipticityConstant_pos`, and a uniform bound on all coefficients. |
| 4 | The zeroth-order coefficient satisfies $c \le 0$, and the zero multi-index really appears among the operator's terms. | ✅ Same hypothesis with `lam = 0`: `∃ zeroIndex ∈ data.terms, (∀ i, zeroIndex i = 0) ∧ ∀ x, data.coefficient zeroIndex x ≤ -0`. |
| 5 | The coefficients lie in $C^{k+\delta}$. | ✅ `hcoeff : OperatorCoefficientsHolder 2 (k + δ) L`. |
| 6 | The data are $f \in C^{k+\delta}(\Omega)$ and $g \in C^{k+2+\delta}(\bar\Omega)$ — note the asymmetry between the two sets. | ✅ `HolderOn (k + δ) Ω f` and `HolderOn (k + 2 + δ) (closure Ω) g`. The gauge now measures `multiDerivativeWithin`, built from `fderivWithin`, so it constrains $g$ at boundary points too; with the global `fderiv` it was silently vacuous there. |
| 7 | Existence of a solution in $C^{k+2+\delta}(\Omega)$. | ✅ `∃ u, HolderOn (k + 2 + δ) Ω u ∧ …`; since $\Omega$ is open, `HolderOn` there delivers genuine derivatives. |
| 8 | The solution is classical: twice continuously differentiable inside, continuous up to $\bar\Omega$, satisfying $Lu = f$ in $\Omega$ and $u = g$ on $\partial\Omega$. | ✅ `EllipticDirichletSolution Ω L f g u` is the conjunction of `ContDiffOn ℝ 2 u Ω`, `ContinuousOn u (closure Ω)`, `∀ x ∈ Ω, L u x = f x`, and `∀ x ∈ frontier Ω, u x = g x`. |
| 9 | Uniqueness, stated on the set where the problem lives and only against competitors with the same regularity. | ✅ `∀ v, HolderOn (k + 2 + δ) Ω v → EllipticDirichletSolution Ω L f g v → Set.EqOn v u (closure Ω)`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Defining "solution" without requiring continuity up to $\bar\Omega$. | Lean functions are total, so the value at a boundary point would be a free parameter unconnected to the interior. Uniqueness then fails outright: with $\Omega$ the unit ball, $L = \Delta$ and $f = g = 0$, both $u \equiv 0$ and $v = \mathbf{1}_\Omega$ qualify — $v$ is locally constant on the open set $\Omega$, so it is smooth there with finite gauge, harmonic there, and equal to $0$ on the frontier. |
| 2 | Omitting the sign condition on the zeroth-order coefficient. | Without $c \le 0$ the operator can have a Dirichlet eigenvalue. Take $L = \Delta + \lambda_1$ on the unit ball with $\lambda_1$ its first Dirichlet eigenvalue, and $f = g = 0$: the eigenfunction $\varphi_1$ and $0$ are both smooth solutions, so uniqueness fails. |
| 3 | Stating uniqueness as a bare `∃!` over global functions. | That would compare $u$ and $v$ at points outside $\bar\Omega$, where the problem asserts nothing, so no solution could ever be unique. `Set.EqOn … (closure Ω)` is the right notion. |
| 4 | Dropping the uniqueness clause, or dropping the regularity hypothesis on the competitor $v$. | Existence alone is a weaker theorem, and uniqueness genuinely fails in a larger regularity class. |
| 5 | Writing `ContDiff ℝ ⊤ ρ` for the smooth defining function. | In current mathlib `⊤` in the smoothness exponent means `ω`, i.e. real-analytic, not $C^\infty$. That is a strictly stronger and different assumption on the domain. |
| 6 | Defining "regular domain" with a barrier that is only continuous. | `laplacian` is built from `fderiv`, which returns $0$ where the function is not differentiable, so a nowhere-differentiable barrier satisfies $\Delta b \le 0$ for free and the regularity assumption collapses to "open, bounded, nonempty". |
| 7 | Encoding "$u \in C^{k+2+\delta}(\Omega)$" as finiteness of the Hölder gauge alone. | The gauge is `fderiv`-based, so a bounded nowhere-differentiable function has a finite gauge. Without the `ContDiffOn` clause the conclusion would not deliver a classical solution. |
| 8 | Taking the Hölder norms over compact subsets of $\Omega$ instead of over $\Omega$ itself. | This is a global (up to the boundary) theorem. A local reading would be a different statement — correct for the interior regularity theorem 7.1.2, wrong here. |

## Notes on the ground truth

- `SecondOrderEllipticOperator L 0` is used to say $c \le 0$; unfolding gives `coefficient zeroIndex x ≤ -0`, which is literally $c \le 0$. This also drags in a positive ellipticity constant and a uniform bound on all coefficients, both of which match Krylov's standing assumptions.
- `SmoothBoundedDomain` is a strong and honest rendering of "smooth boundary" — a global defining function with nonvanishing boundary gradient — and is stronger than the $C^{k+2+\delta}$ boundary the theorem needs. Assuming more only restricts the theorem.
- `hcoeff` asks for Hölder regularity on `univ`, i.e. on all of $\mathbb{R}^d$, where the text only needs it on $\bar\Omega$. Again stronger than needed, so the theorem stays sound.
- `hL` and `hcoeff` each open their own `EllipticOperatorData 2 L`. Benign, since `formula` is quantified over all input functions and hence determines the coefficients from `L`.
- The uniqueness conclusion is `Set.EqOn v u (closure Ω)`, which is genuinely stronger than agreement on $\Omega$ alone.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[krylov_6_5_3_smooth_domain_dirichlet_solvability.md](krylov_6_5_3_smooth_domain_dirichlet_solvability.md) and the background in [krylov_6_5_3_smooth_domain_dirichlet_solvability.context.md](krylov_6_5_3_smooth_domain_dirichlet_solvability.context.md),
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

- Requirement 4 with the sign condition $c \le 0$ dropped: uniqueness fails.
- Requirement 6 with $g$ required only on the open set rather than on $\bar\Omega$.
- Requirement 2 with the boundary not required smooth.

### Domain-specific pitfalls for this problem

- The zeroth-order coefficient's sign is a hypothesis, and the zero multi-index must genuinely occur in the operator for it to constrain anything.
- $f$ lives on $\Omega$ and $g$ on $\bar\Omega$; the closure matters.
- The regularity gain is exactly two derivatives.
- The solution is classical and continuous up to the boundary, so the boundary condition is a statement about limits from inside.
- Uniqueness is relative to the same regularity class.
