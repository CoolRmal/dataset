# Criteria: mattila_12_14_falconer_distance_set

**Statement:** [mattila_12_14_falconer_distance_set.md](mattila_12_14_falconer_distance_set.md) · **Lean:** [mattila_12_14_falconer_distance_set.lean](mattila_12_14_falconer_distance_set.lean) · **Context:** [mattila_12_14_falconer_distance_set.context.md](mattila_12_14_falconer_distance_set.context.md)

## What the theorem says

For a Borel set $A \subset \mathbb{R}^n$, its distance set $D(A)$ is the set of all distances
$\lvert x-y\rvert$ realized by pairs of points of $A$; it is a subset of the real line. Falconer's
theorem gives two lower bounds on how large $D(A)$ is, in terms of the Hausdorff dimension of $A$. If
$\dim A$ exceeds $(n+1)/2$, then $D(A)$ has positive Lebesgue measure on the line. If $\dim A$ lies
in the intermediate range $\frac{n-1}{2} \le \dim A \le \frac{n+1}{2}$ — endpoints included — then
$D(A)$ still has dimension at least $\dim A - (n-1)/2$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The distance set is the set of *distances*, a subset of $\mathbb{R}$. | ✅ `distanceSet A = {r : ℝ \| ∃ x ∈ A, ∃ y ∈ A, r = dist x y}` from `Defs.lean`, a `Set ℝ`. |
| 2 | The ambient metric is the Euclidean one. | ✅ `EuclideanSpace ℝ (Fin n)`, whose `dist` is the $\ell^2$ distance. |
| 3 | $A$ is a Borel set. | ✅ `hA : MeasurableSet A`; the `MeasurableSpace` instance on `EuclideanSpace ℝ (Fin n)` is the Borel $\sigma$-algebra. |
| 4 | Part (1): if $\dim A > (n+1)/2$ then $D(A)$ has positive Lebesgue measure. | ✅ `((n : ℝ≥0∞) + 1) / 2 < dimH A → 0 < volume (distanceSet A)`, with `volume : Measure ℝ`. |
| 5 | Part (2) has a **two-sided** hypothesis on $\dim A$, **non-strict at both ends**: $\frac{n-1}{2} \le \dim A \le \frac{n+1}{2}$. | ✅ `((n : ℝ≥0∞) - 1) / 2 ≤ dimH A ∧ dimH A ≤ ((n : ℝ≥0∞) + 1) / 2`. |
| 6 | Part (2)'s conclusion is the dimension gain $\dim D(A) \ge \dim A - (n-1)/2$, **non-strict**. | ✅ `dimH A - ((n : ℝ≥0∞) - 1) / 2 ≤ dimH (distanceSet A)`. |
| 7 | Both parts are asserted, with the correct strictness pattern: part (1)'s hypothesis is **strict**, part (2)'s hypothesis and conclusion are **non-strict**. | ✅ A conjunction, with `<` in part (1)'s hypothesis, `≤` at both ends of part (2)'s hypothesis, and `≤` in part (2)'s conclusion. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Stating the theorem for every $n$, with no lower bound on the dimension. | At $n = 1$ part (2) reads: $0 < \dim A < 1$ implies $\dim D(A) > \dim A$. That is false — there are compact $A \subset \mathbb{R}$ with $\dim(A - A) = \dim A$. The `2 ≤ n` hypothesis is what makes the statement safe. |
| 2 | Working in `Fin n → ℝ` or `PiLp ∞ …` instead of `EuclideanSpace`. | Those carry the sup metric, so `dist` is not $\lvert x-y\rvert$ and the distance set is a different object. The theorem's thresholds are specific to the Euclidean metric. |
| 3 | Using the difference set $A - A$, or a set of vectors, in place of the set of distances. | $D(A) \subset \mathbb{R}$ is one-dimensional data; the difference set lives in $\mathbb{R}^n$ and satisfies different bounds. |
| 4 | Assuming `MeasurableSet D`, or replacing `D` by `toMeasurable volume D`. | $D(A)$ is a continuous image of $A \times A$ and need not be Borel. Since `volume` is defined on all sets, `0 < volume D` is already the right statement, and adding measurability assumes something unproved. |
| 5 | Dropping the upper bound $\dim A \le (n+1)/2$ from part (2). | Without it the claimed gain exceeds $1$ as soon as $\dim A > (n+1)/2$, while $D(A) \subset \mathbb{R}$ forces $\dim D(A) \le 1$: for $A = \mathbb{R}^n$ the claim would read $\dim D(A) \ge (n+1)/2 > 1$, which is false. The upper bound is what keeps part (2) true. |
| 6 | Formalizing only part (1). | Both conclusions are part of the theorem. |
| 7 | Writing the conclusion of part (2) so that truncated `ℝ≥0∞` subtraction can bite — for example dropping the lower bound $\frac{n-1}{2} \le \dim A$ that keeps $\dim A - (n-1)/2$ genuine. | Subtraction in `ℝ≥0∞` is truncated at `0`, so below $(n-1)/2$ the conclusion would silently degrade to the vacuous `0 ≤ dimH (distanceSet A)`, and the statement would no longer say what the printed range asserts. |
| 8 | Excluding either endpoint of part (2)'s hypothesis — writing $\frac{n-1}{2} < \dim A$ or $\dim A < \frac{n+1}{2}$ in place of $\le$. | The book (Thm 12.14, p.166) makes both bounds non-strict. The upper endpoint is the theorem's strongest instance: at $\dim A = \frac{n+1}{2}$, part (2) asserts $\dim D(A) \ge 1$, and no other clause supplies it — part (1) needs $\dim A$ strictly above $\frac{n+1}{2}$. Strict hypotheses silently drop these cases and give a strictly weaker theorem. |
| 9 | Relaxing part (1)'s strict hypothesis to `≤`, or strengthening part (2)'s conclusion to `<`. | Part (1)'s threshold is strict: at $\dim A = (n+1)/2$ the text asserts only $\dim D(A) \ge 1$ (via part (2)), not positive measure. And part (2)'s conclusion is the non-strict $\dim D(A) \ge \dim A - (n-1)/2$ — Falconer's proof gives no more, and a strict version is outright false at the upper endpoint, where it would demand $\dim D(A) > 1$ for a subset of $\mathbb{R}$. |

## Notes on the ground truth

- `hn : 2 ≤ n` was added as a repair; the transcribed statement does not carry it, and without it the
  theorem is false at $n = 1$ (Mistake 1).
- Part (2)'s hypothesis is non-strict at **both** ends, exactly as printed (Thm 12.14, p.166) —
  note the contrast with part (1)'s strict `<`. Excluding either endpoint is Mistake 8, and the
  upper endpoint carries real content: there part (2) asserts `1 ≤ dimH (distanceSet A)`.
- `dimH` is mathlib's Hausdorff dimension, valued in `ℝ≥0∞`, so **every** subtraction in the
  statement is truncated at `0`. Two places matter: `(n : ℝ≥0∞) - 1` is genuine because
  `2 ≤ n`, and `dimH A - ((n : ℝ≥0∞) - 1)/2` agrees with the printed real subtraction throughout
  part (2)'s range: the hypothesis puts `dimH A` at or above `((n : ℝ≥0∞) - 1)/2`, and at the lower
  endpoint the truncated and the real statement alike reduce to the trivial bound
  `0 ≤ dimH (distanceSet A)`, which is also all the book asserts there. Casting through `ℝ` would
  make this visible without the reader having to check.
- $D(A)$ contains $0$ whenever $A$ is nonempty, matching the text's definition.
- The distance set is the named `distanceSet A` from `Defs.lean`, not a `let` inside the statement.
- `MeasurableSet A` is essential and must not be weakened to `NullMeasurableSet` or dropped: the
  proof extracts Frostman measures from $A$.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[mattila_12_14_falconer_distance_set.md](mattila_12_14_falconer_distance_set.md) and the background in [mattila_12_14_falconer_distance_set.context.md](mattila_12_14_falconer_distance_set.context.md),
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

- Requirement 5 with the two-sided hypothesis of part (2) reduced to one inequality.
- Requirement 1 with $D(A)$ read as a set of pairs or a subset of $\mathbb{R}^n$.
- Requirement 6 with the conclusion of part (2) strengthened to a strict inequality: that is not what Falconer's theorem gives, and at the upper endpoint $\dim A = \frac{n+1}{2}$ it is false, demanding $\dim D(A) > 1$ of a subset of $\mathbb{R}$.

### Domain-specific pitfalls for this problem

- The distance set lives in $\mathbb{R}$ and its size is measured by Lebesgue measure in part (1) and by Hausdorff dimension in part (2).
- The strictness pattern is content: part (1)'s hypothesis is strict, part (2)'s two-sided hypothesis is non-strict at both ends, and part (2)'s conclusion is non-strict. Swapping any of these changes the theorem.
- Hausdorff dimension comparisons involve extended reals; $\frac{n+1}{2}$ and $\frac{n-1}{2}$ must be coerced correctly, and subtraction of extended reals truncates at $0$.
- No measurability of $D(A)$ may be assumed.
- Both parts are asserted.
