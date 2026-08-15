# Criteria: lee_10_11_whitney_embedding_theorem

**Statement:** [lee_10_11_whitney_embedding_theorem.md](lee_10_11_whitney_embedding_theorem.md) · **Lean:** [lee_10_11_whitney_embedding_theorem.lean](lee_10_11_whitney_embedding_theorem.lean) · **Context:** [lee_10_11_whitney_embedding_theorem.context.md](lee_10_11_whitney_embedding_theorem.context.md)

## What the theorem says

Every smooth manifold of dimension $m$ sits inside $\mathbb{R}^{2m+1}$ as a smoothly embedded copy
of itself, and can be placed there properly — meaning the preimage of every compact set is compact,
so the copy does not run off to infinity inside a bounded region. "Smooth embedding" means the map
is smooth, is an immersion (its differential is injective at every point), and is a homeomorphism
onto its image. The target dimension $2m+1$ is part of the statement.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $M$ is a smooth manifold of dimension exactly $m$, without boundary. | ✅ `[ChartedSpace (Fin m → ℝ) M]` and `[IsManifold 𝓘(ℝ, Fin m → ℝ) ∞ M]`. The model `𝓘(ℝ, ·)` is boundaryless (as opposed to `modelWithCornersEuclideanHalfSpace`) and `∞` gives $C^\infty$ transitions. |
| 2 | $M$ is Hausdorff. | ✅ `[T2Space M]`. |
| 3 | $M$ satisfies Lee's countability requirement. | ✅ `[SecondCountableTopology M]`, the condition Lee actually states. For a locally Euclidean Hausdorff space it is equivalent to $\sigma$-compactness, but the textbook's own hypothesis is second countability, so that is what the ground truth uses. |
| 4 | The conclusion produces a single map $F$ carrying all the required properties at once, not several unrelated existence claims. | ✅ One `∃ F : M → (Fin (2 * m + 1) → ℝ)` followed by a conjunction. |
| 5 | The target dimension is exactly $2m+1$. | ✅ `F : M → (Fin (2 * m + 1) → ℝ)`, with the dimension written out rather than existentially quantified. |
| 6 | $F$ is smooth. | ✅ Implied by `IsSmoothEmbedding …`, whose `isImmersion` field already gives `CMDiff ∞ F`; asserting `ContMDiff` as a separate conjunct would be redundant. |
| 7 | $F$ is a topological embedding: injective, and a homeomorphism onto its image. | ✅ The `isEmbedding` field of `Manifold.IsSmoothEmbedding`. |
| 8 | $F$ is proper. | ✅ `IsProperMap F`. Mathlib's `IsProperMap` is universal closedness, which for these spaces is the same as "preimages of compact sets are compact". |
| 9 | $F$ is an **immersion**: its differential is injective at every point. | ✅ The `isImmersion` field of `Manifold.IsSmoothEmbedding`. This is exactly why the Mathlib notion, and not "`ContMDiff` + `IsEmbedding`", is the right rendering of "smooth embedding". |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Treating "smooth embedding" as "smooth + topological embedding" and stopping there. | That is not an embedding of smooth manifolds. The map $t \mapsto t^3$ is a smooth homeomorphism $\mathbb{R} \to \mathbb{R}$ whose derivative vanishes at $0$, so its image is not smoothly parametrised. The immersion clause is what rules this out. |
| 2 | Existentially quantifying the target dimension: `∃ N, ∃ F : M → (Fin N → ℝ), …`. | Strictly weaker, and it throws away all the quantitative content. Mathlib already has that weaker form for compact $M$ (`exists_embedding_euclidean_of_compact`). |
| 3 | Dropping `IsProperMap F`. | Leaves the weaker claim "every smooth $m$-manifold embeds in $\mathbb{R}^{2m+1}$". Lee's theorem asserts a *proper* embedding, which is what makes the image closed. |
| 4 | Dropping `[T2Space M]`. | The statement becomes false: the line with two origins is a `ChartedSpace (Fin 1 → ℝ)` with a smooth atlas, and it embeds into no Hausdorff space at all. |
| 5 | Dropping the countability assumption. | Also false: an uncountable disjoint union of copies of $\mathbb{R}^m$ is Hausdorff, locally Euclidean and smooth, but $\mathbb{R}^{2m+1}$ is second countable so no injection of it can be an embedding. |
| 6 | Using a model with corners for a manifold with boundary. | Whitney's theorem in this form is stated for manifolds without boundary; changing the model changes the theorem. |

## Notes on the ground truth

- `Manifold.IsSmoothEmbedding I J n f` is a structure with two fields, `isImmersion` and
  `isEmbedding`, so one conjunct carries requirements 6, 7 and 9 at once. An earlier version of this
  file wrote `IsEmbedding F ∧ ContMDiff … F`, which is strictly weaker — `t ↦ t³` on `ℝ` is a smooth
  homeomorphism that is not an immersion — and that gap has been repaired.
- The model space is `Fin m → ℝ` (sup norm) rather than Mathlib's usual `EuclideanSpace ℝ (Fin m)`.
  The two are linearly homeomorphic, hence diffeomorphic, so nothing in an embedding statement
  changes; it is off-convention only.
- `ContMDiff I I' ∞` with the scoped `∞` really is $C^\infty$. Contrast the Euclidean files of this
  book, where `⊤` under `open scoped ContDiff` would elaborate to `ω`, real-analytic.
- This file does not import `Defs.lean`; everything it needs is in Mathlib.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[lee_10_11_whitney_embedding_theorem.md](lee_10_11_whitney_embedding_theorem.md) and the background in [lee_10_11_whitney_embedding_theorem.context.md](lee_10_11_whitney_embedding_theorem.context.md),
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

- Requirement 9 dropped — "smooth embedding" rendered as smoothness plus a topological embedding: strictly weaker, and the standard counterexample is $t \mapsto t^3$.
- Requirement 5 with the target dimension existentially quantified.
- Requirement 2 or 3 dropped: the statement becomes false.
- Requirement 8 dropped, leaving the weaker non-proper embedding claim.

### Domain-specific pitfalls for this problem

- "Smooth embedding" is `Manifold.IsSmoothEmbedding` — immersion **and** topological embedding — not `ContMDiff` conjoined with `Topology.IsEmbedding`.
- Lee's countability hypothesis is **second countability**, not $\sigma$-compactness; the two are equivalent here but the textbook states the former.
- Since `IsSmoothEmbedding` already entails smoothness, a separate `ContMDiff` conjunct is redundant and costs hygiene credit.
- The model with corners `𝓘(ℝ, E)` is boundaryless; a half-space model would state the with-boundary theorem.
- The smoothness exponent `∞` is $C^\infty$; in the same scope `⊤` elaborates to `ω`, real-analytic.
