# G. B. Folland, *A Course in Abstract Harmonic Analysis*, Second Edition, 2.44 Proposition

- **Source:** G. B. Folland, *A Course in Abstract Harmonic Analysis*, Second Edition
- **Domain:** Harmonic analysis
- **Lean declaration:** `Dataset.FollandHarmonic.folland_2_44_approximate_identity` ([folland_2_44_approximate_identity.lean](folland_2_44_approximate_identity.lean))
- **Criteria:** [folland_2_44_approximate_identity.criteria.md](folland_2_44_approximate_identity.criteria.md)

## Statement

**2.44 Proposition.** Let $\mathcal{U}$ be a neighborhood base at $1$ in $G$. For each $U \in \mathcal{U}$, let $\psi_U$ be a function such that

(i) $\operatorname{supp}\psi_U$ is compact and contained in $U$,

(ii) $\psi_U \ge 0$ and $\int \psi_U = 1$.

Then $\|\psi_U * f - f\|_p \to 0$ as $U \to \{1\}$ if $1 \le p < \infty$ and $f \in L^p$, or if $p = \infty$ and $f$ is left uniformly continuous. If, in addition,

(iii) $\psi_U(x^{-1}) = \psi_U(x)$ for all $x$,

then $\|f * \psi_U - f\|_p \to 0$ as $U \to \{1\}$ if $1 \le p < \infty$ and $f \in L^p$, or if $p = \infty$ and $f$ is right uniformly continuous.

**Notation.** A family $\{\psi_U\}$ satisfying (i)–(iii) is called an *approximate identity*. "$\|\psi_U * f - f\|_p \to 0$ as $U \to \{1\}$" means: for every $\varepsilon > 0$ there is a neighborhood $U$ of $1$ such that every $\psi$ satisfying (i)–(ii) with support inside $U$ already achieves $\|\psi * f - f\|_p < \varepsilon$. Throughout, $G$ is a locally compact group with a fixed left Haar measure, $L_yf(x) = f(y^{-1}x)$ and $R_yf(x) = f(xy)$ are the left and right translates of $f$, and $f*g(x) = \int f(y)g(y^{-1}x)\,dy$ is convolution. $\mathcal{L}^1(G)$ is a Banach algebra under convolution. The modular function $\Delta : G \to (0,\infty)$ is determined by $\lambda(Ex) = \Delta(x)\lambda(E)$ for a left Haar measure $\lambda$; $G$ is *unimodular* when $\Delta \equiv 1$.
