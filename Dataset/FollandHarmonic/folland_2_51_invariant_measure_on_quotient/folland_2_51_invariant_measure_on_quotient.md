# G. B. Folland, *A Course in Abstract Harmonic Analysis*, Second Edition, Theorem 2.51 (invariant measures on homogeneous spaces and Weil's formula)

- **Source:** G. B. Folland, *A Course in Abstract Harmonic Analysis*, Second Edition
- **Domain:** Harmonic analysis
- **Lean declaration:** `Dataset.FollandHarmonic.folland_2_51_invariant_measure_on_quotient` ([folland_2_51_invariant_measure_on_quotient.lean](folland_2_51_invariant_measure_on_quotient.lean))
- **Criteria:** [folland_2_51_invariant_measure_on_quotient.criteria.md](folland_2_51_invariant_measure_on_quotient.criteria.md)
- **Context:** [folland_2_51_invariant_measure_on_quotient.context.md](folland_2_51_invariant_measure_on_quotient.context.md)

## Statement

**2.51 Theorem.** Suppose $G$ is a locally compact group and $H$ is a closed subgroup. There is a $G$-invariant Radon measure $\mu$ on $G/H$ if and only if $\Delta_G|_H = \Delta_H$. In this case, $\mu$ is unique up to a constant factor, and if this factor is suitably chosen we have

$$\int_G f(x)\,dx = \int_{G/H} Pf\,d\mu = \int_{G/H}\int_H f(x\xi)\,d\xi\,d\mu(xH) \tag{2.52}$$

for $f \in C_c(G)$.

**Notation.** Throughout, $G$ is a locally compact group with a fixed left Haar measure, $L_yf(x) = f(y^{-1}x)$ and $R_yf(x) = f(xy)$ are the left and right translates of $f$, and $f*g(x) = \int f(y)g(y^{-1}x)\,dy$ is convolution. $\mathcal{L}^1(G)$ is a Banach algebra under convolution. $Pf(xH) = \int_H f(x\xi)\,d\xi$ is the averaging map $C_c(G) \to C_c(G/H)$, and $\Delta_G$, $\Delta_H$ are the modular functions of $G$ and of $H$.
