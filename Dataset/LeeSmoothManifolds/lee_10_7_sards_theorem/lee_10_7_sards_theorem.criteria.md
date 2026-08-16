# Criteria: lee_10_7_sards_theorem

**Statement:** [lee_10_7_sards_theorem.md](lee_10_7_sards_theorem.md) · **Lean:** [lee_10_7_sards_theorem.lean](lee_10_7_sards_theorem.lean) · **Context:** [lee_10_7_sards_theorem.context.md](lee_10_7_sards_theorem.context.md)

## What the theorem says

Let $F : M \to N$ be a smooth map between smooth manifolds. Call a point $p$ of $M$ *critical* if
the differential $dF_p$ fails to be surjective, and call the images of critical points *critical
values*. Sard's theorem says the set of critical values is a null set in $N$ — it takes up no
volume. Since $N$ carries no preferred measure, "null set in $N$" has to be read as: in every smooth
chart of $N$, the picture of the critical-value set has Lebesgue measure zero.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. In the assessment column, ✅ means the ground truth states the requirement and
◐ means it states it in a form that deliberately departs from the text — a narrower setting, a
stronger hypothesis, or an equivalent but not literal phrasing — with the reason given. A ◐ records
a decision, not an open defect; where a more literal rendering would be at least as good, the row
says so.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $M$ is a smooth manifold of dimension $m$ without boundary, and $N$ one of dimension $n$. | ✅ `[ChartedSpace (Fin m → ℝ) M]` with `[IsManifold 𝓘(ℝ, Fin m → ℝ) ∞ M]`, and the same for `N` with `n`. |
| 2 | $M$ is second countable. Lee builds this into "smooth manifold"; Mathlib does not, and the theorem is false without it. | ✅ `[SecondCountableTopology M]`. `[SigmaCompactSpace M]` or Lindelöfness would do as well. |
| 3 | $F$ is $C^\infty$. | ✅ `hF : ContMDiff 𝓘(ℝ, Fin m → ℝ) 𝓘(ℝ, Fin n → ℝ) ∞ F`, with `∞` meaning $C^\infty$ (not `ω`). |
| 4 | The critical set is the set of points where the differential is *not* surjective. | ✅ `critical := {p : M \| ¬ Manifold.IsSubmersionAt 𝓘(ℝ, Fin m → ℝ) 𝓘(ℝ, Fin n → ℝ) ∞ F p}`. |
| 5 | The conclusion is about the **image** $F(\text{critical})$, the critical values, not the critical set itself. | ✅ `F '' critical` appears inside the measure. |
| 6 | "Null in $N$" is stated chart by chart, for charts belonging to the smooth structure of $N$. | ✅ `∀ ψ : OpenPartialHomeomorph N (Fin n → ℝ), ψ ∈ IsManifold.maximalAtlas 𝓘(ℝ, Fin n → ℝ) ∞ N → …`. |
| 7 | Inside a chart, only the part of the set lying in the chart's domain can be pushed forward, and its image must have Lebesgue measure zero. | ✅ `volume (ψ '' (F '' critical ∩ ψ.source)) = 0`, with `volume` the Lebesgue product measure on `Fin n → ℝ`. |
| 8 | No measurability side condition anywhere. | ✅ None is imposed. A Mathlib measure applied to an arbitrary set is the induced outer measure, so `volume S = 0` already says exactly "$S$ is a null set". |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Omitting second countability (or $\sigma$-compactness) of $M$. | The statement is then **false**. Take $M = \mathbb{R} \times D$ with $D$ an uncountable discrete space — a legitimate `ChartedSpace (Fin 1 → ℝ)` with `IsManifold … ∞`, even Hausdorff — let $N = \mathbb{R}$ and $F(t,d) = \iota(d)$ for an injection $\iota : D \hookrightarrow [0,1]$. Then $F$ is smooth (locally constant), every point is critical, and the critical values fill $[0,1]$, of measure 1. Our file once lacked this hypothesis and it was repaired. |
| 2 | Asserting `volume (F '' critical) = 0` with an invented measure on $N$, or `μ (F '' critical) = 0` for an unspecified `μ`. | A manifold has no preferred measure. Either the measure is not defined, or the statement quietly depends on which measure was picked. |
| 3 | Stating the chart condition only for `chartAt` rather than for charts of the maximal smooth atlas. | Restricting to one preselected chart per point is a weaker claim; quantifying over the whole maximal atlas is the safe reading, and equivalent to quantifying over any single atlas since transition maps are diffeomorphisms and preserve null sets. |
| 4 | Concluding that the critical **set** in $M$ is null. | False. For a constant map every point of $M$ is critical, so the critical set is all of $M$. Sard's theorem is about the image. |
| 5 | Adding `MeasurableSet (F '' critical)` as a hypothesis, or as a second conjunct of the conclusion. | As a hypothesis it weakens the theorem to a special case; as a conclusion it asserts something that is not true in general. |
| 6 | Stating it for `ContMDiff … k F` with a finite `k` and no side condition. | The $C^k$ version of Sard's theorem needs $k > \max(m - n, 0)$. Without that bound the statement is false; Lee 10.7 is the $C^\infty$ statement. |
| 7 | Forgetting to intersect with `ψ.source` before applying the chart. | An `OpenPartialHomeomorph` returns junk values outside its domain, so the image would include meaningless points and the claim would be about the wrong set. |

## Notes on the ground truth

- Lee's critical point is one where $dF_p$ is not surjective. We write this as
  `¬ Manifold.IsSubmersionAt …` instead of `¬ Surjective (mfderiv …)`. This avoids a junk-value
  issue — `mfderiv` is the zero map off the differentiability locus, so the `mfderiv` version would
  wrongly count non-differentiability points, harmless here only by accident. Mathlib has not yet
  proved "`mfderiv` surjective ⟺ `IsSubmersionAt`" in finite dimensions (it is a TODO in
  `Submersion.lean`), so `¬ IsSubmersionAt` is possibly a *larger* set than Lee's critical set, which
  makes our conclusion at least as strong as his — the safe direction.
- **Deliberate departure.** The critical set is introduced with a `let critical := …` inside the statement. It works, but a
  `let` in a benchmark statement is awkward: it has to be introduced or unfolded before use, and it
  obscures the logical shape. Inlining the set, or naming it as a top-level definition in
  `Defs.lean` alongside `RegularValue`, would read better.
- `[T2Space M]`, `[T2Space N]` and second countability are assumed, matching Lee's definition of a
  smooth manifold.
- `[SecondCountableTopology N]` is also assumed. It is not needed for the truth of the statement,
  but it is part of Lee's definition of a smooth manifold, so keeping it is faithful.
- This file does not import `Defs.lean`; it uses only Mathlib notions.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[lee_10_7_sards_theorem.md](lee_10_7_sards_theorem.md) and the background in [lee_10_7_sards_theorem.context.md](lee_10_7_sards_theorem.context.md),
not against the ground-truth Lean file: a candidate spelled differently but
mathematically equivalent to the text loses nothing. The scale is defined in
[GRADING.md](../../GRADING.md); the numbers below are this problem's instance of it.

| Band | Points | This problem |
|---|---|---|
| A. Completeness | 50 | The requirement table above has 8 rows, so each row is worth 6.2 points: full credit if the candidate states it in any equivalent form, half for a harmless strengthening or weakening, none if it is absent. |
| B. Semantic fidelity | 20 | Junk values, `ℝ` vs `ℝ≥0∞`, coercions, quantifier order, a.e. vs everywhere — see the pitfalls below. |
| C. Mathlib-concept correctness | 15 | The Mathlib notion must mean the textbook notion, with the typeclass assumptions it needs. |
| D. Non-degeneracy | 10 | Not vacuous, not trivial, not a strictly weaker theorem. |
| E. Hygiene | 5 | No needless definitions, redundant conjuncts or unused hypotheses. |

**Every row of the *Mistakes to check for* table above is a defect.** Charge each one to the band it belongs to and deduct there.

### Fatal — any of these caps the total at 25

- Requirement 5 with the conclusion about the critical *points* rather than the critical *values*.
- Requirement 2 with second countability of $M$ dropped: the statement is false.
- Requirement 6 with nullity defined by an arbitrary chart rather than one in the smooth structure.

### Domain-specific pitfalls for this problem

- A critical point is one where the differential fails to be *surjective*; injectivity is the wrong condition.
- "Measure zero in $N$" is a chartwise condition, quantified over the charts of the smooth structure.
- Only $S \cap \operatorname{dom}\psi$ can be pushed through $\psi$; forgetting the intersection makes the statement ill-formed.
- No measurability of the image is assumed, and none is needed for an outer measure.
- The smoothness hypothesis is what makes the differential the genuine one.
