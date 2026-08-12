# Criteria: folland_2_42_translation_continuity_lp

**Statement:** [folland_2_42_translation_continuity_lp.md](folland_2_42_translation_continuity_lp.md) · **Lean:** [folland_2_42_translation_continuity_lp.lean](folland_2_42_translation_continuity_lp.lean)

A limit statement at the group identity, for **both** translations, and only for $p < \infty$ — the proposition is false for $p = \infty$ (translation is not continuous on $L^\infty$).

Legend: ✅ ground truth satisfies the criterion · ⚠️ ground truth acceptable but improvable · ❗ trap — known/likely model error to check in candidate statements.

| # | Category | Criterion / potential error | Assessment of ground truth |
|---|----------|-----------------------------|----------------------------|
| 1 | Hypothesis completeness | `p ≠ ∞` is essential: on `L^∞` the translates of a characteristic function stay at distance `1`. | ✅ `hp' : p ≠ ∞`. ❗ Highest-value trap. |
| 2 | Conclusion completeness | Both `L_y f → f` and `R_y f → f` are asserted. | ✅ A conjunction. ❗ Predicted error: only the left translate. |
| 3 | Faithful encoding | "as `y → 1`" is the neighbourhood filter of the group identity, `𝓝 (1 : G)`, not `atTop` or a sequential limit. | ✅ `Tendsto … (𝓝 1) (𝓝 0)`. |
| 4 | Faithful encoding | The quantity tending to `0` is the `𝓛ᵖ` seminorm of the difference, an `ℝ≥0∞`-valued function. | ✅ `eLpNorm (leftTranslate y f - f) p μ`; the target `𝓝 (0 : ℝ≥0∞)` is the correct ambient. |
| 5 | Definition necessity | `leftTranslate`/`rightTranslate` are one-line notational definitions shared across four problems in this book; mathlib has no `L_y`/`R_y` for a general group acting on scalar functions. | ✅ Warranted, and used elsewhere in the book. |
