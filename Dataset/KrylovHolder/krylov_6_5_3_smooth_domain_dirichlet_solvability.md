# N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Hölder Spaces*, Theorem 6.5.3 (the Dirichlet problem in a smooth domain)

- **Source:** N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Hölder Spaces*
- **Domain:** PDE
- **Lean declaration:** `Dataset.KrylovHolder.krylov_6_5_3_smooth_domain_dirichlet_solvability` ([krylov_6_5_3_smooth_domain_dirichlet_solvability.lean](krylov_6_5_3_smooth_domain_dirichlet_solvability.lean))
- **Criteria:** [krylov_6_5_3_smooth_domain_dirichlet_solvability.criteria.md](krylov_6_5_3_smooth_domain_dirichlet_solvability.criteria.md)

## Statement

**Theorem 6.5.3.** For any $f \in C^{k+\delta}(\Omega)$ and $g \in C^{k+2+\delta}(\bar\Omega)$ there exists a unique function $u \in C^{k+2+\delta}(\Omega)$ satisfying the equation

$$Lu = f \quad \text{in } \Omega$$

and equal to $g$ on $\partial\Omega$.

**Notation (standing assumptions).** $\Omega \subset \mathbb{R}^d$ is a bounded domain with smooth boundary, $k \ge 0$ is an integer and $0 < \delta < 1$. $L$ is a second-order uniformly elliptic operator

$$Lu(x) = \sum_{|\alpha| \le 2} a^\alpha(x) D^\alpha u(x), \qquad \sum_{|\alpha| = 2} a^\alpha(x)\, \xi^\alpha \ \ge\ \kappa |\xi|^2 \quad (x, \xi \in \mathbb{R}^d),$$

with ellipticity constant $\kappa > 0$ and coefficients $a^\alpha \in C^{k+\delta}$. Here $\alpha$ runs over multi-indices, $|\alpha| = \alpha_1 + \dots + \alpha_d$, $D^\alpha = D_1^{\alpha_1}\cdots D_d^{\alpha_d}$ with $D_i = \partial/\partial x_i$, and $\xi^\alpha = \xi_1^{\alpha_1}\cdots\xi_d^{\alpha_d}$; in the classical notation $Lu = a^{ij}D_{ij}u + b^i D_i u + cu$.

**Notation (Hölder spaces).** For an integer $k \ge 0$, $\delta \in (0,1)$ and a set $\Omega \subseteq \mathbb{R}^d$,

$$[u]_{k,\Omega} = \max_{|\alpha| = k}\ \sup_{\Omega} |D^\alpha u| , \qquad
[u]_{k+\delta,\Omega} = \max_{|\alpha| = k}\ \sup_{\substack{x,y \in \Omega \\ x \ne y}} \frac{|D^\alpha u(x) - D^\alpha u(y)|}{|x-y|^\delta} ,$$

$$|u|_{k+\delta,\Omega} = \sum_{j=0}^{k} [u]_{j,\Omega} \ +\ [u]_{k+\delta,\Omega} ,$$

and $C^{k+\delta}(\Omega)$ is the set of functions having continuous derivatives up to order $k$ in $\Omega$ and finite norm $|u|_{k+\delta,\Omega}$; $C^{k+\delta}(\bar\Omega)$ is the corresponding space for the closure $\bar\Omega$.
