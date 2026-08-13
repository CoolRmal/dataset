# Criteria: kallenberg_10_5_doob_meyer

**Statement:** [kallenberg_10_5_doob_meyer.md](kallenberg_10_5_doob_meyer.md) · **Lean:** [kallenberg_10_5_doob_meyer.lean](kallenberg_10_5_doob_meyer.lean)

## What the theorem says

Take a process $X$ on $\mathbb{R}_+$ that is adapted to a filtration and has right-continuous paths.
The Doob–Meyer theorem says that $X$ is a local submartingale exactly when it can be written as
$X = M + A$, where $M$ is a local martingale and $A$ is a process that starts at $0$, never
decreases, is right-continuous, is predictable, and is locally integrable. It also says that the
pair $M, A$ is unique up to a null set. Everything here is *local*: the martingale and integrability
properties are only required after stopping the process along a sequence of stopping times that
increases to infinity.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The time index is continuous, $\mathbb{R}_+$, and the underlying measure is a probability measure. | ✅ `ℱ : Filtration ℝ≥0 ‹MeasurableSpace Ω›`, `X : ℝ≥0 → Ω → ℝ`, `[IsProbabilityMeasure μ]`. |
| 2 | The filtration is right-continuous, and $X$ is adapted with a.e. right-continuous paths — Kallenberg's standing assumptions for this chapter. | ✅ `[ℱ.IsRightContinuous]`, `hX : Adapted ℱ X`, and `hXright : ∀ᵐ ω ∂μ, ∀ t, ContinuousWithinAt (fun s ↦ X s ω) (Ici t) t`. |
| 3 | Side (i) is that $X$ is a *local* submartingale in the text's sense: there are stopping times $\tau_n$ increasing to infinity such that each stopped and centred process $X^{\tau_n} - X_0$ is a genuine submartingale. | ✅ `IsLocalSubmartingale X ℱ μ`, which unfolds to `∃ τ, (∀ n, IsStoppingTime ℱ (τ n)) ∧ LocalizesToInfinity τ μ ∧ ∀ n, Submartingale (fun t ω ↦ stoppedProcess X (τ n) t ω - X ⊥ ω) ℱ μ`. |
| 4 | Side (ii) contains a *local* martingale $M$, defined by the same stopping construction. | ✅ `IsLocalMartingale M ℱ μ`, with the same centring `- X ⊥ ω` and the same `LocalizesToInfinity` requirement on the stopping times. |
| 5 | The two sides are joined by an "if and only if", so both directions are asserted. | ✅ The whole statement is `IsLocalSubmartingale X ℱ μ ↔ ∃ M A, …`. |
| 6 | The decomposition is $X = M + A$ off a null set, for all times at once. | ✅ `∀ᵐ ω ∂μ, ∀ t, X t ω = M t ω + A t ω` — one null set, then every time. |
| 7 | $A$ is locally integrable, again by stopping along a sequence of stopping times that increases to infinity. | ✅ `IsLocallyIntegrableProcess A ℱ μ`. |
| 8 | $A$ is predictable, i.e. measurable for the predictable $\sigma$-algebra of the filtration. This is the clause that makes the decomposition unique. | ✅ `IsStronglyPredictable ℱ A`, which is `StronglyMeasurable[ℱ.predictable] (Function.uncurry A)`. |
| 9 | $A$ is non-decreasing in $t$, has right-continuous paths, and starts at $0$. | ✅ `∀ᵐ ω ∂μ, Monotone fun t ↦ A t ω`, `∀ᵐ ω ∂μ, ∀ t, ContinuousWithinAt (fun s ↦ A s ω) (Ici t) t`, and `A 0 =ᵐ[μ] 0`. |
| 10 | Uniqueness: any second pair $(M', A')$ with all the same properties agrees with $(M, A)$ off a null set. | ✅ The last clause re-imposes every listed property on `M'` and `A'` and then concludes `(∀ᵐ ω ∂μ, ∀ t, M t ω = M' t ω) ∧ ∀ᵐ ω ∂μ, ∀ t, A t ω = A' t ω`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Using Mathlib's `Submartingale` and `Martingale` directly in place of the localized notions. | That states the classical Doob–Meyer theorem for class-(D) submartingales, a different and much weaker result than Theorem 10.5. |
| 2 | Requiring only `Adapted ℱ A` instead of predictability. | With merely adapted $A$ the decomposition still exists but is wildly non-unique in continuous time, so the uniqueness half of the theorem becomes false. |
| 3 | Dropping $A_0 = 0$. | Without it, $(M - c, A + c)$ is another decomposition for any constant $c$, so uniqueness fails. |
| 4 | Dropping local integrability of $A$, or dropping monotonicity or right-continuity of $A$. | Each is part of Kallenberg's definition of an increasing process; without them the class of admissible $A$ is larger and uniqueness fails. |
| 5 | Stating only "(ii) implies (i)", or stating the decomposition without any uniqueness claim. | The theorem is an equivalence plus uniqueness; either omission loses content. |
| 6 | Quantifying uniqueness only over pairs with $M' + A' = X$, without re-imposing the other properties on $(M', A')$. | Then the claim is false: $X = (M + f) + (A - f)$ for any process $f$, so agreement cannot follow. |
| 7 | Writing the decomposition as a per-time statement, `∀ t, X t =ᵐ[μ] M t + A t`. | That allows a different null set for each $t$, i.e. only a modification. For right-continuous processes it happens to be equivalent, but as written it is strictly weaker than what the text asserts. The same applies to the uniqueness conclusions. |
| 8 | Dropping right-continuity of $X$ or of the filtration. | Both are standing assumptions in this chapter, and the continuous-time decomposition is not available without them. |

## Notes on the ground truth

- `stoppedProcess X (τ n) t ω` is `X (min ↑t (τ n ω)).untopA ω`. Because the minimum is taken against
  a finite time `t`, the `WithTop` argument is never `⊤`, so no arbitrary default value ever leaks
  into the localized definitions. A bare `stoppedValue X τ` would hit `Classical.arbitrary` when
  `τ = ⊤`; nothing here does.
- The uniqueness clause is placed *inside* the existential, so the statement reads "there exist $M$
  and $A$ with the listed properties such that any other such pair agrees with them". That is
  logically the same as "a decomposition exists and is unique", and avoids repeating the property
  list. A separate uniqueness theorem would be more idiomatic Mathlib packaging.
- An earlier version of this file stated the decomposition and the uniqueness conclusions only
  per-time (`∀ t, X t =ᵐ[μ] M t + A t`). It now uses the `∀ᵐ ω, ∀ t` form, which is the reading the
  text intends. Mistake row 7 keeps the weaker form on record.
- ⚠️ `LocalizesToInfinity τ μ` asks for `∀ᵐ ω ∂μ, Tendsto (fun n ↦ τ n ω) atTop atTop` where the
  stopping times take values in `WithTop ℝ≥0`. Because `WithTop ℝ≥0` has a largest element, the
  target `atTop` filter is the principal filter at `⊤`, so this demands that $\tau_n(\omega)$ be
  *equal to* $+\infty$ for all large $n$, rather than merely growing without bound. The intended
  reading, "$\tau_n \uparrow \infty$", is `Tendsto (fun n ↦ τ n ω) atTop (𝓝 ⊤)`. A candidate that
  writes the neighbourhood-of-$\top$ form is closer to the text than the ground truth is here.
- ⚠️ `IsLocallyIntegrableProcess A ℱ μ` asks that `stoppedProcess A (τ n) t` be integrable for every
  finite `t`. Kallenberg's local integrability is $\mathbb{E}\,A_{\tau_n} < \infty$, which is the
  supremum over `t` of those quantities and is therefore slightly stronger.
