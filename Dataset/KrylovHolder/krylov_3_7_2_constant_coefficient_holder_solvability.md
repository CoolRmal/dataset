# N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Hölder Spaces*, Theorem 3.7.2 (global Hölder solvability, constant coefficients)

- **Source:** N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Hölder Spaces*
- **Domain:** PDE
- **Lean declaration:** `Dataset.KrylovHolder.krylov_3_7_2_constant_coefficient_holder_solvability` ([krylov_3_7_2_constant_coefficient_holder_solvability.lean](krylov_3_7_2_constant_coefficient_holder_solvability.lean))
- **Criteria:** [krylov_3_7_2_constant_coefficient_holder_solvability.criteria.md](krylov_3_7_2_constant_coefficient_holder_solvability.criteria.md)
- **Context:** [krylov_3_7_2_constant_coefficient_holder_solvability.context.md](krylov_3_7_2_constant_coefficient_holder_solvability.context.md)

## Statement

**Theorem 3.7.2.** Let $\lambda \ne 0$, $k \ge 0$ be an integer and $0 < \delta < 1$. Then for any $f \in C^{k+\delta}(\mathbb{R}^d)$ there exists a unique solution $u \in C^{k+m+\delta}(\mathbb{R}^d)$ of the equation

$$L_\lambda u(x) = f(x), \qquad x \in \mathbb{R}^d .$$

**Notation (the operator).** $L = \sum_{|\alpha| \le m} a^\alpha D^\alpha$ is an operator of order $m \ge 1$ with *constant* coefficients $a^\alpha$, uniformly elliptic with ellipticity constant $\kappa > 0$, i.e.

$$\sum_{|\alpha| = m} a^\alpha \xi^\alpha \ \ge\ \kappa |\xi|^m \qquad \text{for all } \xi \in \mathbb{R}^d ,$$

where $\alpha = (\alpha_1,\dots,\alpha_d)$ runs over multi-indices, $|\alpha| = \alpha_1 + \dots + \alpha_d$, $D^\alpha = D_1^{\alpha_1}\cdots D_d^{\alpha_d}$ with $D_i = \partial/\partial x_i$, and $\xi^\alpha = \xi_1^{\alpha_1}\cdots\xi_d^{\alpha_d}$. The shifted operator is

$$L_\lambda u := L u - \lambda u .$$

**Notation (Hölder spaces).** For an integer $k \ge 0$, $\delta \in (0,1)$ and a domain $\Omega \subseteq \mathbb{R}^d$,

$$[u]_{k,\Omega} = \max_{|\alpha| = k}\ \sup_{\Omega} |D^\alpha u| , \qquad
[u]_{k+\delta,\Omega} = \max_{|\alpha| = k}\ \sup_{\substack{x,y \in \Omega \\ x \ne y}} \frac{|D^\alpha u(x) - D^\alpha u(y)|}{|x-y|^\delta} ,$$

$$|u|_{k+\delta,\Omega} = \sum_{j=0}^{k} [u]_{j,\Omega} \ +\ [u]_{k+\delta,\Omega} ,$$

and $C^{k+\delta}(\Omega)$ is the set of functions having continuous derivatives up to order $k$ in $\Omega$ and finite norm $|u|_{k+\delta,\Omega}$. For $\Omega = \mathbb{R}^d$ the domain is omitted from the notation.
