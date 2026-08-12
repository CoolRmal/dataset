# Criteria: bogachev_gaussian_1_9_3_symmetric_tail_characterization

**Statement:** [bogachev_gaussian_1_9_3_symmetric_tail_characterization.md](bogachev_gaussian_1_9_3_symmetric_tail_characterization.md) · **Lean:** [bogachev_gaussian_1_9_3_symmetric_tail_characterization.lean](bogachev_gaussian_1_9_3_symmetric_tail_characterization.lean)

A faithful formalization must carry three hypotheses — independence, a **common symmetric** law, and the one-sided tail domination $P(|(\xi+\eta)/\sqrt2| \ge t) \le P(|\xi|\ge t)$ for **all** $t \ge 0$ — and conclude Gaussianity. The inequality is the entire content: reversing it, or assuming equality of the two distributions, produces respectively a false statement and a triviality. No moment assumption may be added; showing $\mathbb{E}\xi^2 < \infty$ is the hard half of the proof.

Legend: ✅ ground truth satisfies the criterion · ⚠️ ground truth acceptable but improvable · ❗ trap — known/likely model error to check in candidate statements.

| # | Category | Criterion / potential error | Assessment of ground truth |
|---|----------|-----------------------------|----------------------------|
| 1 | Hypothesis completeness | Symmetry of the common law is essential and is not implied by the tail bound. | ✅ `hsymm : μ.map Neg.neg = μ`. ❗ Predicted error: omitting symmetry, or replacing it by `∫ x ∂μ = 0`. |
| 2 | Faithful encoding | Independence with a common law is encoded by working with `μ.prod μ` and the map $(x,y)\mapsto(x+y)/\sqrt2$; the tail set is $\{\lvert (x+y)/\sqrt2\rvert \ge t\}$ in the product space. | ✅ `(μ.prod μ) {p \| t ≤ \|(p.1 + p.2) / √2\|} ≤ μ {x \| t ≤ \|x\|}`. ❗ Predicted error: dropping the $\sqrt2$ normalization, which makes the hypothesis unsatisfiable for nondegenerate laws. |
| 3 | Semantic closeness / direction | The inequality is `≤` with the normalized sum on the **left**. The reverse inequality holds for every symmetric law with finite variance and characterizes nothing. | ✅ Orientation as in (1.9.1). ❗ Predicted error: flipping the inequality. |
| 4 | Hypothesis completeness | The bound is required for every $t \ge 0$. Requiring it only for large $t$ weakens the statement. | ✅ `∀ t, 0 ≤ t → …`. |
| 5 | Conclusion completeness | The conclusion is that the law is Gaussian — including the degenerate case $\xi \equiv 0$, which does satisfy the hypotheses. | ✅ `IsGaussian μ`, and mathlib's `gaussianReal m 0 = dirac m` makes the degenerate case a genuine instance. ❗ Predicted error: concluding `μ = gaussianReal 0 v` with `0 < v`, which is false for $\xi \equiv 0$. |
| 6 | Junk values | Measures in mathlib are outer measures, so `μ {x \| t ≤ \|x\|}` needs no measurability side condition; the set is closed anyway. | ✅ No spurious measurability hypotheses. |
