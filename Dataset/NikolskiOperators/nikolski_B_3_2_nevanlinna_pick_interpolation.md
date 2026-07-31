# N. K. Nikolski, *Operators, Functions, and Systems: An Easy Reading*, Corollary 3.2.4 (G. Pick, Nevanlinna–Pick interpolation)

- **Source:** N. K. Nikolski, *Operators, Functions, and Systems: An Easy Reading*, Volume 1: Hardy, Hankel, and Toeplitz (Part B)
- **Domain:** Function theory
- **Lean declaration:** `Dataset.NikolskiOperators.nikolski_B_3_2_nevanlinna_pick_interpolation` ([nikolski_B_3_2_nevanlinna_pick_interpolation.lean](nikolski_B_3_2_nevanlinna_pick_interpolation.lean))
- **Criteria:** [nikolski_B_3_2_nevanlinna_pick_interpolation.criteria.md](nikolski_B_3_2_nevanlinna_pick_interpolation.criteria.md)

## Statement

**3.2.4. Corollary (G. Pick, 1916).** There exists $f \in H^\infty$ such that $f(\lambda_k) = w_k$, $k = 1, \dots, n$, and $\|f\|_\infty \le 1$ if and only if $I - WW^* \ge 0$:

$$\sum_{i,j=1}^{n} a_i \bar{a}_j \frac{1 - w_i \bar{w}_j}{1 - \lambda_i \bar{\lambda}_j} \ge 0, \qquad a_i \in \mathbb{C}.$$

Moreover, the solution $f$ is unique if and only if the matrix $I - WW^*$ is degenerated, i.e. $\partial = \operatorname{rank}(I - WW^*) < n$.
