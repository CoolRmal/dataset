# N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Hölder Spaces*, Theorem 10.3.3 (the parabolic Dirichlet problem in a domain)

- **Source:** N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Hölder Spaces*
- **Domain:** PDE
- **Lean declaration:** `Dataset.KrylovHolder.krylov_10_3_3_parabolic_dirichlet_domain_solvability` ([krylov_10_3_3_parabolic_dirichlet_domain_solvability.lean](krylov_10_3_3_parabolic_dirichlet_domain_solvability.lean))
- **Criteria:** [krylov_10_3_3_parabolic_dirichlet_domain_solvability.criteria.md](krylov_10_3_3_parabolic_dirichlet_domain_solvability.criteria.md)

## Statement

**Theorem 10.3.3.** For any $f \in C^{\delta/2,\,\delta}(Q)$ and $g \in C^{1+\delta/2,\,2+\delta}(Q)$ there exists a unique function $u \in C^{1+\delta/2,\,2+\delta}(Q)$ satisfying the equation

$$Lu - u_t = f \quad \text{in } Q$$

and equal to $g$ on $\partial' Q$.

**Notation (standing assumptions).** $Q$ is a bounded domain in $\mathbb{R}^{d+1}$, whose points are written $p = (t,x)$ with $t \in \mathbb{R}$, $x \in \mathbb{R}^d$, and $0 < \delta < 1$. $L$ is a second-order operator acting in the space variables,

$$Lu(t,x) = a^{ij}(t,x) D_{ij} u(t,x) + b^i(t,x) D_i u(t,x) + c(t,x) u(t,x),$$

with summation over repeated indices, which is uniformly parabolic in the sense that for some $\kappa > 0$

$$a^{ij}(t,x)\,\xi_i \xi_j \ \ge\ \kappa|\xi|^2 \qquad \text{for all } (t,x) \text{ and all } \xi \in \mathbb{R}^d ,$$

and whose coefficients $a^{ij}, b^i, c$ belong to $C^{\delta/2,\,\delta}(Q)$.

**Notation (the parabolic boundary).** $\partial' Q$ is the parabolic boundary of $Q$: the set of boundary points of $Q$ that can be approached from $Q$ only from later times, i.e. $\partial'Q = \partial Q \setminus \{p \in \partial Q : Q \text{ contains a backward neighbourhood } \{q : |q - p| < \varepsilon,\ q_t < p_t\} \text{ of } p\}$. For a cylinder $Q = (0,T)\times\Omega$ it is the union of the bottom $\{0\}\times\Omega$ and the lateral surface $[0,T)\times\partial\Omega$; the top $\{T\}\times\Omega$ is excluded.

**Notation (parabolic Hölder spaces).** For $0 < \delta < 1$, $C^{\delta/2,\,\delta}(Q)$ consists of the functions that are $\delta$-Hölder in $x$ and $(\delta/2)$-Hölder in $t$ on $Q$, and $C^{1+\delta/2,\,2+\delta}(Q)$ of the functions $u$ for which $u$, $D_x u$, $D^2_x u$ and $u_t$ exist and are bounded on $Q$, with $D^2_x u$ and $u_t$ being $\delta$-Hölder in $x$ and $(\delta/2)$-Hölder in $t$.
