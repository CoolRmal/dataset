# Context: krylov_4_5_1_variable_coefficient_global_solvability

**Statement:** [krylov_4_5_1_variable_coefficient_global_solvability.md](krylov_4_5_1_variable_coefficient_global_solvability.md) · **Criteria:** [krylov_4_5_1_variable_coefficient_global_solvability.criteria.md](krylov_4_5_1_variable_coefficient_global_solvability.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Notation

Chapter 4 of the book works with **complex-valued** functions throughout: the coefficients $a^\alpha$, the datum $f$ and the solution $u$ all take complex values. The standing assumption $m \ge 2$ on the order is in force.

Uniform ellipticity in Chapter 4 is a condition on the **whole** characteristic polynomial, not only the principal part: the modulus of $\sum_{|\alpha| \le m} a^\alpha(x)\, i^{|\alpha|}\xi^\alpha$ — note the factor $i^{|\alpha|}$ — is bounded below by $\kappa(1 + |\xi|^m)$ for all $x$ and all $\xi$, with one $\kappa > 0$ serving every $x$. At $\xi = 0$ this already constrains the zero-order coefficient. Reading it as the second-order chapters' real inequality on the principal part alone is wrong.

$L_\lambda$ denotes Krylov's **scaled family** $\sum_{|\alpha| \le m} a^\alpha(x)\,\lambda^{m-|\alpha|} D^\alpha$, which reduces to $L$ at $\lambda = 1$. It is **not** the shifted operator $Lu - \lambda u$ (nor $Lu + \lambda u$). Because the scaling weights the lower-order terms by powers of $\lambda$, the theorem genuinely covers **both signs**: every real $\lambda$ with $|\lambda| \ge \lambda_0$. Under a shift reading, one of the two half-lines would be false.

Krylov's norm $|u|_{k+\delta}$ bundles **all** the lower-order sup norms, not only the top Hölder seminorm, and membership in $C^{k+\delta}$ requires the derivatives to exist as well as the norm to be finite.

$\lambda_0$ is **produced** by the theorem, and it is the specific constant of Theorem 4.1.2: together with its companion $N_0$ it is characterized by the a priori estimate $[u]_{m+\delta} + |\lambda|^{m+\delta}|u|_0 \le N_0([L_\lambda u]_\delta + |\lambda|^\delta |L_\lambda u|_0)$ holding for every $u \in C^{m+\delta}(\mathbb{R}^d)$ and every real $|\lambda| \ge \lambda_0$. It depends only on $\kappa$, $m$, $\delta$, $d$ and the bound $K$ on the $|a^\alpha|_\delta$ — not on $f$, not on $u$, and not on $k$.
