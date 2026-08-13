# Criteria: bogachev_3_7_1_change_of_variables_in_Rn

**Statement:** [bogachev_3_7_1_change_of_variables_in_Rn.md](bogachev_3_7_1_change_of_variables_in_Rn.md) · **Lean:** [bogachev_3_7_1_change_of_variables_in_Rn.lean](bogachev_3_7_1_change_of_variables_in_Rn.lean)

## What the theorem says

Take an open set $U$ in $\mathbb{R}^n$ and a continuously differentiable map $F$ on $U$ that is
injective there. Then $F$ changes variables in integrals exactly as expected: for any measurable
$A \subseteq U$ and any integrable function $g$ on $\mathbb{R}^n$, integrating $g \circ F$ against
the absolute value of the Jacobian determinant over $A$ gives the same number as integrating $g$
over the image $F(A)$. The absolute value matters because $F$ is not assumed to preserve
orientation.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $U$ is open. This comes from the surrounding text, not from the theorem sentence. | ✅ `hU : IsOpen U`. |
| 2 | $F$ is continuously differentiable on $U$. Also from the surrounding text. | ✅ `hF : ContDiffOn ℝ 1 F U`. |
| 3 | $F$ is injective on $U$ (not necessarily on all of $\mathbb{R}^n$). | ✅ `hinj : InjOn F U`. |
| 4 | $A$ is a Lebesgue measurable set and $A \subseteq U$. | ✅ `hA : NullMeasurableSet A volume` and `hAU : A ⊆ U`. |
| 5 | $g$ is a Borel function lying in $L^1(\mathbb{R}^n)$, i.e. integrable over all of $\mathbb{R}^n$, not merely over the image. | ⚠️ `hg : Integrable g volume` gives integrability plus measurability up to null sets, which is the usual Mathlib reading; it does not literally say "Borel". Acceptable, and the printed conclusion is unaffected. |
| 6 | The left side integrates over $A$ the product $g(F(x)) \cdot \lvert \det F'(x)\rvert$. | ✅ `∫ x in A, g (F x) * \|(fderivWithin ℝ F U x).det\| ∂volume`. |
| 7 | The Jacobian is the determinant of the derivative of $F$ taken inside $U$, where $F$ is actually differentiable. | ✅ `fderivWithin ℝ F U x`. |
| 8 | The determinant carries an absolute value. | ✅ `\|(fderivWithin ℝ F U x).det\|`. |
| 9 | The right side integrates $g$ over the image set $F(A)$. | ✅ `∫ y in F '' A, g y ∂volume`. |
| 10 | The dimension $n$ is arbitrary. | ✅ `{n : ℕ}` with everything living in `Fin n → ℝ`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Dropping the absolute value on the determinant. | The determinant can be negative, and then the two sides differ in sign: for $F(x) = -x$ on $\mathbb{R}^1$ the left side would come out negative while the right side is positive. |
| 2 | Omitting injectivity of $F$ on $U$. | Without it the map can fold $U$ onto its image and the left side counts the same image points several times. The identity is false already for $F(x) = x^2$ on $(-1,1)$. |
| 3 | Omitting openness of $U$ or continuous differentiability of $F$. | Both are stated in the book's surrounding prose. A model that reads only the theorem sentence typically loses one of them, and the statement is false without them. |
| 4 | Quantifying $A$ over Borel sets (`MeasurableSet A`) only. | The book says "any measurable set", meaning Lebesgue measurable. Borel-only is a strictly weaker theorem. |
| 5 | Assuming only that $g$ is integrable on $F(A)$. | The book assumes $g \in L^1(\mathbb{R}^n)$. Assuming less about $g$ makes the claim stronger than the printed one; assuming $g$ continuous makes it weaker. Neither is the theorem in the book. |
| 6 | Integrating the right side over $U$, or over a preimage $F^{-1}(A)$, instead of over the image $F(A)$. | A different identity. The right side must be over $F(A)$. |
| 7 | Restating everything for nonnegative $g$ with lower integrals `∫⁻`. | Then $g \in L^1$ loses its signed content, and the printed statement covers signed $g$. |

## Notes on the ground truth

- `fderivWithin ℝ F U x` and `fderiv ℝ F x` agree at points of the open set $U$ where $F$ is
  differentiable, so a candidate using `fderiv` is not wrong here. `fderivWithin` was chosen because
  `F` is a total Lean function and `fderiv ℝ F x` returns the default value $0$ at any point where
  the *global* map fails to be differentiable — the within-version does not depend on that
  side condition being checked.
- $\mathbb{R}^n$ is modelled as `Fin n → ℝ` with `volume`, the product Lebesgue measure. This is the
  same measure space as `EuclideanSpace ℝ (Fin n)`; only the norm differs, and no norm appears here.
- The shape of the statement follows Mathlib's own
  `MeasureTheory.integral_image_eq_integral_abs_det_fderiv_smul`, which also uses `f '' s` on the
  right and `fderivWithin` in the Jacobian, so a candidate can be compared against the library form
  term by term.
- Both integrals are Bochner integrals `∫`. Under the hypotheses both integrands are genuinely
  integrable, so no value is silently defaulting to $0$.
