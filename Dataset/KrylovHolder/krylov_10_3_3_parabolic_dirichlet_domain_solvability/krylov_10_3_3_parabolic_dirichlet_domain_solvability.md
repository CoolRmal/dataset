# N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Hölder Spaces*, Theorem 10.3.3 (the parabolic Dirichlet problem in a domain)

- **Source:** N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Hölder Spaces*
- **Domain:** PDE
- **Lean declaration:** `Dataset.KrylovHolder.krylov_10_3_3_parabolic_dirichlet_domain_solvability` ([krylov_10_3_3_parabolic_dirichlet_domain_solvability.lean](krylov_10_3_3_parabolic_dirichlet_domain_solvability.lean))
- **Criteria:** [krylov_10_3_3_parabolic_dirichlet_domain_solvability.criteria.md](krylov_10_3_3_parabolic_dirichlet_domain_solvability.criteria.md)
- **Context:** [krylov_10_3_3_parabolic_dirichlet_domain_solvability.context.md](krylov_10_3_3_parabolic_dirichlet_domain_solvability.context.md)

## Statement

**Theorem 10.3.3.** For any $f \in C^{\delta/2,\,\delta}(Q)$ and $g \in C^{1+\delta/2,\,2+\delta}(Q)$ there exists a unique function $u \in C^{1+\delta/2,\,2+\delta}(\bar Q)$ satisfying the equation

$$Lu - u_t = f \quad \text{in } Q$$

and equal to $g$ on $\partial' Q$.

**Notation (the domain, Sec. 10.1).** $T \in (-\infty, \infty]$ and $\Omega$ is a bounded domain in $\mathbb{R}^d$ of class $C^{2+\delta}$ in the sense of Definition 6.1.6 (for every boundary point a boundary-straightening map $\psi$ with $[\psi]_{s}$, $[\psi^{-1}]_s$ bounded by a common constant for all $s \in [0, 2+\delta]$, mapping the boundary piece to a piece of a hyperplane and the domain to one side of it). The space-time domain is the infinite cylinder

$$Q = (-\infty, T) \times \Omega ,$$

whose points are written $p = (t,x)$, and its parabolic boundary is the lateral surface

$$\partial' Q = (-\infty, T) \times \partial\Omega$$

(the cylinder has no initial-time cap: it extends to $t = -\infty$).

**Notation (standing assumptions of Chapter 10).** $0 < \delta < 1$ and $K$ is a constant. $L$ is the second-order operator acting in the space variables,

$$Lu(t,x) = a^{ij}(t,x) D_{ij} u(t,x) + b^i(t,x) D_i u(t,x) + c(t,x) u(t,x),$$

with summation over repeated indices, with **real** coefficients defined for all $(t,x)$, the matrix $a = (a^{ij})$ symmetric, $c \le 0$, nondegenerate with constant of ellipticity $\kappa > 0$:

$$a^{ij}(t,x)\,\xi_i \xi_j \ \ge\ \kappa|\xi|^2 \qquad \text{for all } (t,x) \text{ and all } \xi \in \mathbb{R}^d ,$$

and $|a, b, c|_{\delta/2,\,\delta} \le K$, i.e. the coefficients belong to $C^{\delta/2,\,\delta}$ of the whole space.

**Notation (parabolic Hölder spaces).** For $0 < \delta < 1$, $C^{\delta/2,\,\delta}(Q)$ consists of the functions that are $\delta$-Hölder in $x$ and $(\delta/2)$-Hölder in $t$ on $Q$, and $C^{1+\delta/2,\,2+\delta}(Q)$ of the functions $u$ for which $u$, $D_x u$, $D^2_x u$ and $u_t$ exist and are bounded on $Q$, with $D^2_x u$ and $u_t$ being $\delta$-Hölder in $x$ and $(\delta/2)$-Hölder in $t$.
