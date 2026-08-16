# Criteria: kong_5_4_2_hopf_friedrich_dichotomy

**Statement:** [kong_5_4_2_hopf_friedrich_dichotomy.md](kong_5_4_2_hopf_friedrich_dichotomy.md) · **Lean:** [kong_5_4_2_hopf_friedrich_dichotomy.lean](kong_5_4_2_hopf_friedrich_dichotomy.lean) · **Context:** [kong_5_4_2_hopf_friedrich_dichotomy.context.md](kong_5_4_2_hopf_friedrich_dichotomy.context.md)

## What the theorem says

Take a family of planar systems $x' = F(x,\mu)$ depending on a real parameter, analytic in both
variables, with the origin an equilibrium for every $\mu$. Suppose that at $\mu = 0$ the
linearization at the origin has eigenvalues $\pm i\beta$ with $\beta > 0$ — a centre — and that the
real part $\alpha(\mu)$ of the eigenvalues has vanishing derivative at $\mu = 0$, so the eigenvalues
do not cross the imaginary axis at first order. Then exactly one of two pictures holds. Either the
system at $\mu = 0$ is a genuine centre — all nearby orbits are closed — and no nearby closed orbits
exist for $\mu \ne 0$; or a single limit cycle is born on one side of $\mu = 0$ only, shrinking to
the origin as $\mu \to 0$ with its period tending to $2\pi/\beta$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. In the assessment column, ✅ means the ground truth states the requirement and
◐ means it states it in a form that deliberately departs from the text — a narrower setting, a
stronger hypothesis, or an equivalent but not literal phrasing — with the reason given. A ◐ records
a decision, not an open defect; where a more literal rendering would be at least as good, the row
says so.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $\beta > 0$. | ✅ `hβ : 0 < β`. |
| 2 | $F$ is analytic in the pair $(x,\mu)$. | ✅ `ContDiff ℝ ω (fun p : (Fin 2 → ℝ) × ℝ ↦ F p.1 p.2)`; in the `ContDiff` scope `ω` is real-analytic, which is Kong's hypothesis (5.4.2), while `∞` would be merely $C^\infty$ and the dichotomy is not available there. |
| 3 | The origin is an equilibrium for **every** value of the parameter. | ✅ `∀ μ, F 0 μ = 0`. |
| 4 | The linearization is the Jacobian in $x$, evaluated at the origin, for the given $\mu$. | ✅ `linearizationMatrix F μ i j := fderiv ℝ (fun x ↦ F x μ) 0 (Pi.single j 1) i` — the columns are the directional derivatives along the standard basis at $0$. |
| 5 | $\alpha(0) = 0$, i.e. the trace of the linearization at $\mu = 0$ vanishes. | ✅ `Matrix.trace (linearizationMatrix F 0) = 0`. |
| 6 | $\beta(0) = \beta$, i.e. the determinant of the linearization at $\mu = 0$ is $\beta^2$. | ✅ `Matrix.det (linearizationMatrix F 0) = β ^ 2`. |
| 7 | The degeneracy condition $\alpha'(0) = 0$, i.e. the trace of the linearization has derivative $0$ in $\mu$ at $\mu = 0$. | ✅ `HasDerivAt (fun μ ↦ Matrix.trace (linearizationMatrix F μ)) 0 0`. |
| 8 | The conclusion is a three-way alternative: the centre case, or a cycle for small $\mu > 0$, or a cycle for small $\mu < 0$. | ✅ `center ∨ hopf true ∨ hopf false`. |
| 9 | The centre case has two conjuncts: every nearby nonconstant orbit at $\mu = 0$ is closed, **and** for small $\mu \ne 0$ there are no nearby closed orbits. | ✅ Both, with the first restricted to nonconstant trajectories with $\lVert x(0)\rVert < \varepsilon$ and the second as `∀ μ, 0 < abs μ → abs μ < ε → ¬∃ x, IsClosedOrbit (fun y ↦ F y μ) x ∧ ‖x 0‖ < ε`. |
| 10 | In the cycle case, for every small $\mu$ on the chosen side there is a closed orbit with a positive period. | ✅ `IsClosedOrbit (fun y ↦ F y μ) (orbit μ) ∧ 0 < period μ ∧ ∀ t, orbit μ (t + period μ) = orbit μ t`. |
| 11 | That cycle is **unique** among nearby closed orbits, as a set of points rather than as a parametrized curve. | ✅ `∀ y, IsClosedOrbit (fun z ↦ F z μ) y → ‖y 0‖ < ε → range y = range (orbit μ)`. |
| 12 | The cycle shrinks to the origin and its period tends to $2\pi/\beta$ as $\mu \to 0$. | ✅ `Tendsto (fun μ ↦ ⨆ t, ‖orbit μ t‖) …` — the supremum over the whole cycle, not just its base point — with both limits taken along the one-sided filter `𝓝[>] 0` or `𝓝[<] 0` matching the side on which the cycle exists. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Introducing $\alpha$ and $\beta$ as existentially quantified functions of $\mu$ with the eigenvalue condition, then writing $\alpha'(0) = 0$. | With no regularity imposed on $\alpha$, the eigenvalue condition only pins down $\alpha(\mu)$ pointwise up to the labelling of the two conjugate eigenvalues, and the derivative condition can be met by a badly chosen labelling. Going through the trace and determinant of the linearization avoids inventing these functions at all. |
| 2 | Confusing mathlib's smoothness markers: writing `ContDiff ℝ ω` while meaning $C^\infty$, or `ContDiff ℝ ∞` while meaning analytic. | These are different hypotheses and the theorem depends on the difference. `∞` is $C^\infty$; `ω` (which is `⊤` at that type) is analytic. |
| 3 | Taking the derivative in the wrong variable, or at the wrong base point. | The linearization is the derivative in $x$ at $x = 0$, with $\mu$ held fixed. Differentiating in $\mu$, or at a moving base point, gives a different matrix and the spectral conditions become meaningless. |
| 4 | Dropping the second conjunct of the centre case. | "All nearby orbits at $\mu = 0$ are closed" alone is too easy to satisfy; the assertion that cycles do **not** appear for $\mu \ne 0$ is what makes this alternative exclude the other. |
| 5 | Stating uniqueness of the limit cycle as uniqueness of the solution function. | Any time-shift or reparametrization of a periodic solution traces the same cycle, so uniqueness must be uniqueness of the image set. |
| 6 | Omitting $F(0,\mu) = 0$, or omitting $\beta > 0$. | Without the first the origin is not an equilibrium and there is no bifurcation to analyse. Without the second $\beta$ could be $0$ or negative and the period $2\pi/\beta$ is meaningless. |
| 7 | Allowing the cycle case to be silent about whether cycles also exist on the other side. | Kong says the cycle appears for small $\mu > 0$ **only**, or for small $\mu < 0$ **only**; the exclusivity is part of the claim. |

## Notes on the ground truth

- The exclusivity just mentioned is in fact dropped by our statement: `hopf true` says nothing about negative $\mu$ and `hopf false` says nothing about positive $\mu$, so `center ∨ hopf true ∨ hopf false` is weaker than the printed dichotomy. A faithful version would add "and no closed orbits near the origin for $\mu$ on the other side".
- "$\Gamma(\mu) \to (0,0)$" is encoded as convergence of $\lVert \text{orbit}\ \mu\ 0\rVert$, that is, of one point of the cycle. Convergence of the whole cycle would be $\sup_t \lVert \text{orbit}\ \mu\ t\rVert \to 0$.
- The limits are taken along the two-sided filter `𝓝[≠] 0`, but `orbit` and `period` are constrained only on the relevant side of $0$; their values on the other side are unconstrained, so the existential can choose whatever makes the limits work. `𝓝[>] 0` and `𝓝[<] 0` would be exact.
- `period μ` is asserted to *be* a period, not the least one. Since any integer multiple of a period is a period, the limit $2\pi/\beta$ constrains a chosen period rather than the minimal one. Adding minimality — for instance `IsLeast {T \| 0 < T ∧ Function.Periodic (orbit μ) T} (period μ)` — would be faithful.
- "Orbits in a neighborhood of $(0,0)$" is encoded by a bound on the initial point $\lVert x(0)\rVert < \varepsilon$ only, not by asking the whole orbit to stay in the neighborhood.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[kong_5_4_2_hopf_friedrich_dichotomy.md](kong_5_4_2_hopf_friedrich_dichotomy.md) and the background in [kong_5_4_2_hopf_friedrich_dichotomy.context.md](kong_5_4_2_hopf_friedrich_dichotomy.context.md),
not against the ground-truth Lean file: a candidate spelled differently but
mathematically equivalent to the text loses nothing. The scale is defined in
[GRADING.md](../../GRADING.md); the numbers below are this problem's instance of it.

| Band | Points | This problem |
|---|---|---|
| A. Completeness | 50 | The requirement table above has 12 rows, so each row is worth 4.2 points: full credit if the candidate states it in any equivalent form, half for a harmless strengthening or weakening, none if it is absent. |
| B. Semantic fidelity | 20 | Junk values, `ℝ` vs `ℝ≥0∞`, coercions, quantifier order, a.e. vs everywhere — see the pitfalls below. |
| C. Mathlib-concept correctness | 15 | The Mathlib notion must mean the textbook notion, with the typeclass assumptions it needs. |
| D. Non-degeneracy | 10 | Not vacuous, not trivial, not a strictly weaker theorem. |
| E. Hygiene | 5 | No needless definitions, redundant conjuncts or unused hypotheses. |

**Every row of the *Mistakes to check for* table above is a defect.** Charge each one to the band it belongs to and deduct there.

### Fatal — any of these caps the total at 25

- Requirement 7 with the degeneracy condition $\alpha'(0)=0$ dropped: that is the ordinary Hopf setting and a different theorem.
- Requirement 8 with the two alternatives merged, or with case (b) allowed on both sides of $\mu=0$ simultaneously.
- Requirement 11 with uniqueness of the cycle dropped.

### Domain-specific pitfalls for this problem

- Analyticity of $F$ is what the theorem assumes; smoothness is strictly weaker and does not suffice for the centre alternative.
- The trace/determinant formulation of the eigenvalue hypotheses is equivalent to the printed one and avoids naming $\alpha,\beta$ as functions.
- Case (b) is one-sided: a cycle for small $\mu>0$ *only*, or for small $\mu<0$ *only*.
- Uniqueness of the limit cycle is as a set of points, not as a parametrized solution.
- The limiting period is $2\pi/\beta$ with $\beta>0$ the imaginary part at $\mu=0$.
