# Criteria: conway_X_5_6_stone_theorem

**Statement:** [conway_X_5_6_stone_theorem.md](conway_X_5_6_stone_theorem.md) · **Lean:** [conway_X_5_6_stone_theorem.lean](conway_X_5_6_stone_theorem.lean) · **Context:** [conway_X_5_6_stone_theorem.context.md](conway_X_5_6_stone_theorem.context.md)

## What the theorem says

A one-parameter unitary group is a family $U(t)$ of unitary operators, indexed by the reals, with
$U(0) = 1$ and $U(s+t) = U(s)U(t)$; it is strongly continuous when $t \mapsto U(t)x$ is continuous
for each vector $x$. Stone's theorem says every such family has a generator: a self-adjoint
operator $A$, generally unbounded and defined only on a dense subspace, with
$U(t) = \exp(itA)$ for all $t$. Since $A$ is unbounded, $\exp(itA)$ has to be read through the
spectral resolution of $A$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The space is a complex Hilbert space. | ✅ `[NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]`. |
| 2 | The hypothesis is all four parts of "strongly continuous one-parameter unitary group": $U(0) = 1$, $U(s+t) = U(s)U(t)$, each $U(t)$ unitary, and $t \mapsto U(t)x$ continuous for each $x$. | ✅ `StronglyContinuousUnitaryGroup U` in `Defs.lean` lists exactly those four conditions. |
| 3 | Unitarity means both $U^*U = 1$ and $UU^* = 1$. | ✅ `IsUnitaryOperator` in `Defs.lean`: `U.adjoint.comp U = id ∧ U.comp U.adjoint = id`. |
| 4 | The generator is an unbounded operator: it carries its own domain, a subspace of $\mathcal{H}$, and is linear on that domain. | ✅ `DenselyDefinedOperator H` bundles `domain : Submodule ℂ H` and `op : domain →ₗ[ℂ] H`. |
| 5 | That domain is dense. | ✅ `dense_domain : Dense (domain : Set H)` is a field of the structure, so it cannot be forgotten. |
| 6 | The generator is *self-adjoint*, which for an unbounded operator is two conditions: the domain of $A^*$ equals the domain of $A$, and $A^*y = Ay$ there. | ✅ `IsSelfAdjointUnbounded A`: the first clause is `∀ y : H, y ∈ A.domain ↔ ∃ z : H, ∀ x : A.domain, inner ℂ (A.op x) y = inner ℂ (x : H) z`, the second is the identification of that $z$ with `A.op y`. |
| 7 | $\exp(itA)$ is given a meaning through a spectral measure for $A$, which must be supported on the reals. | ✅ `IsSpectralExponential A U` supplies `E : ProjectionValuedMeasure H` with `E.toFun {z : ℂ \| z.im ≠ 0} = 0`. |
| 8 | Within that, the scalar measures $\langle E(\cdot)x,y\rangle$ are pinned on **every** measurable set, $A$ is recovered by integrating $z$, and $U(t)$ by integrating $e^{itz}$. | ✅ `scalarMeasure x y B = inner ℂ (E.toFun B x) y` for all measurable `B`; `∀ x : A.domain, ∀ y : H, inner ℂ (A.op x) y = ∫ᵛ z, z ∂[…]`; `∀ t : ℝ, ∀ x y : H, inner ℂ (U t x) y = ∫ᵛ z, Complex.exp (Complex.I * t * z) ∂[…]`. |
| 9 | The identity defining $A$ is asserted only for $x$ in the domain of $A$. | ✅ `∀ x : A.domain`. Outside the domain the integrand need not be integrable, and Lean's `∫ᵛ` would then return $0$, making the identity hold for a bad reason. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Typing the generator as a bounded operator `H →L[ℂ] H`. | Then the theorem is false: translation on $L^2(\mathbb{R})$ is a strongly continuous unitary group whose generator $-i\,d/dx$ is unbounded. |
| 2 | Replacing strong continuity by norm continuity (`Continuous U` into the operator-norm topology). | Norm continuity forces the generator to be bounded, by a classical theorem. The statement would then be a triviality about a much smaller class of groups. |
| 3 | Asserting only symmetry, `∀ x y ∈ dom A, ⟪Ax, y⟫ = ⟪x, Ay⟫`, in place of self-adjointness. | Symmetry is strictly weaker: symmetric operators that are not self-adjoint exist and do not exponentiate to unitary groups. The clause about the domain of $A^*$ is the one candidates drop. |
| 4 | Omitting density of the domain. | Without a dense domain the adjoint is not well defined, so "self-adjoint" has no meaning and the statement says nothing. |
| 5 | Writing `U t = NormedSpace.exp ℂ (Complex.I * t • A)`. | This only typechecks for a bounded `A`, so it silently smuggles in Mistake 1. For unbounded $A$ the exponential exists only through the spectral measure. |
| 6 | Dropping the support condition `E.toFun {z \| z.im ≠ 0} = 0`. | The spectral measure of a self-adjoint operator lives on the reals, and that is what keeps $\lVert e^{itz}\rVert = 1$ so the exponential integrand is integrable. Without it the second identity could be satisfied by the junk value $0$ of `∫ᵛ`. |
| 7 | Quantifying the identity `inner ℂ (A.op x) y = ∫ᵛ z, z ∂[…]` over all `x : H` rather than over the domain. | For $x$ outside the domain the integrand $z$ need not be integrable against $E_{x,y}$, and `∫ᵛ` returns $0$ there, so part of the identity would be satisfied for free. |

## Notes on the ground truth

- The unbounded operator is hand-rolled as `DenselyDefinedOperator` with `IsSelfAdjointUnbounded`
  rather than through `LinearPMap`. The two say the same thing; carrying the domain and the two
  adjoint conditions explicitly keeps the statement readable without unfolding library definitions.
- Mathlib's inner product is conjugate-linear in its **first** argument, which is why the spectral
  integrand carries a conjugation; getting this backwards states the theorem for $N^*$ and, together
  with the support condition, is unsatisfiable whenever $\sigma(N)$ is not conjugation-symmetric.
- The statement asserts `∃!`. Uniqueness of the generator is a true part of Stone's theorem and
  `∃!` over `DenselyDefinedOperator H` means equality of both domain and map, so this is a
  strengthening; a candidate stating plain `∃` matches the text and is equally acceptable.
- `IsUnitaryOperator U` is `U ∈ unitary (H →L[ℂ] H)`, Mathlib's predicate, which unfolds to the
  same pair of adjoint identities.
- The projection-valued measure is hand-rolled in `Defs.lean` because Mathlib has none.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[conway_X_5_6_stone_theorem.md](conway_X_5_6_stone_theorem.md) and the background in [conway_X_5_6_stone_theorem.context.md](conway_X_5_6_stone_theorem.context.md),
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

- Requirement 4 with a *bounded* generator: the theorem is then false, since most one-parameter unitary groups have unbounded generators.
- Requirement 6 weakened to symmetry instead of self-adjointness of the unbounded operator.
- Requirement 5 with the domain not required dense, so that the generator is not determined.
- Requirement 2 with norm continuity substituted for strong continuity.

### Domain-specific pitfalls for this problem

- Unitarity is *both* $U^*U = 1$ and $UU^* = 1$; on an infinite dimensional space the first alone only says $U$ is an isometry.
- Strong continuity is continuity of $t \mapsto U(t)x$ for each $x$, not of $t \mapsto U(t)$ in operator norm.
- An unbounded operator carries its domain as part of its data, and every identity involving it may only be asserted for vectors in that domain.
- $\exp(itA)$ has to be given a meaning by a spectral measure supported on $\mathbb{R}$; a power series or a `Real.exp`-style definition does not typecheck for unbounded $A$.
- The scalar measures $\langle E(\cdot)x,y\rangle$ must be pinned on every measurable set for the integral identities to determine anything.
