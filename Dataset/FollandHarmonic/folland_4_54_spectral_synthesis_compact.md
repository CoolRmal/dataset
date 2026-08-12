# G. B. Folland, *A Course in Abstract Harmonic Analysis*, Second Edition, Theorem 4.54 (spectral synthesis on compact groups)

- **Source:** G. B. Folland, *A Course in Abstract Harmonic Analysis*, Second Edition
- **Domain:** Harmonic analysis
- **Lean declaration:** `Dataset.FollandHarmonic.folland_4_54_spectral_synthesis_compact` ([folland_4_54_spectral_synthesis_compact.lean](folland_4_54_spectral_synthesis_compact.lean))
- **Criteria:** [folland_4_54_spectral_synthesis_compact.criteria.md](folland_4_54_spectral_synthesis_compact.criteria.md)

## Statement

**4.54 Theorem.** If $G$ is compact, then $\iota(\nu(I)) = I$ for every closed ideal $I \subset L^1(G)$.

**Notation.** $G$ is a locally compact abelian group, $\widehat{G}$ its dual group of continuous characters $\xi : G \to \mathbb{T}$, and $\widehat{f}(\xi) = \int f(x)\overline{\langle x,\xi\rangle}\,dx$ the Fourier transform. For a closed ideal $I \subset \mathcal{L}^1(G)$, $\nu(I) = \{\xi : \widehat{f}(\xi) = 0 \text{ for all } f \in I\}$ is its cospectrum (hull) and, for $E \subset \widehat{G}$, $\iota(E) = \{f \in \mathcal{L}^1(G) : \widehat{f}|_E = 0\}$ is the kernel of $E$; $\nu(f) := \nu(\{f\})$.
