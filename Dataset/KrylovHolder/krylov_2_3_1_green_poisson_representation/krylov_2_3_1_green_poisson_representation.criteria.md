# Criteria: krylov_2_3_1_green_poisson_representation

**Statement:** [krylov_2_3_1_green_poisson_representation.md](krylov_2_3_1_green_poisson_representation.md) · **Lean:** [krylov_2_3_1_green_poisson_representation.lean](krylov_2_3_1_green_poisson_representation.lean) · **Context:** [krylov_2_3_1_green_poisson_representation.context.md](krylov_2_3_1_green_poisson_representation.context.md)

## What the theorem says

Take a bounded domain $\Omega$ that is regular in the standing sense of Krylov's Chapter 2:
regular enough for integration by parts, i.e. Green's second identity holds for every pair of
functions in $C^2(\bar\Omega)$. Start from $K$, the fundamental solution of the Laplacian, and for
each $x \in \Omega$ correct it by a function $h(x,\cdot) \in C^2(\bar\Omega)$ that is harmonic in
$\Omega$ and agrees with $K(x,\cdot)$ on the boundary. The difference $G = K - h$ is the Green's
function: harmonic away from $x$ and zero on the boundary. The theorem says that any
$C^2(\bar\Omega)$-solution of $\Delta u = f$ in $\Omega$ with $u = g$ on $\partial\Omega$ can be
written down explicitly: a volume integral of $G$ against $f$, plus a surface integral of the
Poisson kernel $H = \partial G/\partial n$ (no minus sign) against $g$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The dimension is at least $1$, so that $\partial\Omega$ and the surface measure make sense. | ✅ `hd : 0 < d`. |
| 2 | $\Omega$ is open, bounded, nonempty, and regular in Chapter 2's standing sense: Green's second identity $\int_\Omega (v\,\Delta w - w\,\Delta v) = \int_{\partial\Omega} (v\,\partial w/\partial n - w\,\partial v/\partial n)\,dS$ holds for every pair $v, w \in C^2(\bar\Omega)$, relative to the surface measure and the outward unit normal. | ✅ `hΩ : GreensIdentityDomain Ω boundaryMeasure normal`, which unfolds to `IsOpen Ω ∧ Bornology.IsBounded Ω ∧ Ω.Nonempty ∧` the identity `∫ x in Ω, (v x * Δ w x - w x * Δ v x) = ∫ y, (v y * … - w y * …) ∂boundaryMeasure` for all `v w` with `ContDiffOn ℝ 2 · (closure Ω)`, the normal derivatives taken as `fderivWithin ℝ · (closure Ω) y (normal y)`. |
| 3 | $K$ is genuinely the fundamental solution of the Laplacian, not an arbitrary two-variable function. | ✅ `hK : IsLaplaceFundamentalSolution K`, i.e. $\int K(x,y)\,\Delta\varphi(y)\,dy = \varphi(x)$ for every smooth compactly supported $\varphi$ with integrable integrand. |
| 4 | For each $x \in \Omega$ the corrector $h(x,\cdot)$ lies in $C^2(\bar\Omega)$ — derivatives through second order continuous (hence bounded) up to the closure — is harmonic in $\Omega$, and equals $K(x,\cdot)$ on $\partial\Omega$. | ✅ `hcorrector : ∀ x ∈ Ω, ContDiffOn ℝ 2 (h x) (closure Ω)`, `hharmonic : ∀ x ∈ Ω, ∀ y ∈ Ω, Δ (h x) y = 0` (pointwise, safe against the `Δ`-junk-value trap only because `hcorrector` carries the $C^2$ regularity separately), and `hboundary : ∀ x ∈ Ω, ∀ y ∈ frontier Ω, h x y = K x y`. |
| 5 | $G = K - h$, and $G(x,\cdot)$ is harmonic on $\Omega \setminus \{x\}$ and vanishes on $\partial\Omega$. | ✅ `hgreen`, `hgreenHarmonic : ∀ x ∈ Ω, HarmonicOnNhd (G x) (Ω \ {x})`, `hgreenBoundary`. |
| 6 | The Poisson kernel is the normal derivative of $G$ at a boundary point — $H(x,y) = +\,\partial G(x,y)/\partial n_y$, with **no** minus sign — taken as a one-sided derivative from inside the closed domain. | ✅ `hpoisson` says `H x y = fderivWithin ℝ (G x) (closure Ω) y (normal y)`: no negation, and `fderivWithin` on `closure Ω` rather than the plain `fderiv`. |
| 7 | The direction differentiated along is the outward unit normal to $\partial\Omega$. | ✅ `hnormal : IsOutwardUnitNormal Ω normal`: unit length, orthogonal to every differentiable curve in the boundary, and pointing from $\Omega$ into the complement. The same `normal` is the one `hΩ`'s Green's identity is stated with, which ties it to the domain's geometry. |
| 8 | $u$ is a $C^2(\bar\Omega)$-solution: derivatives through second order continuous (hence bounded) up to the closure, $\Delta u = f$ in $\Omega$, and $u = g$ on $\partial\Omega$. | ✅ `huSmooth : ContDiffOn ℝ 2 u (closure Ω)`, `huEquation : ∀ x ∈ Ω, Δ u x = f x`, `huBoundary : ∀ x ∈ frontier Ω, u x = g x`. |
| 9 | The conclusion holds at every interior point and is the sum of two integrals: $G(x,\cdot)f$ over $\Omega$ against Lebesgue measure, and $H(x,\cdot)g$ over $\partial\Omega$ against the $(d-1)$-dimensional surface measure. | ✅ `∀ x ∈ Ω, u x = (∫ y in Ω, G x y * f y) + ∫ y, H x y * g y ∂boundaryMeasure` with `hmeasure : boundaryMeasure = μH[((d : ℝ) - 1)].restrict (frontier Ω)`; the parentheses keep the two integrals separate summands. |
| 10 | Both integrals must actually converge. | ✅ `hGintegrable` and `hHintegrable`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Leaving $K$ as a free variable with no hypothesis attached. | Then the pair $(K,h)$ carries no information and the theorem is false. Let $\Omega$ be the unit ball and set $K = h = G = H = 0$; every remaining hypothesis holds. With $f = 0$, $g = 1$, $u \equiv 1$ the conclusion claims $1 = 0$. |
| 2 | Writing the Poisson kernel with the plain `fderiv ℝ (G x) y`. | $y$ is a boundary point and $G(x,\cdot)$ is only controlled on $\bar\Omega$, so the two-sided derivative usually does not exist there. Lean's `fderiv` returns $0$ at such points, which would silently force $H \equiv 0$ and make the boundary integral disappear. |
| 3 | Putting a minus sign on the Poisson kernel: $H = -\partial G/\partial n_y$. | Krylov's normalization is $\Delta_y K(x,\cdot) = \delta_x$ (a positive Laplacian, unlike texts built on $-\Delta$), and with it the book's kernel (p. 18) is $H = +\,\partial G/\partial n_y$. Negating it flips the boundary term: with $f = 0$, $g \equiv 1$, $u \equiv 1$ the correct formula reads $1 = \int_{\partial\Omega} H\,dS$, so the negated version asserts $1 = -1$. An earlier version of the ground truth carried this spurious minus sign; the current statement has none. |
| 4 | Glossing "regular bounded domain" as barrier regularity — every boundary point admits a barrier (a Perron-method notion). | Theorem 2.3.1's "regular" is Chapter 2's standing notion: regular enough for integration by parts, i.e. Green's identities hold for all $C^2(\bar\Omega)$ pairs — which is exactly what the proof uses. Barrier regularity belongs to the Perron method of Ch. 7.6 and is inequivalent: a Lebesgue-spine domain in $d \ge 3$ has a rectifiable boundary supporting Green's identity yet its cusp tip carries no barrier, while a von Koch–type domain in the plane is barrier-regular at every boundary point but has a non-rectifiable boundary on which surface integration by parts is meaningless. An earlier version of the ground truth (and its gloss) used the barrier notion; the current statement assumes the Green's-identity property itself. |
| 5 | Weakening $C^2(\bar\Omega)$ — for $u$ or for the corrector $h(x,\cdot)$ — to "$C^2$ inside $\Omega$ plus continuity on $\bar\Omega$". | Krylov's $C^2(\bar\Omega)$ means derivatives through second order continuous and bounded up to the closure, and the proof needs it: Green's second identity is applied to pairs involving $u$ and $h(x,\cdot)$, whose boundary terms contain $\partial u/\partial n$ and $\partial h/\partial n$ — one-sided derivatives that need not exist for a function merely continuous on $\bar\Omega$ (in Lean, `fderivWithin` at the boundary is then the junk value $0$). In particular $H = \partial G/\partial n_y$ itself is only well defined because $h(x,\cdot) \in C^2(\bar\Omega)$. An earlier version of the ground truth had exactly this weakening for both $u$ and $h$; the current statement carries `ContDiffOn ℝ 2 · (closure Ω)` for both. |
| 6 | Working in `Fin d → ℝ` instead of `EuclideanSpace ℝ (Fin d)`. | `Fin d → ℝ` carries the sup norm, so `μH[d-1]` would be Hausdorff measure for the $\ell^\infty$ metric. On a hypersurface that is not even proportional to the Euclidean surface measure: the segment from $(0,0)$ to $(1,1)$ has $\ell^\infty$-length $1$ but Euclidean length $\sqrt{2}$, while a coordinate segment has the same length in both. |
| 7 | Imposing no regularity of $u$ up to the closure at all — only "$\Delta u = f$ in $\Omega$" and "$u = g$ on $\partial\Omega$". | A Lean function is defined everywhere, so its boundary values are unrelated to its interior behaviour unless regularity links them. Take $f = 0$, $g \equiv 1$ and $u = \mathbf{1}_{\partial\Omega}$: harmonic inside, equal to $g$ on the frontier, yet the formula claims $0 = 1$ at interior points. |
| 8 | Omitting the integrability hypotheses. | $G(x,\cdot)$ has a $\lvert x-y\rvert^{2-d}$ singularity. Lean's Bochner integral returns $0$ for a non-integrable integrand, so the identity would compare a real number against junk. |
| 9 | Integrating the second term against Lebesgue measure, or over $\bar\Omega$ instead of $\partial\Omega$. | The Poisson term is a surface integral. Lebesgue measure of $\partial\Omega$ is $0$, so the term would vanish and the formula would be false. |
| 10 | Requiring of the corrector only harmonicity inside and the prescribed values on the frontier, with no regularity up to $\bar\Omega$. | A total function's frontier values are then decoupled from its interior behaviour, and the theorem becomes false: replace $h$ by $h + \mathbf{1}_\Omega$ — still harmonic in $\Omega$, still equal to $K$ on $\partial\Omega$ — which makes $G$ discontinuous at the boundary, forces $H \equiv 0$ through the `fderivWithin` junk value, and defeats the conclusion at $f = 0$, $g = 1$, $u \equiv 1$. |
| 11 | Writing the conclusion's sum of integrals without parenthesizing the volume integral. | `∫ y in Ω, G x y * f y + ∫ y, H x y * g y ∂boundaryMeasure` parses the boundary integral into the *body* of the volume integral, asserting $u(x) = \int_\Omega Gf\,dy + \mathrm{vol}(\Omega)\int_{\partial\Omega} Hg\,dS$ — wrong whenever $\mathrm{vol}(\Omega) \ne 1$. The ground truth writes `(∫ y in Ω, G x y * f y) + ∫ y, H x y * g y ∂boundaryMeasure`; an earlier version had the mis-parse. |

## Notes on the ground truth

- The integrability hypotheses are extra: in the text they follow from $K$ being the fundamental solution. Assuming them is harmless and keeps the Bochner integral honest.
- `hgreenHarmonic` and `hgreenBoundary` are consequences of the earlier hypotheses in the text ("so that, in particular"); assuming them explicitly is harmless.
- The Laplacian is mathlib's `InnerProductSpace` Laplacian (`Δ` notation). Harmonicity of the corrector is the pointwise `∀ y ∈ Ω, Δ (h x) y = 0` — safe against the derivative-junk-value trap only because `hcorrector` carries `ContDiffOn ℝ 2 (h x) (closure Ω)` separately; a candidate whose *only* regularity for $h$ is a pointwise `Δ … = 0` has said nothing (mistake rows 5 and 10). Harmonicity of the Green function stays mathlib's `HarmonicOnNhd` on the open set $\Omega \setminus \{x\}$, where it is the classical notion.
- `GreensIdentityDomain Ω boundaryMeasure normal` packages "regular bounded domain" the way Krylov's Chapter 2 uses it: open, bounded, nonempty, plus the validity of Green's second identity for all $C^2(\bar\Omega)$ pairs relative to the given surface measure and outward normal. It deliberately says nothing about barriers; barrier regularity is a different, inequivalent notion (mistake row 4).
- `IsOutwardUnitNormal` constrains the direction rather than uniquely determining it on a rough boundary; it is `hΩ`'s Green's identity, stated with the same `normal` and `boundaryMeasure`, that gives the pair its content. This remains the weakest point of the encoding (row 7).

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
- Requirement 6 or 7 with a sign error: the Poisson kernel negated ($H = -\partial G/\partial n$) or the normal pointing inward.
- Requirement 5 with $G$ not required to vanish on the boundary.

### Domain-specific pitfalls for this problem

- The normal derivative is in the *second* variable and along the *outward* normal, and the Poisson kernel carries **no** minus sign: $H = +\,\partial G/\partial n_y$. Krylov normalizes $K$ by $\Delta_y K = \delta_x$; importing the minus sign of $-\Delta$-based texts flips the boundary term.
- The corrector is $C^2(\bar\Omega)$ in $y$ for each fixed $x$, harmonic inside, and matches $K$ on the boundary; all three clauses are needed.
- "Regular" means regular enough for integration by parts — Green's identities for all $C^2(\bar\Omega)$ pairs — not barrier (Perron) regularity; the two are inequivalent.
- Both integrals must be asserted to converge; a Bochner integral of a non-integrable function is the junk value $0$.
- $u$ is a $C^2(\bar\Omega)$-solution — derivatives through second order continuous and bounded up to the closure, not merely $C^2$ inside with continuity at the boundary.
