# Criteria: conway_II_7_6_compact_normal_spectral_theorem

**Statement:** [conway_II_7_6_compact_normal_spectral_theorem.md](conway_II_7_6_compact_normal_spectral_theorem.md) · **Lean:** [conway_II_7_6_compact_normal_spectral_theorem.lean](conway_II_7_6_compact_normal_spectral_theorem.lean) · **Context:** [conway_II_7_6_compact_normal_spectral_theorem.context.md](conway_II_7_6_compact_normal_spectral_theorem.context.md)

## What the theorem says

Let $T$ be a compact normal operator on a complex Hilbert space. Then $T$ has at most countably
many distinct eigenvalues. List the distinct nonzero ones as $\lambda_1, \lambda_2, \dots$ and let
$P_n$ be the orthogonal projection onto the eigenspace $\ker(T - \lambda_n)$. These projections
annihilate each other: $P_nP_m = 0$ when $n \ne m$. And $T$ is the sum $\sum_n \lambda_n P_n$, where
the series converges in the operator norm — not merely one vector at a time.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. In the assessment column, ✅ means the ground truth states the requirement and
◐ means it states it in a form that deliberately departs from the text — a narrower setting, a
stronger hypothesis, or an equivalent but not literal phrasing — with the reason given. A ◐ records
a decision, not an open defect; where a more literal rendering would be at least as good, the row
says so.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The space is a complex Hilbert space: normed group, inner product over $\mathbb{C}$, complete. | ✅ `[NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]`. |
| 2 | $T$ is normal, and that is the only algebraic hypothesis — no self-adjointness, no separability, no finite dimension. | ✅ `hnormal : IsStarNormal T`, Mathlib's predicate for $T^*T = TT^*$. |
| 3 | $T$ is compact. | ✅ `hcompact : IsCompactOperator T`. |
| 4 | The eigenvalues come in a countable family. | ✅ `∃ (ι : Type) (_ : Countable ι) (eigenvalue : ι → ℂ) …`. |
| 5 | The listed eigenvalues are nonzero and distinct. | ✅ `(∀ i, eigenvalue i ≠ 0)` and `Function.Injective eigenvalue`. |
| 6 | Each $P_i$ is an *orthogonal* projection — idempotent **and** self-adjoint. | ✅ `∀ i, IsOrthogonalProjection (projection i)`, which `Defs.lean` sets equal to Mathlib's `IsStarProjection`. |
| 7 | The range of $P_i$ is exactly the eigenspace $\ker(T - \lambda_i)$, not just contained in it. | ✅ `LinearMap.range (projection i).toLinearMap = LinearMap.ker (T - eigenvalue i • ContinuousLinearMap.id ℂ H).toLinearMap`. |
| 8 | No $P_i$ is the zero operator. | ✅ `∀ i, projection i ≠ 0`. Together with row 7 this forces each $\lambda_i$ to be a genuine eigenvalue: if $P_i$ could be $0$ the range condition would say $\ker(T-\lambda_i) = 0$, and the family could list numbers that are not eigenvalues at all. |
| 9 | $P_iP_j = 0$ whenever $i \ne j$, for both orders of the product. | ✅ `Pairwise (fun i j ↦ (projection i).comp (projection j) = 0)`, which unfolds to `∀ i j, i ≠ j → …` over ordered pairs and so covers $P_iP_j$ and $P_jP_i$. |
| 10 | $T = \sum_i \lambda_i P_i$, with the series converging in the operator norm of $\mathcal{B}(\mathcal{H})$. | ✅ `HasSum (fun i ↦ eigenvalue i • projection i) T`, stated at the operator level, so the topology is the norm topology of `H →L[ℂ] H`. This is unconditional summability, which is true here because the tail is bounded by $\sup_{i \notin F}\lvert \lambda_i\rvert$. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Assuming `IsSelfAdjoint T` instead of normality. | Self-adjoint operators have real spectrum, and the theorem becomes the much easier real case. Conway's hypothesis is normality. |
| 2 | Saying only that each $P_i$ is idempotent. | An idempotent that is not self-adjoint is an oblique projection. The book says "the projection of $\mathcal{H}$ onto $\ker(T-\lambda_n)$", which in a Hilbert space means the orthogonal one. |
| 3 | Requiring only `range Pᵢ ⊆ ker (T - λᵢ)`. | Then $P_i$ could project onto a proper piece of the eigenspace, and the sum would not reconstruct $T$. |
| 4 | Dropping `projection i ≠ 0`. | The family could then list arbitrary non-eigenvalues with $P_i = 0$ attached, and the statement would say much less than the theorem. |
| 5 | Replacing $P_iP_j = 0$ by disjointness of the ranges in the submodule lattice. | Lattice `Disjoint` only says the ranges meet in $0$. For projections, $P_iP_j = 0$ says the ranges are *orthogonal*, which is strictly stronger. |
| 6 | Writing the sum pointwise: `∀ x, HasSum (fun i ↦ eigenvalue i • projection i x) (T x)`. | That is convergence in the strong operator topology. The text says "converges in the metric defined by the norm on $\mathcal{B}(\mathcal{H})$", which is strictly stronger. |
| 7 | Indexing by `ℕ` with no way for the family to be finite or empty. | $T = 0$ has no nonzero eigenvalues, and a finite-rank normal $T$ has finitely many. An arbitrary countable index type covers all three shapes. |

## Notes on the ground truth

- The first sentence of the book ("$T$ has only a countable number of distinct eigenvalues") is
  captured only indirectly, by the index type carrying `Countable ι`. That the listed family
  exhausts the nonzero eigenvalues does follow from the sum together with rows 7-9, but it is never
  asserted. An explicit conjunct such as `∀ λ ≠ 0, (∃ x ≠ 0, T x = λ • x) → λ ∈ Set.range eigenvalue`
  would state that sentence directly. This is an honest gap: acceptable, improvable.
- The clause `∀ ε : ℝ, 0 < ε → {i : ι | ε ≤ ‖eigenvalue i‖}.Finite` is an extra conclusion not in the
  transcribed II.7.6. It is true, and in fact follows from the rest, so it only strengthens an
  existence statement. A candidate that omits it should not be penalized.
- Normality is written out as an equation on adjoints rather than as `IsStarNormal T`. The two are
  the same statement; the equation is just less idiomatic.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[conway_II_7_6_compact_normal_spectral_theorem.md](conway_II_7_6_compact_normal_spectral_theorem.md) and the background in [conway_II_7_6_compact_normal_spectral_theorem.context.md](conway_II_7_6_compact_normal_spectral_theorem.context.md),
not against the ground-truth Lean file: a candidate spelled differently but
mathematically equivalent to the text loses nothing. The scale is defined in
[GRADING.md](../../GRADING.md); the numbers below are this problem's instance of it.

| Band | Points | This problem |
|---|---|---|
| A. Completeness | 50 | The requirement table above has 10 rows, so each row is worth 5.0 points: full credit if the candidate states it in any equivalent form, half for a harmless strengthening or weakening, none if it is absent. |
| B. Semantic fidelity | 20 | Junk values, `ℝ` vs `ℝ≥0∞`, coercions, quantifier order, a.e. vs everywhere — see the pitfalls below. |
| C. Mathlib-concept correctness | 15 | The Mathlib notion must mean the textbook notion, with the typeclass assumptions it needs. |
| D. Non-degeneracy | 10 | Not vacuous, not trivial, not a strictly weaker theorem. |
| E. Hygiene | 5 | No needless definitions, redundant conjuncts or unused hypotheses. |

**Every row of the *Mistakes to check for* table above is a defect.** Charge each one to the band it belongs to and deduct there.

### Fatal — any of these caps the total at 25

- Requirement 6 weakened to "idempotent": an oblique projection onto the same eigenspace does not satisfy the theorem.
- Requirement 7 weakened to an inclusion rather than equality of the range with the eigenspace.
- Requirement 10 with convergence in the strong or weak topology instead of the operator norm.

### Domain-specific pitfalls for this problem

- An orthogonal projection is idempotent *and* self-adjoint (`IsStarProjection`); `P ∘ P = P` alone is a strictly weaker condition.
- Normality is $T^*T = TT^*$; substituting self-adjointness states a special case with real eigenvalues.
- The listed eigenvalues must be nonzero and pairwise distinct, and each projection nonzero, or the enumeration can be padded with junk.
- Convergence "in the metric of $\mathcal{B}(\mathcal{H})$" is operator-norm convergence; `HasSum` in the operator-norm topology is the right notion and is order-independent.
- Countability of the index type is part of the conclusion, not an assumption on $\mathcal{H}$.
