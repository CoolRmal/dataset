# N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Hölder Spaces*, Theorem 4.2.1 (better regular data give a better regular solution)

- **Source:** N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Hölder Spaces*
- **Domain:** PDE
- **Lean declaration:** `Dataset.KrylovHolder.krylov_4_2_1_better_regular_data_better_regular_solution` ([krylov_4_2_1_better_regular_data_better_regular_solution.lean](krylov_4_2_1_better_regular_data_better_regular_solution.lean))
- **Criteria:** [krylov_4_2_1_better_regular_data_better_regular_solution.criteria.md](krylov_4_2_1_better_regular_data_better_regular_solution.criteria.md)

## Statement

**Theorem 4.2.1.** Let the assumptions of Theorem 4.1.2 be satisfied, and let $k \ge 0$ be an integer, $K_1 \ge 1$ be a constant. Assume that for any $\alpha$ we have $|a^\alpha|_{k+\delta} \le K_1$. Then:

1. for any $\lambda$, the inclusions $u \in C^{m+\delta}(\mathbb{R}^d)$ and $L_\lambda u \in C^{k+\delta}(\mathbb{R}^d)$ imply that $u \in C^{k+m+\delta}(\mathbb{R}^d)$;
2. moreover, if we take $\lambda_0$ from Theorem 4.1.2 and take a real $\lambda$ so that $|\lambda| \ge \lambda_0$, then there exists a constant $N > 0$ depending only on $\kappa, k, m, \delta, K_1, d$, such that for any $u \in C^{k+m+\delta}(\mathbb{R}^d)$ we have

$$|u|_{k+m+\delta} + |\lambda|^{(k+m+\delta)/m} |u|_0 \ \le\ N\left(|L_\lambda u|_{k+\delta} + |\lambda|^{(k+\delta)/m} |L_\lambda u|_0\right).$$

**Notation (the operator, and the assumptions of Theorem 4.1.2).** $L = L(x) = \sum_{|\alpha| \le m} a^\alpha(x) D^\alpha$ is a uniformly elliptic operator of order $m \ge 1$ with ellipticity constant $\kappa > 0$,

$$\sum_{|\alpha| = m} a^\alpha(x)\, \xi^\alpha \ \ge\ \kappa |\xi|^m \qquad \text{for all } x, \xi \in \mathbb{R}^d ,$$

whose coefficients $a^\alpha$ are $\delta$-Hölder on $\mathbb{R}^d$ with $|a^\alpha|_\delta$ bounded by a fixed constant; $L_\lambda u := Lu - \lambda u$; and $\lambda_0 \ge 0$ is the constant furnished by Theorem 4.1.2, which depends only on $\kappa$, $m$, $\delta$, $d$ and the bound on $\max_\alpha |a^\alpha|_\delta$, and beyond which ($|\lambda| \ge \lambda_0$) the equation $L_\lambda u = f$ is uniquely solvable in $C^{m+\delta}(\mathbb{R}^d)$ for $f \in C^{\delta}(\mathbb{R}^d)$.

**Notation (Hölder spaces).** For an integer $k \ge 0$, $\delta \in (0,1)$ and a domain $\Omega \subseteq \mathbb{R}^d$,

$$[u]_{k,\Omega} = \max_{|\alpha| = k}\ \sup_{\Omega} |D^\alpha u| , \qquad
[u]_{k+\delta,\Omega} = \max_{|\alpha| = k}\ \sup_{\substack{x,y \in \Omega \\ x \ne y}} \frac{|D^\alpha u(x) - D^\alpha u(y)|}{|x-y|^\delta} ,$$

$$|u|_{k+\delta,\Omega} = \sum_{j=0}^{k} [u]_{j,\Omega} \ +\ [u]_{k+\delta,\Omega} , \qquad |u|_{0,\Omega} = \sup_\Omega |u| ,$$

and $C^{k+\delta}(\Omega)$ is the set of functions having continuous derivatives up to order $k$ in $\Omega$ and finite norm $|u|_{k+\delta,\Omega}$. For $\Omega = \mathbb{R}^d$ the domain is omitted from the notation.
