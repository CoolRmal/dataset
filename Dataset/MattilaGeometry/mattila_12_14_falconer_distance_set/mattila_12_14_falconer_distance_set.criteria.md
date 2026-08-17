# Criteria: mattila_12_14_falconer_distance_set

**Statement:** [mattila_12_14_falconer_distance_set.md](mattila_12_14_falconer_distance_set.md) · **Lean:** [mattila_12_14_falconer_distance_set.lean](mattila_12_14_falconer_distance_set.lean) · **Context:** [mattila_12_14_falconer_distance_set.context.md](mattila_12_14_falconer_distance_set.context.md)

## What the theorem says

For a Borel set $A \subset \mathbb{R}^n$, its distance set $D(A)$ is the set of all distances
$\lvert x-y\rvert$ realized by pairs of points of $A$; it is a subset of the real line. Falconer's
theorem gives two lower bounds on how large $D(A)$ is, in terms of the Hausdorff dimension of $A$. If
$\dim A$ exceeds $(n+1)/2$, then $D(A)$ has positive Lebesgue measure on the line. If $\dim A$ lies
in the intermediate range between $(n-1)/2$ and $(n+1)/2$, then $D(A)$ still has dimension strictly
bigger than $\dim A - (n-1)/2$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The distance set is the set of *distances*, a subset of $\mathbb{R}$. | ✅ `D := {r : ℝ \| ∃ x ∈ A, ∃ y ∈ A, r = dist x y}`. |
| 2 | The ambient metric is the Euclidean one. | ✅ `EuclideanSpace ℝ (Fin n)`, whose `dist` is the $\ell^2$ distance. |
| 3 | $A$ is a Borel set. | ✅ `hA : MeasurableSet A`; the `MeasurableSpace` instance on `EuclideanSpace ℝ (Fin n)` is the Borel $\sigma$-algebra. |
| 4 | Part (1): if $\dim A > (n+1)/2$ then $D(A)$ has positive Lebesgue measure. | ✅ `((n : ℝ≥0∞) + 1) / 2 < dimH A → 0 < volume D`, with `volume : Measure ℝ`. |
| 5 | Part (2) has a **two-sided** hypothesis on $\dim A$. | ✅ `((n : ℝ≥0∞) - 1) / 2 < dimH A ∧ dimH A < ((n : ℝ≥0∞) + 1) / 2`. |
| 6 | Part (2)'s conclusion is the dimension gain $\dim D(A) \ge \dim A - (n-1)/2$, **non-strict**. | ✅ `dimH A - ((n : ℝ≥0∞) - 1) / 2 ≤ dimH (distanceSet A)`. |
| 7 | Both parts are asserted. The hypotheses are strict inequalities; the conclusion of part (2) is **not**. | ✅ A conjunction, with `<` in the hypotheses of both parts and `≤` in the conclusion of part (2). |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Stating the theorem for every $n$, with no lower bound on the dimension. | At $n = 1$ part (2) reads: $0 < \dim A < 1$ implies $\dim D(A) > \dim A$. That is false — there are compact $A \subset \mathbb{R}$ with $\dim(A - A) = \dim A$. The `2 ≤ n` hypothesis is what makes the statement safe. |
| 2 | Working in `Fin n → ℝ` or `PiLp ∞ …` instead of `EuclideanSpace`. | Those carry the sup metric, so `dist` is not $\lvert x-y\rvert$ and the distance set is a different object. The theorem's thresholds are specific to the Euclidean metric. |
| 3 | Using the difference set $A - A$, or a set of vectors, in place of the set of distances. | $D(A) \subset \mathbb{R}$ is one-dimensional data; the difference set lives in $\mathbb{R}^n$ and satisfies different bounds. |
| 4 | Assuming `MeasurableSet D`, or replacing `D` by `toMeasurable volume D`. | $D(A)$ is a continuous image of $A \times A$ and need not be Borel. Since `volume` is defined on all sets, `0 < volume D` is already the right statement, and adding measurability assumes something unproved. |
| 5 | Dropping the upper bound $\dim A < (n+1)/2$ from part (2). | In that larger range part (1) already gives the stronger conclusion; asserting the dimension gain there is not what the text says. |
| 6 | Formalizing only part (1). | Both conclusions are part of the theorem. |
| 7 | Writing the conclusion of part (2) so that truncated `ℝ≥0∞` subtraction can bite — for example dropping the hypothesis that keeps $\dim A - (n-1)/2$ genuine. | Subtraction in `ℝ≥0∞` is truncated at `0`, so the conclusion would silently degrade to `0 < dimH D`, which is far weaker than the printed gain. |
| 8 | Replacing the strict inequalities by `≤` anywhere. | Every inequality in 12.14, in hypotheses and conclusions alike, is strict. |

## Notes on the ground truth

- `hn : 2 ≤ n` was added as a repair; the transcribed statement does not carry it, and without it the
  theorem is false at $n = 1$ (Mistake 1).
- `dimH` is mathlib's Hausdorff dimension, valued in `ℝ≥0∞`, so **every** subtraction in the
  statement is truncated at `0`. Two places matter: `(n : ℝ≥0∞) - 1` is genuine because
  `2 ≤ n`, and `dimH A - ((n : ℝ≥0∞) - 1)/2` is genuine because part (2)'s hypothesis puts
  `dimH A` above that value. Casting through `ℝ` would make this visible without the reader having
  to check.
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
| A. Completeness | 50 | The requirement table above has 9 rows, so each row is worth 5.6 points: full credit if the candidate states it in any equivalent form, half for a harmless strengthening or weakening, none if it is absent. |
| B. Semantic fidelity | 20 | Junk values, `ℝ` vs `ℝ≥0∞`, coercions, quantifier order, a.e. vs everywhere — see the pitfalls below. |
| C. Mathlib-concept correctness | 15 | The Mathlib notion must mean the textbook notion, with the typeclass assumptions it needs. |
| D. Non-degeneracy | 10 | Not vacuous, not trivial, not a strictly weaker theorem. |
| E. Hygiene | 5 | No needless definitions, redundant conjuncts or unused hypotheses. |

**Every row of the *Mistakes to check for* table above is a defect.** Charge each one to the band it belongs to and deduct there.

### Fatal — any of these caps the total at 25

- Requirement 5 with the two-sided hypothesis of part (2) reduced to one inequality.
- Requirement 1 with $D(A)$ read as a set of pairs or a subset of $\mathbb{R}^n$.
- Requirement 6 with the conclusion of part (2) strengthened to a strict inequality: that is not what Falconer's theorem gives.

### Domain-specific pitfalls for this problem

- The distance set lives in $\mathbb{R}$ and its size is measured by Lebesgue measure in part (1) and by Hausdorff dimension in part (2).
- Hausdorff dimension comparisons involve extended reals; $\frac{n+1}{2}$ and $\frac{n-1}{2}$ must be coerced correctly, and subtraction of extended reals truncates at $0$.
- No measurability of $D(A)$ may be assumed.
- Both parts are asserted.
