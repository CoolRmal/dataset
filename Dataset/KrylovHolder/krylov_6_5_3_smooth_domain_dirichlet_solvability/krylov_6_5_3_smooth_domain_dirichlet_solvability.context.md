# Context: krylov_6_5_3_smooth_domain_dirichlet_solvability

**Statement:** [krylov_6_5_3_smooth_domain_dirichlet_solvability.md](krylov_6_5_3_smooth_domain_dirichlet_solvability.md) · **Criteria:** [krylov_6_5_3_smooth_domain_dirichlet_solvability.criteria.md](krylov_6_5_3_smooth_domain_dirichlet_solvability.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Notation

Krylov's norm $|u|_{k+\delta}$ bundles **all** the lower-order sup norms, not only the top Hölder seminorm, and membership in $C^{k+\delta}$ requires the derivatives to exist as well as the norm to be finite. On the closure $\bar\Omega$ the derivatives in question are taken within $\bar\Omega$ — one-sided at the boundary — so membership in $C^{k+2+\delta}(\bar\Omega)$ genuinely constrains boundary behaviour.

Despite the traditional heading "the Dirichlet problem in a smooth domain", the theorem does **not** assume a $C^\infty$ boundary. The domain is of class $C^{k+2+\delta}$ in the sense of Definition 6.1.6: a single pair of constants $K_0, \rho_0 > 0$ serves every boundary point, near which the boundary is straightened into a hyperplane by an invertible map whose Hölder norms of every order up to $k+2+\delta$, and those of its inverse, are bounded by $K_0$, the inverse being Lipschitz as well. Reading "smooth" as infinitely differentiable restricts the theorem; the infinitely smooth case is a separate corollary in the book.

The standing assumptions of Chapter 6 are part of the statement: the coefficients $a^{ij}, b^i, c$ are **real** and defined on all of $\mathbb{R}^d$, the matrix $a$ is symmetric, $c \le 0$, the ellipticity bound $a^{ij}(x)\xi_i\xi_j \ge \kappa|\xi|^2$ holds with a single constant $\kappa > 0$ for all $x$ and $\xi$, and one constant $K$ bounds $|a,b,c|_{k+\delta}$ on the whole of $\mathbb{R}^d$ — not just on $\bar\Omega$, and not merely on compact subsets.

Note the asymmetry in the data: $f$ on the open $\Omega$, $g$ on the **closure**. The solution is found — and is unique — in $C^{k+2+\delta}(\bar\Omega)$, the space over the closure, so its regularity holds up to the boundary, not only inside. The zeroth-order coefficient must satisfy $c\le0$, or uniqueness fails.
