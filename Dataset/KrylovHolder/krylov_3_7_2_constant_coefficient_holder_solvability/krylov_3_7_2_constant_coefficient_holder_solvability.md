# N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Hölder Spaces*, Theorem 3.7.2 (global Hölder solvability, constant coefficients)

- **Source:** N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Hölder Spaces*
- **Domain:** PDE
- **Lean declaration:** `Dataset.KrylovHolder.krylov_3_7_2_constant_coefficient_holder_solvability` ([krylov_3_7_2_constant_coefficient_holder_solvability.lean](krylov_3_7_2_constant_coefficient_holder_solvability.lean))
- **Criteria:** [krylov_3_7_2_constant_coefficient_holder_solvability.criteria.md](krylov_3_7_2_constant_coefficient_holder_solvability.criteria.md)
- **Context:** [krylov_3_7_2_constant_coefficient_holder_solvability.context.md](krylov_3_7_2_constant_coefficient_holder_solvability.context.md)

## Statement

**Theorem 3.7.2.** Let $\lambda \ne 0$, $k \ge 0$ be an integer and $0 < \delta < 1$. Then for any $f \in C^{k+\delta}(\mathbb{R}^d)$ there exists a unique solution $u \in C^{k+m+\delta}(\mathbb{R}^d)$ of the equation

$$L_\lambda u(x) = f(x), \qquad x \in \mathbb{R}^d .$$

**Notation (the operator).** $L = \sum_{|\alpha| \le m} a^\alpha D^\alpha$ is an operator with *constant complex* coefficients $a^\alpha$, elliptic in the sense of Krylov's Definition 1.1.1: both

$$\sum_{|\alpha| = m} a^\alpha \xi^\alpha \ \ne\ 0 \quad \text{for } \xi \in \mathbb{R}^d \setminus \{0\}, \qquad \text{and} \qquad \sum_{|\alpha| \le m} a^\alpha i^{|\alpha|} \xi^\alpha \ \ne\ 0 \quad \text{for } \xi \in \mathbb{R}^d .$$

(The second sum, $p(\xi) = \sum_{|\alpha| \le m} a^\alpha i^{|\alpha|}\xi^\alpha$, is the characteristic polynomial of $L$; note that under this definition $\Delta$ itself is *not* elliptic, since its characteristic polynomial $-|\xi|^2$ vanishes at $\xi = 0$.) Here $\alpha = (\alpha_1,\dots,\alpha_d)$ runs over multi-indices, $|\alpha| = \alpha_1 + \dots + \alpha_d$, $D^\alpha = D_1^{\alpha_1}\cdots D_d^{\alpha_d}$ with $D_i = \partial/\partial x_i$, and $\xi^\alpha = \xi_1^{\alpha_1}\cdots\xi_d^{\alpha_d}$. The order obeys the book's standing assumption $m \ge 2$. For real $\lambda$ the operator family is

$$L_\lambda := \sum_{|\alpha| \le m} a^\alpha \lambda^{m-|\alpha|} D^\alpha ,$$

so that $L_1 = L$ and the zeroth-order coefficient of $L_\lambda$ is $\lambda^m a^0$.

**Notation (Hölder spaces).** For an integer $k \ge 0$, $\delta \in (0,1)$ and a domain $\Omega \subseteq \mathbb{R}^d$,

$$[u]_{k,\Omega} = \max_{|\alpha| = k}\ \sup_{\Omega} |D^\alpha u| , \qquad
[u]_{k+\delta,\Omega} = \max_{|\alpha| = k}\ \sup_{\substack{x,y \in \Omega \\ x \ne y}} \frac{|D^\alpha u(x) - D^\alpha u(y)|}{|x-y|^\delta} ,$$

$$|u|_{k+\delta,\Omega} = \sum_{j=0}^{k} [u]_{j,\Omega} \ +\ [u]_{k+\delta,\Omega} ,$$

and $C^{k+\delta}(\Omega)$ is the set of (complex-valued) functions having continuous derivatives up to order $k$ in $\Omega$ and finite norm $|u|_{k+\delta,\Omega}$. For $\Omega = \mathbb{R}^d$ the domain is omitted from the notation.
