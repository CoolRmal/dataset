# Criteria: grafakos_1_3_2_marcinkiewicz_interpolation

**Statement:** [grafakos_1_3_2_marcinkiewicz_interpolation.md](grafakos_1_3_2_marcinkiewicz_interpolation.md) · **Lean:** [grafakos_1_3_2_marcinkiewicz_interpolation.lean](grafakos_1_3_2_marcinkiewicz_interpolation.lean) · **Context:** [grafakos_1_3_2_marcinkiewicz_interpolation.context.md](grafakos_1_3_2_marcinkiewicz_interpolation.context.md)

## What the theorem says

Take an operator $T$ that is not assumed linear, only *sublinear*: the size of $T(f+g)$ is at most
the size of $Tf$ plus the size of $Tg$, and scaling $f$ by a constant scales the size of $Tf$ by the
same factor. Suppose $T$ satisfies a weak-type bound at two exponents $p_0 < p_1$: for each level
$\alpha$, the set where $\lvert Tf\rvert$ exceeds $\alpha$ has measure at most
$(A_j\|f\|_{p_j}/\alpha)^{p_j}$. Then for every $p$ strictly between $p_0$ and $p_1$, $T$ is bounded
from $L^p$ to $L^p$, and Grafakos writes the constant out in closed form in terms of
$p, p_0, p_1, A_0, A_1$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The domain measure space is $\sigma$-finite; the target measure space is arbitrary. | ✅ `[SigmaFinite μ]` on the domain, and `ν : Measure Y` carries no extra instance. |
| 2 | $T$ is sublinear: it kills the zero function, the size of $T(f+g)$ is at most the sum of the sizes, and scalars come out in absolute value. | ✅ `hT : IsSublinearOperator T`, which is `T 0 = 0 ∧ (∀ f g x, ‖T (f + g) x‖ ≤ ‖T f x‖ + ‖T g x‖) ∧ ∀ c f x, ‖T (c • f) x‖ = ‖c‖ * ‖T f x‖`. |
| 3 | A weak-type bound at $p_0$ with constant $A_0$ and one at $p_1$ with constant $A_1$. Each says: for every $f$ in that $L^{p_j}$ and every $\alpha > 0$, the measure of the set where $\lvert Tf\rvert$ is *strictly* above $\alpha$ is at most $(A_j\|f\|_{p_j}/\alpha)^{p_j}$. | ✅ `h₀ : HasWeakType μ ν T p₀ A₀` and `h₁ : HasWeakType μ ν T p₁ A₁`, unfolding to `∀ f, MemLp f (ENNReal.ofReal p) μ → ∀ α, 0 < α → ν {y \| ENNReal.ofReal α < ‖T f y‖ₑ} ≤ ENNReal.rpow (C * eLpNorm f (ENNReal.ofReal p) μ / ENNReal.ofReal α) p`. |
| 4 | Both endpoint constants are finite. | ✅ `hA₀ : A₀ < ∞` and `hA₁ : A₁ < ∞`. |
| 5 | The exponents satisfy $0 < p_0 < p < p_1 \le \infty$, with $p_1 = \infty$ admitted. | ✅ `{p₀ p₁ p : ℝ≥0∞}` with `0 < p₀`, `p₀ < p`, `p < p₁`; `p₁ = ∞` is allowed, and `HasWeakType` spells out the $L^\infty$ endpoint separately (weak $L^\infty$ is $L^\infty$). The conclusion is stated in two cases, the printed constant for $p_1 < \infty$ and its limiting form $2(r/(r-r_0))^{1/r}A_0^{r_0/r}A_1^{1-r_0/r}$ for $p_1 = \infty$ — the case used for the Hardy–Littlewood maximal operator. |
| 6 | $T$ turns measurable functions into measurable functions — the text's "taking values in the space of measurable functions on $Y$". | ✅ `hmeas : ∀ f, AEStronglyMeasurable f μ → AEStronglyMeasurable (T f) ν`. |
| 7 | The conclusion has two halves: for $f \in L^p$, $Tf$ is again in $L^p$, and its norm is bounded by the constant times $\|f\|_p$. | ✅ `HasStrongType μ ν T (ENNReal.ofReal p) (ENNReal.ofReal p) A`, which unfolds to `MemLp (T f) _ ν ∧ eLpNorm (T f) _ ν ≤ A * eLpNorm f _ μ`. |
| 8 | The constant is the printed closed formula, built only from $p, p_0, p_1, A_0, A_1$ — so it is the same for every $f$. | ✅ `2 * ENNReal.rpow (ENNReal.ofReal (p / (p - p₀) + p / (p₁ - p))) (1 / p) * ENNReal.rpow A₀ ((p₀ / p) * ((p₁ - p) / (p₁ - p₀))) * ENNReal.rpow A₁ ((p₁ / p) * ((p - p₀) / (p₁ - p₀)))`. Every denominator is nonzero by `hp`, and the binders for the constants precede the `∀ f` hidden inside `HasStrongType`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Assuming $T$ is linear, e.g. `T : (X → ℂ) →ₗ[ℂ] (Y → ℂ)`. | That is the Riesz–Thorin hypothesis. The whole point of Marcinkiewicz is that sublinearity suffices, so the linear version is a strictly weaker theorem. |
| 2 | Writing the superlevel set with `≤`, as `{y \| ‖T f y‖ₑ ≥ ENNReal.ofReal α}`. | Grafakos's distribution function is $d_F(\alpha) = \nu\{\lvert F\rvert > \alpha\}$, a strict inequality. The closed set is larger, so this asserts a bound that was not assumed. |
| 3 | Forgetting the outer power in the weak-type bound, e.g. `ν {…} ≤ C * eLpNorm f p μ / ENNReal.ofReal α`. | The weak norm is $\sup_\alpha \alpha\, d_F(\alpha)^{1/p}$; clearing the $1/p$ root raises the whole quotient to the power $p$. Without it the hypothesis is a different statement and the interpolation does not follow. |
| 4 | Omitting the hypothesis that $Tf$ is measurable. | Sublinearity and the two weak bounds do not give measurability of $Tf$: unlike the linear case one cannot write $Tf = Tf_0 + Tf_1$. Take $Tf := \varphi \cdot Sf$ with $S$ a genuine sublinear operator and $\varphi$ a non-measurable function of modulus $1$; all hypotheses survive but the `MemLp (T f)` half of the conclusion fails. An earlier version of the ground truth had exactly this defect. |
| 5 | Replacing the explicit constant with `∃ C, …`, or using the Riesz–Thorin constant $A_0^{1-\theta}A_1^{\theta}$. | Throws away the quantitative content, which is the substance of 1.3.2. Sanity check on the printed formula: the two exponents on $A_0$ and $A_1$ sum to $1$, since $\frac{p_0(p_1-p)+p_1(p-p_0)}{p(p_1-p_0)} = 1$. |
| 6 | Adding `[SigmaFinite ν]` or `[IsFiniteMeasure μ]`. | The text assumes $\sigma$-finiteness on the domain only and lets $(Y,\nu)$ be any measure space. Extra hypotheses give a weaker theorem. |
| 7 | Dropping `A₀ < ∞` and `A₁ < ∞`. | With $A_j = \infty$ the endpoint hypotheses say nothing at all. It is also not harmless: in `ℝ≥0∞`, $\infty \cdot 0 = 0$, so for $f$ with $\|f\|_p = 0$ the conclusion still asserts something that must be proved. |

## Notes on the ground truth

- This Mathlib has no weak-type API — there is no `wnorm`, `MemWLp` or `HasWeakType` — so
  `IsSublinearOperator`, `HasWeakType` and `HasStrongType` are defined in `Defs.lean`. Hand-rolling
  them is the right call here.
- `T : (X → ℂ) → Y → ℂ` is a total function, and `IsSublinearOperator T` demands the sublinearity
  identities for *every* input, including functions outside $L^{p_0} + L^{p_1}$, where the text does
  not define $T$ at all. This is a stronger hypothesis, hence a slightly weaker theorem, but it is
  the standard way to handle a partially defined operator. A candidate that restricts sublinearity
  to `MemLp` functions is closer to the text and should not be penalized.
- The `T 0 = 0` conjunct of `IsSublinearOperator` is redundant — it is the $c = 0$ case of the
  homogeneity clause.
- Using `p : ℝ` and lifting with `ENNReal.ofReal` is safe only because `hp` supplies $0 < p_0$:
  `ENNReal.ofReal` sends every non-positive real to `0`, and `eLpNorm f 0 μ = 0`.
- An alternative design drops the `MemLp (T f)` conjunct and states only the `eLpNorm` inequality.
  That needs no measurability hypothesis, because the lower Lebesgue integral behind `eLpNorm` is
  defined for arbitrary functions. The ground truth keeps both conjuncts and pays for it with
  `hmeas`.
- `hmeas` was added to repair an earlier version of this file, which lacked it and was therefore not
  provable.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[grafakos_1_3_2_marcinkiewicz_interpolation.md](grafakos_1_3_2_marcinkiewicz_interpolation.md) and the background in [grafakos_1_3_2_marcinkiewicz_interpolation.context.md](grafakos_1_3_2_marcinkiewicz_interpolation.context.md),
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

- Requirement 3 with strong-type endpoint hypotheses instead of weak-type: that is a different (much easier) interpolation theorem.
- Requirement 8 with the constant existentially quantified rather than given by the printed formula.
- Requirement 2 with $T$ assumed linear: linearity is not available for the maximal operators this theorem is designed for.

### Domain-specific pitfalls for this problem

- Weak-type $(p,p)$ is a bound on the distribution function, $\nu\{|Tf|>\alpha\} \le (A\lVert f\rVert_p/\alpha)^p$, not a bound on an $L^p$ norm.
- Measurability of $Tf$ has to be assumed, since $T$ is only known to take values in the measurable functions.
- The endpoint $p_1 = \infty$ is admitted by the text; typing $p_1$ as a real number silently excludes it and narrows the theorem.
- The constant is built from real powers of `ℝ≥0∞` values; `ENNReal.rpow` at exponent $0$ or at $\infty$ has conventions that must not be relied on — the finiteness hypotheses $A_0,A_1<\infty$ are there for that reason.
- $\sigma$-finiteness is assumed of the *domain* measure only; the target space is arbitrary.
