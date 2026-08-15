# Context: conway_IX_2_2_bounded_normal_spectral_theorem

**Statement:** [conway_IX_2_2_bounded_normal_spectral_theorem.md](conway_IX_2_2_bounded_normal_spectral_theorem.md) · **Criteria:** [conway_IX_2_2_bounded_normal_spectral_theorem.criteria.md](conway_IX_2_2_bounded_normal_spectral_theorem.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Spectral measures, $\sigma(N)$, and $\int z\,dE(z)$

**Spectral measure (projection-valued measure).** A map $E$ from the Borel subsets of $\sigma(N)$ to
orthogonal projections on $\mathcal{H}$ with $E(\emptyset) = 0$, $E(\sigma(N)) = 1$,
$E(\Delta_1 \cap \Delta_2) = E(\Delta_1)E(\Delta_2)$, and countable additivity *in the strong operator
topology*: for pairwise disjoint $\Delta_n$ the partial sums $\sum_{n \le N} E(\Delta_n)x$ converge to
$E(\bigcup_n \Delta_n)x$ for every vector $x$. Norm convergence would be too strong.

**$\sigma(N)$** is the spectrum of $N$ as an element of the Banach algebra $\mathcal{B}(\mathcal{H})$:
the set of $\lambda \in \mathbb{C}$ for which $N - \lambda$ is not invertible. For a normal operator it
is a nonempty compact subset of $\mathbb{C}$, and it need not consist of eigenvalues.

**$N = \int z\,dE(z)$.** The integral is understood weakly: for all vectors $x,y$,
$\langle Nx, y\rangle = \int z \, d\langle E(z)x,y\rangle$, where
$\Delta \mapsto \langle E(\Delta)x,y\rangle$ is a complex measure of finite total variation. Reading it
this way is what makes the identity a statement about ordinary scalar integrals.

**"Relatively open subset of $\sigma(N)$"** in (b) means open *in the subspace topology* of
$\sigma(N)$ — a set of the form $O \cap \sigma(N)$ with $O$ open in $\mathbb{C}$ — not open in
$\mathbb{C}$. The condition says $E$ has full support: it charges every nonempty relatively open piece
of the spectrum.

**(c) is a two-way equivalence** with *both* commutation relations $AN = NA$ **and** $AN^* = N^*A$ on
the left-hand side, and the $\Delta$ on the right ranges over all Borel sets.

**Uniqueness.** The theorem asserts there is exactly one such $E$. For uniqueness to be a meaningful
assertion the value of $E$ on sets outside its domain has to be pinned down as well, otherwise two
"different" spectral measures could differ only on sets nobody looks at.
