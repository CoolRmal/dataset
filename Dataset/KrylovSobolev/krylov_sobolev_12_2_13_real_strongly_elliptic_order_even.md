# N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Sobolev Spaces*, Exercise 12.2.13 (real strongly elliptic operators have even order)

- **Source:** N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Sobolev Spaces*
- **Domain:** PDE
- **Lean declaration:** `Dataset.KrylovSobolev.krylov_sobolev_12_2_13_real_strongly_elliptic_order_even` ([krylov_sobolev_12_2_13_real_strongly_elliptic_order_even.lean](krylov_sobolev_12_2_13_real_strongly_elliptic_order_even.lean))
- **Criteria:** [krylov_sobolev_12_2_13_real_strongly_elliptic_order_even.criteria.md](krylov_sobolev_12_2_13_real_strongly_elliptic_order_even.criteria.md)

## Statement

**Exercise 12.2.13.** Prove that if the coefficients $a^\alpha$ of an $m$th order strongly elliptic differential operator are real and $d \ge 2$, then $m$ is even.

**Notation.** From Definition 12.2.1: let $m \ge 1$ be an integer and let $a^\alpha$ be some (complex) numbers given for any multi-indices $\alpha$ such that $|\alpha| \le m$. The operator $L = \sum_{|\alpha| \le m}a^\alpha D^\alpha$ is called an *$m$th order operator with constant coefficients*. It is called *($m$th order) strongly elliptic* if both

$$\sum_{|\alpha| = m}a^\alpha\xi^\alpha \ne 0 \quad\text{for } \xi \in \mathbb{R}^d\setminus\{0\}, \qquad \sum_{|\alpha| \le m}a^\alpha i^{|\alpha|}\xi^\alpha \ne 0 \quad\text{for } \xi \in \mathbb{R}^d.$$

The polynomial $\sigma(\xi) = \sigma_L(\xi) = \sum_{|\alpha| \le m}a^\alpha i^{|\alpha|}\xi^\alpha$ is called the *characteristic polynomial* of $L$. Here $\xi^\alpha = (\xi^1)^{\alpha_1}\cdots(\xi^d)^{\alpha_d}$.
