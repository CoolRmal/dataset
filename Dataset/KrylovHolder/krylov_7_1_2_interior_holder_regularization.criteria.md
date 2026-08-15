# Criteria: krylov_7_1_2_interior_holder_regularization

**Statement:** [krylov_7_1_2_interior_holder_regularization.md](krylov_7_1_2_interior_holder_regularization.md) · **Lean:** [krylov_7_1_2_interior_holder_regularization.lean](krylov_7_1_2_interior_holder_regularization.lean) · **Context:** [krylov_7_1_2_interior_holder_regularization.context.md](krylov_7_1_2_interior_holder_regularization.context.md)

## What the theorem says

Let $L$ be a uniformly elliptic operator of order $m$ with Hölder coefficients, and let $u$ be a
function on a domain $\Omega$ that already has $m+\delta$ derivatives there. If the shifted
expression $L_\lambda u = Lu - \lambda u$ turns out to be $k+\delta$ times differentiable, then $u$
picks up $k$ extra derivatives: it is $C^{k+m+\delta}$. The word that matters is *interior* — the
gain holds on compact pieces of $\Omega$ and may degenerate as one approaches the boundary. No
constants and no restriction on $\lambda$ enter.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $0 < \delta < 1$, with $k \ge 0$ and $m$ integers. | ✅ `hδ : 0 < δ ∧ δ < 1`, `k m : ℕ`. |
| 2 | $\Omega$ is open. | ✅ `hΩ : IsOpen Ω`, which is what makes the derivatives inside `multiDerivative` genuine. |
| 3 | $L$ is a uniformly elliptic operator of order $m$, given by coefficients times derivatives. | ✅ `hL : VariableCoefficientEllipticOperator m L`, supplying `order_le`, `formula`, `principalSymbol` and a positive ellipticity constant. |
| 4 | The coefficients are $C^{k+\delta}$ — the same $k$ as the datum. | ✅ `hcoeff : OperatorCoefficientsHolder m (k + δ) L`. |
| 5 | $u$ is $C^{m+\delta}$ on the domain, as genuine membership rather than a finite gauge alone. | ✅ `hu : HolderLocallyOn (m + δ) Ω u`; each `HolderOn` carries a `ContDiffOn` clause next to the finite gauge. |
| 6 | The equation is imposed only inside $\Omega$, where $u$ is known. | ✅ `hLu : ShiftedEllipticEquationOn Ω L lam u f`, i.e. `∀ x ∈ Ω, L u x - lam * u x = f x`. |
| 7 | The right-hand side is $C^{k+\delta}$ on the domain. | ✅ `hf : HolderLocallyOn (k + δ) Ω f`. |
| 8 | $\lambda$ is arbitrary: no threshold, no sign condition. | ✅ `{lam : ℝ}` is an unconstrained implicit variable. Regularity does not depend on invertibility of $L_\lambda$. |
| 9 | The conclusion is interior: $u$ is $C^{k+m+\delta}$ on every compact subset of $\Omega$, not with a single finite norm over $\Omega$. | ✅ `HolderLocallyOn (k + m + δ) Ω u`, which unfolds to `∀ K, IsCompact K → K ⊆ Ω → HolderOn (k+m+δ) K u`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Concluding a single finite Hölder gauge over all of $\Omega$. | That is false. Take $d = 2$, $m = 2$, $k = 1$, $\delta = 1/2$, $\Omega$ the unit disc, $L = \Delta$, $\lambda = 0$, and $u = \operatorname{Re}\bigl((1-z)^{5/2}\bigr)$ with $z = x_1 + ix_2$ (principal branch). Then $u$ is harmonic, its derivatives through order $2$ are bounded on $\Omega$ and $D^2u \sim c(1-z)^{1/2}$ is $\tfrac12$-Hölder there, so the hypotheses hold with $f = 0$; but $D^3u \sim c(1-z)^{-1/2}$ is unbounded on $\Omega$, so the uniform gauge is infinite. |
| 2 | Imposing the equation on all of $\mathbb{R}^d$ rather than on $\Omega$. | Outside $\Omega$ nothing is known about $u$, and `multiDerivative` may be returning junk zeros there. The statement is still satisfiable, but it is a stronger hypothesis and hence a weaker theorem than the text's. |
| 3 | Importing a threshold or a sign condition on $\lambda$ from the solvability theorems of chapters 3–4. | The text says "for some $\lambda$", with no restriction. Adding one narrows the theorem for no reason. |
| 4 | Bolting a Schauder estimate with a constant onto the conclusion. | The text asserts membership only. An estimate would need the constant to be quantified before $u$ and, taken over $\Omega$ rather than over compact subsets, would be false for the same reason as mistake 1. |
| 5 | Concluding $C^{k+\delta}$ or $C^{m+\delta}$. | Those are the hypotheses. The point of the theorem is the gain to $k+m+\delta$. |
| 6 | Using a second Hölder exponent somewhere instead of the same $\delta$ throughout. | The bookkeeping is exact: $m+\delta$ in, $k+\delta$ for the right-hand side, $k+m+\delta$ out, all with one $\delta$. |
| 7 | Encoding the memberships as gauge finiteness only. | `multiDerivative` is built from `fderiv`, which is $0$ off the differentiability locus, so a bounded nowhere-differentiable function would satisfy a finiteness-only hypothesis and the conclusion would be false. |

## Notes on the ground truth

- `hL` and `hcoeff` are global: `principalSymbol` quantifies over all $x \in \mathbb{R}^d$, and `OperatorCoefficientsHolder` asks for Hölder regularity on `univ`. The text only needs these inside $\Omega$. Assuming more only restricts the theorem, so it stays sound.
- `HolderLocallyOn` quantifies over all compact $K \subseteq \Omega$. Its `HolderOn` clause pairs a `ContDiffOn ℝ k' u K` smoothness condition (built on `fderivWithin K`) with a gauge built on the global `fderiv`. Since $\Omega$ is open and $K$ ranges over closed balls inside it, this still pins down the classical derivatives, but the mismatch is worth noting.
- `holderGauge` hand-rolls the top-order difference quotient where mathlib's `HolderOnWith`/`eHolderNorm` would serve, and uses `multiDerivative` (repeated directional `fderiv` along a fixed list of coordinates) instead of `iteratedFDeriv`. Both are sound on open sets — mixed partials of a $C^k$ function commute, so the arbitrary order chosen by `multiIndexDirections` is harmless — but they are further from mathlib's API than necessary.
- `holderGauge` takes a maximum where Krylov's norm takes a sum; equivalent up to a factor depending on $d$ and $k$, and invisible in a statement with no constants.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[krylov_7_1_2_interior_holder_regularization.md](krylov_7_1_2_interior_holder_regularization.md) and the background in [krylov_7_1_2_interior_holder_regularization.context.md](krylov_7_1_2_interior_holder_regularization.context.md),
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

- Requirement 9 with the conclusion stated as a global Hölder bound up to $\partial\Omega$.
- Requirement 8 with a threshold or sign condition imposed on $\lambda$.
- Requirement 6 with the equation imposed outside $\Omega$, where $u$ is unknown.

### Domain-specific pitfalls for this problem

- "Interior" is the whole point: regularity on compact subsets, no claim at the boundary.
- No condition on $\lambda$ is needed or assumed here.
- Hölder membership on an open set means local finiteness of the norms; a single global gauge would be a different condition.
- The coefficients' regularity is the same $k+\delta$ as the datum's.
