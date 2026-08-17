# Criteria: krylov_2_3_1_green_poisson_representation

**Statement:** [krylov_2_3_1_green_poisson_representation.md](krylov_2_3_1_green_poisson_representation.md) · **Lean:** [krylov_2_3_1_green_poisson_representation.lean](krylov_2_3_1_green_poisson_representation.lean) · **Context:** [krylov_2_3_1_green_poisson_representation.context.md](krylov_2_3_1_green_poisson_representation.context.md)

## What the theorem says

Take a bounded domain $\Omega$ that is regular enough that every boundary point has a barrier. Start
from $K$, the fundamental solution of the Laplacian, and for each $x \in \Omega$ correct it by a
harmonic function $h(x,\cdot)$ that agrees with $K(x,\cdot)$ on the boundary. The difference
$G = K - h$ is the Green's function: harmonic away from $x$ and zero on the boundary. The theorem
says that any classical solution of $\Delta u = f$ in $\Omega$ with $u = g$ on $\partial\Omega$ can
be written down explicitly: a volume integral of $G$ against $f$, plus a surface integral of the
Poisson kernel $H = -\partial G/\partial n$ against $g$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The dimension is at least $1$, so that $\partial\Omega$ and the surface measure make sense. | ✅ `hd : 0 < d`. |
| 2 | $\Omega$ is open, bounded, nonempty, and every boundary point carries a barrier: a function that is continuous on $\bar\Omega$, twice differentiable inside, zero at that point, positive elsewhere, and with $\Delta b \le 0$ in $\Omega$. | ✅ `hΩsmooth : SmoothBoundedDomain Ω`, whose first component is `RegularBoundedDomain Ω`; its barrier clause includes `ContDiffOn ℝ 2 barrier Ω`. |
| 3 | $K$ is genuinely the fundamental solution of the Laplacian, not an arbitrary two-variable function. | ✅ `hK : IsLaplaceFundamentalSolution K`, i.e. $\int K(x,y)\,\Delta\varphi(y)\,dy = \varphi(x)$ for every smooth compactly supported $\varphi$ with integrable integrand. |
| 4 | For each $x \in \Omega$ the corrector $h(x,\cdot)$ is $C^2$ and harmonic in $\Omega$, continuous up to $\bar\Omega$, and equals $K(x,\cdot)$ on $\partial\Omega$. | ✅ `hharmonic : ∀ x ∈ Ω, HarmonicIn Ω (h x)`, `hcorrectorContinuous : ∀ x ∈ Ω, ContinuousOn (h x) (closure Ω)`, and `hboundary`. |
| 5 | $G = K - h$, and $G(x,\cdot)$ is harmonic on $\Omega \setminus \{x\}$ and vanishes on $\partial\Omega$. | ✅ `hgreen`, `hgreenHarmonic`, `hgreenBoundary`. |
| 6 | The Poisson kernel is minus the normal derivative of $G$ at a boundary point, taken as a one-sided derivative from inside the domain. | ✅ `hpoisson` uses `fderivWithin ℝ (G x) (closure Ω) y (normal y)`, not the plain `fderiv`. |
| 7 | The direction differentiated along is the outward unit normal to $\partial\Omega$. | ✅ `hnormal : IsOutwardUnitNormal Ω normal` together with `hΩsmooth : SmoothBoundedDomain Ω`. Smoothness of the boundary is what makes the orthogonality clause non-vacuous and pins the normal down; on a rough boundary carrying no differentiable curves only the sign would be fixed, and the Poisson kernel would not be well defined. |
| 8 | $u$ is a classical solution: twice continuously differentiable in $\Omega$, continuous on $\bar\Omega$, solving $\Delta u = f$ inside and equal to $g$ on $\partial\Omega$. | ✅ `hu : LaplaceDirichletSolution Ω f g u`, which is the conjunction of all four clauses. |
| 9 | The conclusion holds at every interior point and is the sum of two integrals: $G(x,\cdot)f$ over $\Omega$ against Lebesgue measure, and $H(x,\cdot)g$ over $\partial\Omega$ against the $(d-1)$-dimensional surface measure. | ✅ `∀ x ∈ Ω, u x = (∫ y in Ω, G x y * f y) + ∫ y, H x y * g y ∂boundaryMeasure` with `hmeasure : boundaryMeasure = μH[((d : ℝ) - 1)].restrict (frontier Ω)`; the parentheses keep the two integrals separate summands. |
| 10 | Both integrals must actually converge. | ✅ `hGintegrable` and `hHintegrable`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Leaving $K$ as a free variable with no hypothesis attached. | Then the pair $(K,h)$ carries no information and the theorem is false. Let $\Omega$ be the unit ball and set $K = h = G = H = 0$; every remaining hypothesis holds. With $f = 0$, $g = 1$, $u \equiv 1$ the conclusion claims $1 = 0$. |
| 2 | Writing the Poisson kernel with the plain `fderiv ℝ (G x) y`. | $y$ is a boundary point and $G(x,\cdot)$ is only controlled inside $\Omega$, so it is usually not differentiable there. Lean's `fderiv` returns $0$ at such points, which would silently force $H \equiv 0$ and make the boundary integral disappear. |
| 3 | Defining "regular domain" with a barrier that is only assumed continuous. | The Laplacian `Δ` is assembled from (iterated) derivatives, which are $0$ wherever the function is not differentiable. A nowhere-differentiable barrier such as $b(y) = \lVert y - z\rVert\,(1 + W(y))$ with $W$ a Weierstrass function then satisfies $\Delta b = 0 \le 0$ for free, so the regularity assumption would say nothing beyond "open, bounded, nonempty". |
| 4 | Working in `Fin d → ℝ` instead of `EuclideanSpace ℝ (Fin d)`. | `Fin d → ℝ` carries the sup norm, so `μH[d-1]` would be Hausdorff measure for the $\ell^\infty$ metric. On a hypersurface that is not even proportional to the Euclidean surface measure: the segment from $(0,0)$ to $(1,1)$ has $\ell^\infty$-length $1$ but Euclidean length $\sqrt{2}$, while a coordinate segment has the same length in both. |
| 5 | Dropping `ContinuousOn u (closure Ω)` from the solution concept. | A Lean function is defined everywhere, so its value at a boundary point is unrelated to its behaviour inside unless continuity links them. Without that clause "$u = g$ on $\partial\Omega$" constrains nothing. |
| 6 | Omitting the integrability hypotheses. | $G(x,\cdot)$ has a $\lvert x-y\rvert^{2-d}$ singularity. Lean's Bochner integral returns $0$ for a non-integrable integrand, so the identity would compare a real number against junk. |
| 7 | Integrating the second term against Lebesgue measure, or over $\bar\Omega$ instead of $\partial\Omega$. | The Poisson term is a surface integral. Lebesgue measure of $\partial\Omega$ is $0$, so the term would vanish and the formula would be false. |
| 8 | Omitting the continuity of the corrector up to $\bar\Omega$, so that $h(x,\cdot)$ is only harmonic inside and prescribed on the frontier. | A total function's frontier values are then decoupled from its interior behaviour, and the theorem becomes false: replace $h$ by $h + \mathbf{1}_\Omega$ — still harmonic in $\Omega$, still equal to $K$ on $\partial\Omega$ — which makes $G$ discontinuous at the boundary, forces $H \equiv 0$ through the `fderivWithin` junk value, and defeats the conclusion at $f = 0$, $g = 1$, $u \equiv 1$. An earlier version of the ground truth had this gap; the current statement carries `hcorrectorContinuous`. |
| 9 | Writing the conclusion's sum of integrals without parenthesizing the volume integral. | `∫ y in Ω, G x y * f y + ∫ y, H x y * g y ∂boundaryMeasure` parses the boundary integral into the *body* of the volume integral, asserting $u(x) = \int_\Omega Gf\,dy + \mathrm{vol}(\Omega)\int_{\partial\Omega} Hg\,dS$ — wrong whenever $\mathrm{vol}(\Omega) \ne 1$. The ground truth writes `(∫ y in Ω, G x y * f y) + ∫ y, H x y * g y ∂boundaryMeasure`; an earlier version had the mis-parse. |

## Notes on the ground truth

- The integrability hypotheses are extra: in the text they follow from $K$ being the fundamental solution. Assuming them is harmless and keeps the Bochner integral honest.
- `hgreenHarmonic` and `hgreenBoundary` are consequences of the earlier hypotheses in the text ("so that, in particular"); assuming them explicitly is harmless.
- The Laplacian is mathlib's `InnerProductSpace` Laplacian (`Δ` notation), and harmonicity of the corrector and of the Green function is mathlib's `HarmonicOnNhd`; on the open sets involved ($\Omega$ and $\Omega \setminus \{x\}$) these are the classical notions. `multiDerivative` remains hand-rolled from repeated `fderiv` along coordinate directions, since mathlib has no classical mixed multi-index derivative; on open sets it agrees with the classical object.
- `SmoothBoundedDomain Ω` is by definition `RegularBoundedDomain Ω ∧ (defining-function clause)`, so the single hypothesis `hΩsmooth` already carries the barrier regularity; a separate `RegularBoundedDomain` hypothesis would be redundant (an earlier version stated one).
- `IsOutwardUnitNormal` is the weakest point of the encoding (row 7): it constrains the direction rather than determining it.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[krylov_2_3_1_green_poisson_representation.md](krylov_2_3_1_green_poisson_representation.md) and the background in [krylov_2_3_1_green_poisson_representation.context.md](krylov_2_3_1_green_poisson_representation.context.md),
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

- Requirement 3 with $K$ an arbitrary two-variable kernel rather than the fundamental solution of the Laplacian.
- Requirement 6 or 7 with the sign of $H$ or the direction of the normal wrong.
- Requirement 5 with $G$ not required to vanish on the boundary.

### Domain-specific pitfalls for this problem

- The normal derivative is in the *second* variable and along the *outward* normal, and the Poisson kernel carries an explicit minus sign.
- The corrector is harmonic in $y$ for each fixed $x$, continuous up to the boundary, and matches $K$ on the boundary; all three clauses are needed.
- Regularity of the domain (existence of barriers) is what makes the hypothesis on $h$ satisfiable.
- Both integrals must be asserted to converge; a Bochner integral of a non-integrable function is the junk value $0$.
- $u$ is a classical solution — $C^2$ inside and continuous up to the boundary.
