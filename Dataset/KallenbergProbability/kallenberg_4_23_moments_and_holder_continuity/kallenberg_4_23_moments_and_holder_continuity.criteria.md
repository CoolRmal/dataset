# Criteria: kallenberg_4_23_moments_and_holder_continuity

**Statement:** [kallenberg_4_23_moments_and_holder_continuity.md](kallenberg_4_23_moments_and_holder_continuity.md) · **Lean:** [kallenberg_4_23_moments_and_holder_continuity.lean](kallenberg_4_23_moments_and_holder_continuity.lean) · **Context:** [kallenberg_4_23_moments_and_holder_continuity.context.md](kallenberg_4_23_moments_and_holder_continuity.context.md)

## What the theorem says

Let $X$ be a process indexed by $\mathbb{R}^d$ with values in a complete metric space, and suppose
there are constants $a, b > 0$ and a single constant $C$ such that
$\mathbb{E}\,\rho(X_s, X_t)^a \le C\,|s - t|^{d + b}$ for all $s$ and $t$. The
Kolmogorov–Loève–Chentsov theorem says that $X$ has a version — another process $Y$ with
$X_t = Y_t$ almost surely for each fixed $t$ — whose paths are Hölder continuous of order $p$ on
every bounded set, for every $p$ strictly between $0$ and $b/a$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. In the assessment column, ✅ means the ground truth states the requirement and
◐ means it states it in a form that deliberately departs from the text — a narrower setting, a
stronger hypothesis, or an equivalent but not literal phrasing — with the reason given. A ◐ records
a decision, not an open defect; where a more literal rendering would be at least as good, the row
says so.

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
  rather than the Euclidean length. The difference is absorbed into the constant $C$, so nothing
  is lost, but `EuclideanSpace ℝ (Fin d)` would match $|s - t|$ literally.
- `IsLocallyHolder` uses closed balls centred at $0$; those exhaust the bounded subsets of
  `Fin d → ℝ`, and the constant `C` is chosen after the radius `R`, as it must be. `HolderOnWith C p f s`
  means `edist (f x) (f y) ≤ C * edist x y ^ p` for `x, y ∈ s`, a uniform bound on the ball; on a
  bounded set this is equivalent to Kallenberg's asymptotic condition $w_f(r) \lesssim r^p$.
- **Deliberate departure.** The conclusion is written `∀ p, ∀ᵐ ω, …`, which allows the null set to depend on $p$. The
  theorem actually gives one null set outside of which the path of $Y$ is locally Hölder of every
  order $p < b/a$ at once, i.e. `∀ᵐ ω ∂μ, ∀ p ∈ Ioo 0 (b/a), …`. That form is true, stronger, and
  closer to the intended content; a candidate stating it should be scored at least as highly.
- "Version" is per-time almost-sure equality, `∀ t, X t =ᵐ[μ] Y t`, not indistinguishability. That
  is the correct reading of Kallenberg's word here.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[kallenberg_4_23_moments_and_holder_continuity.md](kallenberg_4_23_moments_and_holder_continuity.md) and the background in [kallenberg_4_23_moments_and_holder_continuity.context.md](kallenberg_4_23_moments_and_holder_continuity.context.md),
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

- Requirement 4 with the moment constant chosen after $s$ and $t$, making the hypothesis vacuous.
- Requirement 8 with a different version $Y$ for each Hölder exponent.
- Requirement 7 with the conclusion asserted about $X$ itself rather than about a version.

### Domain-specific pitfalls for this problem

- $\lesssim$ hides an existential constant that must be quantified before the variables it is uniform in.
- A *version* is equality a.s. at each fixed time, which is weaker than indistinguishability; the theorem gives only a version.
- "Locally Hölder" means Hölder on every bounded set, with the constant allowed to depend on the set.
- The exponent range is the open interval $(0, b/a)$, and the moment exponent on the right is $d + b$ with $d$ the index dimension.
- The expectation on the left may be infinite a priori, so it should be taken as a lower Lebesgue integral rather than a Bochner integral.
