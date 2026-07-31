# O. Kallenberg, *Foundations of Modern Probability*, Theorem 4.23 (moments and Hölder continuity; Kolmogorov, Loève, Chentsov)

- **Source:** O. Kallenberg, *Foundations of Modern Probability*
- **Domain:** Stochastic processes
- **Lean declaration:** `Dataset.KallenbergProbability.kallenberg_4_23_moments_and_holder_continuity` ([kallenberg_4_23_moments_and_holder_continuity.lean](kallenberg_4_23_moments_and_holder_continuity.lean))
- **Criteria:** [kallenberg_4_23_moments_and_holder_continuity.criteria.md](kallenberg_4_23_moments_and_holder_continuity.criteria.md)

## Statement

**Theorem 4.23 (moments and Hölder continuity; Kolmogorov, Loève, Chentsov).** Let $X$ be a process on $\mathbb{R}^d$ with values in a complete metric space $(S, \rho)$, such that

$$\mathbb{E}\,\rho(X_s, X_t)^a \lesssim |s - t|^{d+b}, \qquad s, t \in \mathbb{R}^d,$$

for some constants $a, b > 0$. Then a version of $X$ is locally Hölder continuous of order $p$, for every $p \in (0, b/a)$.

**Modulus of continuity, Hölder continuity, and locality.** For any mapping $f$ between two metric spaces $(S, \rho)$ and $(S', \rho')$, we define the *modulus of continuity* $w_f = w(f, \cdot)$ by

$$w_f(r) = \sup\{\rho'(f_s, f_t) ;\ s, t \in S,\ \rho(s, t) \le r\}, \qquad r > 0,$$

so that $f$ is uniformly continuous iff $w_f(r) \to 0$ as $r \to 0$. Say that $f$ is *Hölder continuous of order $p$* if $w_f(r) \lesssim r^p$ as $r \to 0$. The stated property is said to hold *locally* if it is valid on every bounded set.

**The relation $\lesssim$.** For functions $f, g > 0$, we mean by $f \lesssim g$ that $f \le cg$ for some constant $c < \infty$.
