# Criteria: niven_zuckerman_10_14_euler_product_prime_power

**Statement:** [niven_zuckerman_10_14_euler_product_prime_power.md](niven_zuckerman_10_14_euler_product_prime_power.md) · **Lean:** [niven_zuckerman_10_14_euler_product_prime_power.lean](niven_zuckerman_10_14_euler_product_prime_power.lean)

The content is that the ratio of Euler products is $1$ plus $p$ times a power series with **integer** coefficients — the divisibility by $p$ of every coefficient after the constant term is the whole point, and it is what drives Ramanujan's congruence two theorems later.

Legend: ✅ ground truth satisfies the criterion · ⚠️ ground truth acceptable but improvable · ❗ trap — known/likely model error to check in candidate statements.

| # | Category | Criterion / potential error | Assessment of ground truth |
|---|----------|-----------------------------|----------------------------|
| 1 | Conclusion completeness | The coefficients $a_i$ must be **integers** and the factor $p$ must be explicit; `∃ a : ℕ → ℝ` loses the theorem. | ✅ `∃ a : ℕ → ℤ, … = 1 + p * ∑' i, (a (i+1) : ℝ) * x ^ (i+1)`. ❗ Highest-value trap. |
| 2 | Hypothesis completeness | `p` prime and `0 ≤ x < 1` (where Euler's product converges). | ✅ `hp : p.Prime` and the range hypotheses on `x`. |
| 3 | Faithful encoding | $\phi(x) = \prod_{n\ge1}(1-x^n)$ is supplied as a hypothesis characterising `φ` by convergence of its partial products, since mathlib has no Euler product for partitions. | ⚠️ Characterising `φ` rather than defining it keeps the statement self-contained; a candidate defining `φ` via `tprod` is equally faithful. |
| 4 | Junk values | `φ x ^ p` in the denominator is nonzero for `0 ≤ x < 1`, but the statement does not say so; real division by zero is `0` in Lean. | ❗ Worth checking: a candidate should either note `φ x ≠ 0` on the range or state the identity in product form. |
