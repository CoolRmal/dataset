# N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Sobolev Spaces*, Exercise 1.1.13 (density of the range of a constant-coefficient operator)

- **Source:** N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Sobolev Spaces*
- **Domain:** PDE
- **Lean declaration:** `Dataset.KrylovSobolev.krylov_sobolev_1_1_13_const_coeff_operator_range_dense` ([krylov_sobolev_1_1_13_const_coeff_operator_range_dense.lean](krylov_sobolev_1_1_13_const_coeff_operator_range_dense.lean))
- **Criteria:** [krylov_sobolev_1_1_13_const_coeff_operator_range_dense.criteria.md](krylov_sobolev_1_1_13_const_coeff_operator_range_dense.criteria.md)

## Statement

**Exercise 1.1.13.** Let $m \ge 1$ be an integer and let $a^\alpha$ be some (complex) numbers, not all of which are zero, given for any multi-indices $\alpha$ such that $|\alpha| \le m$. Consider the operator

$$L = \sum_{|\alpha| \le m} a^\alpha D^\alpha$$

and prove that the set $LC_0^\infty$ is everywhere dense in $\mathcal{L}_p$ for any $p \in [2, \infty)$.

**Notation.** A multi-index is a $d$-tuple $\alpha = (\alpha_1, \dots, \alpha_d)$ of non-negative integers, $|\alpha| = \alpha_1 + \dots + \alpha_d$, and $D^\alpha = D_1^{\alpha_1}\cdots D_d^{\alpha_d}$. The exponent range here is $[2, \infty)$, not the $[1, \infty)$ of Theorem 1.1.6; Remark 1.1.14 flags the restriction. For an integer $k \ge 0$, $C_0^k$ denotes the $C^k$ functions on $\mathbb{R}^d$ that vanish for $|x|$ sufficiently large, and $C_0^\infty$ the infinitely differentiable ones. Subscripts denote partial derivatives: $u_{x^i} = D_iu$ and $u_{x^ix^j} = D_{ij}u$. Repeated indices are summed. $\mathcal{L}_p = \mathcal{L}_p(\mathbb{R}^d)$ is taken with respect to Lebesgue measure.
