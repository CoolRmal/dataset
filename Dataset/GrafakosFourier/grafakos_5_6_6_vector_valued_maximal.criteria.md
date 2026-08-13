# Criteria: grafakos_5_6_6_vector_valued_maximal

**Statement:** [grafakos_5_6_6_vector_valued_maximal.md](grafakos_5_6_6_vector_valued_maximal.md) · **Lean:** [grafakos_5_6_6_vector_valued_maximal.lean](grafakos_5_6_6_vector_valued_maximal.lean)

## What the theorem says

Take a whole sequence of functions $f_1, f_2, \dots$ on $\mathbb{R}^n$ and apply the Hardy–Littlewood
maximal operator to each. At every point, combine the results into a single number by taking the
$\ell^r$ norm of the sequence of values, and do the same for the original sequence. The
Fefferman–Stein inequalities say that this combined maximal function is controlled by the combined
original function: a weak $(1,1)$ bound with constant $C_n(1 + (r-1)^{-1})$, and a strong $L^p$ bound
for $1 < p < \infty$. The point is that the $\ell^r$ sum happens *inside* the norm, pointwise in $x$;
with the norm and the sum interchanged the result would be an immediate consequence of the scalar
maximal theorem.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The $\ell^r$ sum is taken pointwise in $x$ first, and the $L^1$ or $L^p$ norm of the resulting function afterwards. | ✅ `maximalNorm f x = ENNReal.rpow (∑' j, ENNReal.rpow (hardyLittlewoodMaximal n (f j) x) r) (1 / r)` and `ellNorm f x = ENNReal.rpow (∑' j, ENNReal.rpow ‖f j x‖ₑ r) (1 / r)`, both functions of `x`, with the outer norm applied to them. |
| 2 | $M$ is the Hardy–Littlewood maximal operator applied to each $f_j$ separately. | ✅ `hardyLittlewoodMaximal n (f j) x`, the uncentered operator shared with `grafakos_2_1_6`. |
| 3 | The weak $(1,1)$ inequality: for every $\alpha > 0$, the measure of the set where the combined maximal function is strictly above $\alpha$ is at most the constant over $\alpha$ times the $L^1$ norm of the combined original. | ✅ `∀ f, ∀ α : ℝ, 0 < α → volume {x \| ENNReal.ofReal α < maximalNorm f x} ≤ Cn * ENNReal.ofReal (1 + 1 / (r - 1)) / ENNReal.ofReal α * ENNReal.rpow (∫⁻ x, ellNorm f x) 1`; dividing by `ENNReal.ofReal α` is safe since $\alpha > 0$. |
| 4 | The weak constant carries the explicit factor $1 + (r-1)^{-1}$, which blows up as $r \downarrow 1$. | ✅ `ENNReal.ofReal (1 + 1 / (r - 1))` appears as a separate factor. |
| 5 | The strong inequality: the $L^p$ norm of the combined maximal function is at most a finite constant times the $L^p$ norm of the combined original. | ✅ `∀ f, ENNReal.rpow (∫⁻ x, ENNReal.rpow (maximalNorm f x) p) (1 / p) ≤ Cp * ENNReal.rpow (∫⁻ x, ENNReal.rpow (ellNorm f x) p) (1 / p)`, with `Cp < ∞`. |
| 6 | Both exponent ranges: $1 < p < \infty$ and $1 < r < \infty$. | ✅ `hp : 1 < p`, `hr : 1 < r`, with `p r : ℝ` so both are automatically finite. |
| 7 | No integrability or summability hypotheses on the $f_j$ — the inequalities hold for every sequence of functions. | ✅ `∀ f : ℕ → EuclideanSpace ℝ (Fin n) → ℂ` with no side conditions; everything is `ℝ≥0∞`-valued, where an infinite sum is a supremum of finite partial sums and a lower Lebesgue integral is always defined. |
| 8 | $C_n$ depends only on the dimension, so that the $r$-dependence of the weak bound really is the displayed factor. | ⚠️ `{n : ℕ} {p r : ℝ} (hp : 1 < p) (hr : 1 < r) : … ∃ Cn Cp : ℝ≥0∞, …` puts the existential inside the binders for `n`, `p` and `r`, so `Cn` is allowed to depend on `r` and the explicit factor becomes decorative. The faithful shape quantifies the dimensional constant first: `∀ n, ∃ Cn, ∀ p r, 1 < p → 1 < r → …`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Interchanging the norm and the sum, e.g. `(∑' j, eLpNorm (M (f j)) p volume ^ r) ^ (1/r) ≤ C * (∑' j, eLpNorm (f j) p volume ^ r) ^ (1/r)`. | That follows term by term from the scalar maximal theorem (2.1.6) and misses the entire content of 5.6.6. The whole difficulty is that the $\ell^r$ sum sits inside the integral. |
| 2 | Applying the maximal operator to the combined function, i.e. bounding $M\big((\sum_j\lvert f_j\rvert^r)^{1/r}\big)$. | A different statement. The maximal operator must act on each $f_j$ separately, before the $\ell^r$ sum. |
| 3 | Stating only the strong $L^p$ bound. | The text asserts both, and the weak $(1,1)$ bound is what the $L^p$ bound is proved from. |
| 4 | Writing the level set with `≤`, or fixing a single $\alpha$ instead of quantifying over all $\alpha > 0$. | The weak-type norm is a supremum over all levels, and the distribution function uses the strict inequality. Either change alters the assertion. |
| 5 | Allowing $r = 1$. | The constant $1 + (r-1)^{-1}$ is then undefined; in Lean it silently becomes $1 + 0 = 1$, because `1 / 0 = 0` in `ℝ`, and the resulting weak bound with constant $C_n$ is false. |
| 6 | Formulating the sums or integrals over the real numbers with `tsum : ℝ`. | A non-summable family gives Lean's `tsum` the value `0`, so the left-hand side of either inequality would collapse to `0` for exactly the sequences that make the theorem interesting, and the inequality would hold for free. |
| 7 | Adding integrability or `MemLp` hypotheses on the $f_j$. | Unnecessary: with everything valued in `ℝ≥0∞` the inequalities are automatically true when the right-hand side is $\infty$, so no side conditions are needed. Extra hypotheses narrow the theorem. |

## Notes on the ground truth

- `ENNReal.rpow (∫⁻ x, ellNorm f x) 1` on the right of the weak bound raises to the power $1$, which
  does nothing; it should simply be `∫⁻ x, ellNorm f x`. Harmless but noisy.
- The strong bound uses a single opaque `Cp`, absorbing both the dimensional constant $C_n$ and the
  exponent-dependent $c(p,r)$ of the text. Acceptable, since the text does not pin down $c(p,r)$
  either — but combined with requirement 8 it means neither constant's dependence is actually
  constrained. A candidate that exhibits the split, or quantifies `Cn` outside `p` and `r`, says
  strictly more.
- The theorem is equally true for the centered maximal operator; using the uncentered one matches the
  text's $M$.
- The sequence is indexed by `ℕ`, which is the natural reading of the text's $\sum_j$.
