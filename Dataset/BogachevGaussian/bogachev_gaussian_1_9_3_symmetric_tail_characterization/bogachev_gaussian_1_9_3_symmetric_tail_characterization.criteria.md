# Criteria: bogachev_gaussian_1_9_3_symmetric_tail_characterization

**Statement:** [bogachev_gaussian_1_9_3_symmetric_tail_characterization.md](bogachev_gaussian_1_9_3_symmetric_tail_characterization.md) · **Lean:** [bogachev_gaussian_1_9_3_symmetric_tail_characterization.lean](bogachev_gaussian_1_9_3_symmetric_tail_characterization.lean) · **Context:** [bogachev_gaussian_1_9_3_symmetric_tail_characterization.context.md](bogachev_gaussian_1_9_3_symmetric_tail_characterization.context.md)

## What the theorem says

Let $\xi$ and $\eta$ be two independent real random variables that have the same distribution, and
suppose that distribution is symmetric — unchanged when you replace $x$ by $-x$. Suppose also that
the normalized sum $(\xi+\eta)/\sqrt2$ has a tail no heavier than a single summand: for every
$t \ge 0$, the chance that $\lvert(\xi+\eta)/\sqrt2\rvert$ is at least $t$ is at most the chance
that $\lvert\xi\rvert$ is at least $t$. Then the common distribution is Gaussian. Note that
nothing is assumed about moments; that $\xi$ even has a finite variance is part of what gets
proved.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | There is one distribution $\mu$ on the real line, and it is a probability measure. | ✅ `(μ : Measure ℝ) [IsProbabilityMeasure μ]`. |
| 2 | $\mu$ is symmetric: it is unchanged by $x \mapsto -x$. | ✅ `[μ.IsNegInvariant]`, Mathlib's class saying the pushforward under negation is $\mu$ again. |
| 3 | The two variables are independent and have this same law. | ✅ Encoded by working on the product measure `μ.prod μ`; the two coordinates of a product are independent with law `μ` each. |
| 4 | The tail bound compares $\lvert(\xi+\eta)/\sqrt2\rvert$ against $\lvert\xi\rvert$, with the $\sqrt2$ present. | ✅ `(μ.prod μ) {p : ℝ × ℝ \| t ≤ \|(p.1 + p.2) / √2\|} ≤ μ {x : ℝ \| t ≤ \|x\|}`. |
| 5 | The inequality points the printed way: the normalized sum is on the smaller side. | ✅ The product-measure term is the left-hand side of `≤`. |
| 6 | The tails are the closed events $\{ \lvert\cdot\rvert \ge t\}$, not the open ones. | ✅ `t ≤ \|…\|` in both set-builders. |
| 7 | The bound is required for every $t \ge 0$. | ✅ `∀ t : ℝ, 0 ≤ t → …`. |
| 8 | The conclusion is that $\mu$ is Gaussian, degenerate cases included. | ✅ `IsGaussian μ`; Mathlib's `gaussianReal m 0 = dirac m`, so a point mass counts as Gaussian. |
| 9 | No moment hypothesis is added. | ✅ The only hypotheses are the probability, symmetry and tail assumptions. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Omitting symmetry, or replacing it by "the mean is $0$". | Symmetry is not implied by the tail bound, and mean zero is strictly weaker than symmetry. Without symmetry the conclusion fails. |
| 2 | Dropping the $\sqrt2$ and comparing $\lvert\xi+\eta\rvert$ with $\lvert\xi\rvert$. | With no normalization the hypothesis cannot be satisfied by any non-degenerate law, so the theorem becomes an empty statement about point masses. |
| 3 | Flipping the inequality, so the single summand is on the smaller side. | The reverse inequality holds for every symmetric law with finite variance and characterizes nothing. |
| 4 | Requiring the bound only for large $t$, or only for $t$ in a bounded range. | The hypothesis becomes weaker than the printed one, so the theorem being asserted is a stronger claim than Bogachev proves. |
| 5 | Assuming the two distributions are *equal* as an extra condition on top of the tail bound, e.g. postulating $(\xi+\eta)/\sqrt2$ has law $\mu$. | That equality of laws is a much stronger hypothesis (it is stability of index $2$) and makes the result nearly immediate. The point is that a one-sided tail comparison already suffices. |
| 6 | Concluding `μ = gaussianReal 0 v` with `0 < v`. | False: $\xi \equiv 0$ satisfies all the hypotheses and is the degenerate Gaussian with variance $0$. |
| 7 | Adding a finite-variance or finite-second-moment hypothesis. | Showing $\mathbb{E}\xi^2 < \infty$ is the hard half of the proof. Assuming it gives away the difficulty. |

## Notes on the ground truth

- Independence with a common law is modelled by the product measure `μ.prod μ` rather than by two variables on an abstract probability space with an `IndepFun` hypothesis. The two encodings are equivalent for a statement about distributions, and the product form removes the need for a separate probability space.
- Measures in Mathlib are defined on all sets (they extend to outer measures), so `μ {x \| t ≤ \|x\|}` needs no measurability side condition. Both tail sets are closed anyway.
- The symmetry hypothesis is supplied as the instance `[μ.IsNegInvariant]` rather than as a named equation `μ.map Neg.neg = μ`. A candidate writing the explicit equation is equally faithful.
- `√2` is `Real.sqrt 2`.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[bogachev_gaussian_1_9_3_symmetric_tail_characterization.md](bogachev_gaussian_1_9_3_symmetric_tail_characterization.md) and the background in [bogachev_gaussian_1_9_3_symmetric_tail_characterization.context.md](bogachev_gaussian_1_9_3_symmetric_tail_characterization.context.md),
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

- Requirement 2 dropped or weakened to "mean zero": symmetry is not implied by the tail bound, and the theorem fails without it.
- Requirement 4 with the $\sqrt2$ omitted: the hypothesis becomes unsatisfiable for non-degenerate laws and the statement is vacuous.
- Requirement 8 strengthened to a non-degenerate Gaussian: false, since the Dirac mass at $0$ satisfies every hypothesis.

### Domain-specific pitfalls for this problem

- The direction of the inequality is part of the hypothesis: the *normalized sum* is on the smaller side. The reverse inequality holds for every symmetric law of finite variance and characterizes nothing.
- Independence with a common law is encoded by working on the product measure; two separate measures would be a different statement.
- Degenerate Gaussians must count: in Mathlib `gaussianReal m 0 = dirac m`, so `IsGaussian` is the right predicate and `∃ v > 0, μ = gaussianReal 0 v` is not.
- Adding a finite-variance hypothesis assumes away the hard half of the proof.
