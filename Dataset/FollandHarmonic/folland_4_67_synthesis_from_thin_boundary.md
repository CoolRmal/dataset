# G. B. Folland, *A Course in Abstract Harmonic Analysis*, Second Edition, Theorem 4.67 (a spectral synthesis criterion)

- **Source:** G. B. Folland, *A Course in Abstract Harmonic Analysis*, Second Edition
- **Domain:** Harmonic analysis
- **Lean declaration:** `Dataset.FollandHarmonic.folland_4_67_synthesis_from_thin_boundary` ([folland_4_67_synthesis_from_thin_boundary.lean](folland_4_67_synthesis_from_thin_boundary.lean))
- **Criteria:** [folland_4_67_synthesis_from_thin_boundary.criteria.md](folland_4_67_synthesis_from_thin_boundary.criteria.md)

## Statement

**4.67 Theorem.** Suppose $I$ is a closed ideal in $L^1(G)$, $f \in L^1(G)$, and $\nu(f) \supset \nu(I)$. If $\partial\nu(I) \cap \partial\nu(f)$ contains no nonempty perfect set, then $f \in I$.

**Notation.** $G$ is a locally compact abelian group, $\widehat{G}$ its dual group of continuous characters $\xi : G \to \mathbb{T}$, and $\widehat{f}(\xi) = \int f(x)\overline{\langle x,\xi\rangle}\,dx$ the Fourier transform. For a closed ideal $I \subset \mathcal{L}^1(G)$, $\nu(I) = \{\xi : \widehat{f}(\xi) = 0 \text{ for all } f \in I\}$ is its cospectrum (hull) and, for $E \subset \widehat{G}$, $\iota(E) = \{f \in \mathcal{L}^1(G) : \widehat{f}|_E = 0\}$ is the kernel of $E$; $\nu(f) := \nu(\{f\})$. A set is *perfect* if it is closed and has no isolated points; $\partial E$ denotes the topological boundary of $E$ in $\widehat{G}$.
