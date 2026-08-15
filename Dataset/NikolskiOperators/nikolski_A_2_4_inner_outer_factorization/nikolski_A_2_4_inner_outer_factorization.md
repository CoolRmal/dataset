# N. K. Nikolski, *Operators, Functions, and Systems: An Easy Reading*, Theorem 2.4.1 (V. Smirnov, inner–outer factorization)

- **Source:** N. K. Nikolski, *Operators, Functions, and Systems: An Easy Reading*, Volume 1: Hardy, Hankel, and Toeplitz (Part A)
- **Domain:** Hardy spaces
- **Lean declaration:** `Dataset.NikolskiOperators.nikolski_A_2_4_inner_outer_factorization` ([nikolski_A_2_4_inner_outer_factorization.lean](nikolski_A_2_4_inner_outer_factorization.lean))
- **Criteria:** [nikolski_A_2_4_inner_outer_factorization.criteria.md](nikolski_A_2_4_inner_outer_factorization.criteria.md)
- **Context:** [nikolski_A_2_4_inner_outer_factorization.context.md](nikolski_A_2_4_inner_outer_factorization.context.md)

## Statement

**2.4.1. Theorem (V. Smirnov, 1928).** Let $f \in H^2$, $f \ne 0$. Then there exist an inner function $f_{\mathrm{inn}} \in H^2$ and an outer function $f_{\mathrm{out}} \in H^2$ such that

$$f = f_{\mathrm{inn}} f_{\mathrm{out}}.$$

Moreover, such a factorization is unique up to a constant factor, and $E_f = f_{\mathrm{inn}} H^2$.

**Recall.** A function $f \in H^2$ is called *inner* if $|f| = 1$ a.e. on $\mathbb{T}$. It is called *outer* if $E_f = H^2$.
