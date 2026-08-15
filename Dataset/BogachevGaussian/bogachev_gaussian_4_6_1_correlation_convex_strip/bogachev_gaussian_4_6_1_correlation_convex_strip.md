# V. I. Bogachev, *Gaussian Measures*, Theorem 4.6.1 (a Gaussian correlation inequality)

- **Source:** V. I. Bogachev, *Gaussian Measures*
- **Domain:** Measure theory
- **Lean declaration:** `Dataset.BogachevGaussian.bogachev_gaussian_4_6_1_correlation_convex_strip` ([bogachev_gaussian_4_6_1_correlation_convex_strip.lean](bogachev_gaussian_4_6_1_correlation_convex_strip.lean))
- **Criteria:** [bogachev_gaussian_4_6_1_correlation_convex_strip.criteria.md](bogachev_gaussian_4_6_1_correlation_convex_strip.criteria.md)
- **Context:** [bogachev_gaussian_4_6_1_correlation_convex_strip.context.md](bogachev_gaussian_4_6_1_correlation_convex_strip.context.md)

## Statement

**Theorem 4.6.1.** Let $\gamma$ be a centered Gaussian measure on $\mathbb{R}^n$. Then for every absolutely convex set $A$ and every strip $\Pi$ of the form $\Pi = \{x : |f(x)| \le c\}$, where $f$ is a linear function and $c \in \mathbb{R}^1$, one has

$$\gamma(A \cap \Pi) \ge \gamma(A)\gamma(\Pi). \tag{4.6.3}$$

**Notation.** A set $A$ is *absolutely convex* if it is convex and balanced. A measure on $\mathbb{R}^n$ is centered Gaussian when every linear functional has a centered Gaussian law.
