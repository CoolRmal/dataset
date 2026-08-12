# G. B. Folland, *A Course in Abstract Harmonic Analysis*, Second Edition, Theorem 4.43 (Fourier analysis on a subgroup and its annihilator)

- **Source:** G. B. Folland, *A Course in Abstract Harmonic Analysis*, Second Edition
- **Domain:** Harmonic analysis
- **Lean declaration:** `Dataset.FollandHarmonic.folland_4_43_subgroup_fourier_formula` ([folland_4_43_subgroup_fourier_formula.lean](folland_4_43_subgroup_fourier_formula.lean))
- **Criteria:** [folland_4_43_subgroup_fourier_formula.criteria.md](folland_4_43_subgroup_fourier_formula.criteria.md)

## Statement

**4.43 Theorem.** Suppose $H$ is a closed subgroup of $G$. If $f \in C_c(G)$, define $F \in C_c(G/H)$ by $F(xH) = \int_H f(xy)\,dy$. Then $\widehat{F} = \widehat{f}|_{H^{\perp}}$, where we identify $(G/H)^{\widehat{\ }}$ with $H^{\perp}$. If also $\widehat{f}|_{H^{\perp}} \in L^1(H^{\perp})$, then (with Haar measures on $H$ and $H^{\perp}$ suitably normalized)

$$\int_H f(xy)\,dy = \int_{H^{\perp}} \widehat{f}(\xi)\langle x,\xi\rangle\,d\xi. \tag{4.44}$$

**Notation.** $G$ is a locally compact abelian group, $\widehat{G}$ its dual group of continuous characters $\xi : G \to \mathbb{T}$, and $\widehat{f}(\xi) = \int f(x)\overline{\langle x,\xi\rangle}\,dx$ the Fourier transform. For a closed ideal $I \subset \mathcal{L}^1(G)$, $\nu(I) = \{\xi : \widehat{f}(\xi) = 0 \text{ for all } f \in I\}$ is its cospectrum (hull) and, for $E \subset \widehat{G}$, $\iota(E) = \{f \in \mathcal{L}^1(G) : \widehat{f}|_E = 0\}$ is the kernel of $E$; $\nu(f) := \nu(\{f\})$. $H^{\perp} = \{\xi \in \widehat{G} : \langle y,\xi\rangle = 1 \text{ for all } y \in H\}$ is the annihilator of $H$.
