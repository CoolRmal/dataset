# Criteria: hayman_3_6_corollary_derivative_zeros_in_disk

**Statement:** [hayman_3_6_corollary_derivative_zeros_in_disk.md](hayman_3_6_corollary_derivative_zeros_in_disk.md) · **Lean:** [hayman_3_6_corollary_derivative_zeros_in_disk.lean](hayman_3_6_corollary_derivative_zeros_in_disk.lean) · **Context:** [hayman_3_6_corollary_derivative_zeros_in_disk.context.md](hayman_3_6_corollary_derivative_zeros_in_disk.context.md)

## What the theorem says

This corollary to Theorem 3.6 says: once $l$ is large enough, the $l$-th derivative $f^{(l)}$ has a
zero inside *every* disk on which $f$ is meromorphic and has at least two different poles. The force
of the statement is that a single threshold on $l$ works for all disks at once — the threshold is
chosen for the given $f$, before any disk is named, not separately for each disk.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The threshold on $l$ is chosen before the disk: one threshold serves every disk at once. | ✅ `(f : ℂ → ℂ)` is a parameter and the statement is `∀ᶠ l in atTop, ∀ (z₀ : ℂ) (R : ℝ), …` — the `∀ᶠ l` precedes all disk quantifiers, so the threshold may depend on $f$ but on nothing else. |
| 2 | "For all sufficiently large $l$" is the correct reading of the threshold. | ✅ `∀ᶠ l in atTop`, i.e. the property holds for every $l$ beyond some bound. |
| 3 | The disk is arbitrary: any centre $z_0$ and any positive radius $R$. | ✅ `∀ (z₀ : ℂ) (R : ℝ), 0 < R → …`. |
| 4 | $f$ is meromorphic at every point of the disk. | ✅ `∀ z ∈ Metric.ball z₀ R, MeromorphicAt f z`. |
| 5 | $f$ has at least two *distinct* poles, and both lie inside that same disk. | ✅ `∃ p ∈ Metric.ball z₀ R, ∃ q ∈ Metric.ball z₀ R, p ≠ q ∧ meromorphicOrderAt f p < 0 ∧ meromorphicOrderAt f q < 0` — a pole is a point of negative meromorphic order, which excludes removable singularities carrying a junk value. |
| 6 | The conclusion is the existence of a zero of $f^{(l)}$ inside the disk. | ✅ `∃ z ∈ Metric.ball z₀ R, 0 < meromorphicOrderAt (iteratedDeriv l f) z` — a *genuine* zero of the meromorphic function $f^{(l)}$ (positive order), not a junk-value hit of the representative. |
| 7 | The zero is located in the disk itself, not merely somewhere in the plane. | ✅ The witness is bound by `∈ Metric.ball z₀ R`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Moving the quantifier over the disk outside the threshold, as `∀ z₀ R, …, ∀ᶠ l in atTop, …`. | This is the highest-value trap. It lets the threshold depend on the disk, which is a much weaker statement and follows immediately from Theorem 3.6. The corollary's content is the uniformity over disks. |
| 2 | Fixing a specific $l$, or asserting the conclusion for every $l$. | False for small $l$: with $f(z) = 1/(z(z-1))$ and the disk of radius $2$ about $\tfrac12$, the two poles $0$ and $1$ lie inside, but $f$ itself never vanishes anywhere, so the $l = 0$ case fails. The corollary is only about large $l$. |
| 3 | Requiring two poles counted with multiplicity, e.g. a single double pole. | Then the theorem fails: for $f(z) = 1/z^{2}$ every derivative is a nonzero constant times $z^{-(l+2)}$ and never vanishes. Distinctness of the two poles is essential. |
| 4 | Requiring the two poles only to exist somewhere in the plane rather than inside the given disk. | The conclusion is local to the disk; poles outside it give no information about $f^{(l)}$ inside. |
| 5 | Concluding that $f^{(l)}$ has a zero somewhere, without saying it is in the disk. | Far too weak — the whole point of the corollary is where the zero is. |
| 6 | Dropping the hypothesis that $f$ is meromorphic on the disk. | For an arbitrary function `f : ℂ → ℂ` the iterated derivative is a default value and the statement means nothing. |
| 7 | Writing the conclusion as the literal `iteratedDeriv l f z = 0`. | Mathlib's junk convention makes `iteratedDeriv l f` vanish at every pole for $l \ge 1$, so the "zero" always exists at one of the hypothesized poles and the statement is trivially provable with threshold $l = 1$ — it carries none of Hayman's content. An earlier version of the ground truth had exactly this defect; the current one incorporates the repair by demanding positive meromorphic order. |
| 8 | Encoding a pole as `¬ AnalyticAt ℂ f p` (meromorphic but not analytic). | That admits a removable singularity whose representative carries a junk value: such a point is not a pole, and with the zero stated honestly the statement becomes false — re-value $e^{z}$ at two points and no derivative ever has a genuine zero. Negative `meromorphicOrderAt` is the faithful encoding. |
| 9 | Quantifying $f$ inside the threshold, as `∀ᶠ l in atTop, ∀ f, …`. | That claims one absolute $l$ serving every meromorphic function at once — a uniformity in $f$ that the text does not assert (Hayman's "for all sufficiently large $l$" is for the function under discussion) and that the honest, order-based statement does not support. |

## Notes on the ground truth

- Both the pole hypothesis and the zero conclusion are order-based, and both directions matter.
  Poles are points of negative `meromorphicOrderAt`, which excludes removable singularities whose
  representative carries a junk value. The zero is a point of positive `meromorphicOrderAt` of
  $f^{(l)}$: the literal `iteratedDeriv l f z = 0` is satisfied at every pole by Lean's junk
  convention, which made an earlier version of this statement trivially provable with threshold
  $l = 1$; the order-based conclusion restores Hayman's content.
- The function is fixed before the threshold: `f` is a parameter and `∀ᶠ l` governs only the disk
  quantifiers. Hayman's "for all sufficiently large $l$" allows the threshold to depend on $f$; what
  the corollary adds over Theorem 3.6 is that one threshold serves *every* disk in which $f$ has two
  distinct poles.
- This is a separate assertion from Theorem 3.6, not a restatement: Theorem 3.6 describes behaviour
  arbitrarily close to the centre $z_0$, whereas the corollary covers the whole disk and, crucially,
  makes the threshold on $l$ uniform over disks. Keeping it as its own declaration is deliberate.
- No integrals, suprema or coercions appear, so there is no default-value hazard beyond the
  representative convention handled by the order-based encoding above.

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

- Requirement 1 with the threshold on $l$ chosen after the disc.
- Requirement 5 with only one pole required, or with the poles not required distinct.
- Requirement 7 with the zero located anywhere in the plane rather than in the disc.

### Domain-specific pitfalls for this problem

- The quantifier order — $f$ first, then $\forall^\infty l$, then $\forall \text{disc}$ — is the whole content; a threshold chosen per disc is much weaker, and one chosen before $f$ overshoots the text.
- A pole is a point where the meromorphic function genuinely blows up (negative order); "meromorphic but not analytic" also admits a removable singularity carrying a junk value, and "$f$ is undefined there" is not expressible for a total function.
- A zero of $f^{(l)}$ is a point of positive order of the meromorphic function; the representative's literal value $0$ is automatic at poles and proves nothing.
- The two poles must be distinct points of the *same* disc.
- "Sufficiently large $l$" is an eventually-in-$l$ statement.
