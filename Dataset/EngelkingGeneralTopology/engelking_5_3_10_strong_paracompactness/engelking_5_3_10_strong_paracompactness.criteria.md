# Criteria: engelking_5_3_10_strong_paracompactness

**Statement:** [engelking_5_3_10_strong_paracompactness.md](engelking_5_3_10_strong_paracompactness.md) · **Lean:** [engelking_5_3_10_strong_paracompactness.lean](engelking_5_3_10_strong_paracompactness.lean) · **Context:** [engelking_5_3_10_strong_paracompactness.context.md](engelking_5_3_10_strong_paracompactness.context.md)

## What the theorem says

A family of sets is *star-finite* if each member meets only finitely many members of the family, and
*star-countable* if each member meets only countably many. A space is *strongly paracompact* if it is
Hausdorff and every open cover has a star-finite open refinement. For a regular space (Engelking's
regular, so also $T_1$), the theorem gives four equivalent conditions: strong paracompactness; every
open cover has a closed refinement that is both locally finite and star-finite; the same with
star-countable in place of star-finite; and every open cover has a star-countable open refinement.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The space is regular in Engelking's sense, which is regular together with $T_1$. | ✅ Both `[RegularSpace X]` and `[T1Space X]` are assumed. |
| 2 | All four items appear in Engelking's order as one equivalence. | ✅ `List.TFAE [IsStronglyParacompact X, closedLocallyFiniteStarFinite, closedLocallyFiniteStarCountable, starCountableOpen]`. |
| 3 | Strong paracompactness is "Hausdorff **and** every open cover has a star-finite open refinement". | ✅ `IsStronglyParacompact X := T2Space X ∧ ∀ ι U, IsOpenCover U → ∃ κ V, IsOpenCover V ∧ Refines V U ∧ IsStarFiniteFamily V`. |
| 4 | Star-finite means: for each index $i$, the set of $j$ with $A_i \cap A_j \neq \emptyset$ is finite. Star-countable is the same with "countable". | ✅ `IsStarFiniteFamily A := ∀ i, {j \| (A i ∩ A j).Nonempty}.Finite`, and the `Countable` analogue. |
| 5 | Each item is of the form "for every open cover there **exists** a refinement", with the refinement's index type existentially quantified. | ✅ `∀ (ι : Type v) (U : ι → Set X), IsOpenCover U → ∃ (κ : Type v) (F : κ → Set X), …` in all three `let` items. |
| 6 | Items (ii) and (iii) ask for a **closed** refinement that actually covers $X$. | ✅ `IsClosedCover F := (∀ i, IsClosed (F i)) ∧ ⋃ i, F i = univ`, conjoined with `Refines F U`. |
| 7 | Items (ii) and (iii) both also demand local finiteness of that closed refinement. | ✅ `LocallyFinite F` appears in both. |
| 8 | Item (ii) demands star-finiteness, item (iii) only star-countability. | ✅ `IsStarFiniteFamily F` in (ii), `IsStarCountableFamily F` in (iii). |
| 9 | Item (iv) asks for a star-countable **open** refinement, with no local finiteness. | ✅ `starCountableOpen := … IsOpenCover V ∧ Refines V U ∧ IsStarCountableFamily V`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Assuming `[RegularSpace X]` alone, without $T_1$. | The equivalence becomes false. For the two-point indiscrete space, which is `RegularSpace` in mathlib, the only open cover is essentially $\{X\}$, so (ii), (iii) and (iv) hold trivially, while (i) fails because `IsStronglyParacompact` demands `T2Space X`. |
| 2 | Defining star-finite as "each point lies in only finitely many members". | That is point-finiteness, strictly weaker. A family can be point-finite while some member meets infinitely many others. |
| 3 | Defining star-finite as "the family itself is finite". | Strictly stronger, and it would make items (i)–(iii) fail on ordinary spaces such as $\mathbb{R}$. |
| 4 | Making items (ii) and (iii) ask for open refinements instead of closed ones. | The open/closed alternation is the content of the theorem; with everything open, item (ii) would just restate item (i). |
| 5 | Dropping `LocallyFinite` from items (ii) and (iii). | Weakens both items; the equivalence chain runs through local finiteness of the closed refinements. |
| 6 | Requiring only that each member of the refinement be a closed subset of a member of $U$, without requiring the refinement to cover $X$. | The empty family then satisfies the condition, so the item says nothing. |
| 7 | Requiring the refinement to be indexed by the original index type $\iota$. | That is a *precise* refinement, a different and stronger statement than the one Engelking makes. |
| 8 | Moving regularity into one of the equivalent conditions instead of the hypotheses. | Engelking states regularity as a standing assumption on $X$; folding it into an item changes which implications have to be proved. |

## Notes on the ground truth

- Mathlib has no strong paracompactness, star-finiteness or star-countability, so those definitions
  are hand-rolled in `Defs.lean`. `LocallyFinite`, `IsOpen`, `IsClosed` and `List.TFAE` are the
  correct mathlib pieces, and `List.TFAE` is the idiomatic way to package a four-way equivalence.
- The `T2Space` conjunct inside `IsStronglyParacompact` is redundant given `[RegularSpace X]` and
  `[T1Space X]`, but it keeps the definition faithful when it is reused elsewhere.
- A candidate writing `[T3Space X]` in place of `[RegularSpace X] [T1Space X]` is equally faithful.
- ⚠️ `IsStarFiniteFamily` and `IsStarCountableFamily` count *indices*, not distinct sets, so a family
  that lists the same set twice is judged more harshly. For the existentially produced refinements in
  items (i)–(iv) this is harmless — re-index injectively — and it is the stronger reading.
- ⚠️ All cover index types live in a single free universe `v` (and `IsStronglyParacompact` binds its
  own, separately). Fixing everything at `Type u` — every cover can be re-indexed by a subfamily of
  `Set X` — would make the four items line up exactly.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[engelking_5_3_10_strong_paracompactness.md](engelking_5_3_10_strong_paracompactness.md) and the background in [engelking_5_3_10_strong_paracompactness.context.md](engelking_5_3_10_strong_paracompactness.context.md),
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

- Requirement 8 with star-finite and star-countable interchanged between items (ii) and (iii).
- Requirement 9 with local finiteness added to item (iv), or the refinement in (iv) taken closed rather than open.
- Requirement 6 with the closed refinements of (ii)–(iii) not required to cover $X$.

### Domain-specific pitfalls for this problem

- Star-finiteness is a condition on the family's own index set — each member meets only finitely many members — and is independent of local finiteness.
- Items (ii) and (iii) ask for *closed* refinements, item (iv) for an *open* one; the theorem's content is that these coincide.
- Engelking's "regular" bundles $T_1$, and his "strongly paracompact" bundles Hausdorff.
- Refinement is containment in the correct direction, and the refining families must be covers.
