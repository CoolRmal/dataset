# N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Hölder Spaces*, Theorem 4.5.1 (global solvability, variable coefficients)

- **Source:** N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Hölder Spaces*
- **Domain:** PDE
- **Lean declaration:** `Dataset.KrylovHolder.krylov_4_5_1_variable_coefficient_global_solvability` ([krylov_4_5_1_variable_coefficient_global_solvability.lean](krylov_4_5_1_variable_coefficient_global_solvability.lean))
- **Criteria:** [krylov_4_5_1_variable_coefficient_global_solvability.criteria.md](krylov_4_5_1_variable_coefficient_global_solvability.criteria.md)
- **Context:** [krylov_4_5_1_variable_coefficient_global_solvability.context.md](krylov_4_5_1_variable_coefficient_global_solvability.context.md)

## Statement

**Theorem 4.5.1.** Let $L = L(x) = \sum_{|\alpha| \le m} a^\alpha(x) D^\alpha$ be a uniformly elliptic operator, and $k \ge 0$ be an integer. Assume that $a^\alpha \in C^{k+\delta}(\mathbb{R}^d)$ for any $\alpha$. Define the constant $\lambda_0$ depending only on the ellipticity constant $\kappa$ and $m$, $\delta$, $d$ and $\max_\alpha |a^\alpha|_\delta$ as in Theorem 4.1.2, and take any real $\lambda$ such that $|\lambda| \ge \lambda_0$. Then for any $f \in C^{k+\delta}(\mathbb{R}^d)$ there exists a unique solution $u \in C^{k+m+\delta}(\mathbb{R}^d)$ of the equation

$$L_\lambda u(x) = f(x), \qquad x \in \mathbb{R}^d .$$

**Notation (the operator).** $\alpha = (\alpha_1,\dots,\alpha_d)$ runs over multi-indices, $|\alpha| = \alpha_1 + \dots + \alpha_d$, $D^\alpha = D_1^{\alpha_1}\cdots D_d^{\alpha_d}$ with $D_i = \partial/\partial x_i$, and $\xi^\alpha = \xi_1^{\alpha_1}\cdots\xi_d^{\alpha_d}$. Uniform ellipticity of $L$ with ellipticity constant $\kappa > 0$ means

$$\sum_{|\alpha| = m} a^\alpha(x)\, \xi^\alpha \ \ge\ \kappa |\xi|^m \qquad \text{for all } x, \xi \in \mathbb{R}^d ,$$

and the shifted operator is $L_\lambda u := Lu - \lambda u$.

**Notation (Hölder spaces).** For an integer $k \ge 0$, $\delta \in (0,1)$ and a domain $\Omega \subseteq \mathbb{R}^d$,

$$[u]_{k,\Omega} = \max_{|\alpha| = k}\ \sup_{\Omega} |D^\alpha u| , \qquad
[u]_{k+\delta,\Omega} = \max_{|\alpha| = k}\ \sup_{\substack{x,y \in \Omega \\ x \ne y}} \frac{|D^\alpha u(x) - D^\alpha u(y)|}{|x-y|^\delta} ,$$

$$|u|_{k+\delta,\Omega} = \sum_{j=0}^{k} [u]_{j,\Omega} \ +\ [u]_{k+\delta,\Omega} ,$$

and $C^{k+\delta}(\Omega)$ is the set of functions having continuous derivatives up to order $k$ in $\Omega$ and finite norm $|u|_{k+\delta,\Omega}$. For $\Omega = \mathbb{R}^d$ the domain is omitted from the notation.
