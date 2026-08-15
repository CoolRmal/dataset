# G. B. Folland, *A Course in Abstract Harmonic Analysis*, Second Edition, 2.40 Proposition

- **Source:** G. B. Folland, *A Course in Abstract Harmonic Analysis*, Second Edition
- **Domain:** Harmonic analysis
- **Lean declaration:** `Dataset.FollandHarmonic.folland_2_40_convolution_lp_bound` ([folland_2_40_convolution_lp_bound.lean](folland_2_40_convolution_lp_bound.lean))
- **Criteria:** [folland_2_40_convolution_lp_bound.criteria.md](folland_2_40_convolution_lp_bound.criteria.md)
- **Context:** [folland_2_40_convolution_lp_bound.context.md](folland_2_40_convolution_lp_bound.context.md)

## Statement

**2.40 Proposition.** Suppose $1 \le p \le \infty$, $f \in L^1(G)$, and $g \in L^p(G)$.

a. The integrals in (2.36) converge absolutely for almost every $x$, and we have $f*g \in L^p(G)$ and $\|f*g\|_p \le \|f\|_1\|g\|_p$.

b. If $G$ is unimodular, the same conclusions hold with $f*g$ replaced by $g*f$.

c. If $G$ is not unimodular, we still have $g*f \in L^p(G)$ when $f$ has compact support.

**Notation.** Throughout, $G$ is a locally compact group with a fixed left Haar measure, $L_yf(x) = f(y^{-1}x)$ and $R_yf(x) = f(xy)$ are the left and right translates of $f$, and $f*g(x) = \int f(y)g(y^{-1}x)\,dy$ is convolution. $\mathcal{L}^1(G)$ is a Banach algebra under convolution. The modular function $\Delta : G \to (0,\infty)$ is determined by $\lambda(Ex) = \Delta(x)\lambda(E)$ for a left Haar measure $\lambda$; $G$ is *unimodular* when $\Delta \equiv 1$.
