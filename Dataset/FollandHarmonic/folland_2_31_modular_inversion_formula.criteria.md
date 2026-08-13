# Criteria: folland_2_31_modular_inversion_formula

**Statement:** [folland_2_31_modular_inversion_formula.md](folland_2_31_modular_inversion_formula.md) · **Lean:** [folland_2_31_modular_inversion_formula.lean](folland_2_31_modular_inversion_formula.lean)

## What the theorem says

Fix a left Haar measure $\lambda$ on a locally compact group $G$, and let $\Delta$ be the modular
function, defined by $\lambda(Ex) = \Delta(x)\lambda(E)$. Inverting the group, $x \mapsto x^{-1}$,
does not preserve $\lambda$ unless $G$ is unimodular. The theorem says exactly what weight repairs
it: for every integrable $f$,

$$\int_G f(x^{-1})\,\Delta(x^{-1})\,d\lambda(x) = \int_G f(x)\,d\lambda(x).$$

So the measure $\Delta(x^{-1})\,d\lambda(x)$ is a right Haar measure, and pushing it forward under
inversion gives back $\lambda$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $G$ is a locally compact topological group carrying its Borel structure. | ✅ `[IsTopologicalGroup G] [LocallyCompactSpace G] [MeasurableSpace G] [BorelSpace G]`. |
| 2 | $\mu$ is a **left** Haar measure. | ✅ `(μ : Measure G) [μ.IsHaarMeasure]`; Mathlib's `IsHaarMeasure` is the left-invariant notion. |
| 3 | $f$ is integrable. Both sides must be genuine integrals. | ✅ `hf : Integrable f μ`. |
| 4 | The left integrand evaluates $f$ at the **inverse** of the variable. | ✅ `f x⁻¹`. |
| 5 | That value is multiplied by the modular weight; the weight is Folland's $\Delta(x^{-1})$. | ✅ `f x⁻¹ * ((Measure.modularCharacterFun x : ℝ≥0) : ℝ)` — Mathlib's `modularCharacterFun x` *is* Folland's $\Delta(x^{-1})$; see the notes. |
| 6 | The right side is the plain integral of $f$ against the same measure $\mu$. | ✅ `∫ x, f x ∂μ`. |
| 7 | The identity holds for all integrable $f$, not only for continuous compactly supported ones. | ✅ `f : G → ℂ` with only `Integrable f μ`. |
| 8 | The weight sits inside the integral, multiplying the integrand pointwise. | ✅ It is part of the integrand of `∫ x, …  ∂μ`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Writing `Measure.modularCharacterFun x⁻¹` as the weight. | In Mathlib's convention that expression is Folland's $\Delta(x)$, the reciprocal of the correct weight. The two agree on every unimodular group, so this error is invisible on all abelian and all compact examples; the $ax+b$ group separates them. This is the highest-value trap in this problem. |
| 2 | Omitting the modular weight altogether, i.e. asserting $\int f(x^{-1})\,dx = \int f\,dx$. | That says inversion preserves left Haar measure, which is true only when $G$ is unimodular. |
| 3 | Pulling $\Delta$ out of the integral, as $\Delta(x)^{-1}\int f(x^{-1})\,dx$. | $\Delta$ depends on the integration variable; there is no fixed $x$ to pull out. The resulting expression is not even a number. |
| 4 | Dropping the integrability hypothesis. | Lean gives the Bochner integral of a non-integrable function the value `0`. Both sides could then be `0` for that reason and the identity would hold without meaning anything. |
| 5 | Using a right Haar measure, or an arbitrary invariant measure. | With a right Haar measure the correct weight is the other one; the formula as printed becomes false. |
| 6 | Restricting to $f \in C_c(G)$. | True but strictly weaker than the printed theorem, which is stated for all of $L^1$. |
| 7 | Raising $\Delta$ to a power, e.g. $\Delta(x^{-1})^{1/2}$ or $\Delta(x^{-1})^2$. | The half-power appears in the related formula for the $L^2$ isometry, not here. Only the first power makes the two sides equal. |

## Notes on the ground truth

- **Convention.** Mathlib's `Measure.modularCharacterFun` satisfies
  `map (· * g) μ = modularCharacterFun g • μ`, i.e. $\mu(Ag^{-1}) = \Delta_M(g)\,\mu(A)$. Folland's
  $\Delta$ satisfies $\lambda(Ex) = \Delta(x)\lambda(E)$, so $\Delta_M(g) = \Delta_{\text{Folland}}(g)^{-1}$
  and therefore Folland's $\Delta(x^{-1})$ is Mathlib's `modularCharacterFun x`. The Lean statement
  writes `modularCharacterFun x` for this reason. An earlier version of this file wrote
  `modularCharacterFun x⁻¹` and stated the reciprocal identity; that was corrected.
- `modularCharacterFun` is `ℝ≥0`-valued, so the statement coerces it to `ℝ` in order to multiply it
  by the `ℂ`-valued `f x⁻¹` — the double coercion `((… : ℝ≥0) : ℝ)` is that, plus the automatic
  `ℝ → ℂ` coercion.
- The measure `μ` is an arbitrary left Haar measure, not a distinguished one; the identity is
  scale-invariant, so this is the right level of generality.
