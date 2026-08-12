# Criteria: niven_zuckerman_11_3_moebius_zeta_product

**Statement:** [niven_zuckerman_11_3_moebius_zeta_product.md](niven_zuckerman_11_3_moebius_zeta_product.md) · **Lean:** [niven_zuckerman_11_3_moebius_zeta_product.lean](niven_zuckerman_11_3_moebius_zeta_product.lean)

The identity is a *product of two convergent series* equalling `1` — the Dirichlet-series statement that $\sum\mu(n)n^{-2}$ inverts $\zeta(2)$. Mathlib indexes `tsum` over all of `ℕ`, including `0`, while the book's sums start at `n = 1`. The `if n = 0 then 0 else …` guard is what makes the two agree; without it the `n = 0` term is a division by zero, which Lean evaluates to `0` — accidentally correct here, but only by accident.

Legend: ✅ ground truth satisfies the criterion · ⚠️ ground truth acceptable but improvable · ❗ trap — known/likely model error to check in candidate statements.

| # | Category | Criterion / potential error | Assessment of ground truth |
|---|----------|-----------------------------|----------------------------|
| 1 | Faithful encoding | Both series run over $n \ge 1$ and the identity is the product of their sums, not a Dirichlet convolution identity. | ✅ A product of two `tsum`s, each guarded at `n = 0`. ❗ Predicted error: stating `∑ (μ * ζ) = 1` as arithmetic functions, which is `Nat.ArithmeticFunction.moebius_mul_coe_zeta` and already in mathlib. |
| 2 | Junk values | Without the `n = 0` guard the summand is `μ(0)/0 = 0/0 = 0`; the guard makes the intent explicit rather than relying on Lean's division convention. | ✅ Guarded. ❗ Predicted error: `∑' n : ℕ+` (a different index type) or an unguarded sum. |
| 3 | Mathlib conventions | `ArithmeticFunction.moebius` is `ℤ`-valued and must be cast to `ℝ`. | ✅ `(ArithmeticFunction.moebius n : ℝ)`. |
| 4 | Conclusion completeness | The statement asserts the product equals exactly `1`; convergence of each factor is implicit in `tsum` (a non-summable family sums to `0`). | ⚠️ A candidate asserting `Summable` for both factors is strictly more informative. |
