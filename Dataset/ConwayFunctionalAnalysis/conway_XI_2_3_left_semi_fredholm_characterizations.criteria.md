# Criteria: conway_XI_2_3_left_semi_fredholm_characterizations

**Statement:** [conway_XI_2_3_left_semi_fredholm_characterizations.md](conway_XI_2_3_left_semi_fredholm_characterizations.md) · **Lean:** [conway_XI_2_3_left_semi_fredholm_characterizations.lean](conway_XI_2_3_left_semi_fredholm_characterizations.lean) · **Context:** [conway_XI_2_3_left_semi_fredholm_characterizations.context.md](conway_XI_2_3_left_semi_fredholm_characterizations.context.md)

## What the theorem says

Let $A$ be a bounded operator between two complex Hilbert spaces. Call $A$ *left semi-Fredholm* if it
can be inverted on the left up to a compact error: some bounded $B$ satisfies $BA = 1 + C$ with $C$
compact. The theorem lists eight conditions and says they all amount to the same thing: left
semi-Fredholmness; that the range is closed and the kernel is finite dimensional; the same left
inversion with a finite-rank error instead of a compact one; the non-existence of a sequence of unit
vectors going weakly to zero on which $A$ goes to zero in norm; the non-existence of an orthonormal
sequence on which $A$ goes to zero in norm; the existence of a $\delta > 0$ for which the set where
$\lVert Ah\rVert \le \delta\lVert h\rVert$ contains no infinite-dimensional subspace; a condition on
the spectral measure of the positive operator $(A^*A)^{1/2}$ near $0$; and finite-dimensionality of
$\ker(A + K)$ for every compact $K$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The setting: $A$ is a bounded operator between two complex Hilbert spaces, both complete. | ✅ `(A : H →L[ℂ] K)` with `[NormedAddCommGroup H] [NormedAddCommGroup K] [InnerProductSpace ℂ H] [InnerProductSpace ℂ K] [CompleteSpace H] [CompleteSpace K]`. |
| 2 | Item (a): a left inverse up to a compact error, with the composite $BA$ (not $AB$) and the error acting on the *domain* $\mathcal{H}$. | ✅ `IsLeftSemiFredholm A`, defined in `Defs.lean` as `∃ B : K →L[ℂ] H, ∃ C : H →L[ℂ] H, IsCompactOperator C ∧ B.comp A = ContinuousLinearMap.id ℂ H + C`. |
| 3 | Item (b): the range of $A$ is closed **and** its kernel is finite dimensional — both halves. | ✅ `IsClosed (range A) ∧ FiniteDimensional ℂ (LinearMap.ker A.toLinearMap)`. |
| 4 | Item (c): the same left inversion but with a **finite rank** error $F$ on $\mathcal{H}$. | ✅ `∃ B : K →L[ℂ] H, ∃ F : H →L[ℂ] H, FiniteDimensional ℂ (LinearMap.range F.toLinearMap) ∧ B.comp A = ContinuousLinearMap.id ℂ H + F`. |
| 5 | Item (d): there is **no** sequence of vectors of norm exactly $1$ that tends to $0$ weakly and along which $\lVert Ah_n\rVert \to 0$. | ✅ `¬∃ u : ℕ → H, (∀ n, ‖u n‖ = 1) ∧ Tendsto (fun n ↦ toWeakSpace ℂ H (u n)) atTop (𝓝 0) ∧ Tendsto (fun n ↦ ‖A (u n)‖) atTop (𝓝 0)`. |
| 6 | Item (e): there is **no** orthonormal sequence along which $\lVert Ae_n\rVert \to 0$. | ✅ `¬∃ u : ℕ → H, Orthonormal ℂ u ∧ Tendsto (fun n ↦ ‖A (u n)‖) atTop (𝓝 0)`. |
| 7 | Item (f): some $\delta > 0$ makes every linear subspace on which $\lVert Ax\rVert \le \delta\lVert x\rVert$ finite dimensional, where "manifold" means a linear subspace that need not be closed. | ✅ `∃ δ : ℝ, 0 < δ ∧ ∀ M : Submodule ℂ H, (∀ x : M, ‖A x‖ ≤ δ * ‖(x : H)‖) → FiniteDimensional ℂ M`, over bare `Submodule`s. |
| 8 | Item (g): the positive square root $(A^*A)^{1/2}$ is pinned down, it has a spectral measure $E$, and some $\delta > 0$ makes $E[0,\delta]\mathcal{H}$ finite dimensional. | ✅ `∃ modulus : H →L[ℂ] H, modulus.comp modulus = A.adjoint.comp A ∧ modulus.adjoint = modulus ∧ (∀ x : H, 0 ≤ (inner ℂ (modulus x) x).re) ∧ ∃ E : ProjectionValuedMeasure H, …`, ending with `∃ δ : ℝ, 0 < δ ∧ FiniteDimensional ℂ (LinearMap.range (E.toFun (Metric.closedBall (0 : ℂ) δ)).toLinearMap)`. The three conditions on `modulus` characterize the *unique* positive square root, so `∃ modulus` really names $(A^*A)^{1/2}$. |
| 9 | Inside (g), the spectral measure is anchored to the spectrum, and the scalar measures $\langle E(\cdot)x,y\rangle$ are fixed on **every** measurable set. | ✅ `E.toFun (spectrum ℂ modulus) = ContinuousLinearMap.id ℂ H`, and `∀ x y : H, ∀ B : Set ℂ, MeasurableSet B → scalarMeasure x y B = inner ℂ (E.toFun B x) y`, with `inner ℂ (modulus x) y = ∫ᵛ z, z ∂[…]`. |
| 10 | Item (h): for every compact perturbation $K$, $\ker(A+K)$ is finite dimensional. | ✅ `∀ C : H →L[ℂ] K, IsCompactOperator C → FiniteDimensional ℂ (LinearMap.ker (A + C).toLinearMap)`. |
| 11 | All eight items are collected into one equivalence, in the book's order. | ✅ `List.TFAE [a, b, c, d, e, f, g, h]`, each item `let`-bound. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Omitting item (g), or merging (d) with (e), so the list has six or seven entries. | The theorem is an eight-way equivalence. A shorter list is incomplete, and (g) is precisely the item that is hardest to encode and therefore most often quietly dropped. |
| 2 | Writing (a) as `A.comp B = id + C`, or typing the compact error as `C : K →L[ℂ] K`. | That is *right* semi-Fredholmness, a genuinely different class of operators (it is about the cokernel, not the kernel). The composite must be $BA$ with the error on $\mathcal{H}$. |
| 3 | Restricting item (f) to closed subspaces (`M.topologicalClosure = M`, or `ClosedSubmodule`). | Conway says "manifold", meaning a linear subspace with no closure requirement. Quantifying over fewer subspaces makes the item easier to satisfy, and it is then no longer equivalent to (a)-(e). |
| 4 | Pinning the scalar measures in (g) only on the sets one cares about, leaving them otherwise free. | Mathlib's vector-measure integral `∫ᵛ` returns $0$ when the integrand is not integrable (`VectorMeasure.integral_undef`). With the measures underdetermined, a candidate could satisfy the spectral identity by choosing a measure that makes $z$ non-integrable, so the item would hold for free. |
| 5 | Stating (d) or (e) as positive statements by dropping the leading negation. | The book's items say no such sequence exists. Removing the `¬` asserts the opposite of the intended condition. |
| 6 | Writing `‖u n‖ ≤ 1` in (d). | "Unit vectors" means norm exactly $1$. With `≤ 1` the constant zero sequence qualifies and item (d) becomes false for every $A$. |
| 7 | Keeping only one half of item (b) — closed range, or finite-dimensional kernel. | Each half alone is strictly weaker; for instance a bounded injective operator with dense non-closed range has finite-dimensional (zero) kernel but is not semi-Fredholm. |
| 8 | Reusing the un-conjugated spectral identity of (g) for an operator with non-real spectrum. | Mathlib's inner product is conjugate-linear in its **first** argument, so `inner ℂ (T x) y = ∫ᵛ z, z ∂[…]` literally says $T = \int \bar z\,dE$. That is harmless here because $E$ sits on $\sigma(\text{modulus}) \subseteq [0,\infty)$ where $\bar z = z$, but it is fatal in general — compare `conway_IX_2_2_bounded_normal_spectral_theorem`. |

## Notes on the ground truth

- Mathlib has no projection-valued-measure API, so item (g) uses the hand-rolled
  `ProjectionValuedMeasure` from `Defs.lean` and reads the spectral integral weakly, against the
  complex scalar measures $\langle E(\cdot)x,y\rangle$. The `nonmeasurable` field of that structure
  forces $E(B) = 0$ off the Borel sets, which is what makes the object well determined.
- The junk value of `∫ᵛ` cannot bite in (g) as written: the scalar measures are concentrated on the
  compact set `spectrum ℂ modulus`, so $z \mapsto z$ is genuinely integrable.
- $E[0,\delta]$ becomes `E.toFun (Metric.closedBall (0 : ℂ) δ)`, a disc in $\mathbb{C}$. This is
  legitimate because the anchoring condition forces $E$ to sit on $\sigma(\text{modulus}) \subseteq
  [0,\infty)$, where the disc meets the support exactly in the interval $[0,\delta]$.
- ⚠️ `H →L[ℂ] H` *is* a `CStarAlgebra` in Mathlib, so `CFC.sqrt (A⋆ * A)` from the continuous
  functional calculus would name the modulus directly instead of characterizing it by three
  equations. Similarly `modulus.adjoint = modulus` would read better as `IsSelfAdjoint modulus`, and
  `∀ x, 0 ≤ (inner ℂ (modulus x) x).re` as `modulus.IsPositive`.
- Item (h) types the compact perturbation as `H →L[ℂ] K` so that `A + C` is well formed. Conway
  writes "$K \in \mathcal{B}_0(\mathcal{H})$", which is loose; the Lean tightens it to the only
  reading that makes sense.
- Everything else is reused from Mathlib rather than hand-rolled: `IsCompactOperator`,
  `Orthonormal ℂ`, `ContinuousLinearMap.adjoint`, `toWeakSpace ℂ H`, `Submodule`,
  `FiniteDimensional`.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[conway_XI_2_3_left_semi_fredholm_characterizations.md](conway_XI_2_3_left_semi_fredholm_characterizations.md) and the background in [conway_XI_2_3_left_semi_fredholm_characterizations.context.md](conway_XI_2_3_left_semi_fredholm_characterizations.context.md),
not against the ground-truth Lean file: a candidate spelled differently but
mathematically equivalent to the text loses nothing. The scale is defined in
[GRADING.md](../../GRADING.md); the numbers below are this problem's instance of it.

| Band | Points | This problem |
|---|---|---|
| A. Completeness | 50 | The requirement table above has 11 rows, so each row is worth 4.5 points: full credit if the candidate states it in any equivalent form, half for a harmless strengthening or weakening, none if it is absent. |
| B. Semantic fidelity | 20 | Junk values, `ℝ` vs `ℝ≥0∞`, coercions, quantifier order, a.e. vs everywhere — see the pitfalls below. |
| C. Mathlib-concept correctness | 15 | The Mathlib notion must mean the textbook notion, with the typeclass assumptions it needs. |
| D. Non-degeneracy | 10 | Not vacuous, not trivial, not a strictly weaker theorem. |
| E. Hygiene | 5 | No needless definitions, redundant conjuncts or unused hypotheses. |

**Every row of the *Mistakes to check for* table above is a defect.** Charge each one to the band it belongs to and deduct there.

### Fatal — any of these caps the total at 25

- Requirement 11 with any of the eight items omitted, or stated as implications rather than one equivalence.
- Requirement 2 with $AB$ in place of $BA$, or with the error placed on the codomain space.
- Requirement 3 with only one of "closed range" and "finite dimensional kernel".

### Domain-specific pitfalls for this problem

- "Manifold" in (f) means linear subspace; reading it geometrically produces a different statement.
- Weak convergence in (d) must be taken in the weak topology (`WeakSpace`), and the vectors have norm exactly $1$.
- (d) and (e) are *negative* statements — the assertion is that no such sequence exists; dropping a negation inverts the condition.
- Compact and finite-rank errors are different in (a) and (c); that the two give the same class is part of the theorem.
- In (g) the operator is the positive square root of $A^*A$, characterised by being positive with square $A^*A$; the spectral projection is that of the interval $[0,\delta]$, and finite-dimensionality is of its *range*.
