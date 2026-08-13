# Criteria: engelking_4_4_7_nagata_smirnov_metrization

**Statement:** [engelking_4_4_7_nagata_smirnov_metrization.md](engelking_4_4_7_nagata_smirnov_metrization.md) · **Lean:** [engelking_4_4_7_nagata_smirnov_metrization.lean](engelking_4_4_7_nagata_smirnov_metrization.lean)

## What the theorem says

This is a characterization of the spaces whose topology comes from a metric. A space is metrizable
exactly when two things hold: it is regular (in Engelking's sense, which also requires $T_1$), and it
has a base that can be split into countably many pieces, each of which is a locally finite family —
that is, each point has a neighbourhood meeting only finitely many members of that piece. Such a base
is called $\sigma$-locally finite. Both directions are asserted.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The statement is a biconditional; both directions are claimed. | ✅ `MetrizableSpace X ↔ RegularSpace X ∧ HasSigmaLocallyFiniteBase X`. |
| 2 | "Metrizable" means the **given** topology is induced by a metric, not that some metric structure exists on the type. | ✅ `MetrizableSpace X`, whose unfolding carries a uniformity with `toTopologicalSpace = t` and countably generated `𝓤 X`, plus `T0Space`. |
| 3 | The $T_1$ axiom is present, since Engelking's "regular" bundles it in. | ✅ `[T1Space X]` as an instance hypothesis, so `RegularSpace X` on the right is exactly Engelking's regularity. |
| 4 | Regularity appears as a conjunct of the right-hand side, not as a standing hypothesis. | ✅ `RegularSpace X` sits inside the `↔`. |
| 5 | The $\sigma$-locally finite base is countably many families $\mathcal{B}_n$, indexed by $\mathbb{N}$. | ✅ `∃ (ι : ℕ → Type v) (B : ∀ n, ι n → Set X), …`. |
| 6 | It is the **union** of those families that is a base for the topology. | ✅ `IsTopologicalBasis {V \| ∃ n i, B n i = V}`. |
| 7 | It is each individual family, not the union, that is required to be locally finite. | ✅ `∀ n, LocallyFinite (B n)`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Leaving $T_1$ out entirely, i.e. `MetrizableSpace X ↔ RegularSpace X ∧ …` with no separation hypothesis. | The biconditional becomes false. The two-point indiscrete space satisfies mathlib's `RegularSpace` and has the one-element base $\{X\}$, which is locally finite, but it is not metrizable. |
| 2 | Requiring the base as a whole to be locally finite. | Enormously stronger and essentially never satisfied — in $\mathbb{R}$ no locally finite family of open sets can be a base. |
| 3 | Requiring each family $\mathcal{B}_n$ separately to be a base. | Not what $\sigma$-locally finite means, and it would collapse the condition to "there is a locally finite base". |
| 4 | Writing the metrizability side as `∃ d : MetricSpace X, True`, or assuming an unrelated `[MetricSpace X]` with no link to the ambient topology. | Almost every type carries some metric structure, so this says nothing. The metric must induce the given topology. |
| 5 | Replacing the $\sigma$-locally finite base by a countable base. | That gives the Urysohn metrization theorem, which mathlib already has as `TopologicalSpace.metrizableSpace_of_t3_secondCountable` and which is not a characterization: an uncountable discrete space is metrizable with no countable base. |
| 6 | Moving `RegularSpace X` into the instance binders and stating `MetrizableSpace X ↔ HasSigmaLocallyFiniteBase X`. | Weaker. The forward direction then no longer has to show that a metrizable space is regular, which is part of the content. |

## Notes on the ground truth

- A candidate writing `T3Space X` (mathlib's `T0Space` + `RegularSpace`) in place of the
  `[T1Space X]` instance plus `RegularSpace X` conjunct is equally faithful and should be accepted.
  So is `∃ m : MetricSpace X, m.toTopologicalSpace = ‹TopologicalSpace X›` for the left-hand side.
- Openness of the base members is not stated separately in `HasSigmaLocallyFiniteBase`. It is not
  missing: it follows from `IsTopologicalBasis.eq_generateFrom` together with `sUnion_eq`.
- Mathlib has no $\sigma$-locally finite base predicate and no Nagata–Smirnov theorem, so the custom
  definition is justified. Everything else is mathlib's: `IsTopologicalBasis` for "base",
  `LocallyFinite` for local finiteness, `MetrizableSpace` for metrizability.
- ⚠️ Each layer is indexed by `ι n : Type v` with `v` a free universe parameter, so the biconditional
  is implicitly claimed for every universe `v`. For `v` below the universe of `X`, the right-to-left
  direction may be unsatisfiable simply because there are not enough index values. Indexing the
  layers by subtypes of `Set X`, or stating the base as a `Set (Set X)` with a decomposition
  `Set X → ℕ`, removes the ambiguity.
