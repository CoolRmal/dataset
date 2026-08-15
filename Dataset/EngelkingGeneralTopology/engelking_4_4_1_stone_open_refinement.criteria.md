# Criteria: engelking_4_4_1_stone_open_refinement

**Statement:** [engelking_4_4_1_stone_open_refinement.md](engelking_4_4_1_stone_open_refinement.md) · **Lean:** [engelking_4_4_1_stone_open_refinement.lean](engelking_4_4_1_stone_open_refinement.lean) · **Context:** [engelking_4_4_1_stone_open_refinement.context.md](engelking_4_4_1_stone_open_refinement.context.md)

## What the theorem says

Start with a metrizable space and any cover of it by open sets. Stone's theorem produces a second
open cover, each of whose members sits inside some member of the first, with two extra properties.
It is *locally finite*: every point has a neighbourhood meeting only finitely many members. And it is
*$\sigma$-discrete*: the new cover splits into countably many layers, and inside each layer every
point has a neighbourhood meeting at most one member. Both properties hold of the same refinement at
the same time.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The space is metrizable, and it is the *given* topology that comes from a metric. | ✅ `[MetrizableSpace X]`, whose definition ties the metric uniformity to the ambient topology. |
| 2 | The statement holds for **every** open cover, with an arbitrary index type. | ✅ `∀ (ι : Type v) (U : ι → Set X), IsOpenCover U → …`. |
| 3 | "Open cover" means all members are open **and** their union is everything. | ✅ `IsOpenCover U := (∀ i, IsOpen (U i)) ∧ ⋃ i, U i = univ`. |
| 4 | The refinement produced is itself an open cover of $X$. | ✅ `IsOpenCover V` is asserted about the new family. |
| 5 | It refines the given cover in the right direction: every new member lies inside some old member. | ✅ `Refines V U := ∀ j, ∃ i, V j ⊆ U i`. |
| 6 | The refinement is locally finite. | ✅ `LocallyFinite V`, mathlib's indexed-family version. |
| 7 | The refinement is $\sigma$-discrete, which needs an explicit split of the index type into countably many layers. | ✅ A level map `level : κ → ℕ` is produced, and each fibre is required to be discrete: `∀ n, IsDiscreteFamily fun j : {j : κ // level j = n} ↦ V j`. |
| 8 | "Discrete family" is: every point of $X$ has a neighbourhood meeting **at most one** member. | ✅ `IsDiscreteFamily U := ∀ x, ∃ V ∈ 𝓝 x, {i \| (V ∩ U i).Nonempty}.Subsingleton` — `Set.Subsingleton` is exactly "at most one". |
| 9 | Local finiteness and $\sigma$-discreteness are separate demands on the *same* family. | ✅ They appear as two conjuncts about the one family `V`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Asserting that the whole refinement is discrete, with no layers. | Far too strong. It would force every point to have a neighbourhood meeting one member of the entire cover, which is close to demanding a discrete space. |
| 2 | Replacing "discrete" by "locally finite" in the layers, giving a $\sigma$-locally finite refinement. | That is the Nagata–Smirnov condition (4.4.7), a weaker conclusion. A $\sigma$-locally finite family need not be $\sigma$-discrete. |
| 3 | Defining a discrete family as pairwise disjoint. | Disjointness is weaker: the sets $(1/(n+1),\,1/n)$ in $\mathbb{R}$ are pairwise disjoint but no neighbourhood of $0$ meets at most one of them. |
| 4 | Defining a discrete family as "every point has a neighbourhood meeting exactly one member". | Wrong in the other direction: members may be empty, and a point may lie outside the union, so "at most one" is what is meant. |
| 5 | Dropping `LocallyFinite V` and keeping only the $\sigma$-discreteness. | The two are independent; a $\sigma$-discrete family need not be locally finite. Engelking asks for both. |
| 6 | Dropping `IsOpenCover V`, keeping only `Refines V U`. | Then the empty family satisfies everything and the statement says nothing. |
| 7 | Adding separability, second countability, or completeness to the hypothesis. | Strengthening the hypothesis makes the theorem easier and no longer Stone's. Metrizability alone is the point. |

## Notes on the ground truth

- Assuming `[MetricSpace X]` instead of `[MetrizableSpace X]` is acceptable — every metrizable space
  can be given a compatible metric — so a candidate doing that should not be penalized.
- ⚠️ The $\sigma$-decomposition is carried by an existential index type `κ` together with a separate
  `level : κ → ℕ`. Stone's proof actually gives a refinement indexed by `ι × ℕ` with
  $V_{(i,n)} \subseteq U_i$ and layer $n$ discrete. A candidate returning that concrete
  `ι × ℕ`-indexed family is stating something stronger, which is fine but not required; it would also
  make the layering visible without the auxiliary `level` function.
- ⚠️ The refinement's index type is `κ : Type w` for a universe `w` that is free, so the theorem
  claims a refinement exists in *every* universe, including universes too small to index a family of
  subsets of `X`. Harmless at the usual instantiation `u = v = w`, but `κ : Type v` or `Type u` is
  the correct choice, since the refinement can always be indexed by `ι × ℕ` or by a subfamily of
  `Set X`.
- `IsDiscreteFamily` counts *indices* that are met, not distinct sets. For an existentially produced
  refinement this is harmless, since the index type can be chosen injectively.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[engelking_4_4_1_stone_open_refinement.md](engelking_4_4_1_stone_open_refinement.md) and the background in [engelking_4_4_1_stone_open_refinement.context.md](engelking_4_4_1_stone_open_refinement.context.md),
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

- Requirement 9: producing two refinements, one locally finite and one $\sigma$-discrete, rather than one family with both properties.
- Requirement 5 with the refinement relation reversed.
- Requirement 8 with "discrete" weakened to "locally finite" inside the $\sigma$-decomposition, which makes the second condition redundant.

### Domain-specific pitfalls for this problem

- A discrete family is stronger than a locally finite one: each point has a neighbourhood meeting *at most one* member.
- $\sigma$-discreteness is not a property of the family alone in a formal statement; the countable splitting must be exhibited.
- "Refines" means each new member is contained in some old member; it does not mean the new family is a subfamily.
- The refinement must itself cover $X$ and consist of open sets.
- The index type of the cover is arbitrary, so the statement must quantify over index types rather than fixing one.
