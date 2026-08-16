# Criteria: conway_VIII_5_17_gelfand_naimark

**Statement:** [conway_VIII_5_17_gelfand_naimark.md](conway_VIII_5_17_gelfand_naimark.md) · **Lean:** [conway_VIII_5_17_gelfand_naimark.lean](conway_VIII_5_17_gelfand_naimark.lean) · **Context:** [conway_VIII_5_17_gelfand_naimark.context.md](conway_VIII_5_17_gelfand_naimark.context.md)

## What the theorem says

Every $C^*$-algebra can be realised concretely as an algebra of bounded operators. Given a
$C^*$-algebra $\mathcal{A}$, there is a Hilbert space $\mathcal{H}$ and a map
$\pi : \mathcal{A} \to \mathcal{B}(\mathcal{H})$ that preserves addition, multiplication, scalar
multiples and the star operation, and that preserves norms exactly. A second sentence adds: if
$\mathcal{A}$ is separable, then $\mathcal{H}$ may be taken separable too.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $\mathcal{A}$ is a $C^*$-algebra, with no extra assumptions in the first sentence. | ✅ `{A : Type u} [NonUnitalCStarAlgebra A]`, which covers unital and non-unital algebras alike. |
| 2 | A Hilbert space is produced: normed group, inner product over $\mathbb{C}$, **and** complete. | ✅ `∃ (H : Type u) (_ : NormedAddCommGroup H) (_ : InnerProductSpace ℂ H) (_ : CompleteSpace H)`, all existentially bound. |
| 3 | $\pi$ is a $*$-homomorphism into $\mathcal{B}(\mathcal{H})$: linear over $\mathbb{C}$, multiplicative, and satisfying $\pi(a^*) = \pi(a)^*$. | ✅ `π : A →⋆ₙₐ[ℂ] (H →L[ℂ] H)`, Mathlib's non-unital star algebra homomorphism, which bundles all of these. |
| 4 | $\pi$ is an isometry. | ✅ `Isometry π`, matching the text word for word. For a linear map this is the same as `∀ a, ‖π a‖ = ‖a‖`. |
| 5 | The second sentence is formalized at all: separability of $\mathcal{A}$ implies a separable $\mathcal{H}$ can be found. | ✅ The second conjunct, `TopologicalSpace.SeparableSpace A → ∃ (H : Type u) …`. |
| 6 | In the second sentence, $\mathcal{H}$ and $\pi$ are quantified afresh — the separable space need not be the one from the first sentence. | ✅ The second conjunct re-binds `H` and `π` from scratch, with `(_ : TopologicalSpace.SeparableSpace H)` added. |
| 7 | The Hilbert space lives in the same universe as $\mathcal{A}$. | ✅ `H : Type u` with `{A : Type u}`. This is what the GNS-plus-direct-sum construction actually delivers, and it is the stronger reading. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Using an ordinary algebra homomorphism `A →ₐ[ℂ] (H →L[ℂ] H)` instead of a star homomorphism. | A map that does not send $a^*$ to $\pi(a)^*$ is not a representation of a $C^*$-algebra. The statement would be about a different notion. |
| 2 | Omitting `CompleteSpace H`. | Then $\mathcal{H}$ is only a pre-Hilbert space — the GNS space before completion — and `H →L[ℂ] H` is not a $C^*$-algebra. Materially weaker. |
| 3 | Formalizing only the first sentence. | The separable half is part of the transcribed theorem. Dropping it is the most common omission here. |
| 4 | Replacing the second sentence by "if $\mathcal{A}$ is separable then $\mathcal{A}$ embeds in $\mathcal{B}(\ell^2)$". | True, but not what the text says; it also fixes the Hilbert space rather than asserting that a separable one can be chosen. |
| 5 | Making the separable Hilbert space an extra property of the single $\mathcal{H}$ from the first conjunct. | That asserts that *the* representation built first is separable, which is stronger than "can be chosen separable" and is not the printed claim. |
| 6 | Restricting to unital $C^*$-algebras (`[CStarAlgebra A]` with `A →⋆ₐ[ℂ] …`). | Conway's hypothesis is just "a $C^*$-algebra". The unital version proves a special case, so the formalization is narrower than the theorem. |
| 7 | Writing `∃ H : Type (u+1)`. | The construction lands in the same universe as $\mathcal{A}$; jumping a universe states something weaker than what is true and than what the ground truth asserts. |

## Notes on the ground truth

- Mathlib supplies the GNS construction for a single state (`CStarAlgebra.gnsStarAlgHom` and
  friends) but not the direct-sum assembly over all states, so this theorem is genuinely new content
  rather than a wrapper.
- The whole difficulty of the encoding is structural, not analytic: the Hilbert space is quantified
  over *types*, so the statement must say precisely what kind of type it is and in which universe.
- `Function.Injective π` would be a mathematically equivalent substitute for `Isometry π`, since an
  injective $*$-homomorphism of $C^*$-algebras is automatically isometric. It drifts from the
  wording of the text, but a candidate using it should not be penalized.
- Separability is `TopologicalSpace.SeparableSpace` — Mathlib's notion, a countable dense subset —
  applied both to `A` as a normed space and to `H`. `H →L[ℂ] H` is Mathlib's $\mathcal{B}(\mathcal{H})$
  and picks up its $C^*$-algebra structure automatically. Nothing here is hand-rolled.
- An earlier version of this file used the unital class `[CStarAlgebra A]` with `A →⋆ₐ[ℂ] …`. It has
  been widened to the non-unital class, which matches the generality of the printed statement.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[conway_VIII_5_17_gelfand_naimark.md](conway_VIII_5_17_gelfand_naimark.md) and the background in [conway_VIII_5_17_gelfand_naimark.context.md](conway_VIII_5_17_gelfand_naimark.context.md),
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

- Requirement 3 with $\pi$ merely linear or merely multiplicative: a $*$-homomorphism is all three conditions.
- Requirement 4 weakened to injectivity or to a norm bound $\lVert \pi a\rVert \le \lVert a\rVert$.
- Requirement 5 omitted: the separable refinement is part of the printed theorem.

### Domain-specific pitfalls for this problem

- "Hilbert space" includes completeness; producing an inner-product space that is not complete is not a representation.
- The isometry is of the *algebra norm*, so it is an equality $\lVert \pi a \rVert = \lVert a \rVert$, not a topological embedding.
- The separable case re-quantifies both $\mathcal{H}$ and $\pi$; asserting separability of the space produced by the first part is a different (and false) reading.
- Universe placement is a real constraint: an existential over `Type u` for an algebra in `Type u` is the GNS-strength statement, while quantifying over a larger universe weakens it.
