# O. Kallenberg, *Foundations of Modern Probability*, Theorem 9.30 (optional sampling and closure, Doob)

- **Source:** O. Kallenberg, *Foundations of Modern Probability*
- **Domain:** Martingales
- **Lean declaration:** `Dataset.KallenbergProbability.kallenberg_9_30_optional_sampling_and_closure` ([kallenberg_9_30_optional_sampling_and_closure.lean](kallenberg_9_30_optional_sampling_and_closure.lean))
- **Criteria:** [kallenberg_9_30_optional_sampling_and_closure.criteria.md](kallenberg_9_30_optional_sampling_and_closure.criteria.md)
- **Context:** [kallenberg_9_30_optional_sampling_and_closure.context.md](kallenberg_9_30_optional_sampling_and_closure.context.md)

## Statement

**Theorem 9.30 (optional sampling and closure, Doob).** Let $X$ be an $\mathcal{F}$-submartingale on $\mathbb{R}_+$, where $X$ and $\mathcal{F}$ are right-continuous, and consider some optional times $\sigma, \tau$, where $\tau$ is bounded. Then $X_\tau$ is integrable, and

$$X_{\sigma \wedge \tau} \le \mathbb{E}\big(X_\tau \mid \mathcal{F}_\sigma\big) \quad \text{a.s.}$$

This extends to unbounded times $\tau$ iff $X^+$ is uniformly integrable.
