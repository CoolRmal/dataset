# Criteria: engelking_3_11_16_hewitt_realcompactification

**Statement:** [engelking_3_11_16_hewitt_realcompactification.md](engelking_3_11_16_hewitt_realcompactification.md) · **Lean:** [engelking_3_11_16_hewitt_realcompactification.lean](engelking_3_11_16_hewitt_realcompactification.lean) · **Context:** [engelking_3_11_16_hewitt_realcompactification.context.md](engelking_3_11_16_hewitt_realcompactification.context.md)

## What the theorem says

Call a space *realcompact* if it is Tychonoff and cannot be enlarged: there is no strictly bigger
Tychonoff space in which it sits densely and to which every continuous real-valued function on it
extends. The theorem says every Tychonoff space $X$ has a realcompact "hull" $\nu X$, called the
Hewitt realcompactification. It contains a dense homeomorphic copy of $X$, every continuous
$f \colon X \to \mathbb{R}$ extends to it, and more generally every continuous map from $X$ into any
realcompact space extends to it. And $\nu X$ is the only such space: any other realcompact space
containing $X$ densely with the real-extension property is homeomorphic to $\nu X$ by a
homeomorphism that matches up the two copies of $X$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $X$ is Tychonoff, meaning completely regular **and** $T_1$ — this is Engelking's convention. | ✅ `[T35Space X]`, which is mathlib's `T0Space` + `CompletelyRegularSpace`, exactly Tychonoff. |
| 2 | "Realcompact" is defined negatively: a Tychonoff space with no strictly larger Tychonoff space that contains it densely and takes all its real-valued continuous functions. | ✅ `IsRealcompact` in `Defs.lean` is `T35Space X ∧ ¬∃ Y tY, T35Space Y ∧ ∃ r, IsEmbedding r ∧ …`. |
| 3 | Inside that definition, the enlargement must be **strictly** larger: the copy of $X$ is not already closed in it. | ✅ `range r ≠ closure (range r)`. |
| 4 | Inside that definition, the enlargement must also be **dense**. | ✅ `closure (range r) = univ`. |
| 5 | One single existential produces the space $\nu X$ and the map $\nu \colon X \to \nu X$, and everything else is asserted about that one pair. | ✅ `∃ (Y : Type u) (tY : TopologicalSpace Y) (ν : X → Y), …` with all clauses conjoined under it. |
| 6 | $\nu X$ is realcompact, and $\nu$ is a homeomorphic embedding with dense image. | ✅ `IsRealcompact Y ∧ IsEmbedding ν ∧ closure (range ν) = univ`. |
| 7 | Property (ii): every continuous $f \colon X \to \mathbb{R}$ has a continuous extension $g$ on $\nu X$ with $g \circ \nu = f$. | ✅ `∀ f : X → ℝ, Continuous f → ∃ g : Y → ℝ, Continuous g ∧ g ∘ ν = f`. |
| 8 | Property (iii): every continuous map from $X$ into **any** realcompact space $Z$ extends to $\nu X$. | ✅ `∀ Z tZ, IsRealcompact Z → ∀ f, Continuous f → ∃ g, Continuous g ∧ g ∘ ν = f`. |
| 9 | Uniqueness is rigid: any realcompact $Z$ with a dense embedding $\zeta$ and property (ii) admits a homeomorphism $h \colon \nu X \to Z$ with $h \circ \nu = \zeta$. | ✅ `∃ h : Homeomorph Y Z, h ∘ ν = ζ`, with $Z$ assumed only realcompact, densely embedded, and (ii). |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Defining realcompactness with only the density clause, dropping `range r ≠ closure (range r)`. | Then $r = \mathrm{id}$ is always an "enlargement" that is dense and extends every $f$, so no space at all would be realcompact and the theorem could never be proved. |
| 2 | Using `CompletelyRegularSpace X` or `RegularSpace X` instead of `T35Space X`. | Mathlib's `CompletelyRegularSpace` holds for indiscrete spaces. A $T_0$ space cannot be embedded in one, so the existence claim breaks. Engelking's "Tychonoff" includes $T_1$. |
| 3 | Dropping property (iii), the extension of maps into arbitrary realcompact targets. | Engelking states it as a property of the same $\nu X$. It is the strongest of the three clauses and is the one most often left out. |
| 4 | Stating uniqueness as `Nonempty (Y ≃ₜ Z)` with no compatibility condition. | Strictly weaker: it forgets that the two embedded copies of $X$ must correspond. Two inequivalent extensions can be homeomorphic as bare spaces. |
| 5 | Assuming property (iii) of $Z$ in the uniqueness clause. | Uniqueness is supposed to follow from (i) and (ii) alone. Adding (iii) as a hypothesis makes the clause much cheaper to prove. |
| 6 | Instantiating the existential with `StoneCech X`, or asserting that $\nu X$ is compact. | $\nu X$ is the Hewitt realcompactification, not $\beta X$. They differ: $\mathbb{N}$ is already realcompact, so $\nu\mathbb{N} = \mathbb{N} \neq \beta\mathbb{N}$. |
| 7 | Omitting `T35Space` from the hypothetical enlargement inside the definition of realcompactness. | Engelking quantifies over Tychonoff enlargements only. Allowing arbitrary spaces makes the negated existential much harder to satisfy, so fewer spaces count as realcompact. |

## Notes on the ground truth

- Mathlib has no realcompactness and no Hewitt realcompactification, so `IsRealcompact` is written
  from scratch in `Defs.lean` and must be read literally. Everything around it reuses mathlib:
  `Topology.IsEmbedding`, `Homeomorph`, `Continuous`.
- `closure (range ν) = univ` is `DenseRange ν` written out. `DenseRange ν` is more idiomatic and a
  candidate using it is equally correct.
- Because `tY : TopologicalSpace Y` is bound as an ordinary variable rather than an instance, the
  statement is full of `@…tY…` applications. `letI` or instance-implicit binders would read better.
- Every index type quantified in the statement lives in `X`'s own universe. That costs no
  generality — a cover of `X` can always be re-indexed by its image in `Set X` — and it removes
  the free universe parameter, so the statement is about all covers rather than about covers in
  one arbitrary universe. The generic family predicates in `Defs.lean` stay polymorphic in their
  index type, as they should.
- Uniqueness of the extension $f^{\nu}$ is not asserted. It follows from density anyway, and
  Engelking does not assert it either, so nothing is lost.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[engelking_3_11_16_hewitt_realcompactification.md](engelking_3_11_16_hewitt_realcompactification.md) and the background in [engelking_3_11_16_hewitt_realcompactification.context.md](engelking_3_11_16_hewitt_realcompactification.context.md),
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

- Requirement 3 or 4: dropping strictness or density from the negative clause in the definition of realcompactness, which makes the definition trivial or unsatisfiable.
- Requirement 9 with uniqueness stated as a bare homeomorphism, not one commuting with the embeddings.
- Requirement 1: Tychonoff read as completely regular without $T_1$.

### Domain-specific pitfalls for this problem

- Engelking's "Tychonoff" is completely regular *plus* $T_1$; Mathlib's `T35Space` is the matching class.
- The quantifier "there is no Tychonoff space $\tilde X$" ranges over spaces, so in a formal statement its universe has to be fixed explicitly; a bump to the next universe is the honest reading and should not be penalised.
- Extension means composition on the correct side: $f^\nu \circ \nu = f$, not $\nu \circ f^\nu = f$.
- Density is `closure (range ν) = univ`, and embedding is `IsEmbedding` (a homeomorphism onto the image), not merely injectivity plus continuity.
- Uniqueness "up to homeomorphism" is uniqueness in the category of spaces-under-$X$: the homeomorphism must intertwine the two embeddings.
