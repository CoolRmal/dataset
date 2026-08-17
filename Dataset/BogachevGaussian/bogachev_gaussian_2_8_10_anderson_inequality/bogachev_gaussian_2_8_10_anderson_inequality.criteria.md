# Criteria: bogachev_gaussian_2_8_10_anderson_inequality

**Statement:** [bogachev_gaussian_2_8_10_anderson_inequality.md](bogachev_gaussian_2_8_10_anderson_inequality.md) · **Lean:** [bogachev_gaussian_2_8_10_anderson_inequality.lean](bogachev_gaussian_2_8_10_anderson_inequality.lean) · **Context:** [bogachev_gaussian_2_8_10_anderson_inequality.context.md](bogachev_gaussian_2_8_10_anderson_inequality.context.md)

## What the theorem says

Let $\gamma$ be a centered Gaussian measure and let $A$ be a set that is both convex and balanced
("absolutely convex": if $x \in A$ and $\lvert\alpha\rvert \le 1$ then $\alpha x \in A$). Anderson's
inequality says that sliding $A$ away from the origin can only lose measure:
$\gamma(A+a) \le \gamma(A)$ for every vector $a$. More than that, the loss is monotone along the
way: for every $t$ between $0$ and $1$, the fully shifted set $A+a$ has measure at most that of the
partially shifted set $A+ta$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $\gamma$ is Gaussian. | ✅ `(γ : Measure E) [IsGaussian γ]`. |
| 2 | $\gamma$ is centered — every functional has mean $0$. | ✅ `hcentered : ∀ f : StrongDual ℝ E, γ[f] = 0`, Bogachev's definition of a centred measure. |
| 3 | The centering condition must be a genuine condition, not one Lean satisfies by default. | ✅ Centring is stated functional-by-functional through real-valued integrals `γ[f]`, which are never disabled, so the hypothesis has content on any space and no `[CompleteSpace E]` is needed. See mistake row 4 for the vector-valued variant that does need completeness. |
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
| 4 | Stating the centering as a vector-valued Bochner integral `∫ x, x ∂γ = 0` without knowing the space is complete. | Mathlib's Bochner integral is defined as `if _ : CompleteSpace G then … else 0`. On a space not known to be complete `∫ x, x ∂γ = 0` holds automatically for every measure, so the hypothesis vanishes and the theorem is being asserted for arbitrary non-centered Gaussians — which is false. A shifted Gaussian on an incomplete subspace of $\ell^2$ refutes it. A candidate working on a Banach space with `[CompleteSpace E]` may use the vector-valued form; the ground truth avoids the issue by centring functional-by-functional. |
| 5 | Keeping only $\gamma(A+a) \le \gamma(A)$. | The monotone version is strictly stronger and is what applications use. Both are printed. |
| 6 | Stating the monotone conclusion as $\gamma(A+ta) \le \gamma(A+sa)$ for $s \le t$, or as $\gamma(A+ta) \le \gamma(A)$. | Different claims. The printed one puts the fully shifted set $A+a$ on the small side for every intermediate $t$. |
| 7 | Restricting $t$ to $(0,1)$ or to a single value. | The range is the closed interval $[0,1]$; the endpoints are where the statement connects to the first conclusion. |

## Notes on the ground truth

- Centredness is rendered functional-by-functional, `∀ f : StrongDual ℝ E, γ[f] = 0`, which is Bogachev's definition of a centred Gaussian measure and involves only real-valued integrals. No `[CompleteSpace E]` is assumed and none is needed; the completeness caveat of mistake row 4 applies only to candidates who state centring via the vector-valued integral `∫ x, x ∂γ`.
- `Balanced ℝ A` is Mathlib's predicate, `∀ α : ℝ, ‖α‖ ≤ 1 → α • A ⊆ A`. Together with `Convex ℝ A` this is exactly Bogachev's "absolutely convex".
- Bogachev's hypotheses include that $A$ and its translates lie in the completed $\gamma$-measurable $\sigma$-algebra. We assume `MeasurableSet A`; the translates are then measurable automatically because translation is a measurable equivalence.
- Bogachev works on a locally convex space, and so does the Lean statement: `[AddCommGroup E] [Module ℝ E] [TopologicalSpace E] [IsTopologicalAddGroup E] [ContinuousSMul ℝ E] [LocallyConvexSpace ℝ E]` with a Borel structure. A candidate restricting to a Banach space narrows the scope but not the mathematical content.
- Inequalities are written with the smaller side on the left, so `γ (A + a) ≤ γ A` rather than the book's `≥` orientation.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[bogachev_gaussian_2_8_10_anderson_inequality.md](bogachev_gaussian_2_8_10_anderson_inequality.md) and the background in [bogachev_gaussian_2_8_10_anderson_inequality.context.md](bogachev_gaussian_2_8_10_anderson_inequality.context.md),
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

- Requirement 5 or 6 dropped: convexity alone and balancedness alone each admit explicit counterexamples.
- Requirement 2 dropped: false for a Gaussian with non-zero mean.
- Requirement 3: stating centredness with a Bochner integral on a space not known to be complete, where `∫` is the junk value `0` and the hypothesis is vacuous.

### Domain-specific pitfalls for this problem

- Junk value — Bochner integral on an incomplete space: Mathlib defines `∫ x, f x ∂μ` as `if _ : CompleteSpace G then … else 0`. Stating $\int x \, d\gamma = 0$ without `[CompleteSpace E]` makes the centring hypothesis hold for free. The ground truth sidesteps this entirely by centring functional-by-functional (`γ[f] = 0` for every `f ∈ X*`), whose integrals are real-valued.
- "Absolutely convex" is two conditions, `Convex ℝ A` *and* `Balanced ℝ A`. Neither implies the other and neither alone suffices.
- $A + a$ is the image of $A$ under translation, not a Minkowski sum with a ball or a preimage.
- The second conclusion compares the *fully* shifted set $A+a$ with the partially shifted $A+ta$; comparing $A+ta$ with $A$, or two partial shifts with each other, is a different claim.
- The parameter range is the closed interval $[0,1]$; the endpoints are exactly where the second conclusion meets the first.
