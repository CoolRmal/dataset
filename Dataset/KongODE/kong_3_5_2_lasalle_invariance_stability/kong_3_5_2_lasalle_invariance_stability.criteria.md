# Criteria: kong_3_5_2_lasalle_invariance_stability

**Statement:** [kong_3_5_2_lasalle_invariance_stability.md](kong_3_5_2_lasalle_invariance_stability.md) · **Lean:** [kong_3_5_2_lasalle_invariance_stability.lean](kong_3_5_2_lasalle_invariance_stability.lean) · **Context:** [kong_3_5_2_lasalle_invariance_stability.context.md](kong_3_5_2_lasalle_invariance_stability.context.md)

## What the theorem says

Consider the autonomous system $x' = f(x)$ with $f(0) = 0$, and a function $V$ defined on the closed
ball of radius $l$ around the origin. Suppose $V$ is $C^1$, vanishes at the origin, is strictly
positive elsewhere in the ball, and never increases along solutions — that is, its orbital
derivative $\dot V(x) = \nabla V(x)\cdot f(x)$ is $\le 0$ throughout the ball. Ordinarily this gives
stability but not convergence. LaSalle's addition is: if the set where $\dot V$ vanishes contains no
nontrivial orbit, then the origin is not merely stable but asymptotically stable — nearby solutions
actually tend to it.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The ball has positive radius. | ✅ `hl : 0 < l`. |
| 2 | The vector field is regular enough that solutions exist and are unique. | ✅ `Continuous F`, Kong's standing hypothesis, together with an explicit uniqueness hypothesis for trajectories — which is what the argument actually uses, rather than the convenient over-assumption $C^1$. |
| 3 | The origin is an equilibrium, so that $x \equiv 0$ really is a solution. | ✅ `hF0 : F 0 = 0`. |
| 4 | $V$ is $C^1$ on the closed ball. | ✅ First conjunct of `LyapunovFunctionOnBall l V F`: `ContDiffOn ℝ 1 V (Metric.closedBall 0 l)`. |
| 5 | $V$ is positive definite: $V(0) = 0$ and $V(x) > 0$ for every other point of the ball. | ✅ `V 0 = 0 ∧ ∀ x ∈ Metric.closedBall 0 l, x ≠ 0 → 0 < V x`. |
| 6 | The orbital derivative $\nabla V(x)\cdot f(x)$ is $\le 0$ at every point of the ball, as a pointwise condition on the ball rather than a condition along solutions. | ✅ `∀ x ∈ Metric.closedBall 0 l, fderivWithin ℝ V (Metric.closedBall 0 l) x (F x) ≤ 0`. |
| 7 | The derivative of $V$ is taken **within** the ball, matching "$V \in C^1(D)$". | ✅ `fderivWithin ℝ V (Metric.closedBall 0 l) x` everywhere it appears, including in the invariance hypothesis. |
| 8 | The invariance hypothesis: any solution whose whole orbit lies in the ball with orbital derivative $0$ throughout is the zero solution. | ✅ `NoNontrivialOrbitInZeroDerivativeSet l V F`, whose conclusion is `x = 0` as an equality of *functions*. |
| 9 | The conclusion asserts uniform stability **and** asymptotic convergence. | ✅ `AsymptoticallyStableZeroSolution (fun _ x ↦ F x)`, which unfolds to `UniformlyStableZeroSolution … ∧ ∃ δ > 0, …`. |
| 10 | The attraction radius is one number, independent of the initial time and of the solution, and the convergence is as $t \to +\infty$. | ✅ `∃ δ, 0 < δ ∧ ∀ t₀ x, …` with `Tendsto x atTop (𝓝 0)`. |
| 11 | Solutions are genuine solutions of the autonomous system. | ✅ `IsAutonomousTrajectory F x := ∀ t, HasDerivAt x (F (x t)) t`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Assuming nothing at all about the vector field $f$. | The theorem then becomes false. Sketch: in the plane take $V(x) = \lVert x\rVert^2$ and, in polar coordinates, $r' = -\sin^2(\pi/r)$, with a purely tangential component whose speed on each circle $r = 1/k$ is a function of $\theta$ taking only the values $1$ and $2$. Then $\dot V = -2r\sin^2(\pi/r) \le 0$, so the Lyapunov hypotheses hold; and no solution can lie on a circle $r = 1/k$, because a derivative has the intermediate value property and $\theta' = \tau(\theta)$ with $\tau$ two-valued has no solution — so the invariance hypothesis holds too. Yet solutions starting between two consecutive circles decrease only to the inner circle and do not tend to $0$, for arbitrarily small initial data. |
| 2 | Omitting $f(0) = 0$. | Then the origin need not be an equilibrium and "the zero solution" is not a solution at all. |
| 3 | Writing the orbital derivative as `deriv (fun t ↦ V (x t)) t ≤ 0` along solutions. | Two things break. `deriv` returns `0` where the composite is not differentiable, so the condition can be met by accident; and it turns a pointwise hypothesis on the ball into a hypothesis along trajectories, which is a different assumption. |
| 4 | Using the ambient `fderiv ℝ V x` while $V$ is only assumed $C^1$ on the closed ball. | On the bounding sphere $\lVert x\rVert = l$ the ambient derivative can be the junk value $0$. The hypothesis then reads $0 \le 0$ there, saying nothing, and those same sphere points get wrongly counted as belonging to the zero-orbital-derivative set, weakening the invariance hypothesis. |
| 5 | Concluding only that solutions tend to the origin. | The theorem concludes uniform stability as well. Convergence alone permits large excursions before the return. |
| 6 | Dropping the invariance hypothesis. | Without it only stability follows, not asymptotic stability. That hypothesis is the entire point of LaSalle's refinement. |
| 7 | Writing positive definiteness as $V(x) > 0$ for all $x$ in the ball, or omitting $V(0) = 0$. | $V(0) > 0$ is impossible together with $V(0) = 0$; and if $V(0) = 0$ is dropped, the sublevel sets no longer shrink to the origin and the argument gives nothing. |

## Notes on the ground truth

- The invariance hypothesis quantifies only over trajectories defined on all of $\mathbb{R}$, whereas Kong's orbits are those of maximal solutions. That makes our hypothesis weaker, hence the theorem formally stronger — an honest divergence from the text.
- In the same way, the conclusion speaks only about solutions defined on all of $\mathbb{R}$, so it is weaker than Kong's, which also covers solutions that exist only forward in time. For the trajectories at issue here, which stay in a compact ball, the restriction is mild but it is real.
- The autonomous field is fed to the time-dependent stability predicate as `fun _ x ↦ F x`. Quantifying the initial time over $[0,\infty)$ rather than a single instant is harmless because the system is invariant under time translation.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[kong_3_5_2_lasalle_invariance_stability.md](kong_3_5_2_lasalle_invariance_stability.md) and the background in [kong_3_5_2_lasalle_invariance_stability.context.md](kong_3_5_2_lasalle_invariance_stability.context.md),
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

- Requirement 8 with the invariance hypothesis dropped: only stability follows, not asymptotic stability.
- Requirement 6 with $\dot V$ required negative *definite*, which is a strictly stronger hypothesis and a weaker theorem.
- Requirement 3 with the equilibrium condition $f(0)=0$ dropped, so $x \equiv 0$ need not be a solution.

### Domain-specific pitfalls for this problem

- The orbital derivative is $\nabla V \cdot f$, a function of $x$ alone.
- Positive definiteness of $V$ is strict off the origin; negative semi-definiteness of $\dot V$ is not strict.
- "Nontrivial orbit" excludes the constant solution at the origin; the hypothesis is that no other whole orbit stays in $D_0$.
- The derivative of $V$ is taken within the closed ball, matching $V \in C^1(D)$.
- The conclusion is a conjunction of the two stability properties, with radii independent of the initial time.
