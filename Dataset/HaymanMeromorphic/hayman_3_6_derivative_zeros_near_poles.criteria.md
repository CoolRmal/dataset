# Criteria: hayman_3_6_derivative_zeros_near_poles

**Statement:** [hayman_3_6_derivative_zeros_near_poles.md](hayman_3_6_derivative_zeros_near_poles.md) · **Lean:** [hayman_3_6_derivative_zeros_near_poles.lean](hayman_3_6_derivative_zeros_near_poles.lean)

## What the theorem says

Let $f$ be meromorphic on the disk $\lvert z - z_0\rvert < R$ and suppose it has at least two
different poles there. Grow a disk out from the centre $z_0$ until it first touches a pole, and call
its radius $r$; so no pole lies strictly inside $\lvert z - z_0\rvert < r$, and $r$ is the largest
radius with that property. The behaviour of the high derivatives $f^{(l)}$ near $z_0$ is decided by
how many poles sit on the circle $\lvert z - z_0\rvert = r$. If at least two poles sit on it, then
for every $\delta > 0$ the equation $f^{(l)}(z) = 0$ has a solution in $\lvert z - z_0\rvert < \delta$
once $l$ is large enough. If exactly one pole sits on it, then for all small enough $\delta$ the
derivatives $f^{(l)}$ tend to infinity uniformly on the closed disk $\lvert z - z_0\rvert \le \delta$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The disk has positive radius and $f$ is meromorphic at every point of it. | ✅ `hR : 0 < R` and `hf : ∀ z ∈ Metric.ball z₀ R, MeromorphicAt f z`. |
| 2 | The pole set of $f$ inside the disk is named. | ⚠️ `hP : P = {z ∈ Metric.ball z₀ R \| ¬ AnalyticAt ℂ f z}`. This is "meromorphic but not analytic", which also admits a point where $f$ merely has the wrong value. See the notes — this makes part (ii) false as stated. |
| 3 | $f$ has at least two *distinct* poles in the disk. | ✅ `htwo : ∃ p ∈ P, ∃ q ∈ P, p ≠ q`. Two distinct points, not one pole of multiplicity two. |
| 4 | $r > 0$ and no pole lies strictly inside the circle of radius $r$ about $z_0$. | ✅ `hr : 0 < r` and membership in `{t : ℝ \| 0 < t ∧ ∀ z ∈ P, ¬ ‖z - z₀‖ < t}`. |
| 5 | $r$ is the *largest* such radius — the maximality is what makes the two cases exhaustive. | ✅ `hrmax : IsGreatest {t : ℝ \| 0 < t ∧ ∀ z ∈ P, ¬ ‖z - z₀‖ < t} r`, which gives both membership and the upper-bound property. |
| 6 | Case (i) is triggered by at least two distinct poles on the circle $\lVert z - z_0\rVert = r$. | ✅ `∃ p ∈ P, ∃ q ∈ P, p ≠ q ∧ ‖p - z₀‖ = r ∧ ‖q - z₀‖ = r` as the antecedent of the first conjunct. |
| 7 | Case (i) concludes: for every $\delta > 0$, for all large $l$, some $z$ with $\lVert z - z_0\rVert < \delta$ has $f^{(l)}(z) = 0$. | ✅ `∀ δ, 0 < δ → ∀ᶠ l in atTop, ∃ z ∈ Metric.ball z₀ δ, iteratedDeriv l f z = 0`, with $\delta$ chosen before the threshold on $l$. |
| 8 | Case (ii) is triggered by *exactly one* pole on that circle. | ✅ `∃! p, p ∈ P ∧ ‖p - z₀‖ = r`, using unique existence. |
| 9 | Case (ii) concludes: for all sufficiently small $\delta > 0$, $f^{(l)} \to \infty$ **uniformly** on the closed disk of radius $\delta$. | ✅ `∀ᶠ δ in 𝓝[>] (0 : ℝ), Tendsto (fun l ↦ ⨅ z : Metric.closedBall z₀ δ, ‖iteratedDeriv l f z‖) atTop atTop`. Divergence of the infimum over the disk is exactly uniform divergence. |
| 10 | Both cases are asserted, as two separate implications. | ✅ A conjunction of the two implications. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Keeping only case (i). | Half the theorem. Case (ii) is a genuinely different conclusion — blow-up, not zeros — and is what the corollary and later results use. |
| 2 | Replacing the maximality of $r$ by "no pole is closer than $r$", i.e. only `∀ z ∈ P, r ≤ ‖z - z₀‖`. | Without maximality, $r$ could be much smaller than the true first-touch radius, no pole would lie on the circle, both antecedents would fail, and the theorem would say nothing. |
| 3 | Requiring only that $f$ has two poles counted with multiplicity, e.g. one pole of order two. | The dichotomy is about how many *distinct* points sit on the critical circle; a single double pole is case (ii), not case (i). |
| 4 | Writing case (ii) as pointwise divergence, `∀ z ∈ closedBall z₀ δ, Tendsto (fun l ↦ ‖iteratedDeriv l f z‖) atTop atTop`. | Strictly weaker than uniform divergence: the rate could degrade as $z$ moves, and Hayman explicitly says "uniformly". |
| 5 | Writing case (ii) as "for every $\delta > 0$" instead of "for all sufficiently small $\delta$". | False. Once $\delta$ is large enough to reach a pole, $f^{(l)}$ has poles inside the disk and the infimum of $\lVert f^{(l)}\rVert$ need not diverge. |
| 6 | Swapping the order in case (i) to "for all large $l$, for every $\delta > 0$, …". | Strictly stronger and not what is proved. It would say that a single large $l$ gives zeros of $f^{(l)}$ arbitrarily close to $z_0$, forcing $f^{(l)}(z_0) = 0$ by continuity. Hayman fixes $\delta$ first and lets the threshold on $l$ depend on it. |
| 7 | Using the two cases as a single disjunction of hypotheses without stating which conclusion goes with which. | The theorem pairs a specific antecedent with a specific consequent. A disjunction loses that pairing and makes the statement much weaker. |

## Notes on the ground truth

- **Part (ii) is false as formalized, because of how "pole" is encoded.** The pole set is
  `{z ∈ ball z₀ R \| ¬ AnalyticAt ℂ f z}`. A function that is meromorphic everywhere can fail to be
  analytic at a point without having a pole there: take $f = \exp$ but redefine $f(1) = f(2) = 5$.
  This $f$ is `MeromorphicAt` at every point (it agrees with an analytic function away from those two
  points), yet it is not analytic at $1$ or $2$, so $P = \{1,2\}$, `htwo` holds, and with $z_0 = 0$
  the greatest pole-free radius is $r = 1$ with exactly one $P$-point on that circle. Part (ii) then
  claims $\lVert f^{(l)}\rVert$ diverges uniformly on $\lVert z\rVert \le \delta$ for small $\delta$,
  but $f^{(l)} = \exp$ there for every $l$, so it does not. A repaired statement should identify
  poles by negative order, e.g. via `MeromorphicAt.order` being negative, rather than by failure of
  analyticity.
- The same encoding is loose in the other direction too: it does not distinguish a pole from a
  removable singularity at which `f` happens to carry a different value. For a meromorphic function
  in normal form the two agree, but Lean does not know that here.
- $r$ is passed in as a variable together with `IsGreatest`, rather than being defined as an
  infimum of distances. This is a clean way to say "radius of the largest pole-free circle" and
  avoids a default value from an empty infimum. It also forces the hypotheses to be unsatisfiable
  when $z_0$ is itself a pole, since then no positive $r$ works — which is the intended reading.
- The infimum in part (ii) is `⨅` over the subtype `Metric.closedBall z₀ δ`. In `ℝ` an infimum over
  a set with no lower bound returns a default value, but $\lVert\cdot\rVert$ is bounded below by
  $0$, so no default fires here.
- The docstring on the Lean declaration says the derivatives "have zeros arbitrarily close to that
  circle". The statement actually places the zeros arbitrarily close to the *centre* $z_0$, which is
  what Hayman writes. The docstring, not the statement, is the inaccurate one.
