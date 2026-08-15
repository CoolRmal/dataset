# Criteria: grafakos_2_2_14_fourier_identities_on_schwartz

**Statement:** [grafakos_2_2_14_fourier_identities_on_schwartz.md](grafakos_2_2_14_fourier_identities_on_schwartz.md) · **Lean:** [grafakos_2_2_14_fourier_identities_on_schwartz.lean](grafakos_2_2_14_fourier_identities_on_schwartz.lean) · **Context:** [grafakos_2_2_14_fourier_identities_on_schwartz.context.md](grafakos_2_2_14_fourier_identities_on_schwartz.context.md)

## What the theorem says

Five identities for Schwartz functions on $\mathbb{R}^n$. The multiplication formula says you may
move the hat from one factor to the other inside an integral. Fourier inversion says the forward and
inverse transforms undo each other in both orders. Parseval's relation says the transform preserves
the $L^2$ inner product, and Plancherel's identity says it preserves the $L^2$ norm — as does the
inverse transform. The last identity pairs $f$ against $h$ and, on the other side, $\widehat f$
against $h^{\vee}$. All five are constant-free, with no factors of $2\pi$ anywhere, and that is only
correct because Grafakos normalizes the transform as $\widehat f(\xi) = \int f(x)e^{-2\pi i x\cdot\xi}\,dx$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. In the assessment column, ✅ means the ground truth states the requirement and
◐ means it states it in a form that deliberately departs from the text — a narrower setting, a
stronger hypothesis, or an equivalent but not literal phrasing — with the reason given. A ◐ records
a decision, not an open defect; where a more literal rendering would be at least as good, the row
says so.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The transform is $\int f(x)e^{-2\pi i x\cdot\xi}dx$ against Lebesgue measure, with no normalizing prefactor. | ✅ The scoped `𝓕` and `𝓕⁻` on `𝓢(EuclideanSpace ℝ (Fin n), ℂ)`. Mathlib's `𝓕` is `VectorFourier.fourierIntegral 𝐞 volume (innerₗ V)` with `𝐞 t = exp (2 * π * i * t)`, exactly Grafakos's convention, and the Schwartz-space instance agrees with it. |
| 2 | Identity (1), the multiplication formula: $\int f\,\widehat g = \int \widehat f\, g$. | ✅ `(∫ x, f x * 𝓕 g x) = ∫ x, 𝓕 f x * g x`. |
| 3 | Identity (2), inversion in *both* orders: $(\widehat f)^{\vee} = f$ and $\widehat{(f^{\vee})} = f$. | ✅ `𝓕⁻ (𝓕 f) = f ∧ 𝓕 (𝓕⁻ f) = f`, and these are equalities of Schwartz maps, not merely almost-everywhere or pointwise equalities. |
| 4 | Identity (3), Parseval: the pairing uses the complex conjugate of one factor, so it is the $L^2$ inner product and not the bilinear pairing of identity (1). | ✅ `(∫ x, f x * star (h x)) = ∫ x, 𝓕 f x * star (𝓕 h x)`, the printed identity read literally, with `h` in the role the text gives it. |
| 5 | Identity (4), Plancherel for *both* transforms: $\|f\|_2 = \|\widehat f\|_2$ and $\|f\|_2 = \|f^{\vee}\|_2$. | ✅ `eLpNorm (fun x ↦ 𝓕 f x) 2 volume = eLpNorm f 2 volume` and `eLpNorm (fun x ↦ 𝓕⁻ f x) 2 volume = eLpNorm f 2 volume`. |
| 6 | Identity (5): $\int f\,h = \int \widehat f\,h^{\vee}$ — the inverse transform paired with $h$. | ✅ `(∫ x, f x * h x) = ∫ x, 𝓕 f x * 𝓕⁻ h x`. |
| 7 | All three functions live in the Schwartz class, so every integral in sight converges. | ✅ `f g h : 𝓢(EuclideanSpace ℝ (Fin n), ℂ)`; products of Schwartz functions are Schwartz, hence integrable, and `𝓕` maps the Schwartz class to itself, so no Bochner integral here can quietly evaluate to the default value `0`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Hand-rolling the transform as `∫ x, Complex.exp (-Complex.I * ⟪x, ξ⟫) * f x`, or inserting a $(2\pi)^{-n/2}$ factor. | Under the $e^{-ix\cdot\xi}$ convention, identities (3), (4) and (5) pick up powers of $2\pi$ and are false as written. The constant-free form is tied to the $2\pi$-in-the-exponent normalization. |
| 2 | Writing the last conjunct as identity (1) again with $g := h$, e.g. `(∫ x, 𝓕 f x * h x) = ∫ x, f x * 𝓕 h x`. | That is the multiplication formula with the sides transposed, not identity (5). Identity (5) is the only place where $h^{\vee}$ occurs, and it must appear. An earlier version of this ground truth made exactly this substitution. |
| 3 | Stating only one direction of inversion, e.g. only `𝓕⁻ (𝓕 f) = f`. | One direction alone does not say the transform is a bijection of the Schwartz class; both composites are asserted in the text. |
| 4 | Stating Plancherel only for $\widehat f$ and omitting $f^{\vee}$, or stating it as an inequality `≤`. | The text asserts two equalities. An inequality is a weaker statement — that one is Hausdorff–Young, Proposition 2.2.16, a different result. |
| 5 | Writing Parseval without any conjugation. | Without the conjugate it collapses to the bilinear identity (1) and no longer expresses preservation of the $L^2$ inner product. |
| 6 | Stating the identities for merely $L^1$ or $L^2$ functions instead of Schwartz functions. | Products such as $f\widehat g$ then need not be integrable, and Lean gives a non-integrable Bochner integral the value `0`, so several of the identities would become claims about `0 = 0`. The theorem is stated on $\mathcal{S}$ for a reason. |

## Notes on the ground truth

- `star` on `ℂ` is complex conjugation, so the choice of `star` over `starRingEnd ℂ` makes no
  difference.
- Inversion is stated as equality *in* `𝓢(EuclideanSpace ℝ (Fin n), ℂ)`, which is the strongest
  faithful reading. Stating it pointwise for the underlying functions is equivalent on the Schwartz
  class via `SchwartzMap.ext` and should be accepted.
- The exponent in the Plancherel conjuncts is the `ℝ≥0∞` literal `2` rather than
  `ENNReal.ofReal 2`; these agree.
- The ambient space is `EuclideanSpace ℝ (Fin n)` because the Fourier-transform instance on the
  Schwartz class needs a finite-dimensional real inner-product space, and `volume` there is
  $n$-dimensional Lebesgue measure.
- The final conjunct was repaired: it previously duplicated identity (1) with `g := h`, leaving
  identity (5) unstated and `h` carrying no content of its own.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[grafakos_2_2_14_fourier_identities_on_schwartz.md](grafakos_2_2_14_fourier_identities_on_schwartz.md) and the background in [grafakos_2_2_14_fourier_identities_on_schwartz.context.md](grafakos_2_2_14_fourier_identities_on_schwartz.context.md),
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

- Requirement 2 and 4 conflated: stating the bilinear multiplication formula in place of Parseval, or vice versa.
- Requirement 3 with only one order of inversion.
- Requirement 5 with only one of the two Plancherel equalities.

### Domain-specific pitfalls for this problem

- The Fourier normalization must be Grafakos's $e^{-2\pi i x\cdot\xi}$ with no prefactor; every identity here is constant-free only for that choice.
- Identity (1) is bilinear, identity (3) sesquilinear, identity (5) bilinear with an inverse transform — three different pairings that must not be merged.
- `star` on `ℂ` is complex conjugation; applying it to both factors, or to neither, changes identity (3).
- Plancherel is an equality of $L^2$ norms of Schwartz functions, so no completion or a.e. class is involved.
- All five identities are asserted together; each is a separate claim.
