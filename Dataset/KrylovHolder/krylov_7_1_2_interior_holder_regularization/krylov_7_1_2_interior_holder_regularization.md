# N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Hölder Spaces*, Theorem 7.1.2 (interior Hölder regularization)

- **Source:** N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Hölder Spaces*
- **Domain:** PDE
- **Lean declaration:** `Dataset.KrylovHolder.krylov_7_1_2_interior_holder_regularization` ([krylov_7_1_2_interior_holder_regularization.lean](krylov_7_1_2_interior_holder_regularization.lean))
- **Criteria:** [krylov_7_1_2_interior_holder_regularization.criteria.md](krylov_7_1_2_interior_holder_regularization.criteria.md)
- **Context:** [krylov_7_1_2_interior_holder_regularization.context.md](krylov_7_1_2_interior_holder_regularization.context.md)

## Statement

**Theorem 7.1.2.** Let $\Omega$ be a domain in $\mathbb{R}^d$ and $u \in C^{m+\delta}(\Omega)$. Assume that $L_\lambda u \in C^{k+\delta}(\Omega)$ for some $\lambda$. Then

$$u \in C^{k+m+\delta}_{\mathrm{loc}}(\Omega).$$

**Notation (the operator, Sec. 7.1).** $L = L(x) = \sum_{|\alpha| \le m} a^\alpha(x) D^\alpha$ is an $m$th-order elliptic operator with *complex* coefficients $a^\alpha$ satisfying $|a^\alpha|_{k+\delta} \le K$ for a constant $K$, uniformly elliptic with constant of ellipticity $\kappa > 0$ in the sense that the characteristic polynomial obeys

$$\Big|\sum_{|\alpha| \le m} a^\alpha(x)\, i^{|\alpha|} \xi^\alpha\Big| \ \ge\ \kappa\,(1 + |\xi|^m) \qquad (x, \xi \in \mathbb{R}^d).$$

Here $\alpha$ runs over multi-indices, $|\alpha| = \alpha_1 + \dots + \alpha_d$, $D^\alpha = D_1^{\alpha_1}\cdots D_d^{\alpha_d}$ with $D_i = \partial/\partial x_i$, and $\xi^\alpha = \xi_1^{\alpha_1}\cdots\xi_d^{\alpha_d}$. The order satisfies the book's standing assumption $m \ge 2$. For real $\lambda$ the operator family is

$$L_\lambda := \sum_{|\alpha| \le m} a^\alpha(x)\, \lambda^{m-|\alpha|} D^\alpha ,$$

so that $L_1 = L$; $k \ge 0$ is an integer and $0 < \delta < 1$.

**Notation (Hölder spaces).** For an integer $k \ge 0$, $\delta \in (0,1)$ and a domain $\Omega \subseteq \mathbb{R}^d$,

$$[u]_{k,\Omega} = \max_{|\alpha| = k}\ \sup_{\Omega} |D^\alpha u| , \qquad
[u]_{k+\delta,\Omega} = \max_{|\alpha| = k}\ \sup_{\substack{x,y \in \Omega \\ x \ne y}} \frac{|D^\alpha u(x) - D^\alpha u(y)|}{|x-y|^\delta} ,$$

$$|u|_{k+\delta,\Omega} = \sum_{j=0}^{k} [u]_{j,\Omega} \ +\ [u]_{k+\delta,\Omega} ,$$

and $C^{k+\delta}(\Omega)$ is the set of (complex-valued) functions having continuous derivatives up to order $k$ in $\Omega$ and finite norm $|u|_{k+\delta,\Omega}$. The local space $C^{k+\delta}_{\mathrm{loc}}(\Omega)$ consists of the functions belonging to $C^{k+\delta}(\Omega')$ for every bounded open $\Omega'$ with $\overline{\Omega'} \subset \Omega$. The result is an *interior* regularization statement: the gain of $k$ derivatives is local in $\Omega$, no regularity — and no finiteness of the global norm — being claimed up to $\partial\Omega$.
