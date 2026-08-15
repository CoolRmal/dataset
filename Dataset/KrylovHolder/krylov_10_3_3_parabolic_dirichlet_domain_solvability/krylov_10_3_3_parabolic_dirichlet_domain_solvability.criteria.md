# Criteria: krylov_10_3_3_parabolic_dirichlet_domain_solvability

**Statement:** [krylov_10_3_3_parabolic_dirichlet_domain_solvability.md](krylov_10_3_3_parabolic_dirichlet_domain_solvability.md) · **Lean:** [krylov_10_3_3_parabolic_dirichlet_domain_solvability.lean](krylov_10_3_3_parabolic_dirichlet_domain_solvability.lean) · **Context:** [krylov_10_3_3_parabolic_dirichlet_domain_solvability.context.md](krylov_10_3_3_parabolic_dirichlet_domain_solvability.context.md)

## What the theorem says

On a bounded space-time domain $Q$, with $L$ a second-order operator acting in the space variables
that is uniformly parabolic and has Hölder coefficients, the problem $Lu - u_t = f$ inside $Q$ with
$u = g$ on the parabolic boundary has exactly one solution in the parabolic Hölder class
$C^{1+\delta/2,\,2+\delta}$. The parabolic boundary $\partial'Q$ is the part of $\partial Q$ where
data must be prescribed: for a cylinder $(0,T)\times\Omega$ it is the bottom together with the
lateral side, and it deliberately excludes the top — prescribing the terminal surface would make the
problem run backwards in time.

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
| 2 | $L$ acts in the space variables and is uniformly parabolic: $\sum_{i,j} a^{ij}\xi_i\xi_j \ge \kappa\lVert\xi\rVert^2$ with $\kappa > 0$. | ✅ `hL : ParabolicOperator L`, which also fixes the shape $\sum a^{ij}D_{ij}u + \sum b^iD_iu + cu$ with the derivatives taken in the frozen-time slice. |
| 3 | The coefficients $a^{ij}, b^i, c$ lie in $C^{\delta/2,\,\delta}(Q)$. | ◐ `hcoeff : ParabolicOperatorCoefficientsHolder δ Q L` says this in the slice-wise sense of `ParabolicHolderOn`, which does not deliver a bound uniform over $Q$ — see the notes. |
| 4 | $Q$ is open, bounded, nonempty, and regular enough that a barrier exists at every parabolic boundary point. | ✅ `hQ : RegularParabolicDomain Q L`, whose barrier is continuous on $\bar Q$, `ParabolicHolderOn 2 Q`, zero at the point, positive elsewhere, and satisfies $L b - b_t \le 0$ in $Q$. |
| 5 | The parabolic boundary is the set of boundary points approachable from $Q$ at *later* times: bottom and lateral surface in, top surface out. | ✅ `parabolicBoundary Q = {p ∈ frontier Q \mid ∀ ε > 0, ∃ q ∈ Q, p.1 ≤ q.1 ∧ dist q p < ε}`. For $Q = (0,1)\times B$ a bottom point $(0,x)$ qualifies via $q = (\varepsilon/2, x)$, while a top point $(1,x)$ does not, since every $q \in Q$ has $q_1 < 1$. |
| 6 | The data are $f \in C^{\delta/2,\,\delta}$ and $g \in C^{1+\delta/2,\,2+\delta}$. | ◐ `ParabolicHolderOn δ Q f` and `ParabolicHolderOn (2 + δ) (closure Q) g`; the latter is stated on `closure Q`, which is stronger than the text but partly ineffective there — see the notes. |
| 7 | Existence of a solution in $C^{1+\delta/2,\,2+\delta}(Q)$, with the exponent bookkeeping right. | ✅ `∃ u, ParabolicHolderOn (2 + δ) Q u ∧ …`; `ParabolicHolderOn (2 + δ)` gives $C^{2+\delta}$ in $x$ and $C^{(2+\delta)/2} = C^{1+\delta/2}$ in $t$. |
| 8 | The solution is classical: continuous up to the parabolic boundary, differentiable in $t$ inside, satisfying $Lu - u_t = f$ in $Q$ and $u = g$ on $\partial'Q$. | ✅ `ParabolicDirichletSolution Q L f g u` conjoins `ContinuousOn u (Q ∪ parabolicBoundary Q)`, `∀ p ∈ Q, DifferentiableAt ℝ (fun t ↦ u (t, p.2)) p.1`, the equation, and the boundary condition. |
| 9 | Uniqueness, stated on the set where the problem lives and only against competitors of the same regularity. | ✅ `∀ v, ParabolicHolderOn (2 + δ) Q v → ParabolicDirichletSolution Q L f g v → Set.EqOn v u (Q ∪ parabolicBoundary Q)`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Prescribing $g$ on the whole topological boundary $\partial Q$, or on the terminal surface. | Including the top makes the problem a backward one, for which no solution of the stated regularity exists in general. The theorem would be false. |
| 2 | Inverting the definition of $\partial'Q$ — selecting the boundary points approachable from $Q$ at *earlier* times, i.e. requiring $q_1 \le p_1$. | That picks out exactly the wrong set. For $Q = (0,1)\times B$ it selects the top $(1,x)$ (take $q = (1-\varepsilon/2,x)$) and rejects the bottom $(0,x)$ (every $q \in Q$ has $q_1 > 0$), so data would be prescribed on the terminal surface and nowhere on the initial one. |
| 3 | Defining "solution" without continuity up to $Q \cup \partial'Q$. | Lean functions are total, so the boundary values would be unrelated to the interior. Uniqueness collapses: with $Q = (0,1)\times B$, $L = \Delta$ and $f = g = 0$, both $u \equiv 0$ and $v = \mathbf{1}_Q$ qualify, since $v$ is locally constant on the open set $Q$ and vanishes on the frontier. |
| 4 | Assuming only that $Q$ is open, bounded and nonempty. | Nothing would then be assumed about $\partial Q$, and punctured, cusped or spine-shaped domains are admitted, for which no solution attains the data. Some boundary regularity — here, a barrier at every parabolic boundary point — is required for existence. |
| 5 | Adding a sign condition on the zeroth-order coefficient, copied from the elliptic Theorem 6.5.3. | Not needed here: the substitution $v = e^{-Kt}u$ absorbs a bounded $c$ of arbitrary sign. Assuming it narrows the theorem and misrepresents the printed hypotheses. |
| 6 | Stating uniqueness as a bare `∃!` over global functions. | That compares values at points outside $\bar Q$, where nothing is asserted, so no solution could ever be unique. |
| 7 | Asserting `Set.EqOn` on `closure Q`. | The closure includes the terminal surface, where the problem prescribes nothing and where two solutions may legitimately differ. |
| 8 | Applying the time derivative to the wrong slice, e.g. differentiating $t \mapsto u(t, x)$ at a point other than $p$, or differentiating in a space variable. | The equation is $Lu - u_t$ with $u_t$ taken along the time fibre through the point: `deriv (fun t ↦ u (t, p.2)) p.1`. |

## Notes on the ground truth

- The parabolic Hölder spaces are the weak spot, exactly as in `krylov_8_7_3_shifted_heat_holder_solvability`. `ParabolicHolderOn r Q u` asks for `HolderOn r` on each time slice `{x \mid (t,x) ∈ Q}` and `HolderOnReal (r/2)` on each spatial fibre `{t \mid (t,x) ∈ Q}`, with no uniformity across slices and no mixed condition; and `HolderOnReal` contributes no supremum bound at all. So "$u \in C^{1+\delta/2,2+\delta}(Q)$" is strictly weaker than the printed space — which weakens existence and strengthens uniqueness — and `hcoeff` does not actually deliver a uniform bound on the coefficients over $Q$. The exponent bookkeeping itself is correct.
- `ParabolicOperator` imposes no symmetry on $(a^{ij})$ and no bound on $a$, $b$, $c$. The lack of symmetry is harmless: only the symmetric part of $a$ is determined by $L$, and the quadratic form sees only that part. The parabolicity is required at *all* points $p$, not only on $Q$; also harmless.
- `ParabolicOperator L` and `ParabolicOperatorCoefficientsHolder δ Q L` each existentially quantify their own triple $(a,b,c)$. Benign in effect, since `formula` holds for all input functions and testing on polynomials recovers $c$, then $b$, then the symmetric part of $a$; but a single bundled triple would avoid relying on that argument.
- `g` is assumed `ParabolicHolderOn (2 + δ) (closure Q)`, where the text asks only for $Q$. `closure Q` is not open, and `holderGauge` measures `multiDerivative`, built from the global `fderiv`, which is typically $0$ at boundary points — so the extra strength is largely illusory.
- No compatibility condition between $f$ and $g$ at the corner where the initial and lateral surfaces meet is stated. Krylov's standing setting (a cylinder over a smooth domain) supplies the geometry that makes this work; `RegularParabolicDomain` is a barrier condition rather than a smoothness condition on $\partial Q$.
- The docstring on `parabolicBoundary` in `Defs.lean` describes it as "approach from earlier times", which reads backwards relative to the condition `p.1 ≤ q.1` that the definition actually uses. The definition is the correct one; the wording is not.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[krylov_10_3_3_parabolic_dirichlet_domain_solvability.md](krylov_10_3_3_parabolic_dirichlet_domain_solvability.md) and the background in [krylov_10_3_3_parabolic_dirichlet_domain_solvability.context.md](krylov_10_3_3_parabolic_dirichlet_domain_solvability.context.md),
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

- Requirement 5 with the boundary condition imposed on the whole topological boundary rather than on $\partial' Q$.
- Requirement 2 with parabolicity replaced by an ellipticity condition in all $d+1$ variables.
- Requirement 7 with the two Hölder exponents chosen independently of the parabolic scaling.

### Domain-specific pitfalls for this problem

- The parabolic boundary excludes the top of a cylinder; this is what makes the problem well posed rather than over-determined.
- $L$ differentiates in $x$ only; $u_t$ is a separate term of the equation.
- Parabolic Hölder exponents come in the locked pairs $(\delta/2,\delta)$ and $(1+\delta/2, 2+\delta)$.
- Membership in a Hölder space requires the derivatives to exist, not just a gauge to be finite; `deriv` of a non-differentiable function is the junk value $0$.
- Uniqueness is relative to the same regularity class.
