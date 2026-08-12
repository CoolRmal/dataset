# G. B. Folland, *A Course in Abstract Harmonic Analysis*, Second Edition, 2.42 Proposition

- **Source:** G. B. Folland, *A Course in Abstract Harmonic Analysis*, Second Edition
- **Domain:** Harmonic analysis
- **Lean declaration:** `Dataset.FollandHarmonic.folland_2_42_translation_continuity_lp` ([folland_2_42_translation_continuity_lp.lean](folland_2_42_translation_continuity_lp.lean))
- **Criteria:** [folland_2_42_translation_continuity_lp.criteria.md](folland_2_42_translation_continuity_lp.criteria.md)

## Statement

**2.42 Proposition.** If $1 \le p < \infty$ and $f \in L^p(G)$ then $\|L_yf - f\|_p$ and $\|R_yf - f\|_p$ tend to zero as $y \to 1$.

**Notation.** Throughout, $G$ is a locally compact group with a fixed left Haar measure, $L_yf(x) = f(y^{-1}x)$ and $R_yf(x) = f(xy)$ are the left and right translates of $f$, and $f*g(x) = \int f(y)g(y^{-1}x)\,dy$ is convolution. $\mathcal{L}^1(G)$ is a Banach algebra under convolution. The modular function $\Delta : G \to (0,\infty)$ is determined by $\lambda(Ex) = \Delta(x)\lambda(E)$ for a left Haar measure $\lambda$; $G$ is *unimodular* when $\Delta \equiv 1$.
