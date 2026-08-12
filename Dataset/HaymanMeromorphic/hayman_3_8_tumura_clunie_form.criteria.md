# Criteria: hayman_3_8_tumura_clunie_form

**Statement:** [hayman_3_8_tumura_clunie_form.md](hayman_3_8_tumura_clunie_form.md) · **Lean:** [hayman_3_8_tumura_clunie_form.lean](hayman_3_8_tumura_clunie_form.lean)

A structure theorem: finitely many poles plus finitely many zeros of $f$ and of $f^{(l)}$ pin $f$ down to $P_1e^{P_3}/P_2$, and the zero-free case pins it to one of exactly two shapes. Both conclusions are required, and $l \ge 2$ is a genuine hypothesis — for $l = 1$ the conclusion fails.

Legend: ✅ ground truth satisfies the criterion · ⚠️ ground truth acceptable but improvable · ❗ trap — known/likely model error to check in candidate statements.

| # | Category | Criterion / potential error | Assessment of ground truth |
|---|----------|-----------------------------|----------------------------|
| 1 | Conclusion completeness | Both the general form and the zero-free refinement are asserted. | ✅ A conjunction, the second conjunct guarded by the zero-free hypothesis. ❗ Predicted error: keeping only the general form. |
| 2 | Hypothesis completeness | $l \ge 2$; finitely many poles; finitely many zeros of both $f$ and $f^{(l)}$. | ✅ `hl : 2 ≤ l`, `hpoles`, `hzeros`, `hlzeros`. ❗ Predicted error: `1 ≤ l`. |
| 3 | Faithful encoding | $f = P_1e^{P_3}/P_2$ holds off the zeros of $P_2$; a global equation would assert something about the poles themselves. | ✅ `∀ z, P₂.eval z ≠ 0 → f z = P₁.eval z / P₂.eval z * exp (P₃.eval z)` with `P₂ ≠ 0`. |
| 4 | Faithful encoding / second form | $(Az+B)^{-n}$ needs `n ≥ 1` and is asserted off the zero of $Az+B$; the exponent is a negative integer power. | ✅ `(A * z + B) ^ (-(n : ℤ))` with `1 ≤ n`, guarded by `A * z + B ≠ 0`. ❗ Predicted error: a natural-number power, which inverts the meaning. |
| 5 | Junk values | `Set.Finite` on the zero and pole sets is junk-free; the polynomial evaluations are total. | ✅ Safe. |
