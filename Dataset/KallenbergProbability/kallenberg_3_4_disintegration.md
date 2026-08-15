# O. Kallenberg, *Foundations of Modern Probability*, Theorem 3.4 (disintegration)

- **Source:** O. Kallenberg, *Foundations of Modern Probability*
- **Domain:** Probability
- **Lean declaration:** `Dataset.KallenbergProbability.kallenberg_3_4_disintegration` ([kallenberg_3_4_disintegration.lean](kallenberg_3_4_disintegration.lean))
- **Criteria:** [kallenberg_3_4_disintegration.criteria.md](kallenberg_3_4_disintegration.criteria.md)
- **Context:** [kallenberg_3_4_disintegration.context.md](kallenberg_3_4_disintegration.context.md)

## Statement

**Theorem 3.4 (disintegration).** Let $\rho$ be a $\sigma$-finite measure on $S \times T$, where $T$ is Borel. Then

- **(i)** $\rho = \nu \otimes \mu$ for a $\sigma$-finite measure $\nu \sim \rho(\cdot \times T) \equiv \hat{\rho}_S$ and a $\sigma$-finite kernel $\mu : S \to T$,
- **(ii)** the $\mu_s$ are $\nu$-a.e. unique up to normalizations, and they are a.e. bounded iff $\hat{\rho}_S$ is $\sigma$-finite,
- **(iii)** when $\hat{\rho}$ is $\sigma$-finite and $\nu = \hat{\rho}_S$, we may choose the $\mu_s$ to be probability measures on $T$.

**Supporting measure and disintegration kernel.** Any $\sigma$-finite measure $\nu \sim \rho(\cdot \times T)$ is called a *supporting measure* of $\rho$, and we refer to $\mu$ as the associated *disintegration kernel*.

**Finiteness notions for kernels.** A kernel $\mu : S \to T$ is said to be *finite* if $\mu_s T < \infty$ for all $s \in S$, *s-finite* if it is a countable sum of finite kernels, and *$\sigma$-finite* if it satisfies $\mu_s f_s < \infty$ for some measurable function $f > 0$ on $S \times T$, where $f_s = f(s, \cdot)$.
