# Criteria: hayman_3_6_corollary_derivative_zeros_in_disk

**Statement:** [hayman_3_6_corollary_derivative_zeros_in_disk.md](hayman_3_6_corollary_derivative_zeros_in_disk.md) · **Lean:** [hayman_3_6_corollary_derivative_zeros_in_disk.lean](hayman_3_6_corollary_derivative_zeros_in_disk.lean) · **Context:** [hayman_3_6_corollary_derivative_zeros_in_disk.context.md](hayman_3_6_corollary_derivative_zeros_in_disk.context.md)

## What the theorem says

This corollary to Theorem 3.6 says: once $l$ is large enough, the $l$-th derivative $f^{(l)}$ has a
zero inside *every* disk on which $f$ is meromorphic and has at least two different poles. The force
of the statement is that a single threshold on $l$ works for all disks and all functions at once —
the threshold is an absolute number, not something depending on $f$ or on the disk.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The threshold on $l$ is chosen first, before the function and the disk. | ✅ `∀ᶠ l in atTop, ∀ (f : ℂ → ℂ) (z₀ : ℂ) (R : ℝ), …` — the `∀ᶠ l` is the outermost quantifier. |
| 2 | "For all sufficiently large $l$" is the correct reading of the threshold. | ✅ `∀ᶠ l in atTop`, i.e. the property holds for every $l$ beyond some bound. |
| 3 | The disk is arbitrary: any centre $z_0$ and any positive radius $R$. | ✅ `∀ (z₀ : ℂ) (R : ℝ), 0 < R → …`. |
| 4 | $f$ is meromorphic at every point of the disk. | ✅ `∀ z ∈ Metric.ball z₀ R, MeromorphicAt f z`. |
| 5 | $f$ has at least two *distinct* poles, and both lie inside that same disk. | ✅ `∃ p ∈ Metric.ball z₀ R, ∃ q ∈ Metric.ball z₀ R, p ≠ q ∧ ¬ AnalyticAt ℂ f p ∧ ¬ AnalyticAt ℂ f q`. |
| 6 | The conclusion is the existence of a zero of $f^{(l)}$ inside the disk. | ✅ `∃ z ∈ Metric.ball z₀ R, iteratedDeriv l f z = 0`. |
| 7 | The zero is located in the disk itself, not merely somewhere in the plane. | ✅ The witness is bound by `∈ Metric.ball z₀ R`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Moving the quantifier over $f$ and the disk outside, as `∀ f z₀ R, …, ∀ᶠ l in atTop, …`. | This is the highest-value trap. It lets the threshold depend on the function and the disk, which is a much weaker statement and follows immediately from Theorem 3.6. The corollary's content is the uniformity. |
| 2 | Fixing a specific $l$, or asserting the conclusion for every $l$. | False for small $l$: with $f(z) = 1/(z(z-1))$ and the disk of radius $2$ about $\tfrac12$, the two poles $0$ and $1$ lie inside, but $f$ itself never vanishes anywhere, so the $l = 0$ case fails. The corollary is only about large $l$. |
| 3 | Requiring two poles counted with multiplicity, e.g. a single double pole. | Then the theorem fails: for $f(z) = 1/z^{2}$ every derivative is a nonzero constant times $z^{-(l+2)}$ and never vanishes. Distinctness of the two poles is essential. |
| 4 | Requiring the two poles only to exist somewhere in the plane rather than inside the given disk. | The conclusion is local to the disk; poles outside it give no information about $f^{(l)}$ inside. |
| 5 | Concluding that $f^{(l)}$ has a zero somewhere, without saying it is in the disk. | Far too weak — the whole point of the corollary is where the zero is. |
| 6 | Dropping the hypothesis that $f$ is meromorphic on the disk. | For an arbitrary function `f : ℂ → ℂ` the iterated derivative is a default value and the statement means nothing. |

## Notes on the ground truth

- A "pole" is encoded as a point of the disk at which $f$ is meromorphic but not analytic. This
  admits, in principle, a point where $f$ has a removable singularity but carries a different value.
  Such a point makes $f$ discontinuous there, and Lean's `deriv` returns $0$ at a point of
  non-differentiability, so the conclusion still happens to hold. Identifying poles by negative
  `MeromorphicAt.order` would be the cleaner encoding, and is what the companion statement
  `hayman_3_6_derivative_zeros_near_poles` really needs.
- This is a separate assertion from Theorem 3.6, not a restatement: Theorem 3.6 describes behaviour
  arbitrarily close to the centre $z_0$, whereas the corollary covers the whole disk and, crucially,
  makes the threshold on $l$ uniform. Keeping it as its own declaration is deliberate.
- No integrals, suprema or coercions appear, so there is no default-value hazard beyond the pole
  convention and the `deriv` convention mentioned above.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[hayman_3_6_corollary_derivative_zeros_in_disk.md](hayman_3_6_corollary_derivative_zeros_in_disk.md) and the background in [hayman_3_6_corollary_derivative_zeros_in_disk.context.md](hayman_3_6_corollary_derivative_zeros_in_disk.context.md),
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

- Requirement 1 with the threshold on $l$ chosen after the function or the disc.
- Requirement 5 with only one pole required, or with the poles not required distinct.
- Requirement 7 with the zero located anywhere in the plane rather than in the disc.

### Domain-specific pitfalls for this problem

- The quantifier order — $\forall^\infty l\ \forall f\ \forall \text{disc}$ — is the whole content; the reversed order is much weaker.
- A pole is a point of meromorphy that is not a point of analyticity; "$f$ is undefined there" is not expressible for a total function.
- The two poles must be distinct points of the *same* disc.
- "Sufficiently large $l$" is an eventually-in-$l$ statement.
