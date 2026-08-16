# Context: krylov_4_2_1_better_regular_data_better_regular_solution

**Statement:** [krylov_4_2_1_better_regular_data_better_regular_solution.md](krylov_4_2_1_better_regular_data_better_regular_solution.md) · **Criteria:** [krylov_4_2_1_better_regular_data_better_regular_solution.criteria.md](krylov_4_2_1_better_regular_data_better_regular_solution.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Notation

Krylov's norm $|u|_{k+\delta}$ bundles **all** the lower-order sup norms, not only the top Hölder seminorm, and membership in $C^{k+\delta}$ requires the derivatives to exist as well as the norm to be finite.

Two separate assertions with different $\lambda$-ranges: the regularity gain holds for **every** $\lambda$, the weighted estimate only above the threshold. The exponents $(k+m+\delta)/m$ and $(k+\delta)/m$ come from the operator's scaling and are not interchangeable.
