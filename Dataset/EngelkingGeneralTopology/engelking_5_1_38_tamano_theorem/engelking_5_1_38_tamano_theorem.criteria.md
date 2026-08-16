# Criteria: engelking_5_1_38_tamano_theorem

**Statement:** [engelking_5_1_38_tamano_theorem.md](engelking_5_1_38_tamano_theorem.md) · **Lean:** [engelking_5_1_38_tamano_theorem.lean](engelking_5_1_38_tamano_theorem.lean) · **Context:** [engelking_5_1_38_tamano_theorem.context.md](engelking_5_1_38_tamano_theorem.context.md)

## What the theorem says

A *compactification* of a space $X$ is a compact Hausdorff space containing a dense homeomorphic copy
of $X$. Tamano's theorem says that for a Tychonoff space $X$, being paracompact is the same as the
product $X \times cX$ being normal, for compactifications $cX$. Four conditions are equivalent:
$X$ is paracompact; $X \times cX$ is normal for **every** compactification; $X \times \beta X$ is
normal for the Čech–Stone compactification specifically; and $X \times cX$ is normal for **some**
compactification. The alternation between "every", "the particular one", and "some" is where the
content lies.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $X$ is Tychonoff (completely regular and $T_1$). | ✅ `[T35Space X]`, mathlib's `T0Space` + `CompletelyRegularSpace`. |
| 2 | All four items are present, in Engelking's order, as one equivalence. | ✅ `List.TFAE [ParacompactSpace X, everyCompactification, NormalSpace (X × StoneCech X) ∧ T1Space (X × StoneCech X), someCompactification]`. |
| 3 | Item (i) is paracompactness. Engelking's paracompactness includes Hausdorff, which the ambient `[T35Space X]` already supplies. | ✅ `ParacompactSpace X`; combined with `[T35Space X]` this is exactly Engelking's notion. |
| 4 | "Compactification" is a dense embedding into a compact **Hausdorff** space. | ✅ `IsCompactification e := IsEmbedding e ∧ DenseRange e ∧ IsCompact (univ : Set K) ∧ T2Space K`. |
| 5 | Item (ii) is universally quantified over compactifications. | ✅ `everyCompactification := ∀ K tK e, IsCompactification e → …`, with `→` after the hypothesis. |
| 6 | Item (iv) is existentially quantified over compactifications. | ✅ `someCompactification := ∃ K tK e, IsCompactification e ∧ …`, with `∧` after the hypothesis. |
| 7 | Item (iii) names the Čech–Stone compactification specifically. | ✅ `NormalSpace (X × StoneCech X)`; under `[T35Space X]`, `stoneCechUnit` is a dense embedding (`isEmbedding_stoneCechUnit`, `denseRange_stoneCechUnit`), so this really is $X \times \beta X$. |
| 8 | The product $X \times cX$ carries the **product** topology. | ✅ `@NormalSpace (X × K) (tX.induced Prod.fst ⊓ tK.induced Prod.snd)`, which is definitionally mathlib's `instTopologicalSpaceProd`. |
| 9 | Engelking's "normal" includes $T_1$, so the products must be $T_1$ as well as normal. | ✅ `T1Space (X × K)` is stated explicitly alongside `NormalSpace` in items (ii)–(iv), even though it follows from `[T35Space X]` and Hausdorffness of $K$. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Weakening `[T35Space X]` to `[RegularSpace X]` or `[CompletelyRegularSpace X]`. | Item (iii) breaks: without $T_0$, `stoneCechUnit` is no longer an embedding, so $X \times \beta X$ is not the product Engelking means. |
| 2 | Dropping `T2Space K` from the definition of a compactification. | It damages the theorem twice over. It enlarges the class quantified over in (ii), making (i) $\Rightarrow$ (ii) harder and plausibly false, and it enlarges the witnesses allowed in (iv), making (iv) $\Rightarrow$ (i) harder. |
| 3 | Collapsing items (ii) and (iv) into a single item, or keeping only (i) ⟺ (iii). | Discards the implication (iv) $\Rightarrow$ (i), which is the substance of Tamano's theorem: one normal product already forces paracompactness. |
| 4 | Swapping the quantifiers, making (ii) existential and (iv) universal. | Then (ii) follows trivially from (iii) and the equivalence loses all content. |
| 5 | Replacing $\beta X$ in item (iii) by the one-point compactification, or by an unspecified $K$. | The one-point compactification only exists as a Hausdorff space when $X$ is locally compact, and an unspecified $K$ just repeats item (iv). Item (iii) is sharp about which compactification is used. |
| 6 | Writing the product topology as `tX.induced Prod.fst ⊔ tK.induced Prod.snd`, or using the wrong projections. | `⊔` gives a strictly finer topology than the product, so the statement would be about a different space. |

## Notes on the ground truth

- Compactness of a compactification is `CompactSpace K`, the idiomatic class.
- Items (ii) and (iv) bring the bound topology into scope with `letI := tK`, so `IsCompactification`,
  `NormalSpace` and `T1Space` are all written uniformly, with the product carrying its canonical
  topology rather than a hand-written meet of induced topologies.
- Every index type quantified in the statement lives in `X`'s own universe. That costs no
  generality — a cover of `X` can always be re-indexed by its image in `Set X` — and it removes
  the free universe parameter, so the statement is about all covers rather than about covers in
  one arbitrary universe. The generic family predicates in `Defs.lean` stay polymorphic in their
  index type, as they should.
- The two `let` bindings in the goal are only there to keep the `List.TFAE` line readable; they do
  not change the statement.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[engelking_5_1_38_tamano_theorem.md](engelking_5_1_38_tamano_theorem.md) and the background in [engelking_5_1_38_tamano_theorem.context.md](engelking_5_1_38_tamano_theorem.context.md),
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

- Requirement 5 or 6 with the quantifier over compactifications changed: (ii) is universal and (iv) existential.
- Requirement 4 with "compactification" missing density or missing the Hausdorff condition.
- Requirement 9 with Engelking's $T_1$ clause dropped from "normal".

### Domain-specific pitfalls for this problem

- Engelking's "normal", "compact" and "paracompact" all carry separation axioms that Mathlib's classes do not.
- The product must carry the product topology; when the second factor's topology is a bound variable rather than an instance, the product topology has to be supplied explicitly.
- Item (iii) is about $\beta X$ specifically, not about an arbitrary compactification.
- A compactification is a dense *embedding*, not merely a continuous injection into a compact space.
