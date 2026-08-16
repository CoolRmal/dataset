# Criteria: engelking_4_4_8_bing_metrization

**Statement:** [engelking_4_4_8_bing_metrization.md](engelking_4_4_8_bing_metrization.md) · **Lean:** [engelking_4_4_8_bing_metrization.lean](engelking_4_4_8_bing_metrization.lean) · **Context:** [engelking_4_4_8_bing_metrization.context.md](engelking_4_4_8_bing_metrization.context.md)

## What the theorem says

Bing's theorem characterizes metrizability the same way Nagata–Smirnov does, but with a stronger
condition on the base. A space is metrizable exactly when it is regular in Engelking's sense
(regular and $T_1$) and it has a base that splits into countably many *discrete* families — families
in which every point of the space has a neighbourhood meeting at most one member. Both directions are
asserted.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. In the assessment column, ✅ means the ground truth states the requirement and
◐ means it states it in a form that deliberately departs from the text — a narrower setting, a
stronger hypothesis, or an equivalent but not literal phrasing — with the reason given. A ◐ records
a decision, not an open defect; where a more literal rendering would be at least as good, the row
says so.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The statement is a biconditional; both directions are claimed. | ✅ `MetrizableSpace X ↔ RegularSpace X ∧ HasSigmaDiscreteBase X`. |
| 2 | The $T_1$ axiom is present, since Engelking's "regular" bundles it in. | ✅ `[T1Space X]` as an instance hypothesis, making `RegularSpace X` Engelking's notion. |
| 3 | Regularity is a conjunct of the right-hand side, not a standing hypothesis. | ✅ `RegularSpace X` sits inside the `↔`. |
| 4 | "Metrizable" means the given topology comes from a metric. | ✅ `MetrizableSpace X` (= `PseudoMetrizableSpace X` + `T0Space X`), whose unfolding carries `u.toTopologicalSpace = t`. |
| 5 | The base splits into countably many layers, indexed by $\mathbb{N}$. | ✅ `∃ (ι : ℕ → Type v) (B : ∀ n, ι n → Set X), …`. |
| 6 | It is the union of the layers that must be a base, not each layer individually. | ✅ `IsTopologicalBasis {V \| ∃ n i, B n i = V}`. |
| 7 | Each layer is **discrete**: every point has a neighbourhood meeting at most one member of that layer. | ✅ `∀ n, IsDiscreteFamily (B n)`, with `IsDiscreteFamily U := ∀ x, ∃ V ∈ 𝓝 x, {i \| (V ∩ U i).Nonempty}.Subsingleton`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Using `LocallyFinite` for the layers instead of `IsDiscreteFamily`. | That is theorem 4.4.7 (Nagata–Smirnov), a different statement. Discreteness is strictly stronger than local finiteness. |
| 2 | Defining "discrete" as pairwise disjoint. | Disjointness is weaker: the intervals $(1/(n+1),\,1/n)$ in $\mathbb{R}$ are pairwise disjoint, but every neighbourhood of $0$ meets infinitely many. The resulting characterization would be false. |
| 3 | Omitting the $T_1$ hypothesis. | The biconditional fails: the two-point indiscrete space is `RegularSpace` in mathlib and its base $\{X\}$ is a one-element, hence discrete, family, yet it is not metrizable. |
| 4 | Producing a `MetricSpace X` instance without asserting that its topology is the ambient one. | Says nothing — nearly any type carries some metric. The topology has to be pinned down. |
| 5 | Keeping only the `←` direction. | The forward direction is Stone's theorem 4.4.1 in disguise (a metrizable space has a $\sigma$-discrete base) and carries half the content. |
| 6 | Moving `RegularSpace X` into the instance binders. | Weaker: the forward direction no longer has to derive regularity from metrizability. |

## Notes on the ground truth

- `T3Space X` in place of `[T1Space X]` plus the `RegularSpace X` conjunct is an equally faithful
  variant and should be accepted.
- Openness of the base members is not stated separately; it follows from
  `IsTopologicalBasis.eq_generateFrom`, so nothing is missing.
- Mathlib has neither `IsDiscreteFamily` nor Bing's theorem, so the custom predicate is justified;
  everything else reuses mathlib (`IsTopologicalBasis`, `𝓝`, `Set.Subsingleton`, `MetrizableSpace`).
- `IsDiscreteFamily` is stated for an *indexed* family and its `Subsingleton` condition is on the set
  of indices met. That is the right indexed analogue: a discrete family cannot list the same
  nonempty set twice.
- Every index type quantified in the statement lives in `X`'s own universe. That costs no
  generality — a cover of `X` can always be re-indexed by its image in `Set X` — and it removes
  the free universe parameter, so the statement is about all covers rather than about covers in
  one arbitrary universe. The generic family predicates in `Defs.lean` stay polymorphic in their
  index type, as they should.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[engelking_4_4_8_bing_metrization.md](engelking_4_4_8_bing_metrization.md) and the background in [engelking_4_4_8_bing_metrization.context.md](engelking_4_4_8_bing_metrization.context.md),
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

- Requirement 6 with each layer required to be a base instead of the union.
- Requirement 7 with "discrete" weakened to "locally finite", which states Nagata–Smirnov rather than Bing.
- Requirement 1 stated as a single implication.

### Domain-specific pitfalls for this problem

- A discrete family is strictly stronger than a locally finite one; substituting the latter gives a different theorem.
- Engelking's "regular" includes $T_1$.
- It is the union of the countably many layers that must be a base.
- "Metrizable" refers to the given topology.
