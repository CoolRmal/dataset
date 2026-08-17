# Context: krylov_3_7_2_constant_coefficient_holder_solvability

**Statement:** [krylov_3_7_2_constant_coefficient_holder_solvability.md](krylov_3_7_2_constant_coefficient_holder_solvability.md) · **Criteria:** [krylov_3_7_2_constant_coefficient_holder_solvability.criteria.md](krylov_3_7_2_constant_coefficient_holder_solvability.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Notation

Krylov's norm $|u|_{k+\delta}$ bundles **all** the lower-order sup norms, not only the top Hölder seminorm, and membership in $C^{k+\delta}$ requires the derivatives to exist as well as the norm to be finite. The functions in these spaces are complex-valued, and the coefficients $a^\alpha$ are complex constants.

$L_\lambda$ is Krylov's scaled family, not a shift: the order-$|\alpha|$ coefficient is multiplied by $\lambda^{m-|\alpha|}$, so $L_1 = L$ and the zeroth-order coefficient becomes $\lambda^m a^0$. Reading $L_\lambda u$ as $Lu - \lambda u$ is wrong; under the scaled reading the equation is uniquely solvable for every nonzero real $\lambda$, of either sign — no positivity or threshold. Ellipticity is Definition 1.1.1 and has two parts: the principal part is nonzero for every $\xi \ne 0$, **and** the characteristic polynomial $\sum_{|\alpha| \le m} a^\alpha i^{|\alpha|}\xi^\alpha$ is nonzero for every $\xi$, including $\xi = 0$ — so $a^0 \ne 0$, and the Laplacian itself is not elliptic in this sense. The order obeys the book's standing assumption $m \ge 2$. The solution gains exactly $m$ derivatives.
