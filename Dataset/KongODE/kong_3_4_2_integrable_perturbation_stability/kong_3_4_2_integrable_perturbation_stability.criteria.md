# Criteria: kong_3_4_2_integrable_perturbation_stability

**Statement:** [kong_3_4_2_integrable_perturbation_stability.md](kong_3_4_2_integrable_perturbation_stability.md) · **Lean:** [kong_3_4_2_integrable_perturbation_stability.lean](kong_3_4_2_integrable_perturbation_stability.lean) · **Context:** [kong_3_4_2_integrable_perturbation_stability.context.md](kong_3_4_2_integrable_perturbation_stability.context.md)

## What the theorem says

Start with the linear system $x' = A(t)x$ and perturb it to $x' = A(t)x + r(t,x)$. Suppose the
perturbation is small near the origin in a controlled way: there is a continuous nonnegative
function $p$ on $[0,\infty)$ with finite total integral such that
$\lvert r(t,x)\rvert \le p(t)\lvert x\rvert$ for all $t \ge 0$ and all sufficiently small $x$. Then
stability of the linear system passes to the perturbed one: if the linear system is uniformly
stable, so is the zero solution of the perturbed system; and if the linear system is also
asymptotically stable, so is the perturbed one.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $p$ is continuous on $[0,\infty)$. | ✅ First conjunct of `IntegrableSmallPerturbation p r`: `ContinuousOn p (Set.Ici 0)`. |
| 2 | $p$ is nonnegative. | ✅ `∀ t ≥ 0, 0 ≤ p t`, on the half-line where the text asks it. |
| 3 | $\int_0^\infty p < \infty$, stated as integrability rather than as a numerical bound on the integral. | ✅ `IntegrableOn p (Set.Ici 0)`. For continuous $p \ge 0$ this is exactly Kong's condition. |
| 4 | One radius $\rho$, fixed before $t$, within which the bound $\lVert r(t,x)\rVert \le p(t)\lVert x\rVert$ holds for every $t \ge 0$. | ✅ `∃ ρ, 0 < ρ ∧ ∀ t, 0 ≤ t → ∀ x, ‖x‖ < ρ → ‖r t x‖ ≤ p t * ‖x‖`. |
| 5 | The perturbed system is $x' = A(t)x + r(t,x)$, and the conclusions are about **its** zero solution. | ✅ `fun t x ↦ A t *ᵥ x + r t x`. |
| 6 | Part (a): uniform stability of the linear system implies uniform stability of the perturbed one. | ✅ First conjunct of the conclusion. |
| 7 | Part (b): uniform **and** asymptotic stability of the linear system implies uniform and asymptotic stability of the perturbed one; both hypotheses appear. | ✅ `UniformlyStableLinearEquation A → AsymptoticallyStableLinearEquation A → AsymptoticallyStableZeroSolution …`, and `AsymptoticallyStableZeroSolution` has uniform stability as its first conjunct. |
| 8 | The stability notions range over initial times $t_0 \ge 0$, matching the half-line on which the perturbation is controlled. | ✅ `UniformlyStableZeroSolution` and `AsymptoticallyStableZeroSolution` both carry the hypothesis `0 ≤ t₀`. |
| 9 | The attraction radius and the stability radius are single numbers, independent of $t_0$. | ✅ `∃ δ, 0 < δ ∧ ∀ t₀ x, …` in both definitions, with `δ` bound before `t₀`. |
| 10 | Solutions are genuine solutions on the whole line. | ✅ `IsTrajectory F x := ∀ t, HasDerivAt x (F t (x t)) t`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Letting the stability notions quantify over **all** real initial times, including negative ones. | The conclusion becomes false, because nothing is assumed about $r$ for $t < 0$. Take $n = 1$, $A \equiv 0$, $p \equiv 0$ (the hypothesis holds with $\rho = 1$, since $r(t,x) = 0$ for $t \ge 0$) and $r(t,x) := \max(-t, 0)$. The linear system is uniformly stable. But for $\varepsilon = 1$ and any $\delta > 0$, the solution $\psi(t) = (T^2 - t^2)/2$ for $t \le 0$, $\psi(t) = T^2/2$ for $t \ge 0$ has $\lvert\psi(-T)\rvert = 0 < \delta$ and $\lvert\psi(0)\rvert = T^2/2 \ge 1$. Part (b) fails the same way with $A \equiv -1$. |
| 2 | Writing $\int_0^\infty p < \infty$ as `∫ t in Set.Ici 0, p t ≠ ⊤` with a Bochner integral. | Lean gives a non-integrable function integral `0`, so the condition would be satisfied precisely by the functions the hypothesis is meant to exclude. Stating integrability directly avoids this. |
| 3 | Swapping the quantifiers to "for each $t$ there is a radius $\rho_t$". | Then the bound gives no uniform control near the origin and the hypothesis is useless — the perturbation could be large at every fixed small $x$. |
| 4 | Dropping the ball and requiring $\lVert r(t,x)\rVert \le p(t)\lVert x\rVert$ for all $x$. | That is a globally linear bound on the perturbation, a strictly stronger hypothesis and a different theorem. Kong only controls $r$ near the origin. |
| 5 | Concluding only asymptotic attraction in part (b), dropping the uniform-stability half. | The text says "uniformly stable and asymptotically stable"; both conclusions are asserted. |
| 6 | Passing the hypothesis of part (a) but not that of part (b), or stating part (b) with the asymptotic hypothesis alone. | Kong's part (b) assumes both. |
| 7 | Describing solutions with `deriv`. | `deriv` is `0` where the function is not differentiable, so non-solutions would be admitted wherever the field vanishes. |

## Notes on the ground truth

- Kong's standing assumptions for the two systems include continuity of $A$ and of $r$, and $r(t,0) = 0$ so that $x \equiv 0$ really is a solution. We assume none of these. Without them the perturbed system may simply have no solutions through a given point, in which case the conclusion holds because there is nothing to check rather than for a mathematical reason. The condition $r(t,0) = 0$ does follow for $t \ge 0$ from the bound at $x = 0$: $\lVert r(t,0)\rVert \le p(t)\cdot 0 = 0$.
- `IsTrajectory` asks for a solution defined on all of $\mathbb{R}$, including backwards in time, whereas Kong's solutions only need to exist on their maximal interval. This narrows the class of solutions the conclusion speaks about, so our version is weaker than the printed one. It is also the design choice that made the counterexample in mistake 1 possible before the initial time was restricted to $t_0 \ge 0$.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[kong_3_4_2_integrable_perturbation_stability.md](kong_3_4_2_integrable_perturbation_stability.md) and the background in [kong_3_4_2_integrable_perturbation_stability.context.md](kong_3_4_2_integrable_perturbation_stability.context.md),
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

- Requirement 4 with the smallness radius allowed to depend on $t$.
- Requirement 3 with the integrability of $p$ dropped or weakened to boundedness.
- Requirement 9 with the stability radii allowed to depend on the initial time.

### Domain-specific pitfalls for this problem

- The perturbation bound is $|r(t,x)| \le p(t)|x|$ — linear in $|x|$, with the integrable factor in $t$.
- The smallness radius is fixed before $t$ and the bound holds for all $t \ge 0$.
- Uniformity in the initial time is what the word "uniformly" carries in both stability notions.
- The hypotheses live on $[0,\infty)$, so initial times are restricted there.
- Part (b) assumes and concludes *both* properties.
