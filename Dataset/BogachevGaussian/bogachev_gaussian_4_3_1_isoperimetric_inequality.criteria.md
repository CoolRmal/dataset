# Criteria: bogachev_gaussian_4_3_1_isoperimetric_inequality

**Statement:** [bogachev_gaussian_4_3_1_isoperimetric_inequality.md](bogachev_gaussian_4_3_1_isoperimetric_inequality.md) · **Lean:** [bogachev_gaussian_4_3_1_isoperimetric_inequality.lean](bogachev_gaussian_4_3_1_isoperimetric_inequality.lean)

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
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The measure is the standard Gaussian on $\mathbb{R}^n$ with the Euclidean structure. | ✅ `stdGaussian (EuclideanSpace ℝ (Fin n))`. |
| 2 | $\Phi^{-1}$ is valued in $[-\infty,+\infty]$, with $-\infty$ at $0$ and $+\infty$ at $1$. | ✅ `quantile (gaussianReal 0 1) : ℝ → EReal`. |
| 3 | $A$ is an arbitrary measurable set — no convexity, no closedness, no symmetry. | ✅ `hA : MeasurableSet A` is the only condition on `A`. |
| 4 | The enlargement is by the *closed* ball of radius $r$ centered at the origin, in the Euclidean metric. | ⚠️ `A + Metric.closedBall (0 : EuclideanSpace ℝ (Fin n)) r`, with `+` the pointwise set sum. This is Bogachev's literal $A + rU$, but for a non-closed $A$ it is slightly smaller than the set $\{z : \operatorname{dist}(z,A) \le r\}$ named in the `.md`, so our version is the stronger claim. |
| 5 | The radius $r$ is positive. | ⚠️ `hr : 0 < r`, as printed. The inequality also holds trivially at $r = 0$, so this hypothesis could be weakened to `0 ≤ r`. |
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

- The `.md` describes $A + rU$ as $\{z : \operatorname{dist}(z,A) \le r\}$. In Lean we wrote the literal Minkowski sum `A + Metric.closedBall 0 r`, which is $\{z : \exists x \in A,\ \lVert z - x\rVert \le r\}$. For a non-closed $A$ the distance-based set can be slightly larger, because the infimum defining the distance need not be attained. The Minkowski sum is the smaller set, so our statement is the stronger of the two, and it is also the literal reading of Bogachev's $A + rU$.
- `A + closedBall 0 r` is not given a measurability hypothesis. Mathlib measures are defined on every set (they extend to outer measures), so the expression is meaningful; where the sum happens to be non-measurable, the outer measure value is used, which only makes the asserted inequality stronger.
- `(stdGaussian _ A).toReal` is safe: `stdGaussian` is a probability measure, so the value is in $[0,1]$ and the `∞ ↦ 0` truncation of `toReal` never fires.
- The inequality also holds trivially at $r = 0$. We require `0 < r` because that is what the text prints.
- `quantile` is shared with the Ehrhard problem via `Defs.lean`.
