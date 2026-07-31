# N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Hölder Spaces*, Theorem 7.1.2 (interior Hölder regularization)

- **Source:** N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Hölder Spaces*
- **Domain:** PDE
- **Lean declaration:** `Dataset.KrylovHolder.krylov_7_1_2_interior_holder_regularization` ([krylov_7_1_2_interior_holder_regularization.lean](krylov_7_1_2_interior_holder_regularization.lean))
- **Criteria:** [krylov_7_1_2_interior_holder_regularization.criteria.md](krylov_7_1_2_interior_holder_regularization.criteria.md)

## Statement

**Theorem 7.1.2.** Let $\Omega$ be a domain in $\mathbb{R}^d$ and $u \in C^{m+\delta}(\Omega)$. Assume that $L_\lambda u \in C^{k+\delta}(\Omega)$ for some $\lambda$. Then

$$u \in C^{k+m+\delta}(\Omega).$$

**Notation (the operator).** $L = L(x) = \sum_{|\alpha| \le m} a^\alpha(x) D^\alpha$ is a uniformly elliptic operator of order $m \ge 1$ with ellipticity constant $\kappa > 0$,

$$\sum_{|\alpha| = m} a^\alpha(x)\, \xi^\alpha \ \ge\ \kappa |\xi|^m \qquad (x, \xi \in \mathbb{R}^d),$$

whose coefficients satisfy $a^\alpha \in C^{k+\delta}$; here $\alpha$ runs over multi-indices, $|\alpha| = \alpha_1 + \dots + \alpha_d$, $D^\alpha = D_1^{\alpha_1}\cdots D_d^{\alpha_d}$ with $D_i = \partial/\partial x_i$, and $\xi^\alpha = \xi_1^{\alpha_1}\cdots\xi_d^{\alpha_d}$. The shifted operator is $L_\lambda u := Lu - \lambda u$; $k \ge 0$ is an integer and $0 < \delta < 1$.

**Notation (Hölder spaces).** For an integer $k \ge 0$, $\delta \in (0,1)$ and a domain $\Omega \subseteq \mathbb{R}^d$,

$$[u]_{k,\Omega} = \max_{|\alpha| = k}\ \sup_{\Omega} |D^\alpha u| , \qquad
[u]_{k+\delta,\Omega} = \max_{|\alpha| = k}\ \sup_{\substack{x,y \in \Omega \\ x \ne y}} \frac{|D^\alpha u(x) - D^\alpha u(y)|}{|x-y|^\delta} ,$$

$$|u|_{k+\delta,\Omega} = \sum_{j=0}^{k} [u]_{j,\Omega} \ +\ [u]_{k+\delta,\Omega} ,$$

and $C^{k+\delta}(\Omega)$ is the set of functions having continuous derivatives up to order $k$ in $\Omega$ and finite norm $|u|_{k+\delta,\Omega}$. The result is an *interior* regularization statement: the gain of $k$ derivatives is local in $\Omega$, no regularity being claimed up to $\partial\Omega$.
