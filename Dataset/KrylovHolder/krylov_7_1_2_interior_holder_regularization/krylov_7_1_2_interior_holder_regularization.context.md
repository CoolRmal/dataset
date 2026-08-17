# Context: krylov_7_1_2_interior_holder_regularization

**Statement:** [krylov_7_1_2_interior_holder_regularization.md](krylov_7_1_2_interior_holder_regularization.md) · **Criteria:** [krylov_7_1_2_interior_holder_regularization.criteria.md](krylov_7_1_2_interior_holder_regularization.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Notation

Krylov's norm $|u|_{k+\delta,\Omega}$ bundles **all** the lower-order sup norms over $\Omega$, not only the top Hölder seminorm, and membership in $C^{k+\delta}(\Omega)$ requires the derivatives to exist as well as the norm to be finite. The local space $C^{k+\delta}_{\mathrm{loc}}(\Omega)$ instead asks for membership in $C^{k+\delta}(\Omega')$ for every bounded open $\Omega'$ whose closure lies in $\Omega$.

The hypotheses and the conclusion live in different classes, and both directions matter. The hypotheses $u \in C^{m+\delta}(\Omega)$ and $L_\lambda u \in C^{k+\delta}(\Omega)$ are the global-norm classes on $\Omega$; the conclusion is only the local class $C^{k+m+\delta}_{\mathrm{loc}}(\Omega)$. Reading the conclusion as the global class is false — the gained derivatives may blow up at $\partial\Omega$ — and reading the hypotheses as merely local classes is a different theorem from the one the book proves. **Interior** means exactly this locality of the conclusion: nothing is claimed up to $\partial\Omega$.

The setting of Section 7.1: the coefficients $a^\alpha$ are *complex*-valued, as are $u$ and $L_\lambda u$, and satisfy $|a^\alpha|_{k+\delta} \le K$ for a constant $K$ — the same exponent $k+\delta$ as the datum. Uniform ellipticity is the Chapter-4 condition: the modulus of the **full** characteristic polynomial $\sum_{|\alpha| \le m} a^\alpha(x)\, i^{|\alpha|} \xi^\alpha$ is at least $\kappa(1+|\xi|^m)$ for every $x$ and $\xi$, with one constant $\kappa > 0$ — a bound on the principal part alone is weaker (it says nothing at small $\xi$). The order carries the book's standing assumption $m \ge 2$.

The family $L_\lambda = \sum_{|\alpha| \le m} a^\alpha(x)\, \lambda^{m-|\alpha|} D^\alpha$ weights each coefficient by a power of $\lambda$, so that $L_1 = L$; it is **not** the shift $L - \lambda$. Unlike the solvability theorems, $\lambda$ here is an arbitrary real number — no threshold, no sign condition.
