# Criteria: hasLusinPropertyN_iff_maps_nullMeasurableSet

**Statement:** [hasLusinPropertyN_iff_maps_nullMeasurableSet.md](hasLusinPropertyN_iff_maps_nullMeasurableSet.md) · **Lean:** [hasLusinPropertyN_iff_maps_nullMeasurableSet.lean](hasLusinPropertyN_iff_maps_nullMeasurableSet.lean)

The whole content of this theorem lives in the distinction between *Lebesgue* measurability (the completed σ-algebra) and *Borel* measurability. A formalization that silently replaces Lebesgue-measurable by Borel-measurable anywhere — in the hypothesis on $F$, in the sets quantified over, or in the conclusion about images — states a different (and for the images, generally false or vacuous) theorem, because images of Borel sets under measurable maps are analytic, not Borel.

Legend: ✅ ground truth satisfies the criterion · ⚠️ ground truth acceptable but improvable · ❗ trap — known/likely model error to check in candidate statements.

| # | Category | Criterion / potential error | Assessment of ground truth |
|---|----------|-----------------------------|----------------------------|
| 1 | Faithful encoding | “Lebesgue measurable mapping” must be measurability with respect to the *completed* σ-algebra. In Mathlib this is `NullMeasurable F volume`; the stronger `Measurable F` (Borel measurability) restricts the hypothesis and changes the theorem. | ✅ `hF : NullMeasurable F volume`. ❗ Trap: candidates writing `Measurable F` formalize a strictly narrower statement. |
| 2 | Faithful encoding | “Takes all Lebesgue measurable sets to Lebesgue measurable sets” must quantify over `NullMeasurableSet A volume` and conclude `NullMeasurableSet (F '' A) volume`. Using `MeasurableSet` for the image side is essentially never true (images are analytic sets) and would make the right-hand side of the iff wrong. | ✅ Both sides use `NullMeasurableSet _ volume`. |
| 3 | Faithful encoding | Lusin's property (N) quantifies over null sets of the Lebesgue σ-algebra: `∀ A, NullMeasurableSet A μ → μ A = 0 → ν (F '' A) = 0`. Note `ν` applied to the (possibly non-measurable) image is the *outer* measure — exactly the textbook reading, with no measurability assumption smuggled into the conclusion. | ✅ `HasLusinPropertyN` in `Defs.lean` matches Definition 3.6.8; since `volume` is Borel, sub-null-sets are handled correctly via `NullMeasurableSet`. |
| 4 | Domain encoding | $\mathbb{R}^n$ should be a Mathlib-idiomatic Euclidean model with its Lebesgue measure: `Fin n → ℝ` with `volume` (or `EuclideanSpace ℝ (Fin n)`); the measure-theoretic statement is insensitive to the choice of norm, so either is acceptable. | ✅ `(Fin n → ℝ)` with `volume` (the pi Lebesgue measure). |
| 5 | Conclusion structure | The statement is a biconditional (“precisely when”); both directions must be present. | ✅ Stated as `↔`. |
| 6 | Mathlib conventions | The auxiliary notion is introduced as a named reusable definition (`HasLusinPropertyN F μ ν`) with the general two-measure form of Definition 3.6.8, specialised to `volume, volume` in the theorem — rather than inlining an ad-hoc formula. | ✅ Definition in `Defs.lean`, general `(μ, ν)` version, theorem instantiates both to `volume`. |
| 7 | Trap | Generality of `n`: the theorem is about arbitrary finite dimension. Fixing `n = 1` (or stating it for `ℝ`) loses the general statement. | ✅ `{n : ℕ}` is universally quantified. |
