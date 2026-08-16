# Criteria: engelking_5_2_8_normal_product_interval

**Statement:** [engelking_5_2_8_normal_product_interval.md](engelking_5_2_8_normal_product_interval.md) · **Lean:** [engelking_5_2_8_normal_product_interval.lean](engelking_5_2_8_normal_product_interval.lean) · **Context:** [engelking_5_2_8_normal_product_interval.context.md](engelking_5_2_8_normal_product_interval.context.md)

## What the theorem says

This is Dowker's theorem. Call a space *countably paracompact* if it is Hausdorff and every cover of
it by countably many open sets has a locally finite open refinement — a new open cover, each of whose
members lies inside a member of the old one, such that every point has a neighbourhood meeting only
finitely many new members. The theorem says a space $X$ is both normal and countably paracompact
exactly when the product $X \times I$ is normal, where $I = [0,1]$ is the closed unit interval. Both
directions are asserted.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. In the assessment column, ✅ means the ground truth states the requirement and
◐ means it states it in a form that deliberately departs from the text — a narrower setting, a
stronger hypothesis, or an equivalent but not literal phrasing — with the reason given. A ◐ records
a decision, not an open defect; where a more literal rendering would be at least as good, the row
says so.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The statement is a biconditional, with the conjunction on the left and normality of the product on the right. | ✅ `(NormalSpace X ∧ IsCountablyParacompact X) ↔ NormalSpace (X × Set.Icc (0 : ℝ) 1)`. |
| 2 | Both properties of $X$ sit inside the biconditional, not among the hypotheses. | ✅ `NormalSpace X` and `IsCountablyParacompact X` are conjuncts, not instance binders. |
| 3 | The $T_1$ axiom is present, since Engelking's "normal" includes it while mathlib's `NormalSpace` does not. | ✅ `[T1Space X]` as an instance hypothesis. |
| 4 | Countable paracompactness carries Engelking's Hausdorff conjunct. | ✅ `IsCountablyParacompact X := T2Space X ∧ …`. |
| 5 | It restricts to **countable** open covers. | ✅ `∀ (ι : Type v) (_ : Countable ι) (U : ι → Set X), IsOpenCover U → …`. |
| 6 | The refinement it produces is again an open cover of $X$ — open members and union everything. | ✅ `IsOpenCover V`, where `IsOpenCover V := (∀ i, IsOpen (V i)) ∧ ⋃ i, V i = univ`. |
| 7 | The refinement relation runs in the right direction: every new member sits inside some old member. | ✅ `Refines V U := ∀ j, ∃ i, V j ⊆ U i`, applied as `Refines V U` with `V` the new family. |
| 8 | The refinement is locally finite. | ✅ `LocallyFinite V`. |
| 9 | The second factor is the closed unit interval as a space, and the product has the product topology. | ✅ `X × Set.Icc (0 : ℝ) 1`, using the subtype coercion; mathlib's `unitInterval` is an abbreviation for exactly `Set.Icc (0 : ℝ) 1`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Dropping the $T_1$ (or $T_2$) hypothesis on $X$ and stating the bare mathlib biconditional. | The `←` direction becomes false. For the two-point indiscrete space $X$, the closed sets of $X \times I$ are exactly the sets $X \times C$ with $C$ closed in $I$, so $X \times I$ is normal, yet $X$ is not Hausdorff and hence not countably paracompact. |
| 2 | Promoting `NormalSpace X` to an instance binder and stating `IsCountablyParacompact X ↔ NormalSpace (X × I)`. | Strictly weaker: the `←` direction no longer has to recover normality of $X$ from normality of the product, which is part of Engelking's assertion. |
| 3 | Reversing the refinement quantifiers to `∀ i, ∃ j, V j ⊆ U i`. | A different and much weaker condition — it only asks that each old member contain some new member, allowing new members that stick out of the cover entirely. This is the classic quantifier slip in covering statements. |
| 4 | Dropping openness of the refinement, or dropping the requirement that it still covers $X$. | Either one gives a strictly weaker notion of countable paracompactness. Without the covering requirement the empty family works and the condition says nothing. |
| 5 | Allowing arbitrary (uncountable) open covers in the definition. | That is full paracompactness, a strictly stronger property, so the biconditional would be a different — and false — statement. |
| 6 | Replacing $I$ by $\mathbb{R}$. | Normality of $X \times \mathbb{R}$ is not what Dowker's theorem characterizes; compactness of the interval factor is used. |
| 7 | Writing `NormalSpace (Set.Icc (0 : ℝ) 1)` as a statement about a *set* rather than the subtype. | `NormalSpace` takes a type. Applying it to a `Set ℝ` without the coercion is a type error, and papering over it changes what is being claimed. |

## Notes on the ground truth

- Mathlib has neither countable paracompactness nor Dowker's theorem, so `IsCountablyParacompact` in
  `Defs.lean` is written from scratch and must be read literally.
- The `T2Space X` conjunct inside `IsCountablyParacompact` is not redundant on its own, but under the
  ambient `[T1Space X]` together with `NormalSpace X` it follows anyway (normal + $T_1$ implies
  Hausdorff). Keeping it makes the definition faithful when reused elsewhere.
- Every index type quantified in the statement lives in `X`'s own universe. That costs no
  generality — a cover of `X` can always be re-indexed by its image in `Set X` — and it removes
  the free universe parameter, so the statement is about all covers rather than about covers in
  one arbitrary universe. The generic family predicates in `Defs.lean` stay polymorphic in their
  index type, as they should.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[engelking_5_2_8_normal_product_interval.md](engelking_5_2_8_normal_product_interval.md) and the background in [engelking_5_2_8_normal_product_interval.context.md](engelking_5_2_8_normal_product_interval.context.md),
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

- Requirement 5 with the cover restriction to countable families dropped, which turns countable paracompactness into paracompactness.
- Requirement 1 stated as a single implication.
- Requirement 3 with Engelking's $T_1$ clause dropped from "normal".

### Domain-specific pitfalls for this problem

- Countable paracompactness restricts to *countable* open covers; without that it is paracompactness and the equivalence is false.
- Engelking's "normal" is normal plus $T_1$, and his "countably paracompact" carries Hausdorff.
- The second factor is the closed unit interval as a topological space, with the subspace topology from $\mathbb{R}$.
- Both properties of $X$ belong inside the biconditional, not among the hypotheses.
