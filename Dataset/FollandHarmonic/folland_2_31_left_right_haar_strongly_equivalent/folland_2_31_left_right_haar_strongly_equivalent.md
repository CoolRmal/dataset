# G. B. Folland, *A Course in Abstract Harmonic Analysis*, Second Edition, Theorem 2.31 (inversion formula for the modular function)

- **Source:** G. B. Folland, *A Course in Abstract Harmonic Analysis*, Second Edition
- **Domain:** Harmonic analysis
- **Lean declaration:** `Dataset.FollandHarmonic.folland_2_31_left_right_haar_strongly_equivalent` ([folland_2_31_left_right_haar_strongly_equivalent.lean](folland_2_31_left_right_haar_strongly_equivalent.lean))
- **Criteria:** [folland_2_31_left_right_haar_strongly_equivalent.criteria.md](folland_2_31_left_right_haar_strongly_equivalent.criteria.md)
- **Context:** [folland_2_31_left_right_haar_strongly_equivalent.context.md](folland_2_31_left_right_haar_strongly_equivalent.context.md)

## Statement

To each left Haar measure $\lambda$ is associated the right Haar measure $\rho$ defined by $\rho(E) = \lambda(E^{-1})$. The modular function can be used to relate $\lambda$ to $\rho$:

**2.31 Proposition.** $\lambda$ and $\rho$ are strongly equivalent, and

$$d\rho(x) = \Delta(x^{-1})\,d\lambda(x).$$

**Notation.** Two Radon measures $\mu, \nu$ on a locally compact Hausdorff space $X$ are *strongly equivalent* when they satisfy the hypothesis of Proposition 2.23: there is a **continuous** $f \colon X \to (0,\infty)$ with $\int \varphi\,d\nu = \int \varphi f\,d\mu$ for all $\varphi \in C_c(X)$ — and then $\nu(E) = \int_E f\,d\mu$ for every Borel $E$. This is strictly stronger than mutual absolute continuity. The modular function $\Delta \colon G \to (0,\infty)$ is determined by $\lambda(Ex) = \Delta(x)\lambda(E)$ for a left Haar measure $\lambda$.
