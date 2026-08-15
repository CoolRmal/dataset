# Criteria: mattila_8_19_compact_subsets_of_finite_hausdorff_measure

**Statement:** [mattila_8_19_compact_subsets_of_finite_hausdorff_measure.md](mattila_8_19_compact_subsets_of_finite_hausdorff_measure.md) · **Lean:** [mattila_8_19_compact_subsets_of_finite_hausdorff_measure.lean](mattila_8_19_compact_subsets_of_finite_hausdorff_measure.lean) · **Context:** [mattila_8_19_compact_subsets_of_finite_hausdorff_measure.context.md](mattila_8_19_compact_subsets_of_finite_hausdorff_measure.context.md)

## What the theorem says

Let $X$ be a compact metric space. Its $s$-dimensional Hausdorff measure can be recovered from the
inside, using only compact subsets whose own $s$-measure is *finite*: $\mathcal{H}^s(X)$ equals the
supremum of $\mathcal{H}^s(C)$ over all compact $C \subset X$ with $\mathcal{H}^s(C) < \infty$. The
point of the theorem is that this holds even when $\mathcal{H}^s(X) = \infty$, in which case no
single $C$ realizes the value and the supremum climbs to $\infty$ through finite-measure pieces.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. In the assessment column, ✅ means the ground truth states the requirement and
◐ means it states it in a form that deliberately departs from the text — a narrower setting, a
stronger hypothesis, or an equivalent but not literal phrasing — with the reason given. A ◐ records
a decision, not an open defect; where a more literal rendering would be at least as good, the row
says so.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The ambient space is a compact metric space, and the statement is about $\mathcal{H}^s$ on it. | ✅ `{X : Type u} [MetricSpace X] [CompactSpace X]`, with `μH[s]` throughout. |
| 2 | The left-hand side is the measure of the whole space. | ✅ `μH[s] (Set.univ : Set X)`. |
| 3 | The right-hand side is a supremum over the compact subsets of finite $\mathcal{H}^s$ measure — a supremum over a subfamily, not an existence claim. | ✅ `⨆ C : Set X, ⨆ (_ : IsCompact C), ⨆ (_ : μH[s] C < ∞), μH[s] C`. |
| 4 | The two sides are asserted **equal**, so both inequalities are claimed. | ✅ A single equation. The `≥` half is monotonicity; the `≤` half is the content. |
| 5 | Nothing forces $\mathcal{H}^s(X)$ to be finite. | ✅ No finiteness hypothesis appears; both sides live in `ℝ≥0∞`, so `∞ = ∞` is a meaningful instance. |
| 6 | The side condition on $C$ is finiteness of its Hausdorff measure, stated in `ℝ≥0∞`. | ✅ `μH[s] C < ∞`, i.e. `< ⊤`. |
| 7 | The subsets range over all of `Set X` with a compactness condition. | ✅ `C : Set X` with `IsCompact C` (in a compact metric space this is the same as closed). |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Replacing the supremum by `∃ C, IsCompact C ∧ μH[s] C < ∞ ∧ μH[s] C = μH[s] univ`. | This is false whenever $\mathcal{H}^s(X) = \infty$, since then no admissible $C$ attains the value. The supremum formulation is what makes the infinite case true. |
| 2 | Adding `μH[s] (univ : Set X) < ∞` as a hypothesis. | It removes exactly the case the theorem is interesting in. |
| 3 | Stating only `≤` or only `≥`. | The `≥` direction alone is trivial monotonicity; the `≤` direction alone drops half the printed equality. |
| 4 | Passing to real numbers through `ENNReal.toReal`. | `toReal` sends `∞` to `0`, so the equality would silently become `0 = 0` in the infinite case. |
| 5 | Dropping `[CompactSpace X]`. | Compactness of the ambient space is a genuine hypothesis of 8.19. |
| 6 | Comparing the finiteness condition against a real bound, e.g. `∃ M : ℝ, μH[s] C ≤ ENNReal.ofReal M`. | This is equivalent in substance but needlessly reintroduces reals; the direct `< ∞` is the intended condition. |

## Notes on the ground truth

- The `⨆ … ⨆ (_ : P)` telescope contributes `0` for subsets failing a condition. That is harmless
  here: every term is nonnegative and $C = \emptyset$ already qualifies, so the supremum is taken
  over a nonempty family and the spurious `0`s never dominate.
- `μH[s]` is mathlib's `Measure.hausdorffMeasure s = mkMetric (fun r ↦ r ^ s)`, the unnormalized
  $\mathcal{H}^s = \inf \sum d(E_i)^s$, exactly Mattila's convention. Here the identity is
  homogeneous, so any normalization would in fact do — but reusing mathlib's measure rather than
  hand-rolling a content is the right call.
- `[MeasurableSpace X] [BorelSpace X]` are the instances `μH[·]` needs; they add no mathematical
  content.
- The statement is universe-polymorphic in `X`, which keeps the book's generality. Specializing to
  `EuclideanSpace ℝ (Fin n)` would not be unfaithful, just narrower.
- **Deliberate departure.** `hs : 0 < s` is our addition; it is not in the textbook statement and is not used anywhere else
  in the statement. It is a harmless restriction (for $s = 0$ the identity still holds, with
  $\mathcal{H}^0$ the counting measure), but `0 ≤ s`, or no restriction at all, would be closer to
  the text.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[mattila_8_19_compact_subsets_of_finite_hausdorff_measure.md](mattila_8_19_compact_subsets_of_finite_hausdorff_measure.md) and the background in [mattila_8_19_compact_subsets_of_finite_hausdorff_measure.context.md](mattila_8_19_compact_subsets_of_finite_hausdorff_measure.context.md),
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

- Requirement 5 with a finiteness hypothesis on $\mathcal{H}^s(X)$, which removes the interesting case.
- Requirement 6 with the side condition $\mathcal{H}^s(C) < \infty$ dropped, which makes the identity trivial.
- Requirement 4 with only one inequality asserted.

### Domain-specific pitfalls for this problem

- Junk value — supremum: the supremum must be taken in $[0,\infty]$, where an unbounded family has supremum $\infty$; in $\mathbb{R}$ it would default to $0$ and the identity would be false.
- The family is the compact subsets of *finite* $\mathcal{H}^s$ measure.
- The theorem's content is the case $\mathcal{H}^s(X) = \infty$.
- $X$ is a compact metric space and $\mathcal{H}^s$ is computed in it.
