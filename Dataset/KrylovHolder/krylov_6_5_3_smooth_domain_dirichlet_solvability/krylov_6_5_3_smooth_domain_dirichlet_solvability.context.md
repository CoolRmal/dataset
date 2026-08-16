# Context: krylov_6_5_3_smooth_domain_dirichlet_solvability

**Statement:** [krylov_6_5_3_smooth_domain_dirichlet_solvability.md](krylov_6_5_3_smooth_domain_dirichlet_solvability.md) · **Criteria:** [krylov_6_5_3_smooth_domain_dirichlet_solvability.criteria.md](krylov_6_5_3_smooth_domain_dirichlet_solvability.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Notation

Krylov's norm $|u|_{k+\delta}$ bundles **all** the lower-order sup norms, not only the top Hölder seminorm, and membership in $C^{k+\delta}$ requires the derivatives to exist as well as the norm to be finite.

Note the asymmetry in the data: $f$ on the open $\Omega$, $g$ on the **closure**. The zeroth-order coefficient must satisfy $c\le0$, or uniqueness fails.
