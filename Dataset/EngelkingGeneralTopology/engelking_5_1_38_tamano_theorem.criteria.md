# Criteria: engelking_5_1_38_tamano_theorem

**Statement:** [engelking_5_1_38_tamano_theorem.md](engelking_5_1_38_tamano_theorem.md) · **Lean:** [engelking_5_1_38_tamano_theorem.lean](engelking_5_1_38_tamano_theorem.lean)

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
row is incomplete.

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

- ⚠️ `IsCompact (univ : Set K)` is equivalent to `CompactSpace K`; the latter is the idiomatic
  spelling but cannot be produced as an instance for a bound `tK`, so the `Prop`-level form is a
  reasonable choice here.
- ⚠️ Inside items (ii) and (iv), `NormalSpace` is applied with an explicit `@` and a hand-written
  product topology while the neighbouring `T1Space (X × K)` is written without `@`, relying on `tK`
  being picked up as a local instance. The two spellings agree definitionally, but the inconsistency
  is fragile; `letI := tK`, or instance-implicit binders, would be cleaner.
- ⚠️ Items (ii) and (iv) quantify compactifications over `K : Type v` for a free universe `v`, while
  item (iii) supplies `StoneCech X : Type u`. When `v ≠ u`, the implication (iii) $\Rightarrow$ (iv)
  cannot be witnessed by $\beta X$, so the four items are only genuinely comparable at `v = u`.
  Using `K : Type u` would make the equivalence literally correct at every instantiation.
- The two `let` bindings in the goal are only there to keep the `List.TFAE` line readable; they do
  not change the statement.
