# Criteria: folland_2_51_invariant_measure_on_quotient

**Statement:** [folland_2_51_invariant_measure_on_quotient.md](folland_2_51_invariant_measure_on_quotient.md) · **Lean:** [folland_2_51_invariant_measure_on_quotient.lean](folland_2_51_invariant_measure_on_quotient.lean)

A faithful formalization must state an **equivalence** between the existence of a nonzero $G$-invariant Radon measure on $G/H$ and the equality $\Delta_G|_H = \Delta_H$, and must include Weil's formula (2.52) for the measure produced. The modular functions on the two sides are those of *different groups* — $\Delta_G$ restricted to $H$ versus the modular function of $H$ itself — and conflating them makes the criterion vacuous.

Legend: ✅ ground truth satisfies the criterion · ⚠️ ground truth acceptable but improvable · ❗ trap — known/likely model error to check in candidate statements.

| # | Category | Criterion / potential error | Assessment of ground truth |
|---|----------|-----------------------------|----------------------------|
| 1 | Conclusion completeness | The statement is `↔`, and the forward direction must produce a measure satisfying Weil's formula, not merely any invariant measure. | ✅ `(∃ ρ, ρ ≠ 0 ∧ G-invariance ∧ Weil's formula) ↔ (∀ y ∈ H, Δ_G y = Δ_H y)`. ❗ Predicted error: only the `←` direction, or dropping (2.52). |
| 2 | Faithful encoding | $\Delta_G\mid _H$ is `modularCharacterFun` computed **in `G`** at the image of `y`, and $\Delta_H$ is the same function computed **in `H`**. The two live in different instances of the same definition. | ✅ `Measure.modularCharacterFun (y : G)` versus `Measure.modularCharacterFun y` with `y : H`. ❗ Highest-value trap: writing both in the same group, which is a tautology. |
| 3 | Faithful encoding | $G$-invariance of $\mu$ on $G/H$ is invariance under the natural left action `g • q`, using mathlib's `MulAction G (G ⧸ H)`, not a quotient group multiplication (which needs `H` normal). | ✅ `ρ.map (fun q ↦ g • q) = ρ`. ❗ Predicted error: assuming `H.Normal` in order to multiply in `G ⧸ H`, which changes the theorem's scope. |
| 4 | Junk values | `ρ ≠ 0` is essential: the zero measure is invariant and satisfies a degenerate form of Weil's formula only if `f` integrates to zero, so without it the `←` direction would be trivial. | ✅ `ρ ≠ 0` is asserted. ❗ Predicted error: omitting it. |
| 5 | Semantic closeness | Uniqueness up to a positive constant is part of Folland's statement but is a separate assertion; the version formalized here keeps the existence criterion and Weil's formula. | ⚠️ Uniqueness is not formalized; a candidate that adds it is closer to the printed theorem. |
| 6 | Faithful encoding | Weil's formula is over `f ∈ Cc(G)`: continuous with compact support. | ✅ `Continuous f` and `HasCompactSupport f`. |
