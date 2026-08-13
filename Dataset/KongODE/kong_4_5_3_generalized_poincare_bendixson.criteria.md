# Criteria: kong_4_5_3_generalized_poincare_bendixson

**Statement:** [kong_4_5_3_generalized_poincare_bendixson.md](kong_4_5_3_generalized_poincare_bendixson.md) · **Lean:** [kong_4_5_3_generalized_poincare_bendixson.lean](kong_4_5_3_generalized_poincare_bendixson.lean)

## What the theorem says

Take a planar autonomous system $x' = f(x)$ and one of its solutions. Suppose the forward half of
its orbit stays inside a compact set $E$ that contains only finitely many equilibria. Then the
$\omega$-limit set — the set of points the solution keeps returning near as $t \to +\infty$ — must be
one of four things: a single equilibrium; or the orbit of the solution is itself a closed orbit; or
the limit set is a closed orbit; or the limit set is a graphic, meaning a connected union of
finitely many equilibria together with orbits joining them. The same list applies backwards in time,
with the negative half-orbit and the $\alpha$-limit set.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The system is planar. | ✅ Everything is indexed by `Fin 2`. |
| 2 | The vector field is regular enough for the Poincaré–Bendixson machinery. | ⚠️ `hF : ContDiff ℝ 1 F` is stronger than Kong's standing continuity assumption, so our version is weaker than the printed one; but some regularity is essential (see mistake 1), and $C^1$ is what the text's setting really uses, since it needs uniqueness of solutions. |
| 3 | $x$ is a genuine solution of the autonomous system. | ✅ `horbit : IsAutonomousTrajectory F x`, i.e. `∀ t, HasDerivAt x (F (x t)) t`. |
| 4 | $E$ is compact. | ✅ `hcompact : IsCompact E`. |
| 5 | The system has only finitely many equilibria **in $E$**. | ✅ `hfinite : {x ∈ E \| F x = 0}.Finite`. |
| 6 | The forward statement is conditional on the positive semi-orbit staying in $E$; the backward statement on the negative semi-orbit staying in $E$. | ✅ `(∀ t, 0 ≤ t → x t ∈ E) → classify (omegaLimitSet x)` and `(∀ t, t ≤ 0 → x t ∈ E) → classify (alphaLimitSet x)`. |
| 7 | Both halves are asserted — the $\omega$-limit conclusion and the $\alpha$-limit conclusion. | ✅ The two implications are conjoined. |
| 8 | The limit sets are the sets of subsequential limits along times going to $+\infty$ (resp. $-\infty$). | ✅ `omegaLimitSet x := {y \| ∃ t : ℕ → ℝ, Tendsto t atTop atTop ∧ Tendsto (fun j ↦ x (t j)) atTop (𝓝 y)}`, and the mirror image with `atBot` for `alphaLimitSet`. |
| 9 | Case (a): the limit set is exactly one point, and that point is an equilibrium. | ✅ `∃ e, limitSet = {e} ∧ F e = 0`. |
| 10 | Cases (b) and (c) are different: (b) says the given orbit is closed, (c) says the limit set is a closed orbit. | ✅ `IsClosedOrbit F x` for (b) and `∃ y, IsClosedOrbit F y ∧ limitSet = range y` for (c). |
| 11 | A closed orbit is the orbit of a **nonconstant** periodic solution, with a strictly positive period. | ✅ `IsClosedOrbit F x := IsAutonomousTrajectory F x ∧ (∃ t, x t ≠ x 0) ∧ ∃ T, 0 < T ∧ ∀ t, x (t + T) = x t`. |
| 12 | Case (d): the limit set is a graphic — connected, built from finitely many equilibria together with complete orbits each converging to equilibria of the set in both time directions. | ✅ `GraphicForPlanarSystem F limitSet`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Assuming nothing about the vector field. | The four-way disjunction is then false. Sketch: in polar coordinates let $r' = -h(r)$ with $h \ge 0$ continuous, vanishing to second order exactly at $r = 1$ and $r = 2$, and let the tangential speed on the circle $r = 1$ be a function of $\theta$ taking only the values $1$ and $2$ — so, since derivatives have the intermediate value property, no solution lies on that circle. A solution starting at $r = 1.5$ is global, stays in $E = \overline{B}(0,2)$, and the only equilibrium in $E$ is the origin; but its $\omega$-limit set is the unit circle, which is not a single equilibrium, not a closed orbit, and not a graphic (a graphic would have to contain an equilibrium). |
| 2 | Stating case (b) as a second claim about the limit set, so that (b) and (c) say the same thing. | This loses the case where the solution is itself periodic: then $\Omega(\Gamma^+) = \Gamma$ and (b) is what applies. Case (b) is about the orbit, not the limit set. |
| 3 | Defining "closed orbit" as a periodic solution without requiring it to be nonconstant, or allowing period $0$. | Every equilibrium is then a closed orbit, and cases (b) and (c) become trivially available, gutting the theorem. |
| 4 | Reading case (a) as "the limit set contains exactly one equilibrium, possibly alongside other points". | That is a different claim and makes the list of alternatives wrong — the intended alternative is that the limit set *is* a single equilibrium. |
| 5 | Stating only the forward half and omitting the $\alpha$-limit statement. | Kong explicitly asserts both, each with its own semi-orbit hypothesis. |
| 6 | Dropping the compactness of $E$ or the finiteness of the equilibria in $E$. | Both are needed. An unbounded orbit can have empty limit set, and with infinitely many equilibria the limit set can be a continuum of them. |
| 7 | Describing the trajectory with `deriv`. | `deriv` is `0` where the function is not differentiable, so the hypothesis would admit non-solutions wherever the field vanishes. |

## Notes on the ground truth

- Mathlib's `omegaLimit` is defined for a flow acting on a set, not for a single trajectory, so the limit sets are defined by hand with the sequential characterisation, which is correct in a metric space.
- `GraphicForPlanarSystem` permits *constant* connecting orbits. As a result a single equilibrium counts as a graphic, so case (d) already covers case (a) and the four alternatives are not mutually exclusive. This is harmless inside a disjunction but is a divergence from the intended reading.
- In the hypothesis `{x ∈ E \| F x = 0}` the set-builder binder `x` shadows the trajectory `x : ℝ → (Fin 2 → ℝ)`. It elaborates to the set of equilibria in $E$, which is what is meant, but it is easy to misread.
- Requiring the trajectory to exist for all real times, forwards and backwards, is stronger than Kong's setting, where the forward-bounded solution is only known to exist on its maximal interval.
