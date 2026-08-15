# Criteria: grafakos_1_3_4_riesz_thorin_interpolation

**Statement:** [grafakos_1_3_4_riesz_thorin_interpolation.md](grafakos_1_3_4_riesz_thorin_interpolation.md) · **Lean:** [grafakos_1_3_4_riesz_thorin_interpolation.lean](grafakos_1_3_4_riesz_thorin_interpolation.lean) · **Context:** [grafakos_1_3_4_riesz_thorin_interpolation.context.md](grafakos_1_3_4_riesz_thorin_interpolation.context.md)

## What the theorem says

Take a complex-linear operator $T$ that is bounded from $L^{p_0}$ to $L^{q_0}$ with constant $M_0$
and from $L^{p_1}$ to $L^{q_1}$ with constant $M_1$. Pick a mixing parameter $\theta$ strictly
between $0$ and $1$ and form the interpolated exponents by mixing the reciprocals:
$1/p = (1-\theta)/p_0 + \theta/p_1$ and $1/q = (1-\theta)/q_0 + \theta/q_1$. Then $T$ is bounded from
$L^p$ to $L^q$, and the constant is the geometric mean $M_0^{1-\theta}M_1^{\theta}$ — no extra
factor. Grafakos states the hypotheses and the bound for finitely simple functions and then extends
$T$ by density when $p < \infty$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $T$ is linear over the *complex* numbers. | ✅ `T : (X → ℂ) →ₗ[ℂ] (Y → ℂ)`. |
| 2 | All four endpoint exponents are at least $1$, and each is allowed to be $\infty$. | ✅ `hexponents : 1 ≤ p₀ ∧ 1 ≤ p₁ ∧ 1 ≤ q₀ ∧ 1 ≤ q₁` with all exponents of type `ℝ≥0∞`, where the upper bound by `∞` is automatic. |
| 3 | The mixing parameter is strictly inside the interval: $0 < \theta < 1$. | ✅ `hθ : 0 < θ ∧ θ < 1`. |
| 4 | The interpolated exponents are pinned down by mixing the *reciprocals*, in a way that still makes sense when an endpoint exponent is $\infty$. | ✅ `hp : p⁻¹ = ENNReal.ofReal (1 - θ) * p₀⁻¹ + ENNReal.ofReal θ * p₁⁻¹` and the same for `q`, all in `ℝ≥0∞` where `(⊤)⁻¹ = 0` and `(0)⁻¹ = ⊤`. Because inversion on `ℝ≥0∞` is an involution, these equations determine `p` and `q`. |
| 5 | The two endpoint bounds: $T$ maps $L^{p_0}$ into $L^{q_0}$ with norm $\le M_0$, and $L^{p_1}$ into $L^{q_1}$ with norm $\le M_1$. | ✅ `h₀ : HasStrongType μ ν T p₀ q₀ M₀` and `h₁ : HasStrongType μ ν T p₁ q₁ M₁`, each giving `MemLp (T f) q _ ∧ eLpNorm (T f) q _ ≤ M * eLpNorm f p _`. |
| 6 | Both endpoint constants are finite. | ✅ `hM₀ : M₀ < ∞` and `hM₁ : M₁ < ∞`. |
| 7 | The conclusion has two halves: $Tf$ lies in $L^q$, and its norm is at most the constant times $\|f\|_p$. | ✅ `HasStrongType μ ν T p q _` carries both. |
| 8 | The constant is exactly the geometric mean $M_0^{1-\theta}M_1^{\theta}$, with $1-\theta$ attached to the *first* endpoint. | ✅ `ENNReal.rpow M₀ (1 - θ) * ENNReal.rpow M₁ θ`. |
| 9 | Both measure spaces are $\sigma$-finite. | ✅ `[SigmaFinite μ] [SigmaFinite ν]`, matching the text. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Making $T$ real-linear (`→ₗ[ℝ]`), or using a bare function with only an additivity hypothesis. | Riesz–Thorin is a complex interpolation theorem; the three-lines proof needs complex homogeneity, and the real-scalar analogue does not hold with these constants. |
| 2 | Doing the exponent arithmetic in the real numbers, e.g. `1 / p = (1 - θ) / p₀ + θ / p₁` with `p₀ : ℝ`. | Real division cannot express $p_0 = \infty$ at all, and Lean evaluates `1 / 0` as `0`, so a "$p_0 = \infty$" encoded as `p₀ = 0` silently produces a wrong equation. Being able to take an endpoint at $\infty$ is the main reason one interpolates. |
| 3 | Swapping the two exponents, writing $M_0^{\theta}M_1^{1-\theta}$. | At $\theta$ near $0$ the interpolated exponents are near the $p_0$ endpoint, so the constant must be near $M_0$. The swapped version is a different, generally false bound. |
| 4 | Replacing the constant by `∃ C, …`. | Discards the sharp multiplicative form that makes this theorem quotable. |
| 5 | Weakening to $0 \le \theta \le 1$. | At the endpoints the "conclusion" is just one of the hypotheses restated, and the statement is only interesting strictly inside. Grafakos writes $0 < \theta < 1$. |
| 6 | Dropping $1 \le p_0, p_1, q_0, q_1$ and allowing exponents below $1$. | The complex method genuinely needs these; below $1$ the $L^p$ "norms" are not norms and the duality argument fails. |

## Notes on the ground truth

- The text puts its hypotheses and its first conclusion on *finitely simple* functions and only then
  extends $T$ by density. The Lean version instead assumes the endpoint bounds on all of $L^{p_0}$
  and $L^{p_1}$ and concludes on all of $L^p$. This is a defensible reformulation — the extension
  clause becomes empty once $T$ is given on the whole space — but the "unique bounded extension"
  half of the text, the part that needs $p < \infty$ and density of simple functions, is silently
  dropped. A formalization that keeps `SimpleFunc`-valued hypotheses and adds a `∃!` extension clause
  is strictly more faithful.
- No measurability hypothesis on $Tf$ is needed here, unlike in the sublinear Marcinkiewicz
  statement. Because $T$ is linear, one can split $f = f\cdot\mathbf{1}_{\lvert f\rvert>1} +
  f\cdot\mathbf{1}_{\lvert f\rvert\le 1}$ into a piece in $L^{p_0}$ and a piece in $L^{p_1}$ and read
  measurability of $Tf$ off the endpoint hypotheses.
- `ENNReal.ofReal (1 - θ)` is used rather than `1 - ENNReal.ofReal θ`. Truncated subtraction in
  `ℝ≥0∞` would in fact agree here, but the literal reading is safer and should be accepted either
  way.
- `ENNReal.rpow` is well behaved for $0 \le M < \infty$ and $0 < \theta < 1$, so the constant carries
  no hidden default value.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[grafakos_1_3_4_riesz_thorin_interpolation.md](grafakos_1_3_4_riesz_thorin_interpolation.md) and the background in [grafakos_1_3_4_riesz_thorin_interpolation.context.md](grafakos_1_3_4_riesz_thorin_interpolation.context.md),
not against the ground-truth Lean file: a candidate spelled differently but
mathematically equivalent to the text loses nothing. The scale is defined in
[GRADING.md](../../GRADING.md); the numbers below are this problem's instance of it.

| Band | Points | This problem |
|---|---|---|
| A. Completeness | 50 | The requirement table above has 9 rows, so each row is worth 5.6 points: full credit if the candidate states it in any equivalent form, half for a harmless strengthening or weakening, none if it is absent. |
| B. Semantic fidelity | 20 | Junk values, `ℝ` vs `ℝ≥0∞`, coercions, quantifier order, a.e. vs everywhere — see the pitfalls below. |
| C. Mathlib-concept correctness | 15 | The Mathlib notion must mean the textbook notion, with the typeclass assumptions it needs. |
| D. Non-degeneracy | 10 | Not vacuous, not trivial, not a strictly weaker theorem. |
| E. Hygiene | 5 | No needless definitions, redundant conjuncts or unused hypotheses. |

**Every row of the *Mistakes to check for* table above is a defect.** Charge each one to the band it belongs to and deduct there.

### Fatal — any of these caps the total at 25

- Requirement 1 with $T$ only real-linear.
- Requirement 4 with the exponents mixed directly rather than reciprocally.
- Requirement 8 with an extra constant factor, or with $\theta$ and $1-\theta$ attached to the wrong endpoints.

### Domain-specific pitfalls for this problem

- Reciprocal mixing means the identity is about $p^{-1}$; in `ℝ≥0∞` the inverse of $\infty$ is $0$, which is exactly the convention that makes the endpoint cases work.
- The hypotheses are strong-type at both endpoints; a weak-type hypothesis would be Marcinkiewicz.
- $T$ is defined on finitely simple functions only; asserting it on all of $L^{p_0}$ changes the hypothesis.
- Both measure spaces are $\sigma$-finite here, unlike in Marcinkiewicz where only the domain is.
- The density extension claim for $p < \infty$ is a further assertion, with uniqueness of the extension.
