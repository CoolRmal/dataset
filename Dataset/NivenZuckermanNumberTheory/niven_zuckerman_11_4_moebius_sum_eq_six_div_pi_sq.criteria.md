# Criteria: niven_zuckerman_11_4_moebius_sum_eq_six_div_pi_sq

**Statement:** [niven_zuckerman_11_4_moebius_sum_eq_six_div_pi_sq.md](niven_zuckerman_11_4_moebius_sum_eq_six_div_pi_sq.md) · **Lean:** [niven_zuckerman_11_4_moebius_sum_eq_six_div_pi_sq.lean](niven_zuckerman_11_4_moebius_sum_eq_six_div_pi_sq.lean)

The evaluation $\sum\mu(n)/n^2 = 6/\pi^2$, i.e. $1/\zeta(2)$. Mathlib indexes `tsum` over all of `ℕ`, including `0`, while the book's sums start at `n = 1`. The `if n = 0 then 0 else …` guard is what makes the two agree; without it the `n = 0` term is a division by zero, which Lean evaluates to `0` — accidentally correct here, but only by accident.

Legend: ✅ ground truth satisfies the criterion · ⚠️ ground truth acceptable but improvable · ❗ trap — known/likely model error to check in candidate statements.

| # | Category | Criterion / potential error | Assessment of ground truth |
|---|----------|-----------------------------|----------------------------|
| 1 | Conclusion completeness | The value is exactly $6/\pi^2$, not merely `∃ c, … = c`. | ✅ `= 6 / Real.pi ^ 2`. |
| 2 | Junk values | Same `n = 0` guard as Theorem 11.3. | ✅ Present. |
| 3 | Semantic closeness | This is the corollary of 11.3 combined with $\sum 1/n^2 = \pi^2/6$; mathlib has the latter (`basel_sum`), so a candidate may legitimately derive it. | ⚠️ Deriving it is fine; stating $\sum 1/n^2 = \pi^2/6$ instead is the *wrong* theorem. |
| 4 | Mathlib conventions | `Real.pi` and an `ℝ`-valued `tsum`. | ✅ As written. |
