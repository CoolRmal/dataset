# Criteria: hayman_3_4_derivative_deficiency_bound

**Statement:** [hayman_3_4_derivative_deficiency_bound.md](hayman_3_4_derivative_deficiency_bound.md) · **Lean:** [hayman_3_4_derivative_deficiency_bound.lean](hayman_3_4_derivative_deficiency_bound.lean)

The bound $1 + 1/(l+1)$ is sharp (Hayman's own exercise with $f = \tan z$, $l = 1$), so the constant must be exactly that — not $2$, which is the general bound of Theorem 2.4. The sum runs over **finite** values only, since $\Theta(\infty,\psi) \ge l/(l+1)$ carries the rest.

Legend: ✅ ground truth satisfies the criterion · ⚠️ ground truth acceptable but improvable · ❗ trap — known/likely model error to check in candidate statements.

| # | Category | Criterion / potential error | Assessment of ground truth |
|---|----------|-----------------------------|----------------------------|
| 1 | Conclusion completeness / sharp constant | The bound is $1+\frac{1}{l+1}$ over the finite values. Using $2$ loses the entire content, which is that differentiating buys $l/(l+1)$ of deficiency at $\infty$. | ✅ `≤ 1 + 1 / (l + 1 : ℝ)`. ❗ Highest-value trap. |
| 2 | Faithful encoding / range of the sum | The sum is over $a \ne \infty$; including $\infty$ would make the bound false. | ✅ `∑ a ∈ s` with `s : Finset ℂ`, so only finite values occur. |
| 3 | Conclusion completeness | The "in particular" clause — $\psi$ takes every finite value infinitely often with at most one exception — is a second assertion and is what the theorem is used for. | ✅ Present as the second conjunct, a `Set.Subsingleton`. ❗ Predicted error: keeping only the inequality. |
| 4 | Hypothesis completeness | $f$ must be transcendental meromorphic in the plane and $l \ge 1$. | ✅ `htr`, `hl : 1 ≤ l`. ❗ Predicted error: `l = 0`, where $\psi = f$ and the bound is false. |
| 5 | Mathlib conventions | $\psi = f^{(l)}$ is mathlib's `iteratedDeriv l f`, supplied through an equation hypothesis so the statement reads as in the book. | ⚠️ Inlining `iteratedDeriv l f` would remove one hypothesis. |
