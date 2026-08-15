# Criteria: bogachev_gaussian_4_6_1_correlation_convex_strip

**Statement:** [bogachev_gaussian_4_6_1_correlation_convex_strip.md](bogachev_gaussian_4_6_1_correlation_convex_strip.md) · **Lean:** [bogachev_gaussian_4_6_1_correlation_convex_strip.lean](bogachev_gaussian_4_6_1_correlation_convex_strip.lean) · **Context:** [bogachev_gaussian_4_6_1_correlation_convex_strip.context.md](bogachev_gaussian_4_6_1_correlation_convex_strip.context.md)

## What the theorem says

Let $\gamma$ be a centered Gaussian measure on $\mathbb{R}^n$. Let $A$ be an absolutely convex set —
convex and balanced — and let $\Pi$ be a symmetric strip, meaning a set of the form
$\{x : \lvert f(x)\rvert \le c\}$ for a linear function $f$ and a real number $c$. The theorem says
the two events are positively correlated: $\gamma(A \cap \Pi) \ge \gamma(A)\gamma(\Pi)$. Knowing
that $x$ lies in the strip only makes it more likely that $x$ lies in $A$. This is the
Khatri–Šidák case of the Gaussian correlation problem, in which one of the two sets is a strip.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The setting is $\mathbb{R}^n$ with a Gaussian measure. | ✅ `(γ : Measure (EuclideanSpace ℝ (Fin n))) [IsGaussian γ]`. |
| 2 | $\gamma$ is centered. | ✅ `hcentered : ∫ x, x ∂γ = 0`. |
| 3 | $A$ is measurable. | ✅ `hA : MeasurableSet A`. |
| 4 | $A$ is convex. | ✅ `hconv : Convex ℝ A`. |
| 5 | $A$ is balanced, i.e. $\alpha A \subseteq A$ for $\lvert\alpha\rvert \le 1$. | ✅ `hbal : Balanced ℝ A`. |
| 6 | The second set is a symmetric strip cut out by a **linear** functional: $\{x : \lvert f(x)\rvert \le c\}$. | ⚠️ `f : EuclideanSpace ℝ (Fin n) →ₗ[ℝ] ℝ` and the set `{x \| \|f x\| ≤ c}`. Plain linearity is adequate because continuity is automatic in finite dimensions; a continuous linear map `→L[ℝ]` would be the more transferable choice. |
| 7 | $c$ is an arbitrary real number, with no positivity assumed. | ✅ `(c : ℝ)` unconstrained; for $c < 0$ the strip is empty and the inequality is trivially true, matching the text. |
| 8 | The conclusion is the product inequality $\gamma(A)\gamma(\Pi) \le \gamma(A \cap \Pi)$, with the intersection on the larger side. | ✅ `γ A * γ {x \| \|f x\| ≤ c} ≤ γ (A ∩ {x \| \|f x\| ≤ c})`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Replacing the strip by a second absolutely convex set. | That is the Gaussian correlation conjecture, which Bogachev explicitly records as open at the time of writing. A candidate stating it is formalizing a conjecture, not Theorem 4.6.1. This is the highest-value trap here. |
| 2 | Dropping the balancedness of $A$. | False for a translated convex set: shift a small ball far along the direction of $f$ and it becomes almost disjoint from the strip, so the intersection has much less measure than the product. |
| 3 | Dropping convexity of $A$. | False. A symmetric non-convex set can be arranged to avoid the strip, so the intersection loses measure relative to the product. |
| 4 | Omitting the centering hypothesis. | False for a shifted Gaussian: put most of the mass outside the strip and inside $A$, and the correlation can go the other way. |
| 5 | Cutting the strip with an affine function $f(x) + b$, or with a one-sided condition $f(x) \le c$. | Both give a set that is not symmetric about the origin. Symmetry of the strip is what makes the Khatri–Šidák proof work; the one-sided half-space version is false. |
| 6 | Flipping the inequality, or stating equality. | Independence is a strictly special case. The theorem's content is the inequality in the direction $\gamma(A)\gamma(\Pi) \le \gamma(A \cap \Pi)$. |
| 7 | Adding $c > 0$ as a hypothesis. | Not printed. The statement covers $c < 0$, where the strip is empty and both sides are $0$. |

## Notes on the ground truth

- `Balanced ℝ A` together with `Convex ℝ A` is Mathlib's rendering of "absolutely convex".
- $f$ is a plain linear map `→ₗ[ℝ]` rather than a continuous linear map. In finite dimensions every linear map is continuous, so this is adequate and matches Bogachev's "linear function". On an infinite-dimensional space one would need `→L[ℝ]`.
- The centering hypothesis is a Bochner integral, `∫ x, x ∂γ = 0`. Lean disables the Bochner integral on incomplete spaces (returning $0$), which would make such a hypothesis hold for free; here the space is `EuclideanSpace ℝ (Fin n)`, which is complete, so the condition is genuine.
- All four quantities are values of a probability measure and so lie in $[0,1]$. `ℝ≥0∞` multiplication has the special rule $0 \cdot \infty = 0$, but no infinite value can arise here, so nothing is truncated.
- The inequality is written with the smaller side on the left, reversing the book's `≥` orientation without changing the content.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[bogachev_gaussian_4_6_1_correlation_convex_strip.md](bogachev_gaussian_4_6_1_correlation_convex_strip.md) and the background in [bogachev_gaussian_4_6_1_correlation_convex_strip.context.md](bogachev_gaussian_4_6_1_correlation_convex_strip.context.md),
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

- Replacing the strip by a second arbitrary absolutely convex set: that is the full Gaussian correlation conjecture, not this theorem.
- Dropping convexity or balancedness of $A$: the inequality fails.
- Dropping centredness of $\gamma$.
- Reversing the inequality.

### Domain-specific pitfalls for this problem

- "Absolutely convex" is `Convex ℝ A` *and* `Balanced ℝ A`; neither alone suffices.
- The strip is defined by a *linear functional*, symmetric about the origin: $\{x : |f(x)| \le c\}$, not a half-space $\{f(x) \le c\}$ and not a ball.
- $c$ is an arbitrary real; negative $c$ gives the empty strip and the inequality still has to hold, so no positivity may be assumed.
- Centredness is the vanishing of the mean vector, a genuine hypothesis; the Bochner integral expressing it is not a junk value because a Gaussian measure has all moments.
- The inequality is between measures in `ℝ≥0∞`; multiplication there is fine, but a version passing through `toReal` would need the measures to be finite, which they are only because $\gamma$ is a probability measure.
