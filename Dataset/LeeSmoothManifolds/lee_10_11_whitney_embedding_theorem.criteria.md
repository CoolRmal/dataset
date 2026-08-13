# Criteria: lee_10_11_whitney_embedding_theorem

**Statement:** [lee_10_11_whitney_embedding_theorem.md](lee_10_11_whitney_embedding_theorem.md) · **Lean:** [lee_10_11_whitney_embedding_theorem.lean](lee_10_11_whitney_embedding_theorem.lean)

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
| 3 | $M$ satisfies Lee's countability requirement. | ✅ `[SigmaCompactSpace M]`. For a locally Euclidean Hausdorff space, $\sigma$-compactness and second countability are equivalent, so this is a faithful rendering. |
| 4 | The conclusion produces a single map $F$ carrying all the required properties at once, not several unrelated existence claims. | ✅ One `∃ F : M → (Fin (2 * m + 1) → ℝ)` followed by a conjunction. |
| 5 | The target dimension is exactly $2m+1$. | ✅ `F : M → (Fin (2 * m + 1) → ℝ)`, with the dimension written out rather than existentially quantified. |
| 6 | $F$ is smooth. | ✅ `ContMDiff 𝓘(ℝ, Fin m → ℝ) 𝓘(ℝ, Fin (2 * m + 1) → ℝ) ∞ F`. |
| 7 | $F$ is a topological embedding: injective, and a homeomorphism onto its image. | ✅ `IsEmbedding F` (the `Topology.IsEmbedding` spelling, available via `open Topology`). |
| 8 | $F$ is proper. | ✅ `IsProperMap F`. Mathlib's `IsProperMap` is universal closedness, which for these spaces is the same as "preimages of compact sets are compact". |
| 9 | $F$ is an **immersion**: its differential is injective at every point. | ⚠️ Missing. `IsEmbedding F ∧ ContMDiff … ∞ F` does not imply it. `Manifold.IsImmersion 𝓘(ℝ, Fin m → ℝ) 𝓘(ℝ, Fin (2 * m + 1) → ℝ) ∞ F` should be a fourth conjunct; the file already imports `Mathlib.Geometry.Manifold.Immersion`, so adding it costs nothing. A candidate that includes it is *better* than our statement. |

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

- ⚠️ The immersion conjunct is genuinely absent (requirement row 9), so our conclusion is weaker than
  the printed theorem. This is the one substantive gap in this file.
- The model space is `Fin m → ℝ` (sup norm) rather than Mathlib's usual `EuclideanSpace ℝ (Fin m)`.
  The two are linearly homeomorphic, hence diffeomorphic, so nothing in an embedding statement
  changes; it is off-convention only.
- `ContMDiff I I' ∞` with the scoped `∞` really is $C^\infty$. Contrast the Euclidean files of this
  book, where `⊤` under `open scoped ContDiff` would elaborate to `ω`, real-analytic.
- This file does not import `Defs.lean`; everything it needs is in Mathlib.
