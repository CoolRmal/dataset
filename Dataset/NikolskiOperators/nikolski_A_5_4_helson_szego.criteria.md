# Criteria: nikolski_A_5_4_helson_szego

**Statement:** [nikolski_A_5_4_helson_szego.md](nikolski_A_5_4_helson_szego.md) · **Lean:** [nikolski_A_5_4_helson_szego.lean](nikolski_A_5_4_helson_szego.lean) · **Context:** [nikolski_A_5_4_helson_szego.context.md](nikolski_A_5_4_helson_szego.context.md)

## What the theorem says

Fix a weight $w$ on the unit circle and look at the space of functions that are square integrable
against $w$. Five conditions on $w$ are equivalent: the exponentials $(z^n)_{n\in\mathbb{Z}}$ form a
basis of that space; the Riesz projection onto the nonnegative frequencies is bounded there; the
analytic and the strictly coanalytic polynomials make a positive angle with one another; $w$ is the
squared modulus of the boundary values of an outer function $h$ with $\operatorname{dist}(\bar h/h,
H^\infty) < 1$; and $w = e^{u + \tilde v}$ with $u, v$ real and bounded and
$\lVert v\rVert_\infty < \pi/2$. Here $\tilde v$ is the harmonic conjugate of $v$. The last
condition is the Helson–Szegő condition (HS).

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The weight is measurable, positive almost everywhere, and integrable, so that the weighted space is a genuine finite-measure $L^2$. | ✅ `hwmeas`, `hwpos`, `hwint`. |
| 2 | Item (1), first half: two-sided bounds $A\sum\lvert c_k\rvert^2 \le \lVert\sum c_k z^k\rVert^2 \le B\sum\lvert c_k\rvert^2$ with $0 < A \le B$, for all finitely supported coefficient sequences. | ✅ Inside `basis`: `∃ A B, 0 < A ∧ A ≤ B ∧ ∀ c, c.support.Finite → …`. |
| 3 | Item (1), second half: the system is complete — a weighted-$L^2$ function orthogonal to every $z^k$ is zero. | ✅ `complete`, conjoined into `basis`. |
| 4 | Item (2): the projection onto the nonnegative frequencies, **including** $k = 0$, is bounded. | ✅ `boundedProjection` with `analyticFourierPart c k = if 0 ≤ k then c k else 0`. |
| 5 | Item (3): there is $\delta > 0$ with $\delta\lVert p\rVert^2 \le \lVert p + q\rVert^2$ for all analytic $p$ (frequencies $\ge 0$) and coanalytic $q$ (frequencies $< 0$). | ✅ `positiveAngle`, with the support conditions `∀ k, plus k ≠ 0 → 0 ≤ k` and `∀ k, minus k ≠ 0 → k < 0`. |
| 6 | Item (4): $w$ is the squared modulus of the boundary values of an outer $h \in H^2$, and there is a bounded analytic $q$ with $\lVert \bar h/h - q\rVert_\infty$ **strictly** below $1$. | ✅ `outerDistance`: `OuterFunction 2 h`, `HardyClass ⊤ q`, the a.e. identity for `w`, and `eLpNorm … ∞ … < 1`. |
| 7 | Item (5): $w = \exp(u + \tilde v)$ almost everywhere, with $u$ essentially bounded and $\lVert v\rVert_\infty$ **strictly** below $\pi/2$. | ✅ `helsonSzego`, with `circleHilbertTransform v t` playing the role of $\tilde v$. |
| 8 | All five items appear in one genuine equivalence. | ✅ `List.TFAE [basis, boundedProjection, positiveAngle, outerDistance, helsonSzego]`, in the printed order. |
| 9 | The coefficient sequences appearing in items (1)–(3) are finitely supported, so the trigonometric sums are ordinary finite sums. | ✅ `c.support.Finite` guards every use of `weightedL2NormSq`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Defining the harmonic conjugate $\tilde v$ as a `tsum` over $k \in \mathbb{Z}$. | An infinite sum of complex numbers in Lean requires absolute convergence, so the value is the junk $0$ unless the Fourier coefficients of $v$ are absolutely summable — and when they are, the sum is a *continuous* function. Item (5) would then force $w$ to be bounded above and below. Counterexample: $w(\zeta) = \lvert 1 - \zeta\rvert^{1/2}$ satisfies items (1)–(4), but it vanishes at $\zeta = 1$, so no such representation exists and the equivalence fails. |
| 2 | Stating the frame bounds of item (1) without the completeness clause. | That gives a Riesz *sequence*, not a basis. Deleting one exponential leaves the two-sided bounds intact, so completeness carries real content. |
| 3 | Excluding $k = 0$ from the analytic part, or letting the analytic and coanalytic frequency ranges overlap. | A different projection and a different pair of subspaces; the angle condition then no longer matches the Riesz projection. |
| 4 | Writing $\operatorname{dist}(\bar h/h, H^\infty) \le 1$ in item (4). | Since $\lvert \bar h/h\rvert = 1$ almost everywhere, that distance is always at most $1$. The non-strict version is true for every weight and destroys the equivalence. |
| 5 | Writing $\lVert v\rVert_\infty \le \pi/2$ in item (5). | Strictness is exactly what makes (HS) equivalent to the other four items; at $\pi/2$ the condition is satisfied by weights for which the Riesz projection is unbounded. |
| 6 | Dropping the finite-support restriction on the coefficient sequences. | `trigonometricPolynomial` is a `tsum` (junk value $0$ for non-summable coefficients) and `weightedL2NormSq` is a Bochner integral (junk value $0$ when the integrand is not integrable). The frame bounds could then be met by junk values rather than by real norms. |
| 7 | Formalizing only the famous pair (2) $\Leftrightarrow$ (5). | Each of the five items is part of the theorem; three of them would be missing. |
| 8 | Attaching the $\pi/2$ bound to $\tilde v$ rather than to $v$. | The conjugate of a bounded function is typically unbounded, so bounding $\tilde v$ changes the class of weights entirely. |

## Notes on the ground truth

- The book starts from an arbitrary finite Borel measure $\mu$ on $\mathbb{T}$, and the implications
  from items (1)–(3) to (4)/(5) *include* the assertion that $\mu$ has no singular part. The ground
  truth instead assumes from the outset that the measure is $w\,dm$ with $w$ positive almost
  everywhere and integrable, so that content is lost. A faithful version would quantify over a
  finite measure and put "$d\mu = w\,dm$" inside items (4) and (5).
- `circleHilbertTransform v t` is the limit of the symmetric partial sums
  $\sum_{\lvert k\rvert \le N} (-i\,\mathrm{sgn}\,k)\,\hat v(k)e^{ikt}$. For $v \in L^\infty$, hence
  in $L^2$, these partial sums converge almost everywhere, so the definition gives the honest
  conjugate function off a null set. An earlier version of this file used a `tsum` instead, which
  made the whole equivalence false; Mistake 1 records that defect.
- Item (4) divides by `boundaryValue h`, which may vanish on a null set. Division by zero is $0$ in
  Lean, and this sits inside an essential supremum, so it cannot affect the value; still, an
  explicit remark that $h$ is nonzero almost everywhere would be clearer.
- "Symmetric or non-symmetric basis" in the text means a Schauder basis for some ordering of
  $\mathbb{Z}$. The ground truth renders it as the Riesz-basis condition. The two coincide for this
  system, but they are not literally the same words.
- Item (1) is phrased over functions `ℝ → ℂ` while items (2) and (3) are phrased over coefficient
  sequences `ℤ → ℂ`. Both models are isometric here, but mixing them inside one `TFAE` costs
  readability.
- The circle is modelled by `Ioc 0 (2π)` with unnormalized `volume` rather than by mathlib's
  `Circle` with normalized Haar measure; the $2\pi$ cancels in every scale-invariant clause.
- `u` and `v` in item (5) carry no measurability hypothesis. `eLpNorm … ∞` is still meaningful for
  a non-measurable function, so nothing breaks, but adding `AEStronglyMeasurable` would match the
  intent of "$u, v$ are bounded real functions on $\mathbb{T}$".

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[nikolski_A_5_4_helson_szego.md](nikolski_A_5_4_helson_szego.md) and the background in [nikolski_A_5_4_helson_szego.context.md](nikolski_A_5_4_helson_szego.context.md),
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

- Requirement 3 with the completeness half of item (1) dropped.
- Requirement 7 with the bound $\pi/2$ attached to the wrong function, or with $\tilde v$ read as a complex conjugate.
- Requirement 8 with the five items given as implications rather than one equivalence.

### Domain-specific pitfalls for this problem

- $\tilde v$ is the harmonic conjugate (Hilbert transform), not complex conjugation; $\bar h$ in item (4) *is* complex conjugation. Both symbols occur in the same theorem.
- The Riesz projection includes the zero frequency.
- All the inequalities involving $\operatorname{dist}$ and $\|v\|_\infty$ are strict.
- Item (1)'s coefficient sequences are finitely supported, so the sums are finite and no convergence question arises.
- $h$ in item (4) must be **outer**, not merely in $H^2$.
