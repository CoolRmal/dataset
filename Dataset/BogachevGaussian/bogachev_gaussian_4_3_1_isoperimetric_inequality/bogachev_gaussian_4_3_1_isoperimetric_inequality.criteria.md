# Criteria: bogachev_gaussian_4_3_1_isoperimetric_inequality

**Statement:** [bogachev_gaussian_4_3_1_isoperimetric_inequality.md](bogachev_gaussian_4_3_1_isoperimetric_inequality.md) · **Lean:** [bogachev_gaussian_4_3_1_isoperimetric_inequality.lean](bogachev_gaussian_4_3_1_isoperimetric_inequality.lean) · **Context:** [bogachev_gaussian_4_3_1_isoperimetric_inequality.context.md](bogachev_gaussian_4_3_1_isoperimetric_inequality.context.md)

## What the theorem says

Write $\gamma_n$ for the standard Gaussian measure on $\mathbb{R}^n$ and $\Phi^{-1}$ for the inverse
of the standard normal distribution function, with $\Phi^{-1}(0) = -\infty$ and
$\Phi^{-1}(1) = +\infty$. Fatten an arbitrary measurable set $A$ by the closed ball of radius $r$.
The theorem says the quantile goes up by at least $r$:
$\Phi^{-1}(\gamma_n(A+rU)) \ge \Phi^{-1}(\gamma_n(A)) + r$. The gain is exactly $r$, with no
constant in front, and half-spaces are the sets for which equality holds — that sharpness is the
content.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The measure is the standard Gaussian on $\mathbb{R}^n$ with the Euclidean structure. | ✅ `stdGaussian (EuclideanSpace ℝ (Fin n))`. |
| 2 | $\Phi^{-1}$ is valued in $[-\infty,+\infty]$, with $-\infty$ at $0$ and $+\infty$ at $1$. | ✅ `quantile (gaussianReal 0 1) : ℝ → EReal`. |
| 3 | $A$ is an arbitrary measurable set — no convexity, no closedness, no symmetry. | ✅ `hA : MeasurableSet A` is the only condition on `A`. |
| 4 | The enlargement is the Minkowski sum of $A$ with the *closed* ball of radius $r$ centered at the origin, in the Euclidean metric. | ✅ `A + Metric.closedBall (0 : EuclideanSpace ℝ (Fin n)) r`, with `+` the pointwise set sum. This is Bogachev's literal $A + rU$. |
| 5 | The radius $r$ is non-negative. | ✅ `hr : 0 ≤ r`. The printed hypothesis is $r > 0$; the inequality also holds at $r = 0$, so stating it for $r \ge 0$ is the slightly stronger and cleaner form, and a candidate writing `0 < r` is equally acceptable. |
| 6 | The gain is exactly $+r$, with no unspecified constant. | ✅ `+ (r : EReal)`, the literal $r$ coerced into `EReal`. |
| 7 | The inequality is between the quantile of $A$ plus $r$ and the quantile of the enlargement. | ✅ `Φinv (γ A).toReal + (r : EReal) ≤ Φinv (γ (A + closedBall 0 r)).toReal`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Using a real-valued quantile, or applying `.toReal` to an extended-real quantile. | When $\gamma_n(A) = 0$ the correct value is $-\infty$ and the inequality is true for free. A real-valued quantile would return a finite junk number there and turn the statement into a false finite claim. |
| 2 | Working on `Fin n → ℝ` instead of `EuclideanSpace ℝ (Fin n)`. | On `Fin n → ℝ` the norm is the sup norm, so `closedBall 0 r` is a cube of side $2r$. Enlarging by a cube is a different — and, at this constant, false — statement. The ball must be the Euclidean one. |
| 3 | Replacing the gain by `∃ c > 0, … + c * r ≤ …`. | Much weaker. The sharp constant $1$ is the whole point; with an unspecified constant the statement follows from soft concentration arguments. |
| 4 | Adding convexity or closedness of $A$. | Yields a corollary, not the theorem. Applying to arbitrary measurable sets is exactly what distinguishes this result from Ehrhard's inequality. |
| 5 | Using the open ball of radius $r$. | The book's $U$ is the closed unit ball. The two enlargements differ, and the closed one is the printed statement. |
| 6 | Flipping the inequality, or putting the $+r$ on the enlarged side. | Both give statements that are false: enlarging cannot decrease the measure, so the quantile of $A+rU$ is the larger quantity. |
| 7 | Requiring the conclusion only for large $r$, or for $r$ in a bounded range. | The claim is for every $r > 0$. |

## Notes on the ground truth

- The Lean writes the literal Minkowski sum `A + Metric.closedBall 0 r`, which is $\{z : \exists x \in A,\ \lVert z - x\rVert \le r\}$. For a non-closed $A$ the distance-based set $\{z : \operatorname{dist}(z,A) \le r\}$ can be slightly larger, because the infimum defining the distance need not be attained. The Minkowski sum is the smaller set, so our statement is the stronger of the two, and it is also the literal reading of Bogachev's $A + rU$. **Repair:** the `.md` notation block used to gloss $A + rU$ as the distance-based set; it now states the Minkowski sum, so the `.md` and the Lean agree.
- `A + closedBall 0 r` is deliberately given no measurability hypothesis, matching the printed theorem, which assumes measurability of $A$ only. Mathlib measures are defined on every set (they extend to outer measures), so the expression is meaningful; where the sum happens to be non-Borel, the outer measure value is used, which only makes the asserted inequality stronger. For Borel $A$ the sum is in any case a continuous image of $A \times rU$, hence Souslin and so measurable for the completed measure — this is exactly the point Bogachev isolates in Lemma 4.3.2 for the infinite dimensional version.
- `(stdGaussian _ A).toReal` is safe: `stdGaussian` is a probability measure, so the value is in $[0,1]$ and the `∞ ↦ 0` truncation of `toReal` never fires.
- The inequality also holds trivially at $r = 0$. The Lean states it for `hr : 0 ≤ r`, a harmless strengthening of the printed hypothesis $r > 0$; a candidate writing `0 < r` matches the print exactly and is equally acceptable (requirement row 5).
- `quantile` is shared with the Ehrhard problem via `Defs.lean`.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[bogachev_gaussian_4_3_1_isoperimetric_inequality.md](bogachev_gaussian_4_3_1_isoperimetric_inequality.md) and the background in [bogachev_gaussian_4_3_1_isoperimetric_inequality.context.md](bogachev_gaussian_4_3_1_isoperimetric_inequality.context.md),
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

- Requirement 2 with a real-valued quantile: the extreme values are exactly the interesting cases.
- Requirement 3 strengthened by convexity or closedness of $A$: that is a different (and easier) theorem.
- Requirement 6 with the gain weakened to an unspecified constant or to a dimension-dependent one.

### Domain-specific pitfalls for this problem

- Junk value — quantile: $\Phi^{-1}$ must take values in `EReal`; a real-valued version defaults at $0$ and $1$.
- The enlargement is the Minkowski sum with the *closed* ball, which for a non-closed $A$ is strictly smaller than $\{z : \operatorname{dist}(z,A) \le r\}$. The Minkowski form is the printed statement and the stronger claim.
- The ball is the Euclidean one, so the ambient space must carry the inner-product norm.
- `Measure.toReal` on `γ A` is harmless because $\gamma_n$ is a probability measure, but it would be a junk conversion for a measure that could be infinite.
- The text prints $r > 0$; the ground truth assumes only $0 \le r$, under which the inequality still holds ($r = 0$ is trivial). Either form is acceptable: `0 ≤ r` is a harmless strengthening of the theorem, and `0 < r` is the literal print.
