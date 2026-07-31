# O. Kallenberg, *Foundations of Modern Probability*, Theorem 6.13 (Gaussian variance criteria; Lindeberg, Feller)

- **Source:** O. Kallenberg, *Foundations of Modern Probability*
- **Domain:** Probability
- **Lean declaration:** `Dataset.KallenbergProbability.kallenberg_6_13_gaussian_variance_criteria` ([kallenberg_6_13_gaussian_variance_criteria.lean](kallenberg_6_13_gaussian_variance_criteria.lean))
- **Criteria:** [kallenberg_6_13_gaussian_variance_criteria.criteria.md](kallenberg_6_13_gaussian_variance_criteria.criteria.md)

## Statement

**Theorem 6.13 (Gaussian variance criteria; Lindeberg, Feller).** Let $(\xi_{nj})$ be a triangular array with $\mathbb{E}\,\xi_{nj} = 0$ and $\sum_j \operatorname{Var}(\xi_{nj}) \to 1$, and let $\zeta$ be $N(0, 1)$. Then these conditions are equivalent:

- **(i)** $\sum_j \xi_{nj} \to \zeta$ in distribution and $\sup_j \operatorname{Var}(\xi_{nj}) \to 0$,
- **(ii)** $\sum_j \mathbb{E}\big(\xi_{nj}^2 ;\ |\xi_{nj}| > \varepsilon\big) \to 0$, $\varepsilon > 0$.

Here (ii) is the celebrated *Lindeberg condition*.
