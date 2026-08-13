# Criteria: folland_2_69_convolution_factorization

**Statement:** [folland_2_69_convolution_factorization.md](folland_2_69_convolution_factorization.md) · **Lean:** [folland_2_69_convolution_factorization.lean](folland_2_69_convolution_factorization.lean)

## What the theorem says

On any locally compact group $G$, convolving an $L^1$ function with an $L^p$ function gives an
$L^p$ function; that much is Young's inequality. The theorem says the reverse: for
$1 \le p < \infty$, *every* $L^p$ function arises this way. Written as sets,
$L^1(G) * L^p(G) = L^p(G)$.

So given $f \in L^p$ one can find $g \in L^1$ and $h \in L^p$ with $g * h = f$ exactly, not merely
approximately. This is a special case of Cohen's factorization theorem. Folland's theorem also
records the $p = \infty$ analogues, where the answer is the uniformly continuous functions rather
than $L^\infty$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $G$ is a locally compact topological group with its Borel structure, and $\mu$ is a left Haar measure. | ✅ `[IsTopologicalGroup G] [LocallyCompactSpace G] [BorelSpace G]`, `(μ : Measure G) [μ.IsHaarMeasure]`. |
| 2 | The exponent satisfies $1 \le p$ and $p \ne \infty$. | ✅ `hp : 1 ≤ p`, `hp' : p ≠ ∞`. |
| 3 | The theorem applies to an arbitrary $f \in L^p$, given in advance. | ✅ `(f : G → ℂ) (hf : MemLp f p μ)` as hypotheses. |
| 4 | The conclusion produces two factors. | ✅ `∃ g h : G → ℂ`. |
| 5 | The left factor is integrable. | ✅ `Integrable g μ`. |
| 6 | The right factor is in $L^p$. | ✅ `MemLp h p μ`. |
| 7 | The convolution of the two factors equals $f$, exactly, almost everywhere. | ✅ `∀ᵐ x ∂μ, groupConv μ g h x = f x`. |
| 8 | The $L^1$ factor sits on the **left** of the convolution. | ✅ `groupConv μ g h`, with `g` the integrable one. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Stating only the inclusion $L^1 * L^p \subseteq L^p$. | That is Young's inequality (Folland 2.40, a separate problem in this book). The content of 2.69 is the reverse inclusion — surjectivity of convolution onto $L^p$. This is the highest-value trap. |
| 2 | Asserting an approximate factorization, e.g. for every $\varepsilon$ there are $g,h$ with $\lVert g*h - f\rVert_p < \varepsilon$. | Much weaker, and immediate from the approximate identity (2.44). The theorem asserts exact equality. |
| 3 | Writing `∀ x, groupConv μ g h x = f x` instead of `∀ᵐ x ∂μ`. | Convolution of an $L^1$ with an $L^p$ function is only defined almost everywhere, and $f$ itself is only determined almost everywhere, so pointwise equality everywhere is not something one can ask for. |
| 4 | Allowing $p = \infty$. | Folland's $p = \infty$ clause has a *different* conclusion: $L^1 * L^\infty = C_{lu}(G)$, the bounded left uniformly continuous functions, not $L^\infty$. Keeping the $L^p$ conclusion at $p = \infty$ states something false. |
| 5 | Putting the $L^p$ factor on the left, $h * g$. | That is the right-handed statement, which on a non-unimodular group is a genuinely different assertion (Folland states it separately, with $C_{ru}$). |
| 6 | Dropping `Integrable g μ` or `MemLp h p μ`. | The factorization is only interesting because the factors live in the stated spaces. Without those constraints the statement is about arbitrary functions and loses its meaning. |

## Notes on the ground truth

- ⚠️ Only the $L^p$ clause of the theorem is formalized. Folland also states
  $L^1 * L^\infty = L^1 * C_{lu} = C_{lu}$ and $L^\infty * L^1 = C_{ru} * L^1 = C_{ru}$. Those need
  $C_{lu}$ and $C_{ru}$, which Mathlib does not supply; they are recorded in the `.md` but not in
  Lean.
- ⚠️ Only the surjectivity half of the set equality is formalized. The inclusion
  $L^1 * L^p \subseteq L^p$ is the content of `folland_2_40_convolution_lp_bound`, which appears
  separately in this book, so nothing is lost across the dataset — but a candidate that states both
  halves is closer to the printed sentence.
- `groupConv μ g h x` takes the value `0` wherever its defining integral diverges. The statement
  does not separately assert that the integral converges almost everywhere; it does not need to,
  because that follows from `Integrable g μ` and `MemLp h p μ` by Folland 2.40(a), and because
  the a.e. equality with `f` is an honest claim either way.
- `groupConv` is defined in `Defs.lean` because Mathlib's `MeasureTheory.convolution` is set up for
  additive groups and does not cover a general multiplicative locally compact group.
