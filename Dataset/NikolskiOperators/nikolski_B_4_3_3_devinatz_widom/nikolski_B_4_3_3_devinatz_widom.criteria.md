# Criteria: nikolski_B_4_3_3_devinatz_widom

**Statement:** [nikolski_B_4_3_3_devinatz_widom.md](nikolski_B_4_3_3_devinatz_widom.md) · **Lean:** [nikolski_B_4_3_3_devinatz_widom.lean](nikolski_B_4_3_3_devinatz_widom.lean) · **Context:** [nikolski_B_4_3_3_devinatz_widom.context.md](nikolski_B_4_3_3_devinatz_widom.context.md)

## What the theorem says

Let $u$ be an essentially bounded measurable function on the unit circle with $\lvert u\rvert = 1$
almost everywhere. The Devinatz–Widom criterion gives four equivalent descriptions of when the
Toeplitz operator $T_u$ is invertible: both $u$ and $\bar u$ are at distance less than $1$ from the
bounded analytic functions; there is an *outer* bounded analytic $h$ with
$\lVert u - h\rVert_\infty < 1$; and $u$ can be written as $e^{i(c + a + \tilde b)}$ with $a$ and
$b$ real and bounded, $c$ a real constant and $\lVert a\rVert_\infty < \pi/2$. Here $\tilde b$ is
the harmonic conjugate of $b$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. In the assessment column, ✅ means the ground truth states the requirement and
◐ means it states it in a form that deliberately departs from the text — a narrower setting, a
stronger hypothesis, or an equivalent but not literal phrasing — with the reason given. A ◐ records
a decision, not an open defect; where a more literal rendering would be at least as good, the row
says so.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $u$ is in $L^\infty(\mathbb{T})$: almost-everywhere measurable with finite essential supremum. | ✅ `hu : EssentiallyBoundedCircleSymbol u`. |
| 2 | $\lvert u\rvert = 1$ almost everywhere, not everywhere. | ✅ `hmod : IsUnimodularCircleSymbol u`, i.e. `∀ᵐ t ∂volume.restrict (Ioc 0 (2π)), ‖u (unitCirclePoint t)‖ = 1`. |
| 3 | Item (1): there is a bounded operator on $\ell^2(\mathbb{N})$ with the Toeplitz matrix $\hat u(n-j)$, and it is invertible. | ✅ `∃ T : ℓ²(ℕ, ℂ) →L[ℂ] ℓ²(ℕ, ℂ), RepresentsToeplitzOperator u T ∧ Function.Bijective T`. |
| 4 | Item (2): both $\operatorname{dist}(u, H^\infty) < 1$ **and** $\operatorname{dist}(\bar u, H^\infty) < 1$. | ✅ `symbolDistanceToHInfinity u < 1 ∧ symbolDistanceToHInfinity (fun ζ ↦ star (u ζ)) < 1`. |
| 5 | Item (3): an **outer** function in $H^\infty$ with $\lVert u - h\rVert_\infty < 1$. | ✅ `∃ h, OuterFunction ⊤ h ∧ eLpNorm (fun t ↦ u (unitCirclePoint t) - boundaryValue h (unitCirclePoint t)) ∞ … < 1`. |
| 6 | Item (4): real bounded functions and a real constant with $u = e^{i(c + a + \tilde b)}$ almost everywhere. | ✅ `∃ v w : … → ℝ, ∃ c : ℝ, … ∧ ∀ᵐ t, u (unitCirclePoint t) = Complex.exp (Complex.I * (c + v (unitCirclePoint t) + circleHilbertTransform w t))`. |
| 7 | In item (4) the bound $\pi/2$ is attached to the **un**-conjugated function. | ✅ `eLpNorm (fun t ↦ v (unitCirclePoint t)) ∞ … < ENNReal.ofReal (Real.pi / 2)`, while `w` (whose conjugate is used) is only required essentially bounded. |
| 8 | All four items appear in one genuine equivalence. | ✅ `List.TFAE [a, b, c, d]`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Writing $\le$ instead of $<$ in any of the four inequalities. | For a unimodular $u$ the distance to the bounded analytic functions is always at most $1$ (take $h = 0$), so item (2) with $\le$ is true for every $u$ and the equivalence collapses. The same strictness is what gives items (3) and (4) their force. |
| 2 | Requiring only $\operatorname{dist}(u, H^\infty) < 1$ and not the same for $\bar u$. | That single condition corresponds to one-sided invertibility, which is strictly weaker than invertibility. |
| 3 | Dropping the outerness of $h$ in item (3). | With an arbitrary bounded analytic $h$ the condition is weaker and no longer equivalent to invertibility. |
| 4 | Defining the harmonic conjugate $\tilde b$ as a `tsum` over $k \in \mathbb{Z}$. | Infinite sums of complex numbers in Lean require absolute convergence, so the value is the junk $0$ unless $\hat b$ is absolutely summable, and when it is, the sum is a *continuous* function. Item (4) would then force $\arg u$ to stay within $\pi/2$ of a continuous function. Counterexample: take $b$ the sign function on $(-\pi,\pi)$ and $u = e^{i\tilde b}$. Items (1)–(3) hold by the true theorem, but $u$ winds infinitely often near $\zeta = 1$, so the `tsum` version of item (4) fails and the equivalence is false. |
| 5 | Taking the distance to the bounded analytic functions as an infimum over reals. | The infimum of an empty set of reals is $0$ in Lean, which would make "distance $< 1$" true for free. In $[0,\infty]$ the empty infimum is $\infty$, which is the right degenerate value. |
| 6 | Assuming $\lVert u(\zeta)\rVert = 1$ at every point. | An $L^\infty$ function is only determined almost everywhere; the everywhere version excludes legitimate representatives. |
| 7 | Attaching the $\pi/2$ bound to $\tilde b$ rather than to $a$. | The harmonic conjugate of a bounded function is typically unbounded, so bounding it changes the theorem entirely. |
| 8 | Formalizing only the pair (1) $\Leftrightarrow$ (2). | Two of the four items would be missing, and they are the constructive ones that make the criterion usable. |

## Notes on the ground truth

- `circleHilbertTransform w t` is the limit of the symmetric partial sums
  $\sum_{\lvert k\rvert \le N}(-i\,\mathrm{sgn}\,k)\hat w(k)e^{ikt}$. For $w \in L^\infty$, hence in
  $L^2$, these converge almost everywhere, so the definition gives the honest conjugate function
  off a null set. An earlier version of this file used a `tsum`, which made the equivalence false;
  Mistake 4 records that defect.
- `symbolDistanceToHInfinity` is an infimum in $[0,\infty]$ over a set that always contains
  $\infty$, and $h = 0$ contributes $\lVert u\rVert_\infty$, so the set is never empty. The junk
  value of `boundaryValue h` on a null set is invisible to an essential supremum.
- Existence of the representing operator is bundled into the same existential as invertibility, so
  item (1) also silently asserts that $T_u$ is bounded. That is true for $u \in L^\infty$, so it is
  harmless. The infinite sum inside `RepresentsToeplitzOperator` converges absolutely, since
  $\hat u$ and $f$ are both square summable.
- Invertibility is rendered as bijectivity of a continuous linear map; the inverse is then
  automatically bounded by the open mapping theorem.
- `OuterFunction` is encoded by the exponential Poisson representation rather than by the book's
  definition 3.9.7 ("$f$ equals its own outer part up to a unimodular constant"). The two agree for
  functions in a Hardy class, but it is a substitution worth flagging.
- The four items are named `a`, `b`, `c`, `d`, and inside item `d` the binder `∃ c : ℝ` shadows the
  proposition named `c`. Legal but confusing; renaming would remove the ambiguity. Item `d` also
  names its bounded functions `v` and `w` where the text uses $a$ and $b$.
- `hu` is implied by `hmod` except for its measurability half; keeping both is harmless.
- The functions `v` and `w` in item (4) carry no measurability hypothesis. `eLpNorm … ∞` still
  makes sense without it, but `AEStronglyMeasurable` would match the intent of "real valued bounded
  functions on $\mathbb{T}$".

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[nikolski_B_4_3_3_devinatz_widom.md](nikolski_B_4_3_3_devinatz_widom.md) and the background in [nikolski_B_4_3_3_devinatz_widom.context.md](nikolski_B_4_3_3_devinatz_widom.context.md),
not against the ground-truth Lean file: a candidate spelled differently but
mathematically equivalent to the text loses nothing. The scale is defined in
[GRADING.md](../../GRADING.md); the numbers below are this problem's instance of it.

| Band | Points | This problem |
|---|---|---|
| A. Completeness | 50 | The requirement table above has 8 rows, so each row is worth 6.2 points: full credit if the candidate states it in any equivalent form, half for a harmless strengthening or weakening, none if it is absent. |
| B. Semantic fidelity | 20 | Junk values, `ℝ` vs `ℝ≥0∞`, coercions, quantifier order, a.e. vs everywhere — see the pitfalls below. |
| C. Mathlib-concept correctness | 15 | The Mathlib notion must mean the textbook notion, with the typeclass assumptions it needs. |
| D. Non-degeneracy | 10 | Not vacuous, not trivial, not a strictly weaker theorem. |
| E. Hygiene | 5 | No needless definitions, redundant conjuncts or unused hypotheses. |

**Every row of the *Mistakes to check for* table above is a defect.** Charge each one to the band it belongs to and deduct there.

### Fatal — any of these caps the total at 25

- Requirement 4 with only one of the two distance conditions in item (2).
- Requirement 7 with the $\pi/2$ bound attached to $b$ or to $\tilde b$ instead of to $a$.
- Requirement 5 with $h$ not required outer.

### Domain-specific pitfalls for this problem

- $\tilde b$ is the harmonic conjugate of $b$; the norm bound applies to the un-conjugated function $a$.
- Toeplitz matrices depend on $i-j$; Hankel on $i+j$.
- The unimodularity of $u$ is almost everywhere.
- Every distance and norm inequality is strict.
- Junk value — infimum: the distances are infima over function spaces and belong in $[0,\infty]$.
