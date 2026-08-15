# Criteria: nikolski_A_3_6_boundary_uniqueness

**Statement:** [nikolski_A_3_6_boundary_uniqueness.md](nikolski_A_3_6_boundary_uniqueness.md) · **Lean:** [nikolski_A_3_6_boundary_uniqueness.lean](nikolski_A_3_6_boundary_uniqueness.lean) · **Context:** [nikolski_A_3_6_boundary_uniqueness.context.md](nikolski_A_3_6_boundary_uniqueness.context.md)

## What the theorem says

Let $g$ be a function in the Hardy class $H^1$ on the unit disc (the same works for $H^p$ with any
$p > 0$). Its radial boundary values exist at almost every point of the circle. If $g$ is not the
zero function, then $\log\lvert g\rvert$ is integrable on the circle. In particular, the boundary
values of a Hardy function cannot vanish on a set of positive measure unless $g$ is identically
zero on the disc.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The exponent is not $0$. | ✅ `hp : p ≠ 0`. |
| 2 | The function belongs to a Hardy class: analytic on the open disc with bounded radial $L^p$ means. | ✅ `hf : HardyClass p f`. |
| 3 | The radial boundary values exist at almost every point. | ✅ First conjunct of the conclusion, `HasRadialBoundaryValues f` — this is Fatou's theorem and is what makes every later mention of `boundaryValue` meaningful. |
| 4 | If the function is not identically zero on the disc, then $\log$ of the modulus of its boundary values is integrable over the circle. | ✅ `(∃ z ∈ Metric.ball (0 : ℂ) 1, f z ≠ 0) → IntegrableOn (fun t ↦ Real.log ‖boundaryValue f (unitCirclePoint t)‖) (Set.Ioc 0 (2 * Real.pi))`. |
| 5 | The uniqueness half starts from a boundary set of *positive measure*. | ✅ `0 < volume {t ∈ Set.Ioc 0 (2 * Real.pi) \| unitCirclePoint t ∈ E}`. |
| 6 | The vanishing on that set is asserted almost everywhere, not everywhere. | ✅ `∀ᵐ t ∂volume.restrict (Set.Ioc 0 (2 * Real.pi)), unitCirclePoint t ∈ E → boundaryValue f (unitCirclePoint t) = 0`. |
| 7 | The conclusion is that the function vanishes at every point of the disc. | ✅ `∀ z ∈ Metric.ball (0 : ℂ) 1, f z = 0`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Talking about boundary values without ever asserting that they exist. | `boundaryValue f ζ` is a `limUnder`, which Lean fills in with an arbitrary chosen value wherever the radial limit fails. Statements about it are then statements about junk. |
| 2 | Keeping only the "in particular" clause and dropping the claim that $\log\lvert g\rvert$ is integrable. | The integrability claim is the actual content of the corollary; the vanishing statement is a two-line consequence of it. |
| 3 | Stating the integrability of $\log\lvert g\rvert$ without the hypothesis that $g$ is nonzero. | Lean sets $\log 0 = 0$, so for $g = 0$ the integrand is the constant $0$ and the claim would come out true for the wrong reason, hiding a genuinely false assertion. |
| 4 | Omitting $p \ne 0$. | Lean's `eLpNorm f 0 μ` is $0$ by convention, so `HardyClass 0 f` says only "analytic on the disc". Every conclusion here then fails: an arbitrary analytic function need not have boundary values at all. |
| 5 | Concluding only that the boundary function vanishes almost everywhere. | Strictly weaker, and it misses the point: the theorem propagates the vanishing from the circle into the whole disc. |
| 6 | Reading "$g \ne 0$" as `f ≠ 0` for total functions `ℂ → ℂ`. | The values off the disc are unconstrained, so that hypothesis can hold while $f$ vanishes on the entire disc. |
| 7 | Requiring the boundary values to vanish at *every* point of the set. | Boundary values are only defined almost everywhere, so an everywhere-hypothesis is not satisfiable in the intended way and weakens the theorem. |

## Notes on the ground truth

- Instead of naming the boundary zero set, the statement quantifies over an arbitrary set $E$ of
  circle points that has positive measure and on which the boundary values vanish. This is
  equivalent (take $E$ to be the zero set) and is slightly more general-looking. $E$ is not
  required to be measurable; `volume` applied to the parameter preimage is then the outer measure,
  which is the reading that avoids any junk. The direct form — positive measure of the zero set
  itself — would be simpler and closer to the printed line.
- Lean's `Real.log 0 = 0` means the integrability claim does not by itself rule out that
  $\lvert g\rvert$ vanishes on a set of positive measure. It is the nonvanishing guard that makes
  the claim mean what it should. An explicit conjunct
  `∀ᵐ t, boundaryValue f (unitCirclePoint t) ≠ 0`, or a formulation with a lower Lebesgue integral,
  would be immune to misreading.
- Generalizing from the book's $H^1$ to "any $p \ne 0$" also admits $p = \infty$ and $0 < p < 1$.
  The statement is true throughout that range, since all these Hardy classes sit inside the
  Smirnov class, so the generalization is sound.
- Boundary values are radial limits, not nontangential limits. That is weaker than Fatou's theorem
  gives, but it is the standard minimal reading.
- The circle is modelled by the parameter interval $(0,2\pi]$ with unnormalized Lebesgue measure
  rather than by the normalized measure $m$ of the text. Positivity of measure,
  almost-everywhere statements and integrability are all unaffected by the constant factor $2\pi$.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[nikolski_A_3_6_boundary_uniqueness.md](nikolski_A_3_6_boundary_uniqueness.md) and the background in [nikolski_A_3_6_boundary_uniqueness.context.md](nikolski_A_3_6_boundary_uniqueness.context.md),
not against the ground-truth Lean file: a candidate spelled differently but
mathematically equivalent to the text loses nothing. The scale is defined in
[GRADING.md](../../GRADING.md); the numbers below are this problem's instance of it.

| Band | Points | This problem |
|---|---|---|
| A. Completeness | 50 | The requirement table above has 7 rows, so each row is worth 7.1 points: full credit if the candidate states it in any equivalent form, half for a harmless strengthening or weakening, none if it is absent. |
| B. Semantic fidelity | 20 | Junk values, `ℝ` vs `ℝ≥0∞`, coercions, quantifier order, a.e. vs everywhere — see the pitfalls below. |
| C. Mathlib-concept correctness | 15 | The Mathlib notion must mean the textbook notion, with the typeclass assumptions it needs. |
| D. Non-degeneracy | 10 | Not vacuous, not trivial, not a strictly weaker theorem. |
| E. Hygiene | 5 | No needless definitions, redundant conjuncts or unused hypotheses. |

**Every row of the *Mistakes to check for* table above is a defect.** Charge each one to the band it belongs to and deduct there.

### Fatal — any of these caps the total at 25

- Requirement 5 with the boundary zero set required to have full measure rather than positive measure.
- Requirement 4 with $\log|g|$ read on the disc rather than on the boundary values.
- Requirement 7 with the conclusion weakened to "$g^* = 0$ a.e." without asserting vanishing on the disc.

### Domain-specific pitfalls for this problem

- The hypothesis is positivity of the measure of the boundary zero set — a strictly weaker hypothesis than full measure, which is what makes the theorem strong.
- Junk value — `Real.log`: $\log$ of $0$ is $0$ in Lean, so "$\log|g^*| \in L^1$" must be read as integrability of a function that is genuinely $-\infty$ where $g^*$ vanishes; the integrability assertion is what rules that out.
- Radial boundary values exist only almost everywhere and must be produced as part of the statement.
- The conclusion is vanishing at every point of the disc.
