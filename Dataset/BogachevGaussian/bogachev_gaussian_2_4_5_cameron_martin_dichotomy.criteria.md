# Criteria: bogachev_gaussian_2_4_5_cameron_martin_dichotomy

**Statement:** [bogachev_gaussian_2_4_5_cameron_martin_dichotomy.md](bogachev_gaussian_2_4_5_cameron_martin_dichotomy.md) · **Lean:** [bogachev_gaussian_2_4_5_cameron_martin_dichotomy.lean](bogachev_gaussian_2_4_5_cameron_martin_dichotomy.lean)

## What the theorem says

Let $\gamma$ be a Gaussian measure and let $\gamma_h$ be the measure you get by shifting $\gamma$ by
a vector $h$. Every vector $h$ has a Cameron–Martin norm $\lvert h\rvert_{H(\gamma)}$, defined as
the supremum of $f(h)$ over all continuous linear functionals $f$ whose variance under $\gamma$ is
at most $1$; this number may be $+\infty$. The theorem is an all-or-nothing dichotomy. If
$\lvert h\rvert_{H(\gamma)} = \infty$, then $\gamma_h$ and $\gamma$ live on disjoint sets — they are
mutually singular. If $\lvert h\rvert_{H(\gamma)} < \infty$, then $\gamma_h$ and $\gamma$ have
exactly the same null sets — they are equivalent. Consequently the Cameron–Martin space is exactly
the set of shifts that leave $\gamma$ equivalent to itself.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $\gamma$ is an arbitrary Gaussian measure; nothing more is assumed about it. | ✅ `(γ : Measure E) [IsGaussian γ]`, plus the `[MeasurableSpace E] [BorelSpace E]` structure needed to talk about pushforwards. |
| 2 | The Cameron–Martin norm is a supremum over the functionals $f$ with $\int (f - \int f\,d\gamma)^2\,d\gamma \le 1$, i.e. with variance at most $1$. | ✅ `cameronMartinNorm` is indexed by `{f : StrongDual ℝ E // Var[f; γ] ≤ 1}`. |
| 3 | That norm must be allowed to equal $+\infty$; the infinite case is half the theorem. | ✅ `cameronMartinNorm : … → ℝ≥0∞`, built as `⨆ f, ENNReal.ofReal (f h)`. |
| 4 | The shift $\gamma_h = \gamma(\cdot - h)$ is the pushforward of $\gamma$ under translation by $h$. | ✅ `γ.map (· + h)`, whose value on a set `A` is `γ (A - h)`. |
| 5 | Part (i): if $\lvert h\rvert_{H(\gamma)} = \infty$ then $\gamma_h$ and $\gamma$ are mutually singular, for every such $h$. | ✅ `∀ h : E, cameronMartinNorm γ h = ∞ → (γ.map (· + h)) ⟂ₘ γ`. |
| 6 | Part (ii): if $\lvert h\rvert_{H(\gamma)} < \infty$ then $\gamma_h$ and $\gamma$ are equivalent, meaning each is absolutely continuous with respect to the other. | ✅ `∀ h : E, cameronMartinNorm γ h ≠ ∞ → Equivalent (γ.map (· + h)) γ`, with `Equivalent μ ν := μ ≪ ν ∧ ν ≪ μ`. |
| 7 | The consequence (2.4.3): the Cameron–Martin space equals the set of $h$ for which $\gamma_h \sim \gamma$. | ⚠️ `cameronMartinSpace γ = {h : E \| Equivalent (γ.map (· + h)) γ}`, the third conjunct. The book's further equality with $X \cap R_\gamma(X^*)$ is dropped, because $R_\gamma$ is never introduced here. |
| 8 | All three assertions appear in one statement. | ✅ A three-fold conjunction. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Defining the Cameron–Martin norm as a real-valued `sSup`. | In Lean a supremum of an unbounded set of reals evaluates to the junk value `0`. Part (i) would then be a statement about the vectors of Cameron–Martin norm *zero* — the exact opposite of the vectors it is about. This is the highest-value trap here. |
| 2 | Taking the supremum over $\{f : \int f^2\,d\gamma \le 1\}$ or over $\{f : \lVert f\rVert \le 1\}$. | The constraint is on the *variance*, which subtracts the mean. For a non-centered $\gamma$ these give different, smaller sets of $f$ and hence a different norm; the operator-norm ball is unrelated to $\gamma$ entirely. |
| 3 | Writing the shift as `γ.map (· - h)`. | That is the shift in the opposite direction. For a general (non-centered) Gaussian this is a different measure, so the statement being asserted is not the printed one. |
| 4 | Concluding only `γ_h ≪ γ` in part (ii). | One-sided absolute continuity is strictly weaker. The theorem gives mutual absolute continuity, and that is what makes the Cameron–Martin space a group of admissible shifts. |
| 5 | Keeping only parts (i) and (ii) and omitting (2.4.3). | In Lean the set equality is not a formal consequence of (i) and (ii) without unfolding `cameronMartinSpace`. It is a stated part of the theorem and must be present. |
| 6 | Adding hypotheses that $\gamma$ is centered, non-degenerate, or lives on a separable space. | The theorem needs none of these. Each added hypothesis narrows the result. |
| 7 | Stating the dichotomy as "either mutually singular or equivalent" without tying the two cases to the value of $\lvert h\rvert_{H(\gamma)}$. | That is a weaker statement (and is essentially Theorem 2.7.2 specialized to shifts). Here the *criterion* is the content. |

## Notes on the ground truth

- Bogachev works on a locally convex space; the Lean statement is on a normed space, which is where Mathlib's `IsGaussian` lives. This narrows the scope but not the mathematical content.
- The final clause $H(\gamma) = X \cap R_\gamma(X^*)$ of (2.4.3) is omitted, because $R_\gamma$ is not introduced anywhere in this formalization. The two retained equalities are the ones used throughout the rest of the book.
- `cameronMartinNorm` uses `ENNReal.ofReal (f h)`, which clamps negative values to $0$. This is harmless: the index set is symmetric ($f$ has variance at most $1$ exactly when $-f$ does), so the supremum is unchanged.
- `Equivalent` is our own two-line definition because Mathlib has `≪` and `⟂ₘ` but no bundled notion of equivalent measures. Both `≪` and `⟂ₘ` are taken from Mathlib.
