# Context: conway_VII_7_1_riesz_compact_operator_spectrum

**Statement:** [conway_VII_7_1_riesz_compact_operator_spectrum.md](conway_VII_7_1_riesz_compact_operator_spectrum.md) · **Criteria:** [conway_VII_7_1_riesz_compact_operator_spectrum.criteria.md](conway_VII_7_1_riesz_compact_operator_spectrum.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Riesz's trichotomy: $\sigma(A)$ and $\mathcal{B}_0(\mathcal{X})$

**$\mathcal{B}_0(\mathcal{X})$** is the ideal of *compact* operators on the complex Banach space
$\mathcal{X}$.

**$\sigma(A)$** is the Banach-algebra spectrum: $\{\lambda \in \mathbb{C} : A - \lambda \text{ is not
invertible in } \mathcal{B}(\mathcal{X})\}$. It is not the same as the set of eigenvalues in general —
part of the theorem's content is that, for a compact operator on an infinite-dimensional space, every
nonzero spectral value *is* an eigenvalue.

**$\dim\mathcal{X} = \infty$ forces $0 \in \sigma(A)$**, because a compact operator on an
infinite-dimensional space cannot be invertible. That is why $0$ appears in all three cases; it is not
asserted to be an eigenvalue.

**The trichotomy.** Exactly one of: the spectrum is $\{0\}$; it is $\{0\}$ plus finitely many (at least
one) distinct nonzero eigenvalues; or it is $\{0\}$ plus a sequence of distinct nonzero eigenvalues
converging to $0$. In cases (b) and (c) each listed $\lambda_k$ is an eigenvalue with a finite
dimensional eigenspace.

**"one and only one"** is exclusivity. The three cases as printed are already mutually exclusive
provided the listed eigenvalues are nonzero and distinct — which is why those conditions are part of
each case rather than decoration.
