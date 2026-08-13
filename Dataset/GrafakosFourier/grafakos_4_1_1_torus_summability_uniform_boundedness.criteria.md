# Criteria: grafakos_4_1_1_torus_summability_uniform_boundedness

**Statement:** [grafakos_4_1_1_torus_summability_uniform_boundedness.md](grafakos_4_1_1_torus_summability_uniform_boundedness.md) · **Lean:** [grafakos_4_1_1_torus_summability_uniform_boundedness.lean](grafakos_4_1_1_torus_summability_uniform_boundedness.lean)

## What the theorem says

Fix a family of complex multipliers $a(m,R)$, indexed by lattice points $m$ and a parameter $R > 0$,
such that for each $R$ only finitely many $m$ give a nonzero value, the whole family is uniformly
bounded, and $a(m,R)$ tends to a limit $a_m$ as $R \to \infty$. These define operators $S_R$ on
$L^p(\mathbb{T}^n)$ by multiplying the Fourier coefficients of $f$ by $a(m,R)$ — a finite sum, so no
convergence question arises. The theorem says: $S_R f$ converges in $L^p$ for every $f \in L^p$ if
and only if the operators $S_R$ are bounded on $L^p$ by one constant $K$ that does not depend on
$R$. When that happens, the limit multiplier operator $A$ obeys the same bound $K$, extends to all of
$L^p$, and $S_R f$ converges to it in $L^p$ for every $f$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | Condition (i): for each $R > 0$, $a(m,R)$ vanishes for all but finitely many $m$. | ✅ `hfinite : ∀ R, 0 < R → (Function.support (a R)).Finite`, which is the same as "$a(m,R) = 0$ once $\lvert m\rvert > q_R$". |
| 2 | Condition (ii): one bound $M_0$ works for all $m$ and all $R > 0$. | ✅ `hbounded : ∃ M : ℝ, 0 ≤ M ∧ ∀ R m, 0 < R → ‖a R m‖ ≤ M`. |
| 3 | Condition (iii): for each fixed $m$, $a(m,R)$ tends to $a_m$ as $R \to \infty$. | ✅ `htendsto : ∀ m, Tendsto (fun R ↦ a R m) atTop (𝓝 (aLimit m))`, with `R : ℝ` and `atTop` meaning $R \to \infty$. |
| 4 | The torus is $\mathbb{R}^n/\mathbb{Z}^n$ with normalized measure, the characters are $e^{2\pi i m\cdot x}$, and the Fourier coefficient integrates against the conjugate character. | ✅ `Fin n → AddCircle (1 : ℝ)` with `volume`, which has total mass $1$ on each factor, so the product is a probability measure. `torusCharacter m x = ∏ i, fourier (m i) (x i)` is $e^{2\pi i m\cdot x}$, and `torusFourierCoefficient μ f m = ∫ x, star (torusCharacter m x) * f x ∂μ`. |
| 5 | The exponent range $1 \le p < \infty$. | ✅ `{p : ℝ} (hp : 1 ≤ p)`; being a real number, `p` is automatically finite. |
| 6 | $S_R f$ is the multiplier series $\sum_m a(m,R)\widehat f(m)e^{2\pi i m\cdot x}$. | ✅ `let S := fun R f x ↦ ∑' m, a R m * torusFourierCoefficient μ f m * torusCharacter m x`; condition (i) makes the family finitely supported, so this `tsum` is a finite sum. |
| 7 | The left half of the biconditional is "$S_R f$ converges in $L^p$" — to *some* limit, not to a named operator. | ✅ `∀ f, MemLp f (ENNReal.ofReal p) μ → ∃ g, MemLp g (ENNReal.ofReal p) μ ∧ Tendsto (fun R ↦ eLpNorm (S R f - g) (ENNReal.ofReal p) μ) atTop (𝓝 0)`. |
| 8 | The right half is one finite constant valid for all $R$ — the existential must sit outside the quantifier over $R$. | ✅ `∃ C : ℝ≥0∞, C < ∞ ∧ ∀ R, 0 < R → HasStrongType μ μ (S R) (ENNReal.ofReal p) (ENNReal.ofReal p) C`. |
| 9 | The "furthermore" clause, for the *same* constant: a limit operator $A$ bounded on $L^p$ by that constant, agreeing with the limit multiplier series where that series converges, and reached by $S_R f$ in $L^p$ for every $f \in L^p$. | ⚠️ `∀ C, (∀ R, 0 < R → HasStrongType μ μ (S R) … C) → ∃ A, HasStrongType μ μ A … C ∧ (∀ h, MemLp h … → Summable (fun m ↦ fun x ↦ aLimit m * torusFourierCoefficient μ h m * torusCharacter m x) → A h = formalLimit h) ∧ ∀ f, MemLp f … → Tendsto (fun R ↦ eLpNorm (S R f - A f) … ) atTop (𝓝 0)`. The text ties $A$ to $C^\infty(\mathbb{T}^n)$, where the series always converges; the Lean version ties it instead to those $h$ whose series is summable. Weaker, but sound. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Defining $A$ by the formula `fun f x ↦ ∑' m, aLimit m * f̂ m * e(m·x)` and then using it on all of $L^p$ — in particular naming it as the limit inside the biconditional. | For $f \in L^p$ whose Fourier coefficients are not absolutely summable, the family is not summable, so Lean's `tsum` gives `A f x = 0` at every $x$. Concrete failure: $n=1$, $p=2$, $a(m,R) = \mathbf{1}_{\lvert m\rvert\le R}$, so $a_m = 1$. The uniform-bound side holds with $C = 1$, because the Dirichlet projections are $L^2$ contractions; but for $f$ with coefficients in $\ell^2\setminus\ell^1$ one gets $A f = 0$ while $\|S_R f\|_2 \to \|f\|_2 \ne 0$, so the convergence side fails and the biconditional is false. An earlier version of the ground truth had exactly this defect. |
| 2 | Naming the limit as $A f$ inside the biconditional even after $A$ is repaired. | The text's left-hand side is bare convergence, to an unnamed limit. Identifying the limit with $\widetilde A f$ is the *later*, separate "moreover" clause. Fusing them changes what the biconditional asserts. |
| 3 | Writing `∀ R, ∃ C, HasStrongType … C` instead of `∃ C, ∀ R, …`. | Each $S_R$ is a finite-rank operator, so a bound for each fixed $R$ exists automatically. With the quantifiers in that order the right-hand side of the biconditional is a triviality and the theorem says nothing. |
| 4 | Omitting the finite-support condition (i). | Then the series defining $S_R f$ itself may diverge, and `tsum` silently returns `0`. Condition (i) is exactly what the text flags as making $S_R$ well defined. |
| 5 | Using unnormalized Haar measure, or `AddCircle (2 * π)` as the circle. | Any other normalization inserts powers of $2\pi$ into the Fourier coefficients and hence into $S_R$, so the multiplier picture no longer matches. |
| 6 | Allowing $0 < p < 1$. | On a probability space $L^p \subseteq L^1$ only for $p \ge 1$. Below $1$ the coefficient integral need not converge and the Fourier coefficients become default values. |
| 7 | Expressing convergence pointwise or almost everywhere instead of in $L^p$. | The theorem is about norm convergence; almost-everywhere convergence is a different and much harder statement (see 4.3.15). |
| 8 | Dropping "for the same constant $K$" and asserting only that $A$ is bounded by some constant. | The sharpness — that the limit operator inherits the *same* uniform bound — is part of the printed conclusion. |

## Notes on the ground truth

- $A$ is existentially quantified and pinned down only on those $h$ whose limit series is summable.
  This is how the statement avoids applying an unconditionally divergent series to a general
  $L^p$ function while still saying that $A$ is the limit operator. The text instead pins $A$ on
  $C^\infty(\mathbb{T}^n)$, where absolute convergence is automatic.
- `Summable (fun m ↦ fun x ↦ …)` is summability in the space of functions, that is, summability at
  each point $x$ simultaneously.
- Uniqueness of the bounded extension $\widetilde A$ is not asserted. A candidate adding it is more
  faithful to "extends to a bounded operator".
- $L^p$ convergence is expressed as `Tendsto (fun R ↦ eLpNorm (S R f - g) (ENNReal.ofReal p) μ)
  atTop (𝓝 0)` on raw functions rather than inside the `Lp` type. That is the right call, because
  `S R` acts on raw functions, not on equivalence classes.
- `HasStrongType` is hand-rolled in `Defs.lean`, since this Mathlib has no operator-norm notion for
  operators that are not typed as maps between `Lp` spaces.
- `hbounded` is never used to bound `aLimit` directly, but the bound for the limit follows from it.
- The left half of the biconditional was repaired: it previously named the limit as the formal
  series and was therefore false.
