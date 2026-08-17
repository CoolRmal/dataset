# N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Hölder Spaces*, Theorem 6.5.3 (the Dirichlet problem in a smooth domain)

- **Source:** N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Hölder Spaces*
- **Domain:** PDE
- **Lean declaration:** `Dataset.KrylovHolder.krylov_6_5_3_smooth_domain_dirichlet_solvability` ([krylov_6_5_3_smooth_domain_dirichlet_solvability.lean](krylov_6_5_3_smooth_domain_dirichlet_solvability.lean))
- **Criteria:** [krylov_6_5_3_smooth_domain_dirichlet_solvability.criteria.md](krylov_6_5_3_smooth_domain_dirichlet_solvability.criteria.md)
- **Context:** [krylov_6_5_3_smooth_domain_dirichlet_solvability.context.md](krylov_6_5_3_smooth_domain_dirichlet_solvability.context.md)

## Statement

**Theorem 6.5.3.** For any $f \in C^{k+\delta}(\Omega)$ and $g \in C^{k+2+\delta}(\bar\Omega)$ there exists a unique function $u \in C^{k+2+\delta}(\bar\Omega)$ satisfying the equation

$$Lu = f \quad \text{in } \Omega$$

and equal to $g$ on $\partial\Omega$.

**Notation (standing assumptions of Chapter 6).** $k \ge 0$ is an integer, $0 < \delta < 1$, and $K > 0$ is a constant. $L$ is the second-order elliptic operator

$$Lu = a^{ij} D_{ij} u + b^i D_i u + c\,u$$

(summation over repeated indices, $D_i = \partial/\partial x_i$) with **real** coefficients $a^{ij}, b^i, c$ defined on all of $\mathbb{R}^d$, the matrix $a = (a^{ij})$ symmetric, $c \le 0$, ellipticity constant $\kappa > 0$:

$$a^{ij}(x)\,\xi_i \xi_j \ \ge\ \kappa |\xi|^2 \qquad (x, \xi \in \mathbb{R}^d),$$

and the global bound $|a, b, c|_{k+\delta} \le K$ on $\mathbb{R}^d$ (in particular $a, b, c \in C^{k+\delta}(\mathbb{R}^d)$).

**Notation (the domain, Definition 6.1.6).** $\Omega \subset \mathbb{R}^d$ is a bounded domain of class $C^r$ with $r = k+2+\delta$: there are numbers $K_0, \rho_0 > 0$ such that for every $x_0 \in \partial\Omega$ there is a one-to-one mapping $\psi$ of $B_{\rho_0}(x_0)$ onto a domain $D \subset \mathbb{R}^d$ such that (i) $\psi(B_{\rho_0}(x_0) \cap \Omega) \subset \mathbb{R}^d_+ = \{y : y^d > 0\}$ and $\psi(x_0) = 0$; (ii) $\psi(B_{\rho_0}(x_0) \cap \partial\Omega) = D \cap \{y : y^d = 0\}$; (iii) $[\psi]_{s;B_{\rho_0}(x_0)} + [\psi^{-1}]_{s;D} \le K_0$ for every $s \in [0,r]$, and $|\psi^{-1}(y_1) - \psi^{-1}(y_2)| \le K_0 |y_1 - y_2|$ for $y_1, y_2 \in D$.

**Notation (Hölder spaces).** For an integer $k \ge 0$, $\delta \in (0,1)$ and a set $\Omega \subseteq \mathbb{R}^d$,

$$[u]_{k,\Omega} = \max_{|\alpha| = k}\ \sup_{\Omega} |D^\alpha u| , \qquad
[u]_{k+\delta,\Omega} = \max_{|\alpha| = k}\ \sup_{\substack{x,y \in \Omega \\ x \ne y}} \frac{|D^\alpha u(x) - D^\alpha u(y)|}{|x-y|^\delta} ,$$

$$|u|_{k+\delta,\Omega} = \sum_{j=0}^{k} [u]_{j,\Omega} \ +\ [u]_{k+\delta,\Omega} ,$$

and $C^{k+\delta}(\Omega)$ is the set of functions having continuous derivatives up to order $k$ in $\Omega$ and finite norm $|u|_{k+\delta,\Omega}$; $C^{k+\delta}(\bar\Omega)$ is the corresponding space for the closure $\bar\Omega$.
