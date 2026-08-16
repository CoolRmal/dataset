# Criteria: mattila_14_10_marstrand_density_integer

**Statement:** [mattila_14_10_marstrand_density_integer.md](mattila_14_10_marstrand_density_integer.md) · **Lean:** [mattila_14_10_marstrand_density_integer.lean](mattila_14_10_marstrand_density_integer.lean) · **Context:** [mattila_14_10_marstrand_density_integer.context.md](mattila_14_10_marstrand_density_integer.context.md)

## What the theorem says

Marstrand's theorem says that fractional dimensions do not support well-behaved densities. Fix
$s > 0$ and a Radon measure $\mu$ on $\mathbb{R}^n$. Consider the ratio $\mu(B(a,r))/(2r)^s$ as the
radius shrinks to $0$. If this ratio has an honest limit, and that limit is neither $0$ nor $\infty$,
at all points of some set of positive $\mu$ measure, then $s$ must be a whole number. The force of
the theorem is in "honest limit": if one only asks for the $\limsup$ to be positive and finite, the
conclusion is false for every non-integer $s$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. In the assessment column, ✅ means the ground truth states the requirement and
◐ means it states it in a form that deliberately departs from the text — a narrower setting, a
stronger hypothesis, or an equivalent but not literal phrasing — with the reason given. A ◐ records
a decision, not an open defect; where a more literal rendering would be at least as good, the row
says so.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $s$ is a positive real. | ✅ `hs : 0 < s`. |
| 2 | $\mu$ is a Radon measure on $\mathbb{R}^n$: finite on compact sets and inner regular. | ✅ `hμ : IsFiniteMeasureOnCompacts μ ∧ Measure.InnerRegular μ`. |
| 3 | There is a set $E$ of positive $\mu$ measure on which the density condition holds, and $E$ is not required to be measurable. | ✅ `∃ E : Set (EuclideanSpace ℝ (Fin n)), 0 < μ E ∧ ∀ x ∈ E, …`, with no measurability side condition — mathlib measures are outer measures, defined on every set. |
| 4 | At each point of $E$ the density is a genuine limit as $r \downarrow 0$, not merely an upper limit. | ✅ `Tendsto (fun r : ℝ ↦ μ (closedBall x r) / ENNReal.ofReal ((2 * r) ^ s)) (𝓝[>] 0) (𝓝 θ)`. |
| 5 | The limit value is strictly positive and strictly finite. | ✅ `0 < θ ∧ θ < ∞`, with `θ : ℝ≥0∞`. |
| 6 | The limit value is allowed to vary from point to point. | ✅ `∀ x ∈ E, ∃ θ, …` — the existential sits inside the quantifier over points. |
| 7 | The density is normalized by $(2r)^s$, matching Mattila's diameter convention. | ✅ `ENNReal.ofReal ((2 * r) ^ s)` in the denominator. |
| 8 | The conclusion is that $s$ is an integer. | ✅ `∃ m : ℕ, s = m`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Using a `limsup` (for instance reusing `upperHausdorffDensity` from `Defs.lean`) or a `liminf` in place of the limit. | Sets whose *upper* density is positive and finite exist in abundance for non-integer $s$, so the theorem would be false as stated. Existence of the limit is the whole hypothesis. |
| 2 | Writing `∃ θ, ∀ x ∈ E, …`, with one limit value for all points. | That demands a single common density across $E$, which is a strictly weaker hypothesis and a misreading of the text. |
| 3 | Adding `MeasurableSet E`. | It strengthens the hypothesis and so weakens the theorem; the book only asks for a set of positive measure. |
| 4 | Making the density real-valued, e.g. via `ENNReal.toReal`. | `toReal` sends `∞` to `0`, so "the density is finite" could no longer be stated, and points with infinite density would masquerade as points with density $0$. |
| 5 | Adding `[IsFiniteMeasure μ]`, compact support, or any other convenience hypothesis on $\mu$. | Marstrand's theorem assumes only that $\mu$ is Radon. Extra hypotheses narrow it. |
| 6 | Dropping `0 < θ` or `θ < ∞`. | With $\theta = 0$ allowed, any measure works and the conclusion fails; with $\theta = \infty$ allowed, likewise. Both bounds are hypotheses. |
| 7 | Dropping `0 < s`. | It is the text's standing assumption and is what makes the conclusion meaningful together with the `∃ m : ℕ` form. |

## Notes on the ground truth

- The quotient lives in `ℝ≥0∞`. For `r > 0` the denominator `ENNReal.ofReal ((2 * r) ^ s)` is
  positive and finite, so the ratio is never `0/0` or `∞/∞`, and the filter `𝓝[>] 0` never sees the
  junk values of `Real.rpow` at nonpositive base.
- Unlike Theorem 6.2, where the constants $2^{-s}$ and $1$ depend on the normalization, here the
  choice between $(2r)^s$ and $r^s$ only rescales the density by $2^s$ and changes nothing about
  "positive and finite". A candidate dividing by `r ^ s` is still faithful.
- `μ ≠ 0` is not assumed; it follows from `0 < μ E`.
- **Deliberate departure.** `IsFiniteMeasureOnCompacts` and `Measure.InnerRegular` are classes, so instance binders
  `[IsFiniteMeasureOnCompacts μ] [μ.InnerRegular]` would be more idiomatic than the conjunction
  `hμ`. On $\mathbb{R}^n$ inner regularity is automatic for locally finite Borel measures, so that
  component carries no content here.
- "$s$ is an integer" is `∃ m : ℤ, s = m`, the literal rendering.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[mattila_14_10_marstrand_density_integer.md](mattila_14_10_marstrand_density_integer.md) and the background in [mattila_14_10_marstrand_density_integer.context.md](mattila_14_10_marstrand_density_integer.context.md),
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

- Requirement 4 with an upper or lower density in place of a genuine limit.
- Requirement 5 with either positivity or finiteness of the limit dropped.
- Requirement 7 with the normalization $r^s$ instead of $(2r)^s$.

### Domain-specific pitfalls for this problem

- The density is a two-sided limit as $r \downarrow 0$; a `limsup` version is a different (and false) statement.
- The normalization uses the diameter $2r$, Mattila's convention.
- The density value may depend on the point, so the existential over it sits inside the quantifier over $a$.
- "Radon" is finiteness on compacts plus inner regularity.
- The exceptional set has positive $\mu$ measure — positive, not full.
