# G. B. Folland, *A Course in Abstract Harmonic Analysis*, Second Edition, Theorem 2.69 (Cohen's factorization for convolution)

- **Source:** G. B. Folland, *A Course in Abstract Harmonic Analysis*, Second Edition
- **Domain:** Harmonic analysis
- **Lean declaration:** `Dataset.FollandHarmonic.folland_2_69_convolution_factorization` ([folland_2_69_convolution_factorization.lean](folland_2_69_convolution_factorization.lean))
- **Criteria:** [folland_2_69_convolution_factorization.criteria.md](folland_2_69_convolution_factorization.criteria.md)
- **Context:** [folland_2_69_convolution_factorization.context.md](folland_2_69_convolution_factorization.context.md)

## Statement

**2.69 Theorem.** On any locally compact group $G$ we have $L^1(G) * L^p(G) = L^p(G)$ for $1 \le p < \infty$. Moreover, $L^1(G)*L^\infty(G) = L^1(G)*C_{lu}(G) = C_{lu}(G)$ and $L^\infty(G)*L^1(G) = C_{ru}(G)*L^1(G) = C_{ru}(G)$.

**Notation.** Throughout, $G$ is a locally compact group with a fixed left Haar measure, $L_yf(x) = f(y^{-1}x)$ and $R_yf(x) = f(xy)$ are the left and right translates of $f$, and $f*g(x) = \int f(y)g(y^{-1}x)\,dy$ is convolution. $\mathcal{L}^1(G)$ is a Banach algebra under convolution. $C_{lu}(G)$ and $C_{ru}(G)$ denote the bounded left- and right-uniformly continuous functions on $G$.
