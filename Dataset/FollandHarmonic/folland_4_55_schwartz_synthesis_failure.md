# G. B. Folland, *A Course in Abstract Harmonic Analysis*, Second Edition, Theorem 4.55 (Schwartz's example: failure of spectral synthesis)

- **Source:** G. B. Folland, *A Course in Abstract Harmonic Analysis*, Second Edition
- **Domain:** Harmonic analysis
- **Lean declaration:** `Dataset.FollandHarmonic.folland_4_55_schwartz_synthesis_failure` ([folland_4_55_schwartz_synthesis_failure.lean](folland_4_55_schwartz_synthesis_failure.lean))
- **Criteria:** [folland_4_55_schwartz_synthesis_failure.criteria.md](folland_4_55_schwartz_synthesis_failure.criteria.md)

## Statement

**4.55 Theorem.** Let $G = \mathbb{R}^n$ with $n \ge 3$, and let $S$ be the unit sphere in $\mathbb{R}^n$. There is a closed ideal $I$ in $L^1(\mathbb{R}^n)$ such that $\nu(I) = S$ but $I \ne \iota(S)$.

**Notation.** $G$ is a locally compact abelian group, $\widehat{G}$ its dual group of continuous characters $\xi : G \to \mathbb{T}$, and $\widehat{f}(\xi) = \int f(x)\overline{\langle x,\xi\rangle}\,dx$ the Fourier transform. For a closed ideal $I \subset \mathcal{L}^1(G)$, $\nu(I) = \{\xi : \widehat{f}(\xi) = 0 \text{ for all } f \in I\}$ is its cospectrum (hull) and, for $E \subset \widehat{G}$, $\iota(E) = \{f \in \mathcal{L}^1(G) : \widehat{f}|_E = 0\}$ is the kernel of $E$; $\nu(f) := \nu(\{f\})$. On $\mathbb{R}^n$ the dual group is identified with $\mathbb{R}^n$ and $\widehat{f}(\xi) = \int e^{-2\pi i x\cdot\xi}f(x)\,dx$.
