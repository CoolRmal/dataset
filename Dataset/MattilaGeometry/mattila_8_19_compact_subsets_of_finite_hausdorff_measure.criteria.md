# Criteria: mattila_8_19_compact_subsets_of_finite_hausdorff_measure

**Statement:** [mattila_8_19_compact_subsets_of_finite_hausdorff_measure.md](mattila_8_19_compact_subsets_of_finite_hausdorff_measure.md) · **Lean:** [mattila_8_19_compact_subsets_of_finite_hausdorff_measure.lean](mattila_8_19_compact_subsets_of_finite_hausdorff_measure.lean)

## What the theorem says

Let $X$ be a compact metric space. Its $s$-dimensional Hausdorff measure can be recovered from the
inside, using only compact subsets whose own $s$-measure is *finite*: $\mathcal{H}^s(X)$ equals the
supremum of $\mathcal{H}^s(C)$ over all compact $C \subset X$ with $\mathcal{H}^s(C) < \infty$. The
point of the theorem is that this holds even when $\mathcal{H}^s(X) = \infty$, in which case no
single $C$ realizes the value and the supremum climbs to $\infty$ through finite-measure pieces.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

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
- ⚠️ `hs : 0 < s` is our addition; it is not in the textbook statement and is not used anywhere else
  in the statement. It is a harmless restriction (for $s = 0$ the identity still holds, with
  $\mathcal{H}^0$ the counting measure), but `0 ≤ s`, or no restriction at all, would be closer to
  the text.
