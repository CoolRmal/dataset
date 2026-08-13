# Criteria: kallenberg_4_23_moments_and_holder_continuity

**Statement:** [kallenberg_4_23_moments_and_holder_continuity.md](kallenberg_4_23_moments_and_holder_continuity.md) · **Lean:** [kallenberg_4_23_moments_and_holder_continuity.lean](kallenberg_4_23_moments_and_holder_continuity.lean)

## What the theorem says

Let $X$ be a process indexed by $\mathbb{R}^d$ with values in a complete metric space, and suppose
there are constants $a, b > 0$ and a single constant $C$ such that
$\mathbb{E}\,\rho(X_s, X_t)^a \le C\,|s - t|^{d + b}$ for all $s$ and $t$. The
Kolmogorov–Loève–Chentsov theorem says that $X$ has a version — another process $Y$ with
$X_t = Y_t$ almost surely for each fixed $t$ — whose paths are Hölder continuous of order $p$ on
every bounded set, for every $p$ strictly between $0$ and $b/a$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The index space is $\mathbb{R}^d$ and the values lie in a complete metric space with its Borel structure. | ✅ `X : (Fin d → ℝ) → Ω → S` with `[MetricSpace S] [MeasurableSpace S] [BorelSpace S] [CompleteSpace S]`. |
| 2 | The underlying measure is a probability measure, and each $X_t$ is measurable. | ✅ `[IsProbabilityMeasure μ]`, `hX : ∀ t, AEMeasurable (X t) μ`. |
| 3 | The exponents satisfy $a > 0$ and $b > 0$. | ✅ `ha : 0 < a`, `hb : 0 < b`. |
| 4 | The moment bound holds with one constant that works for all pairs $s, t$: the constant is chosen before the pair, not after. | ✅ `hmoment : ∃ C : ℝ, 0 ≤ C ∧ ∀ s t, …`. |
| 5 | The right-hand exponent is $d + b$, with $d$ the dimension of the index space. | ✅ `ENNReal.ofReal (C * ‖s - t‖ ^ ((d : ℝ) + b))`. |
| 6 | The expectation on the left is an integral that is allowed to be $+\infty$, so that the hypothesis genuinely bounds it. | ✅ `∫⁻ ω, ENNReal.ofReal (dist (X s ω) (X t ω) ^ a) ∂μ`, a lower Lebesgue integral valued in `ℝ≥0∞`. |
| 7 | The conclusion produces a new process $Y$ which is a version of $X$: equal to $X_t$ almost surely for each fixed $t$. | ✅ `∃ Y : (Fin d → ℝ) → Ω → S, (∀ t, X t =ᵐ[μ] Y t) ∧ …`. |
| 8 | The same $Y$ works for all Hölder exponents; the exponent is quantified inside the existential. | ✅ `∃ Y, … ∧ ∀ p : ℝ, ∀ hp : p ∈ Ioo 0 (b / a), …`. |
| 9 | The exponent range is the open interval $(0, b/a)$. | ✅ `p ∈ Ioo 0 (b / a)`. |
| 10 | The paths of $Y$ are Hölder of order $p$ on every bounded set, with a constant allowed to depend on the set. | ✅ `∀ᵐ ω ∂μ, IsLocallyHolder ⟨p, hp.1.le⟩ (fun t ↦ Y t ω)`, where `IsLocallyHolder p x` is `∀ R > 0, ∃ C : ℝ≥0, HolderOnWith C p x (Metric.closedBall 0 R)`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Concluding that the paths of $X$ itself are Hölder, with no version $Y$. | This is the single most likely error and it makes the statement false. Changing $X$ on a null set at each time leaves the moment hypothesis untouched but can destroy every path, so nothing about the paths of $X$ can be concluded. |
| 2 | Writing the moment hypothesis as `∀ s t, ∃ C, …`. | With the constant chosen after the pair, the hypothesis holds for any process at all whenever $s \ne t$, so it carries no information. |
| 3 | Using a Bochner integral `∫ ω, dist (X s ω) (X t ω) ^ a ∂μ`. | Lean gives a Bochner integral of a non-integrable function the value $0$, so the bound would hold for free exactly for the pathological processes the hypothesis is meant to exclude. |
| 4 | Writing the exponent as $1 + b$, or as $d\,b$. | $1 + b$ is the one-parameter Kolmogorov criterion; with a $d$-dimensional index the correct power is $d + b$, and with a smaller exponent the theorem is false. |
| 5 | Quantifying the version after the exponent, `∀ p, ∃ Y, …`. | That allows a different version for each $p$, which is weaker than the theorem and useless in practice. |
| 6 | Using the closed interval `Icc 0 (b/a)` or `Iio (b/a)` for the exponent. | The endpoint $b/a$ genuinely fails — Brownian motion is the standard counterexample at $p = 1/2$ — and $p \le 0$ is meaningless. |
| 7 | Asking for a single global Hölder bound `HolderWith C p` on all of $\mathbb{R}^d$. | Hölder continuity here is only local. A global bound is false already for Brownian motion. |
| 8 | Dropping completeness of the target space. | The version is built as a uniform limit on a dense set of indices; without completeness the limit need not exist. |

## Notes on the ground truth

- $\mathbb{R}^d$ is modelled as `Fin d → ℝ`, whose norm `‖s - t‖` is the maximum of the coordinates
  rather than the Euclidean length. ⚠️ The difference is absorbed into the constant $C$, so nothing
  is lost, but `EuclideanSpace ℝ (Fin d)` would match $|s - t|$ literally.
- `IsLocallyHolder` uses closed balls centred at $0$; those exhaust the bounded subsets of
  `Fin d → ℝ`, and the constant `C` is chosen after the radius `R`, as it must be. `HolderOnWith C p f s`
  means `edist (f x) (f y) ≤ C * edist x y ^ p` for `x, y ∈ s`, a uniform bound on the ball; on a
  bounded set this is equivalent to Kallenberg's asymptotic condition $w_f(r) \lesssim r^p$.
- ⚠️ The conclusion is written `∀ p, ∀ᵐ ω, …`, which allows the null set to depend on $p$. The
  theorem actually gives one null set outside of which the path of $Y$ is locally Hölder of every
  order $p < b/a$ at once, i.e. `∀ᵐ ω ∂μ, ∀ p ∈ Ioo 0 (b/a), …`. That form is true, stronger, and
  closer to the intended content; a candidate stating it should be scored at least as highly.
- "Version" is per-time almost-sure equality, `∀ t, X t =ᵐ[μ] Y t`, not indistinguishability. That
  is the correct reading of Kallenberg's word here.
