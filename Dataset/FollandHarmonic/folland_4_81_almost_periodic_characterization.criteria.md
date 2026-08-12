# Criteria: folland_4_81_almost_periodic_characterization

**Statement:** [folland_4_81_almost_periodic_characterization.md](folland_4_81_almost_periodic_characterization.md) · **Lean:** [folland_4_81_almost_periodic_characterization.lean](folland_4_81_almost_periodic_characterization.lean)

Folland's theorem is a three-way equivalence; the version formalized here is the analytically substantive half (b) ⟺ (c) — uniform approximability by trigonometric polynomials versus uniform almost periodicity — since clause (a) presupposes the Bohr compactification, which mathlib does not provide. The hazards are the meaning of "linear combinations of characters" (a **finite** sum, with arbitrary complex coefficients) and of "uniformly almost periodic" (total boundedness of the translates in the **uniform** norm, not pointwise or compact-open).

Legend: ✅ ground truth satisfies the criterion · ⚠️ ground truth acceptable but improvable · ❗ trap — known/likely model error to check in candidate statements.

| # | Category | Criterion / potential error | Assessment of ground truth |
|---|----------|-----------------------------|----------------------------|
| 1 | Conclusion completeness | The formalized statement is the equivalence (b) ⟺ (c). Clause (a), the extension to $bG$, is omitted. | ⚠️ Documented in the `.md`; a candidate that also formalizes (a) — e.g. by existentially quantifying over a compact group containing `G` densely — is closer to the printed theorem. |
| 2 | Faithful encoding | "Linear combination of characters" is a finite sum $\sum_{\xi \in s} c_\xi \langle x,\xi\rangle$ over a `Finset` of characters with complex coefficients; "uniform limit" is the $\varepsilon$-approximation uniformly in `x`. | ✅ `∀ ε > 0, ∃ (s : Finset (PontryaginDual G)) c, ∀ x, ‖f x - ∑ ξ ∈ s, c ξ * (ξ x : ℂ)‖ < ε`. ❗ Predicted error: an infinite series, or coefficients restricted to `ℝ`. |
| 3 | Faithful encoding | Uniform almost periodicity is total boundedness of $\{R_yf\}$ **in the uniform norm**. Mathlib's instance on `G → ℂ` is `Pi.uniformSpace`, the uniformity of *pointwise* convergence, under which every uniformly bounded family is totally bounded — so `TotallyBounded` there is vacuous for bounded `f` and makes the theorem false. | ✅ Spelled out as a uniform ε-net: `∀ ε > 0, ∃ s : Finset G, ∀ y, ∃ z ∈ s, ∀ x, ‖R_y f x - R_z f x‖ < ε` (rewritten after review; the first version used `TotallyBounded` and was vacuous). ❗ Highest-value trap in this problem. |
| 4 | Hypothesis completeness | `f` is bounded and continuous; both are needed for the equivalence. | ✅ `hf : Continuous f` and `hbdd : ∃ C, ∀ x, ‖f x‖ ≤ C`. ⚠️ Boundedness follows from (c) but is part of the standing hypothesis. |
| 5 | Semantic closeness | Folland states the theorem for a locally compact group; characters exist in abundance only in the abelian case, which is where §4.7 sits. | ✅ Stated on a locally compact abelian group, matching the section. |
