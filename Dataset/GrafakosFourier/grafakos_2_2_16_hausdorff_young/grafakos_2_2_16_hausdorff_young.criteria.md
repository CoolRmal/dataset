# Criteria: grafakos_2_2_16_hausdorff_young

**Statement:** [grafakos_2_2_16_hausdorff_young.md](grafakos_2_2_16_hausdorff_young.md) · **Lean:** [grafakos_2_2_16_hausdorff_young.lean](grafakos_2_2_16_hausdorff_young.lean) · **Context:** [grafakos_2_2_16_hausdorff_young.context.md](grafakos_2_2_16_hausdorff_young.context.md)

## What the theorem says

For $1 \le p \le 2$ the Fourier transform carries $L^p(\mathbb{R}^n)$ into $L^{p'}$, where $p'$ is
the conjugate exponent $p/(p-1)$ (so $p' = \infty$ at $p = 1$ and $p' = 2$ at $p = 2$), and the norm
does not grow: $\|\widehat f\|_{p'} \le \|f\|_p$, with no constant in front. The subtlety hides in
the symbol $\widehat f$: for $p > 1$ a function in $L^p$ need not be integrable, so the defining
integral $\int f(x)e^{-2\pi i x\cdot\xi}dx$ need not converge. There, $\widehat f$ means the
extension of the transform from nice functions, obtained as a limit.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The exponent range is exactly $1 \le p \le 2$, both endpoints included. | ✅ `hp : 1 ≤ p ∧ p ≤ 2`. |
| 2 | The hypothesis on $f$ is membership in $L^p$ and nothing more. | ✅ `hf : MemLp f (ENNReal.ofReal p) volume`, with `f : EuclideanSpace ℝ (Fin n) → ℂ` a total function and `volume` supplying the geometry. |
| 3 | The conjugate exponent is $p/(p-1)$, with the $p = 1$ case sent to $\infty$ rather than to whatever $p/(p-1)$ evaluates to there. | ✅ `let conjugateExponent : ℝ≥0∞ := if p = 1 then ∞ else ENNReal.ofReal (p / (p - 1))`, giving $\infty$ at $p=1$ and $2$ at $p=2$. |
| 4 | $\widehat f$ is the *extended* transform, not the raw integral. | ✅ Two conjuncts: such an `F` exists, **and** every `F` satisfying `IsLpFourierTransform` obeys the bound. The universal half is the faithful one — "the" transform is a definite object, unique up to a null set — and it is strictly stronger than producing one good `F`. |
| 5 | The membership claim: the transform lies in $L^{p'}$. | ✅ `MemLp F conjugateExponent volume`. |
| 6 | The norm inequality itself. | ✅ `eLpNorm F conjugateExponent volume ≤ eLpNorm f (ENNReal.ofReal p) volume`. |
| 7 | The bound is constant-free — the implied constant is exactly $1$. | ✅ No constant appears, which is correct for Grafakos's $e^{-2\pi i x\cdot\xi}$ normalization, the one Mathlib's `𝓕` uses. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Applying Mathlib's `𝓕` directly to an arbitrary $f \in L^p$ and bounding `eLpNorm (𝓕 f) …`. | `𝓕 f w` is the Bochner integral `∫ v, 𝐞 (-⟪v,w⟫) • f v`, and Lean gives a non-integrable Bochner integral the value `0`. Since the exponential factor has modulus $1$, the integrand is integrable exactly when $f$ is. So for every $f \in L^p \setminus L^1$ the statement degenerates to $0 \le \|f\|_p$ and says nothing on the whole interesting range. This was a real defect in an earlier version of the ground truth. |
| 2 | Writing the conjugate exponent as `ENNReal.ofReal (p / (p - 1))` with no special case at $p = 1$. | In `ℝ`, `1 / 0 = 0`, so the exponent becomes `ENNReal.ofReal 0 = 0`, and `eLpNorm F 0 volume = 0`. The $p = 1$ case — the one case where no extension is needed at all — would then read $0 \le \|f\|_1$. |
| 3 | Restricting to $1 < p \le 2$. | Drops the $p = 1$ endpoint, which is the Riesz–Thorin input and the only fully elementary case. |
| 4 | Allowing $p > 2$. | False: for $p > 2$ the transform of an $L^p$ function need not be a function at all. |
| 5 | Weakening the conclusion to `∃ C, eLpNorm F _ ≤ C * eLpNorm f _`. | The sharpness — constant $1$ — is exactly what makes 2.2.16 quotable. |
| 6 | Stating only the norm inequality and dropping the claim that the transform lies in $L^{p'}$. | Membership in $L^{p'}$ (which bundles almost-everywhere measurability) is part of the assertion "$\widehat f \in L^{p'}$ with $\|\widehat f\|_{p'} \le \|f\|_p$", not a side remark. |
| 7 | Working on `(Fin n → ℝ) → ℂ` instead of `EuclideanSpace ℝ (Fin n) → ℂ`. | The Fourier-transform machinery needs a real inner-product space; on the plain function type the norm is the sup norm and the instance does not apply. |

## Notes on the ground truth

- The `if p = 1 then ∞ else …` branch works but is not the idiomatic encoding of a conjugate
  exponent. Taking `p q : ℝ≥0∞` with `hpq : p⁻¹ + q⁻¹ = 1` needs no branch, no `Decidable` instance,
  and gets the $p = 1$ case right automatically because `(⊤)⁻¹ = 0` in `ℝ≥0∞`.
- `IsLpFourierTransform` is defined in `Defs.lean` by completion from Schwartz maps rather than by
  taking a limit of truncated integrals. Either route defines the same operator.
- An honest alternative is to add `Integrable f`, use Mathlib's `𝓕 f` directly, and state the bound
  on $L^1 \cap L^p$; by density that carries the same information. A candidate that does this should
  be judged faithful, not penalized for adding a hypothesis.
- $L^p$ here is `MemLp f (ENNReal.ofReal p) volume` on `EuclideanSpace ℝ (Fin n)`, so `volume` is
  $n$-dimensional Lebesgue measure.
- The current statement replaces an earlier one that bounded `eLpNorm (𝓕 f) …` directly and was
  therefore empty for non-integrable $f$.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[grafakos_2_2_16_hausdorff_young.md](grafakos_2_2_16_hausdorff_young.md) and the background in [grafakos_2_2_16_hausdorff_young.context.md](grafakos_2_2_16_hausdorff_young.context.md),
not against the ground-truth Lean file: a candidate spelled differently but
mathematically equivalent to the text loses nothing. The scale is defined in
[GRADING.md](../../GRADING.md); the numbers below are this problem's instance of it.

| Band | Points | This problem |
|---|---|---|
| A. Completeness | 50 | The requirement table above has 7 rows, so each row is worth 7.1 points: full credit if the candidate states it in any equivalent form, half for a harmless strengthening or weakening, none if it is absent. |
| B. Semantic fidelity | 20 | Junk values, `ℝ` vs `ℝ≥0∞`, coercions, quantifier order, a.e. vs everywhere — see the pitfalls below. |
| C. Mathlib-concept correctness | 15 | The Mathlib notion must mean the textbook notion, with the typeclass assumptions it needs. |
| D. Non-degeneracy | 10 | Not vacuous, not trivial, not a strictly weaker theorem. |
| E. Hygiene | 5 | No needless definitions, redundant conjuncts or unused hypotheses. |

**Every row of the *Mistakes to check for* table above is a defect.** Charge each one to the band it belongs to and deduct there.

### Fatal — any of these caps the total at 25

- Requirement 3 with the conjugate exponent wrong at $p=1$, e.g. computed by a division that returns a junk value there.
- Requirement 4 with $\widehat f$ read as the defining integral, which need not converge for $f \in L^p$, $p>1$.
- Requirement 7 with an unspecified constant in place of $1$.

### Domain-specific pitfalls for this problem

- Junk value — division: $p/(p-1)$ at $p=1$ is a division by zero, which in Lean is `0`, not `∞`. The $p=1$ case has to be handled explicitly.
- The transform on $L^p$ is defined by extension from a dense class; the statement must identify the object it is bounding, not assume the raw integral converges.
- The exponent must live in a type containing $\infty$, since $p' = \infty$ at $p = 1$.
- The inequality has no constant; inserting one weakens the proposition.
- The range $1 \le p \le 2$ includes both endpoints.
