# Criteria: proposition_5_5_4

**Statement:** [proposition_5_5_4.md](proposition_5_5_4.md) · **Lean:** [proposition_5_5_4.lean](proposition_5_5_4.lean)

Three conclusions must all be captured: the outer-measure bound $\lambda(f(E)) \le \int_E |f'|$, Lusin's property (N) on $E$, and the Lipschitz-type bound $\lambda(f(E)) \le L\,\lambda(E)$ under a uniform derivative bound. The integrand $|f'|$ is not assumed integrable and $f(E)$ is not assumed measurable, so both sides of the main inequality must be encoded junk-free.

Legend: ✅ ground truth satisfies the criterion · ⚠️ ground truth acceptable but improvable · ❗ trap — known/likely model error to check in candidate statements.

| # | Category | Criterion / potential error | Assessment of ground truth |
|---|----------|-----------------------------|----------------------------|
| 1 | Faithful encoding | “$f$ is differentiable at every point of $E$” means genuine (two-sided) differentiability: `∀ x ∈ E, DifferentiableAt ℝ f x`. Using `DifferentiableOn ℝ f E` (differentiability *within* `E`) weakens the hypothesis and yields a false statement for thin sets `E`. | ✅ `DifferentiableAt`. ❗ Trap: `DifferentiableOn` is the natural-looking but wrong choice. |
| 2 | Junk values | $\lvert f'\rvert $ need not be integrable on $E$; the right-hand side must be the lower Lebesgue integral `∫⁻ x in E, ENNReal.ofReal \|deriv f x\|`, never a Bochner `∫` (which would be junk `0` exactly when the bound is most interesting). | ✅ `∫⁻ … ∂volume` with `ENNReal.ofReal`. |
| 3 | Junk values | `deriv f x` is junk at points where `f` is not differentiable, but it is only ever evaluated at `x ∈ E` (under hypothesis `hf`) inside the set-integral over `E`, so every occurrence is guarded. A candidate integrating `deriv f` over a larger set is unfaithful. | ✅ All occurrences of `deriv f` are restricted to `E`. |
| 4 | Faithful encoding | $\lambda(f(E))$: the image need not be measurable; applying `volume` to an arbitrary set (Mathlib measures are outer measures on all sets) is exactly the textbook's outer-measure reading. Candidates must not add a measurability hypothesis on `f '' E` or wrap it in a completion. | ✅ `volume (f '' E)` used directly. |
| 5 | Hypothesis completeness | “Measurable set $E$” is Lebesgue measurability: `NullMeasurableSet E volume`, not Borel `MeasurableSet`. | ✅ `hE : NullMeasurableSet E volume`. |
| 6 | Conclusion completeness | All three conclusions must be present; the “in particular” clauses (property (N) on $E$; the $L$-bound version) are the ones models drop. The $L$-bound must quantify over all `L : ℝ` with the pointwise bound as its own hypothesis. | ✅ Three-way conjunction with `HasLusinPropertyNOn f E volume volume` and the `∀ L` clause. |
| 7 | Semantic closeness | Property (N) “of $f$ on $E$” restricts to null subsets of `E` — a dedicated relative notion (`HasLusinPropertyNOn f E`), not global property (N) of the restriction `Set.restrict` (which would change the image sets involved). | ✅ `HasLusinPropertyNOn` in `Defs.lean` quantifies over `A ⊆ E`. |
| 8 | Junk values | The $L$-bound conclusion multiplies in `ℝ≥0∞`: `ENNReal.ofReal L * volume E`. Note `volume E` may be `∞` and `L` may be given negative (then the hypothesis forces `E` to miss all points, and `ofReal L = 0`); the encoding stays meaningful in all corner cases. | ✅ Stated in `ℝ≥0∞` via `ENNReal.ofReal L`. |
