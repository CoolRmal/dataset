# Criteria: folland_1_18_wiener_inverse_of_absolutely_convergent_series

**Statement:** [folland_1_18_wiener_inverse_of_absolutely_convergent_series.md](folland_1_18_wiener_inverse_of_absolutely_convergent_series.md) · **Lean:** [folland_1_18_wiener_inverse_of_absolutely_convergent_series.lean](folland_1_18_wiener_inverse_of_absolutely_convergent_series.lean)

## What the theorem says

Take a function $f$ on the unit circle written as a two-sided Fourier series
$f(e^{i\theta}) = \sum_{n \in \mathbb{Z}} a_n e^{in\theta}$ whose coefficients are absolutely
summable, so $\sum_n \lvert a_n\rvert < \infty$. Suppose $f$ is never zero. Wiener's theorem says
the reciprocal $1/f$ is again such a series: there are coefficients $b_n$ with
$\sum_n \lvert b_n\rvert < \infty$ and $1/f(e^{i\theta}) = \sum_n b_n e^{in\theta}$.

The point is the word *absolutely*. That $1/f$ is a continuous function on the circle, and so has
some Fourier expansion, is elementary. That its coefficients are again absolutely summable is the
theorem.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The coefficients are indexed by all the integers, so the series is two-sided. | ✅ `a : ℤ → ℂ` and `∑' n : ℤ`. |
| 2 | The given coefficients are absolutely summable. | ✅ `ha : Summable fun n ↦ ‖a n‖`. |
| 3 | The circle is parameterised by $\theta \mapsto e^{i\theta}$, so the $n$-th term is $a_n e^{in\theta}$. | ✅ `a n * Complex.exp (n * θ * Complex.I)`. |
| 4 | The sum is nonzero at every point of the circle, not just at some. | ✅ `hne : ∀ θ : ℝ, (∑' n : ℤ, a n * Complex.exp (n * θ * Complex.I)) ≠ 0`. |
| 5 | The conclusion produces new coefficients. | ✅ `∃ b : ℤ → ℂ`. |
| 6 | Those new coefficients are absolutely summable. This is the content of the theorem. | ✅ `Summable fun n ↦ ‖b n‖`, a conjunct of the conclusion. |
| 7 | The new series is the reciprocal of the old one, at every $\theta$. | ✅ `∀ θ : ℝ, (∑' n, b n * exp …) * (∑' n, a n * exp …) = 1`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Concluding only that $1/f$ has *some* Fourier series, dropping `Summable fun n ↦ ‖b n‖`. | This is the whole theorem. Without it the conclusion is a triviality about continuous functions on the circle. |
| 2 | Indexing the sums by `ℕ` instead of `ℤ`. | A one-sided series is a boundary value of a function analytic in the disc. That is a different statement, and the corollary as printed is about the two-sided algebra $\ell^1(\mathbb{Z})$. |
| 3 | Dropping `ha`, the absolute summability of the given coefficients. | Lean assigns a non-summable `∑'` the value `0`. Then `hne` would be false at every $\theta$, so the hypotheses could never be met and the theorem would say nothing. |
| 4 | Dropping the never-vanishing hypothesis `hne`. | False: take $a_0 = 1$, $a_1 = -1$, giving $f(e^{i\theta}) = 1 - e^{i\theta}$, which vanishes at $\theta = 0$ and has no reciprocal. |
| 5 | Writing the conclusion with division, `∑' n, b n * exp … = 1 / (∑' n, a n * exp …)`, without any nonvanishing hypothesis. | Lean defines division by zero to be zero, so at a point where $f$ vanishes the equation could be satisfied by $b = 0$. |
| 6 | Requiring $f$ to be bounded away from zero, `∃ δ > 0, ∀ θ, δ ≤ ‖f θ‖`. | Equivalent here, because the circle is compact and $f$ is continuous, but it is not the printed hypothesis and it hands the model a fact it should have to derive. |

## Notes on the ground truth

- The conclusion is written as a product equal to `1` rather than as `1 / f`. This says the same
  thing, avoids Lean's division-by-zero convention entirely, and is slightly further from the
  book's literal `1/f`.
- Quantifying $\theta$ over all of `ℝ` rather than over $[0, 2\pi)$ makes no difference: the
  exponentials are $2\pi$-periodic, so the two hypotheses are the same hypothesis.
- Both `∑'` expressions in the statement are genuine sums, not the junk value `0`: the $a$-series
  converges because of `ha` (the exponentials have modulus one), and the $b$-series converges
  because the conclusion carries `Summable fun n ↦ ‖b n‖`.
- Mathlib has no Wiener lemma and no Gelfand theory for the convolution algebra $\ell^1(\mathbb{Z})$.
  The Wiener–Ikehara theorem mentioned in `Mathlib/NumberTheory/LSeries/PrimesInAP.lean` is a
  different result.
