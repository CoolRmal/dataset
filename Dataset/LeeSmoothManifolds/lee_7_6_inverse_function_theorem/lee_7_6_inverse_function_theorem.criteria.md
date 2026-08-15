# Criteria: lee_7_6_inverse_function_theorem

**Statement:** [lee_7_6_inverse_function_theorem.md](lee_7_6_inverse_function_theorem.md) · **Lean:** [lee_7_6_inverse_function_theorem.lean](lee_7_6_inverse_function_theorem.lean) · **Context:** [lee_7_6_inverse_function_theorem.context.md](lee_7_6_inverse_function_theorem.context.md)

## What the theorem says

Take two open sets $U$ and $V$ in $\mathbb{R}^n$ and a smooth map $F$ from $U$ into $V$. Suppose the
derivative $DF(p)$ at one point $p$ of $U$ is an invertible linear map. Then $F$ is invertible near
$p$: there are connected open neighbourhoods $U_0$ of $p$ inside $U$ and $V_0$ of $F(p)$ inside $V$
such that $F$ carries $U_0$ onto $V_0$ one-to-one, and the inverse map is smooth too. This is a
purely local statement — $F$ itself need not be injective anywhere else.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The source and target live in the same dimension $n$, and both $U$ and $V$ are open. | ✅ `U V : Set (Fin n → ℝ)` with `hU : IsOpen U` and `hV : IsOpen V`. |
| 2 | $F$ maps $U$ into $V$. Without this, "$V_0 \subseteq V$" could never be delivered. | ✅ `hF.1 : MapsTo F U V`. |
| 3 | $F$ is $C^\infty$ on $U$. | ✅ `hF.2 : ContDiffOn ℝ ∞ F U`, with `∞` (not `⊤`) so the class really is $C^\infty$. |
| 4 | The base point lies in $U$. | ✅ `hp : p ∈ U`. |
| 5 | The derivative at $p$ is invertible. | ✅ `hD : Function.Bijective (fderiv ℝ F p)`. Since source and target have the same finite dimension, injective, surjective and bijective all agree; bijective is the form that still says the right thing if a candidate generalises to $m \ne n$. |
| 6 | The hypotheses must force $F$ to really be differentiable at $p$, so that `fderiv` is the actual derivative. | ✅ `hU`, `hp` and `hF.2` together do this: on an open set `fderivWithin` agrees with `fderiv`. |
| 7 | The conclusion produces an open, connected $U_0$ with $p \in U_0$ and $U_0 \subseteq U$. | ✅ `IsOpen U₀ ∧ IsConnected U₀ ∧ p ∈ U₀ ∧ U₀ ⊆ U`. `IsConnected` means nonempty and preconnected, which is the right reading of "connected neighbourhood". |
| 8 | The conclusion produces an open, connected $V_0$ with $F(p) \in V_0$ and $V_0 \subseteq V$. | ✅ The mirror clause `IsOpen V₀ ∧ IsConnected V₀ ∧ F p ∈ V₀ ∧ V₀ ⊆ V`. |
| 9 | The restriction of $F$ to $U_0$ is a diffeomorphism onto $V_0$: it maps $U_0$ into $V_0$, has a two-sided inverse on those sets, and both directions are smooth. | ✅ `∃ e : SmoothDiffeomorphismOn U₀ V₀`, which bundles `mapsTo`, `invMapsTo`, `leftInvOn`, `rightInvOn`, `smooth` and `smooth_inv`. |
| 10 | The diffeomorphism has to be $F$ itself, not some other map between the same two sets. | ✅ `e.toFun = F`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Stating `Bijective (fderiv ℝ F p)` but dropping `IsOpen U`, or giving smoothness only as `ContDiffWithinAt` on a set that is not open. | Lean defines `fderiv ℝ F p` to be the zero map when $F$ is not differentiable at $p$. Without the openness and smoothness hypotheses the assumption is a claim about that junk zero map, and for $n = 0$ the zero map is bijective, so the hypothesis can be met by a map with no derivative at all. |
| 2 | Concluding only `IsLocalHomeomorph F`, or "there is a $G$ with $G(F(x)) = x$ for $x \in U_0$". | A local homeomorphism says nothing about smoothness of the inverse, and a one-sided inverse is not a bijection. Both throw away the whole content of the theorem. |
| 3 | Dropping smoothness of the inverse and keeping only smoothness of $F$. | Then $x \mapsto x^3$ on $\mathbb{R}$ would qualify at $p = 0$, and its inverse is not differentiable there. The inverse being smooth is the point of the theorem. |
| 4 | Writing the smoothness class as `⊤` under `open scoped ContDiff`. | In current Mathlib that scoped `⊤ : WithTop ℕ∞` is `ω`, real-analytic. The result is a true but different theorem: an analytic hypothesis producing an analytic conclusion, not Lee 7.6. Our file previously had this and it was repaired to `∞`. |
| 5 | Omitting `MapsTo F U V` or `IsOpen V`. | Without `MapsTo` there is no reason $F(U_0)$ should sit inside $V$, so the conclusion `V₀ ⊆ V` is not obtainable. Without `IsOpen V` the ambient setting is not the one in the book. |
| 6 | Producing $U_0$ and $V_0$ without connectedness, or without the containments $U_0 \subseteq U$, $V_0 \subseteq V$. | Lee explicitly asks for connected neighbourhoods sitting inside the given sets; a weaker conclusion is not the printed theorem. |

## Notes on the ground truth

- `SmoothDiffeomorphismOn U₀ V₀` is our own structure in `Defs.lean`. It does not require $U_0$ or
  $V_0$ to be open — openness is supplied separately by the `IsOpen U₀` and `IsOpen V₀` conjuncts.
- Mathlib already has `ContDiffAt.toOpenPartialHomeomorph`, which packages a local smooth inverse.
  Our hand-rolled structure duplicates `OpenPartialHomeomorph` plus two-sided smoothness. Using
  Mathlib's bundle instead — `∃ e : OpenPartialHomeomorph …, e.source = U₀ ∧ e.target = V₀ ∧
  EqOn e F U₀ ∧ ContDiffOn ℝ ∞ e U₀ ∧ ContDiffOn ℝ ∞ e.symm V₀` — would reuse existing API and be
  harder to satisfy in a degenerate way. Our version is defensible because Lee restricts a *given*
  total function rather than producing an abstract diffeomorphism.
- The model space is `Fin n → ℝ` (sup norm) rather than `EuclideanSpace ℝ (Fin n)`. Nothing in this
  statement mentions distances, so the two are interchangeable here.
- The smoothness class was originally written `⊤` and has been repaired to `∞`; mistake row 4 is
  kept as a regression check.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[lee_7_6_inverse_function_theorem.md](lee_7_6_inverse_function_theorem.md) and the background in [lee_7_6_inverse_function_theorem.context.md](lee_7_6_inverse_function_theorem.context.md),
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

- Requirement 9 with a smooth bijection in place of a diffeomorphism (no smooth inverse).
- Requirement 10 with the diffeomorphism not identified with $F$.
- Requirement 5 with the derivative condition stated for an operator that is not known to be the genuine derivative.

### Domain-specific pitfalls for this problem

- Junk value — `fderiv`: without $C^\infty$ (or at least differentiability at $p$), `fderiv` is a default and the nonsingularity hypothesis says nothing.
- Both neighbourhoods are required connected, and each is contained in the corresponding given open set.
- The inverse must be smooth, not merely continuous.
- $F$ must map $U$ into $V$ for the conclusion $V_0 \subseteq V$ to be available.
