# N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Sobolev Spaces*, Exercise 13.3.16 (a pointwise test for membership in $H_p^\gamma$)

- **Source:** N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Sobolev Spaces*
- **Domain:** PDE
- **Lean declaration:** `Dataset.KrylovSobolev.krylov_sobolev_13_3_16_pointwise_decay_implies_negative_order_membership` ([krylov_sobolev_13_3_16_pointwise_decay_implies_negative_order_membership.lean](krylov_sobolev_13_3_16_pointwise_decay_implies_negative_order_membership.lean))
- **Criteria:** [krylov_sobolev_13_3_16_pointwise_decay_implies_negative_order_membership.criteria.md](krylov_sobolev_13_3_16_pointwise_decay_implies_negative_order_membership.criteria.md)
- **Context:** [krylov_sobolev_13_3_16_pointwise_decay_implies_negative_order_membership.context.md](krylov_sobolev_13_3_16_pointwise_decay_implies_negative_order_membership.context.md)

## Statement

**Exercise 13.3.16.** Sometimes it is hard to recognize whether a function $u$ is in $H_p^\gamma$, for a $\gamma < 0$. Prove that if $u$ has support in $B_\rho$, where $\rho \in (0, \infty)$, and

$$|u(x)| \le N_0|x|^{-\nu}, \quad \nu < d, \quad 0 < (\nu + \gamma)p < d, \quad \gamma < 0,$$

then $u \in H_p^\gamma$ and $\|u\|_{H_p^\gamma}$ is less than a constant depending only on $d, p, \rho, \nu, \gamma, N_0$. Observe that generally such a $u \notin \mathcal{L}_p$, because one need not have $\nu p < d$, and one cannot use the trivial embedding $\mathcal{L}_p \subset H_p^\gamma$.

By using Corollary 11 generalize the result and prove that if $n \in \{0, 1, \dots\}$, $\gamma \in \mathbb{R}$, $\gamma \le n$, $u$ has support in $B_\rho$,

$$|D^\alpha u(x)| \le N_0|x|^{-\nu}, \quad \forall|\alpha| \le n, \quad \nu < d,$$

and

$$\text{either}\quad \gamma < n \ \text{and}\ 0 < (\nu + \gamma - n)p < d, \quad\text{or}\quad \gamma = n \ \text{and}\ \nu p < d,$$

then $u \in H_p^\gamma$ and $\|u\|_{H_p^\gamma}$ is estimated by a constant depending only on $d, p, \rho, \nu, \gamma, n, N_0$.

**Notation.** Throughout Section 13.3, $p \in (1, \infty)$, and $H_p^\gamma$ with its norm is Definition 13.3.1: $H_p^\gamma = (1 - \Delta)^{-\gamma/2}\mathcal{L}_p$ with $\|g\|_{H_p^\gamma} = \|(1 - \Delta)^{\gamma/2}g\|_{\mathcal{L}_p}$. $B_\rho$ is the ball of radius $\rho$ centered at the origin. For an integer $k \ge 0$, $C_0^k$ denotes the $C^k$ functions on $\mathbb{R}^d$ that vanish for $|x|$ sufficiently large, and $C_0^\infty$ the infinitely differentiable ones. Subscripts denote partial derivatives: $u_{x^i} = D_iu$ and $u_{x^ix^j} = D_{ij}u$. Repeated indices are summed. $\mathcal{L}_p = \mathcal{L}_p(\mathbb{R}^d)$ is taken with respect to Lebesgue measure.
