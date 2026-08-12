# G. B. Folland, *A Course in Abstract Harmonic Analysis*, Second Edition, Theorem 4.52 ($\nu$ is a left inverse for $\iota$)

- **Source:** G. B. Folland, *A Course in Abstract Harmonic Analysis*, Second Edition
- **Domain:** Harmonic analysis
- **Lean declaration:** `Dataset.FollandHarmonic.folland_4_52_hull_of_kernel` ([folland_4_52_hull_of_kernel.lean](folland_4_52_hull_of_kernel.lean))
- **Criteria:** [folland_4_52_hull_of_kernel.criteria.md](folland_4_52_hull_of_kernel.criteria.md)

## Statement

**4.52 Theorem.** If $N \subset \widehat{G}$ is closed, then $\nu(\iota(N)) = N$.

**Notation.** $G$ is a locally compact abelian group, $\widehat{G}$ its dual group of continuous characters $\xi : G \to \mathbb{T}$, and $\widehat{f}(\xi) = \int f(x)\overline{\langle x,\xi\rangle}\,dx$ the Fourier transform. For a closed ideal $I \subset \mathcal{L}^1(G)$, $\nu(I) = \{\xi : \widehat{f}(\xi) = 0 \text{ for all } f \in I\}$ is its cospectrum (hull) and, for $E \subset \widehat{G}$, $\iota(E) = \{f \in \mathcal{L}^1(G) : \widehat{f}|_E = 0\}$ is the kernel of $E$; $\nu(f) := \nu(\{f\})$.
