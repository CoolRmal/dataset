# Criteria: conway_VI_2_1_banach_stone

**Statement:** [conway_VI_2_1_banach_stone.md](conway_VI_2_1_banach_stone.md) · **Lean:** [conway_VI_2_1_banach_stone.lean](conway_VI_2_1_banach_stone.lean) · **Context:** [conway_VI_2_1_banach_stone.context.md](conway_VI_2_1_banach_stone.context.md)

## What the theorem says

Let $X$ and $Y$ be compact Hausdorff spaces and let $T$ be a linear map from $C(X)$ onto $C(Y)$ that
preserves the sup norm. Then $T$ has a completely explicit form: there is a homeomorphism
$\tau : Y \to X$ and a continuous function $\alpha$ on $Y$ whose values all have modulus $1$, such
that $(Tf)(y) = \alpha(y)\,f(\tau(y))$ for every $f$ and every $y$. In particular $X$ and $Y$ are
homeomorphic.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $X$ and $Y$ are compact. | ✅ `[CompactSpace X] [CompactSpace Y]`. |
| 2 | $X$ and $Y$ are Hausdorff. Conway's "compact" includes this. | ✅ `[T2Space X] [T2Space Y]`. |
| 3 | $T$ is linear over $\mathbb{C}$ and preserves norms. | ✅ `T : (X →ᵇ ℂ) →ₗᵢ[ℂ] (Y →ᵇ ℂ)`, a bundled linear isometry. |
| 4 | $T$ is onto. | ✅ `hT : Function.Surjective T`. |
| 5 | The conclusion produces a homeomorphism from $Y$ to $X$ — that direction, so that $f \circ \tau$ makes sense. | ✅ `∃ τ : Y ≃ₜ X`, and the identity is written `T f y = α y * f (τ y)`. |
| 6 | It also produces a continuous $\alpha$ on $Y$. | ✅ `∃ α : Y →ᵇ ℂ`, in the same existential as `τ`. |
| 7 | Every value of $\alpha$ has modulus exactly $1$. | ✅ `∀ y : Y, ‖α y‖ = 1`. |
| 8 | The identity $(Tf)(y) = \alpha(y) f(\tau(y))$ holds for **all** $f$ in $C(X)$ and **all** $y$ in $Y$. | ✅ `∀ f : X →ᵇ ℂ, ∀ y : Y, T f y = α y * f (τ y)`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Reading "compact" as `CompactSpace` alone and omitting `T2Space`. | Without separation, $C(X)$ does not separate the points of $X$, so no homeomorphism can be recovered. A non-$T_0$ space has the same $C(X)$ as its Kolmogorov quotient but is not homeomorphic to it, and the conclusion is then false. |
| 2 | Taking `T` to be an unbundled map with `Isometry T` and no linearity. | A distance-preserving map between normed spaces need only be affine (Mazur–Ulam), not linear. The theorem is about linear isometries. |
| 3 | Omitting surjectivity. | An isometric embedding $C(X) \hookrightarrow C(Y)$ need not be a weighted composition operator — think of restricting to a proper closed subset of $Y$. Surjectivity is what forces $X$ and $Y$ to be homeomorphic. |
| 4 | Declaring `τ : X ≃ₜ Y` and writing `f (τ y)`. | That does not typecheck; and "fixing" it by transposing the equation states a different identity than the one printed. The map must go $Y \to X$. |
| 5 | Writing `‖α‖ = 1` instead of `∀ y, ‖α y‖ = 1`. | The sup norm of $\alpha$ being $1$ allows $\alpha$ to vanish at some points, and then $T$ would not be injective. The condition is pointwise. |
| 6 | Asserting the identity only for $f$ in a dense subset, or quantifying $y$ outside the identity. | The printed conclusion is a pointwise identity holding for every $f$ and every $y$; anything less is a weaker statement. |
| 7 | Splitting the conclusion into separate existence claims for $\tau$ and for $\alpha$. | The theorem produces both at once and relates them through one equation. Separate claims do not say that. |

## Notes on the ground truth

- $C(X)$ is modelled as `X →ᵇ ℂ`. For compact $X$ these are the same functions with the same norm,
  and the bounded-continuous type carries the normed structure the statement needs.
- `Y ≃ₜ X` (`Homeomorph`) bundles continuity in both directions, exactly Conway's "homeomorphism". A
  candidate offering `τ : Y → X` with `Continuous τ ∧ Function.Bijective τ` states something
  formally weaker — no continuity of the inverse — although for compact Hausdorff spaces it is
  equivalent. Acceptable but less direct.
- The transcribed VI.2.1 asserts existence of $(\tau, \alpha)$ only. Uniqueness does hold, but
  writing `∃!` would go beyond the text; the ground truth stays with plain existence.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[conway_VI_2_1_banach_stone.md](conway_VI_2_1_banach_stone.md) and the background in [conway_VI_2_1_banach_stone.context.md](conway_VI_2_1_banach_stone.context.md),
not against the ground-truth Lean file: a candidate spelled differently but
mathematically equivalent to the text loses nothing. The scale is defined in
[GRADING.md](../../GRADING.md); the numbers below are this problem's instance of it.

| Band | Points | This problem |
|---|---|---|
| A. Completeness | 50 | The requirement table above has 8 rows, so each row is worth 6.2 points: full credit if the candidate states it in any equivalent form, half for a harmless strengthening or weakening, none if it is absent. |
| B. Semantic fidelity | 20 | Junk values, `ℝ` vs `ℝ≥0∞`, coercions, quantifier order, a.e. vs everywhere — see the pitfalls below. |
| C. Mathlib-concept correctness | 15 | The Mathlib notion must mean the textbook notion, with the typeclass assumptions it needs. |
| D. Non-degeneracy | 10 | Not vacuous, not trivial, not a strictly weaker theorem. |
| E. Hygiene | 5 | No needless definitions, redundant conjuncts or unused hypotheses. |

**Every row of the *Mistakes to check for* table above is a defect.** Charge each one to the band it belongs to and deduct there.

### Fatal — any of these caps the total at 25

- Requirement 5 with $\tau$ oriented $X \to Y$: the representation formula no longer typechecks as the theorem's.
- Requirement 3 strengthened by assuming $T$ multiplicative (an algebra isomorphism): that makes the theorem elementary.
- Requirement 7 weakened to $\lVert\alpha\rVert \le 1$ or to $\alpha$ nonvanishing.

### Domain-specific pitfalls for this problem

- $T$ is assumed only linear, norm-preserving and onto. Assuming it is an algebra homomorphism or order-preserving is a different, much easier theorem.
- For compact $X$, `C(X)` and the bounded continuous functions `X →ᵇ ℂ` agree; on a non-compact space they do not, so the compactness hypotheses carry weight.
- Hausdorffness is part of Conway's "compact" and must be stated explicitly.
- $\alpha$ has modulus exactly $1$ at *every* point, and the representation formula is asserted for all $f$ and all $y$.
