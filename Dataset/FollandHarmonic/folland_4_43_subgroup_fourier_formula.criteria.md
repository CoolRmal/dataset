# Criteria: folland_4_43_subgroup_fourier_formula

**Statement:** [folland_4_43_subgroup_fourier_formula.md](folland_4_43_subgroup_fourier_formula.md) · **Lean:** [folland_4_43_subgroup_fourier_formula.lean](folland_4_43_subgroup_fourier_formula.lean)

The formula transfers an integral over a coset of $H$ into an integral of $\widehat{f}$ over the annihilator $H^{\perp}$. Three things carry the content: $H^{\perp}$ must be the annihilator $\{\xi : \xi|_H \equiv 1\}$ (not the orthogonal complement of a subspace, and not $\widehat{H}$); the character appears **unconjugated** on the right-hand side, matching the inversion convention; and the two Haar measures are only asserted to exist for a *suitable normalization*.

Legend: ✅ ground truth satisfies the criterion · ⚠️ ground truth acceptable but improvable · ❗ trap — known/likely model error to check in candidate statements.

| # | Category | Criterion / potential error | Assessment of ground truth |
|---|----------|-----------------------------|----------------------------|
| 1 | Faithful encoding | $H^{\perp} = \{\xi \in \widehat{G} : \langle y,\xi\rangle = 1\ \forall y \in H\}$. | ✅ `annihilator G H = {ξ \| ∀ y ∈ H, ξ y = 1}`. ❗ Predicted error: using `\widehat{H}` (the dual of `H`), which is the quotient `Ĝ/H⊥`, not `H⊥`. |
| 2 | Semantic closeness / conjugation | $\widehat{f}(\xi) = \int f\overline{\langle x,\xi\rangle}$ uses the conjugate character, but (4.44) evaluates $\langle x,\xi\rangle$ **without** conjugation — the inversion pairing. | ✅ `dualFourier` conjugates; the right-hand side of the conclusion does not. ❗ Predicted error: conjugating on both sides, which gives the transform at $x^{-1}$. |
| 3 | Hypothesis completeness | The identity needs $\widehat{f}\mid _{H^\perp} \in L^1(H^\perp)$; without it the right-hand integral is a junk `0`. | ✅ `hint : Integrable (fun ξ ↦ fourierTransform μ f ξ) σ`. ❗ Predicted error: omitting it. |
| 4 | Hypothesis completeness | "Haar measures suitably normalized" is a genuine hypothesis: the identity holds only for a compatible triple of Haar measures. The Lean statement leaves the normalization implicit by universally quantifying over the measures, which is **stronger than the theorem**. | ❗ Flagged: a faithful version should existentially quantify over the normalizations, e.g. `∃ ν σ, … ∧ ∀ x, …`. The ground truth as written asserts the formula for *every* pair of Haar measures and should be read as carrying an implicit normalization convention. |
| 5 | Faithful encoding | The left-hand side is an integral over the subgroup `H` of `f (x * y)`, i.e. over the coset `xH`. | ✅ `∫ y : H, f (x * y) ∂ν`. |
| 6 | Semantic closeness | Folland's theorem also asserts $\widehat{F} = \widehat{f}\mid _{H^\perp}$ for the averaged function $F$ on $G/H$; only (4.44) is formalized. | ⚠️ Documented in the `.md`. |
