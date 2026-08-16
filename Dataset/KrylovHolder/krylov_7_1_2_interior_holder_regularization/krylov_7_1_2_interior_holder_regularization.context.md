# Context: krylov_7_1_2_interior_holder_regularization

**Statement:** [krylov_7_1_2_interior_holder_regularization.md](krylov_7_1_2_interior_holder_regularization.md) · **Criteria:** [krylov_7_1_2_interior_holder_regularization.criteria.md](krylov_7_1_2_interior_holder_regularization.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Notation

Krylov's norm $|u|_{k+\delta}$ bundles **all** the lower-order sup norms, not only the top Hölder seminorm, and membership in $C^{k+\delta}$ requires the derivatives to exist as well as the norm to be finite.

**Interior** means the gain holds on compact subsets, with nothing claimed up to $\partial\Omega$. Unlike the solvability theorems, $\lambda$ is arbitrary — no threshold, no sign condition.
