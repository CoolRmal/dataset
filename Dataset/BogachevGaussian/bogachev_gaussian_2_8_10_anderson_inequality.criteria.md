# Criteria: bogachev_gaussian_2_8_10_anderson_inequality

**Statement:** [bogachev_gaussian_2_8_10_anderson_inequality.md](bogachev_gaussian_2_8_10_anderson_inequality.md) · **Lean:** [bogachev_gaussian_2_8_10_anderson_inequality.lean](bogachev_gaussian_2_8_10_anderson_inequality.lean)

## What the theorem says

Let $\gamma$ be a centered Gaussian measure and let $A$ be a set that is both convex and balanced
("absolutely convex": if $x \in A$ and $\lvert\alpha\rvert \le 1$ then $\alpha x \in A$). Anderson's
inequality says that sliding $A$ away from the origin can only lose measure:
$\gamma(A+a) \le \gamma(A)$ for every vector $a$. More than that, the loss is monotone along the
way: for every $t$ between $0$ and $1$, the fully shifted set $A+a$ has measure at most that of the
partially shifted set $A+ta$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $\gamma$ is Gaussian. | ✅ `(γ : Measure E) [IsGaussian γ]`. |
| 2 | $\gamma$ is centered — its mean vector is $0$. | ✅ `hcentered : ∫ x, x ∂γ = 0`. |
| 3 | The centering condition must be a genuine condition, not one Lean satisfies by default. | ✅ `[CompleteSpace E]` is assumed, so the Bochner integral is the real one. See the mistakes table for why this matters. |
| 4 | $A$ is measurable. | ✅ `hA : MeasurableSet A`. |
| 5 | $A$ is convex. | ✅ `hconv : Convex ℝ A`. |
| 6 | $A$ is balanced: $\alpha A \subseteq A$ whenever $\lvert\alpha\rvert \le 1$. | ✅ `hbal : Balanced ℝ A`, Mathlib's predicate. |
| 7 | $a$ is an arbitrary vector — no smallness, no membership in a Cameron–Martin space. | ✅ `(a : E)` unconstrained. |
| 8 | First conclusion: $\gamma(A+a) \le \gamma(A)$, with $A+a$ the translated set $\{x+a : x \in A\}$. | ✅ `γ ((fun x ↦ x + a) '' A) ≤ γ A`. |
| 9 | Second conclusion: $\gamma(A+a) \le \gamma(A+ta)$ for every $t \in [0,1]$. | ✅ `∀ t ∈ Icc (0 : ℝ) 1, γ ((fun x ↦ x + a) '' A) ≤ γ ((fun x ↦ x + t • a) '' A)`. |
| 10 | Both conclusions appear. | ✅ A conjunction of the two. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Assuming only that $A$ is convex. | False without balancedness. Take $A$ a half-space in $\mathbb{R}^1$, say $[0,\infty)$, and shift it towards $-\infty$: the measure goes up. |
| 2 | Assuming only that $A$ is symmetric ($-A = A$) without convexity. | False without convexity. A symmetric annulus in $\mathbb{R}^2$ can gain measure under a suitable shift, because the shift can move the hole off the origin. |
| 3 | Omitting the centering hypothesis. | False for a shifted Gaussian: take $a$ equal to minus the mean, and $A+a$ is centered on the bulk of the measure while $A$ is not. |
| 4 | Stating the centering as a Bochner integral without knowing the space is complete. | Mathlib's Bochner integral is defined as `if _ : CompleteSpace G then … else 0`. On an incomplete space `∫ x, x ∂γ = 0` holds automatically for every measure, so the hypothesis vanishes and the theorem is being asserted for arbitrary non-centered Gaussians — which is false. A shifted Gaussian on an incomplete subspace of $\ell^2$ refutes it. |
| 5 | Keeping only $\gamma(A+a) \le \gamma(A)$. | The monotone version is strictly stronger and is what applications use. Both are printed. |
| 6 | Stating the monotone conclusion as $\gamma(A+ta) \le \gamma(A+sa)$ for $s \le t$, or as $\gamma(A+ta) \le \gamma(A)$. | Different claims. The printed one puts the fully shifted set $A+a$ on the small side for every intermediate $t$. |
| 7 | Restricting $t$ to $(0,1)$ or to a single value. | The range is the closed interval $[0,1]$; the endpoints are where the statement connects to the first conclusion. |

## Notes on the ground truth

- `[CompleteSpace E]` was added after review. The first version omitted it, and with it omitted the statement was false for the reason in mistake row 4.
- `Balanced ℝ A` is Mathlib's predicate, `∀ α : ℝ, ‖α‖ ≤ 1 → α • A ⊆ A`. Together with `Convex ℝ A` this is exactly Bogachev's "absolutely convex".
- Bogachev's hypotheses include that $A$ and its translates lie in the completed $\gamma$-measurable $\sigma$-algebra. We assume `MeasurableSet A`; the translates are then measurable automatically because translation is a measurable equivalence.
- Bogachev works on a locally convex space; we work on a complete normed space, which is where Mathlib's `IsGaussian` lives.
- Inequalities are written with the smaller side on the left, so `γ (A + a) ≤ γ A` rather than the book's `≥` orientation.
