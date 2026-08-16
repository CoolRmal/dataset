# Context: krylov_3_7_2_constant_coefficient_holder_solvability

**Statement:** [krylov_3_7_2_constant_coefficient_holder_solvability.md](krylov_3_7_2_constant_coefficient_holder_solvability.md) · **Criteria:** [krylov_3_7_2_constant_coefficient_holder_solvability.criteria.md](krylov_3_7_2_constant_coefficient_holder_solvability.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Notation

Krylov's norm $|u|_{k+\delta}$ bundles **all** the lower-order sup norms, not only the top Hölder seminorm, and membership in $C^{k+\delta}$ requires the derivatives to exist as well as the norm to be finite.

Ellipticity constrains the principal part only, and $L_\lambda u = Lu - \lambda u$: the sign of $\lambda$ decides invertibility. The solution gains exactly $m$ derivatives.
