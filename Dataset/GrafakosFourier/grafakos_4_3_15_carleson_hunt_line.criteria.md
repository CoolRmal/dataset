# Criteria: grafakos_4_3_15_carleson_hunt_line

**Statement:** [grafakos_4_3_15_carleson_hunt_line.md](grafakos_4_3_15_carleson_hunt_line.md) · **Lean:** [grafakos_4_3_15_carleson_hunt_line.lean](grafakos_4_3_15_carleson_hunt_line.lean)

## What the theorem says

Given a nice function $f$ on the line, cut its Fourier transform off to the symmetric window
$\lvert\xi\rvert \le R$ and transform back. The Carleson operator $\mathcal{C}^{**}f$ records, at
each point $x$, the largest absolute value these truncated reconstructions ever take as $R$ ranges
over the positive reals. The theorem says that for each $p$ with $1 < p < \infty$ there is a finite
constant, depending on $p$ but not on $f$, bounding the $L^p$ norm of $\mathcal{C}^{**}f$ by the
$L^p$ norm of $f$. Almost-everywhere convergence of the partial Fourier integrals is then deduced
from this maximal bound; it is not what is stated here.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The object bounded is the supremum over the truncation parameter $R > 0$, not a limit. | ✅ `carlesonHuntMaximal f x = ⨆ R : {R : ℝ // 0 < R}, ‖∫ ξ in Set.Icc (-R.1) R.1, 𝓕 f ξ * Complex.exp (2 * Real.pi * Complex.I * ξ * x)‖ₑ`, with $R > 0$ enforced by the subtype. |
| 2 | The supremum is formed where suprema always exist, so it never needs a boundedness side condition. | ✅ The `⨆` is taken in `ℝ≥0∞`, which is a complete lattice, and the summand is an extended norm `‖·‖ₑ`. |
| 3 | The truncation window is the symmetric interval $\{\lvert\xi\rvert \le R\}$. | ✅ `Set.Icc (-R.1) R.1`. Endpoints have measure zero, so the closed and open versions agree. |
| 4 | Inside the window, $\widehat f$ is Grafakos's transform (exponent $-2\pi i$) and the reconstruction kernel has the opposite sign, $e^{+2\pi i \xi x}$. | ✅ `𝓕` on `𝓢(ℝ, ℂ)`, which is `∫ v, 𝐞 (-⟪v,w⟫) • f v` with `𝐞 t = exp (2 * π * i * t)`, paired with `Complex.exp (2 * Real.pi * Complex.I * ξ * x)`. |
| 5 | The exponent range is $1 < p < \infty$. | ✅ `{p : ℝ} (hp : 1 < p)`; a real `p` cannot be $\infty$. |
| 6 | One finite constant is chosen after $p$ and works for all $f$. | ✅ `∃ C : ℝ≥0∞, C < ∞ ∧ ∀ f : 𝓢(ℝ, ℂ), …` inside the binder for `p`, so `C` may depend on `p` and is uniform in `f`. |
| 7 | The conclusion is the norm inequality $\|\mathcal{C}^{**}f\|_p \le C_p\|f\|_p$ on the test class. | ✅ `ENNReal.rpow (∫⁻ x, ENNReal.rpow (carlesonHuntMaximal f x) p) (1 / p) ≤ C * eLpNorm (f : ℝ → ℂ) (ENNReal.ofReal p) volume`. |
| 8 | Nothing more is claimed: no extension of $\mathcal{C}^{**}$ to all of $L^p$, no convergence statement. | ✅ `carlesonHuntMaximal` is typed on `𝓢(ℝ, ℂ)`, so the statement cannot over-claim. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Formalizing "the Fourier integral of $f$ converges almost everywhere" instead. | That is the corollary, strictly weaker and derived from the maximal bound. Worse, writing it with `Filter.limUnder` or `Classical.choice` picks an arbitrary value exactly on the set where convergence is in question, so the statement would be about an unspecified function. |
| 2 | Replacing the supremum over $R$ by a limit as $R \to \infty$. | The existence of that limit is precisely what is not known before the theorem is proved. The maximal function must be a supremum. |
| 3 | Taking the supremum in `ℝ` with `sSup` or a real-valued `⨆`. | Lean gives `sSup` of an unbounded set of reals the value `0`, so the left-hand side could silently collapse. A real formulation needs a separate `BddAbove` argument to mean anything. |
| 4 | Truncating asymmetrically, e.g. $\int_{-R}^{R'}$ with two independent parameters. | That is the maximal *partial sum* operator of a different and harder theorem. Grafakos's $\mathcal{C}^{**}$ uses the symmetric window. |
| 5 | Writing `∀ f, ∃ C, …`. | For a fixed Schwartz $f$ both sides are finite, so a constant always exists; the statement would be empty. The constant must be uniform in $f$. |
| 6 | Choosing the constant before $p$, i.e. `∃ C, ∀ p, 1 < p → …`. | False. The bound blows up as $p \downarrow 1$; the Carleson operator is not of strong type $(1,1)$. |
| 7 | Weakening the hypothesis to $1 \le p$. | Same reason: the endpoint $p = 1$ fails. |
| 8 | Flipping the sign in the reconstruction kernel to $e^{-2\pi i \xi x}$. | The inner integral must invert the transform on the window. With the same sign as the transform it is a different operator. |

## Notes on the ground truth

- The text states the bound for $f \in C_0^\infty(\mathbb{R})$; the Lean version states it for all
  Schwartz functions, a strictly larger class. So the formalization is stronger than the printed
  statement, and still true. Mathlib has first-class `SchwartzMap` API and no bundled type of
  compactly supported smooth functions, so this is a reasonable choice — but a candidate using
  compactly supported smooth functions is equally faithful.
- The inner Bochner integral is honest: `𝓕 f` is again Schwartz and the window is compact, so the
  integrand is integrable and the integral is not a default value.
- The left-hand side is written out as `(∫⁻ x, (…) ^ p) ^ (1/p)`. Since Mathlib has an
  `ENorm ℝ≥0∞` instance with `‖x‖ₑ = x`, `eLpNorm (carlesonHuntMaximal f) (ENNReal.ofReal p) volume`
  is the same thing and reads better. Likewise `∃ C : ℝ≥0` would avoid the separate `C < ∞`
  condition.
