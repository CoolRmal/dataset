# G. B. Folland, *A Course in Abstract Harmonic Analysis*, Second Edition, Theorem 2.31 (inversion formula for the modular function)

- **Source:** G. B. Folland, *A Course in Abstract Harmonic Analysis*, Second Edition
- **Domain:** Harmonic analysis
- **Lean declaration:** `Dataset.FollandHarmonic.folland_2_31_modular_inversion_formula` ([folland_2_31_modular_inversion_formula.lean](folland_2_31_modular_inversion_formula.lean))
- **Criteria:** [folland_2_31_modular_inversion_formula.criteria.md](folland_2_31_modular_inversion_formula.criteria.md)
- **Context:** [folland_2_31_modular_inversion_formula.context.md](folland_2_31_modular_inversion_formula.context.md)

## Statement

**2.31 Theorem.** If $\lambda$ is a left Haar measure on $G$ and $\Delta$ is the modular function of $G$, then for every $f \in L^1(G)$

$$\int_G f(x^{-1})\Delta(x^{-1})\,d\lambda(x) = \int_G f(x)\,d\lambda(x).$$

**Notation.** Throughout, $G$ is a locally compact group with a fixed left Haar measure, $L_yf(x) = f(y^{-1}x)$ and $R_yf(x) = f(xy)$ are the left and right translates of $f$, and $f*g(x) = \int f(y)g(y^{-1}x)\,dy$ is convolution. $\mathcal{L}^1(G)$ is a Banach algebra under convolution. The modular function $\Delta : G \to (0,\infty)$ is determined by $\lambda(Ex) = \Delta(x)\lambda(E)$ for a left Haar measure $\lambda$; it is a continuous homomorphism and is identically $1$ exactly when $G$ is unimodular.
