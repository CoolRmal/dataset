# Context: krylov_4_2_1_better_regular_data_better_regular_solution

**Statement:** [krylov_4_2_1_better_regular_data_better_regular_solution.md](krylov_4_2_1_better_regular_data_better_regular_solution.md) · **Criteria:** [krylov_4_2_1_better_regular_data_better_regular_solution.criteria.md](krylov_4_2_1_better_regular_data_better_regular_solution.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Notation

This is a Chapter-4 theorem, and Chapter 4 changes the conventions of the earlier chapters. The
coefficients $a^\alpha$ and all functions are *complex-valued*, the order satisfies the standing
assumption $m \ge 2$, and "uniformly elliptic" means the modulus of the **full** characteristic
polynomial is bounded below: $\bigl|\sum_{|\alpha|\le m} a^\alpha(x)\, i^{|\alpha|}\xi^\alpha\bigr| \ge \kappa(1+|\xi|^m)$
for all real $\xi$ and all $x$. That is not positivity of a real principal symbol — it constrains
every term, and at $\xi = 0$ it already forces $|a^0(x)| \ge \kappa$. Reading "elliptic" as
$\sum_{|\alpha|=m} a^\alpha\xi^\alpha \ge \kappa|\xi|^m$ is a wrong reading here and changes which
theorem is being stated.

The family $L_\lambda$ is $\sum_{|\alpha|\le m} a^\alpha(x)\,\lambda^{m-|\alpha|} D^\alpha$: each
term is weighted by how far it falls short of top order, the zeroth-order term carries $\lambda^m$,
and $L_1 = L$. It is **not** the shifted operator $Lu - \lambda u$ of the second-order chapters; at
$\lambda = 0$ it degenerates to the principal part alone.

$\lambda_0$ means the threshold furnished by Theorem 4.1.2, which — under the bounds
$|a^\alpha|_\delta \le K$ — supplies constants $N_0$ and $\lambda_0 \ge 0$ such that
$[u]_{m+\delta} + |\lambda|^{m+\delta}|u|_0 \le N_0([L_\lambda u]_\delta + |\lambda|^\delta|L_\lambda u|_0)$
for every $u \in C^{m+\delta}$ and every real $\lambda$ with $|\lambda| \ge \lambda_0$. Theorem
4.1.2 is an *a priori estimate*, not a solvability theorem; solvability comes later in the chapter
and plays no role in 4.2.1.

Krylov's norm $|u|_{k+\delta}$ bundles **all** the lower-order sup norms; the seminorm
$[u]_{k+\delta}$ is only the top piece, a maximum over the multi-indices of order exactly $k$ of
Hölder quotients of $D^\alpha u$; and $|u|_0$ is the plain sup norm. The estimate (4.2.1) is stated
in *seminorms* plus $\lambda$-weighted sup norms — replacing them by full norms is a different
inequality. The weights are $|\lambda|^{k+m+\delta}$ and $|\lambda|^{k+\delta}$ exactly as written,
**not** divided by $m$: they differ by $|\lambda|^m$, the $\lambda$-homogeneity of the family.
Membership in $C^{k+\delta}$ requires the derivatives to exist as well as the norm to be finite.

Two separate assertions with different $\lambda$-ranges: the regularity gain holds for **every**
$\lambda$, with no threshold and no sign condition, while the weighted estimate holds for real
$\lambda$ of either sign with $|\lambda| \ge \lambda_0$ — two-sided, not just the positive
half-line. One constant $N$, depending only on $\kappa, k, m, \delta, K_1, d$, serves every such
$\lambda$ and every $u \in C^{k+m+\delta}$ at once.
