# Context: conway_II_7_6_compact_normal_spectral_theorem

**Statement:** [conway_II_7_6_compact_normal_spectral_theorem.md](conway_II_7_6_compact_normal_spectral_theorem.md) · **Criteria:** [conway_II_7_6_compact_normal_spectral_theorem.criteria.md](conway_II_7_6_compact_normal_spectral_theorem.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Notation of Conway II.7.6

**$\mathcal{H}$, $\mathcal{B}(\mathcal{H})$.** $\mathcal{H}$ is a complex Hilbert space — no
separability and no finite-dimensionality is assumed. $\mathcal{B}(\mathcal{H})$ is the algebra of
bounded operators with the operator norm, and "converges in the metric defined by the norm on
$\mathcal{B}(\mathcal{H})$" means convergence *in operator norm*, not strongly and not weakly.

**Normal** means $T^*T = TT^*$. It is weaker than self-adjoint and does not force the eigenvalues to be
real.

**Compact operator.** $T$ maps the unit ball to a relatively compact set. Conway writes
$\mathcal{B}_0(\mathcal{X})$ for the compact operators.

**$P_n$ is the projection onto $\ker(T-\lambda_n)$**: the *orthogonal* projection with range exactly
that eigenspace. Idempotence alone is not enough — an oblique idempotent with the same range is not
what is meant, and the mutual orthogonality $P_nP_m = 0$ is what encodes that the eigenspaces are
perpendicular.

**Only the nonzero eigenvalues are listed.** $0$ may or may not be an eigenvalue and is deliberately
excluded from the enumeration; each listed $\lambda_n$ is nonzero, and the $\lambda_n$ are distinct, so
no eigenvalue is repeated. The eigenvalues are countable, and — because the sum converges in norm —
only finitely many can exceed any given modulus.

**The sum is unordered.** $\sum_{n} \lambda_n P_n = T$ with pairwise orthogonal terms converges
independently of the enumeration.
