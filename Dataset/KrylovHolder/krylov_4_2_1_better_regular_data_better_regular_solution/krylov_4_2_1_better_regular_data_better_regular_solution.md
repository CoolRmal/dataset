# N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Hölder Spaces*, Theorem 4.2.1 (better regular data give a better regular solution)

- **Source:** N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Hölder Spaces*
- **Domain:** PDE
- **Lean declaration:** `Dataset.KrylovHolder.krylov_4_2_1_better_regular_data_better_regular_solution` ([krylov_4_2_1_better_regular_data_better_regular_solution.lean](krylov_4_2_1_better_regular_data_better_regular_solution.lean))
- **Criteria:** [krylov_4_2_1_better_regular_data_better_regular_solution.criteria.md](krylov_4_2_1_better_regular_data_better_regular_solution.criteria.md)
- **Context:** [krylov_4_2_1_better_regular_data_better_regular_solution.context.md](krylov_4_2_1_better_regular_data_better_regular_solution.context.md)

## Statement

**Theorem 4.2.1.** Let the assumptions of Theorem 4.1.2 be satisfied, and let $k \ge 0$ be an integer, $K_1 \ge 1$ be a constant. Assume that for any $\alpha$ we have $|a^\alpha|_{k+\delta} \le K_1$. Then:

1. for any $\lambda$, the inclusions $u \in C^{m+\delta}(\mathbb{R}^d)$ and $L_\lambda u \in C^{k+\delta}(\mathbb{R}^d)$ imply that $u \in C^{k+m+\delta}(\mathbb{R}^d)$;
2. moreover, if we take $\lambda_0$ from Theorem 4.1.2 and take a real $\lambda$ so that $|\lambda| \ge \lambda_0$, then there exists a constant $N > 0$ depending only on $\kappa, k, m, \delta, K_1, d$, such that for any $u \in C^{k+m+\delta}(\mathbb{R}^d)$ we have

$$[u]_{k+m+\delta} + |\lambda|^{k+m+\delta} |u|_0 \ \le\ N\left([L_\lambda u]_{k+\delta} + |\lambda|^{k+\delta} |L_\lambda u|_0\right). \tag{4.2.1}$$

**Notation (the operator, Chapter 4).** $a^\alpha(x)$ are *complex* functions given for $|\alpha| \le m$, $x \in \mathbb{R}^d$, such that for a constant $\kappa > 0$ and all $\xi, x \in \mathbb{R}^d$

$$\Big|\sum_{|\alpha| \le m} a^\alpha(x)\, i^{|\alpha|} \xi^\alpha\Big| \ \ge\ \kappa\,(1 + |\xi|^m),$$

so that the operator $L = L(x) = \sum_{|\alpha| \le m} a^\alpha(x) D^\alpha$ is *uniformly elliptic*; the order obeys the book's standing assumption $m \ge 2$. For real $\lambda$ the operator family is

$$L_\lambda := \sum_{|\alpha| \le m} a^\alpha(x)\, \lambda^{m-|\alpha|} D^\alpha ,$$

so that $L_1 = L$.

**Notation (the assumptions of Theorem 4.1.2, and $\lambda_0$).** Theorem 4.1.2 assumes that $|a^\alpha|_\delta \le K$ for every $\alpha$, where $K$ is a constant, and furnishes constants $N_0, \lambda_0 \ge 0$ depending only on $\kappa, m, \delta, K, d$ such that for any $u \in C^{m+\delta}(\mathbb{R}^d)$ and any real $\lambda$ with $|\lambda| \ge \lambda_0$

$$[u]_{m+\delta} + |\lambda|^{m+\delta}|u|_0 \ \le\ N_0\left([L_\lambda u]_{\delta} + |\lambda|^{\delta} |L_\lambda u|_0\right). \tag{4.1.2}$$

It is this constant $\lambda_0$ that part 2 refers to.

**Notation (Hölder spaces).** For an integer $k \ge 0$, $\delta \in (0,1)$ and a domain $\Omega \subseteq \mathbb{R}^d$,

$$[u]_{k,\Omega} = \max_{|\alpha| = k}\ \sup_{\Omega} |D^\alpha u| , \qquad
[u]_{k+\delta,\Omega} = \max_{|\alpha| = k}\ \sup_{\substack{x,y \in \Omega \\ x \ne y}} \frac{|D^\alpha u(x) - D^\alpha u(y)|}{|x-y|^\delta} ,$$

$$|u|_{k+\delta,\Omega} = \sum_{j=0}^{k} [u]_{j,\Omega} \ +\ [u]_{k+\delta,\Omega} , \qquad |u|_{0,\Omega} = \sup_\Omega |u| ,$$

and $C^{k+\delta}(\Omega)$ is the set of (complex-valued) functions having continuous derivatives up to order $k$ in $\Omega$ and finite norm $|u|_{k+\delta,\Omega}$. For $\Omega = \mathbb{R}^d$ the domain is omitted from the notation.
