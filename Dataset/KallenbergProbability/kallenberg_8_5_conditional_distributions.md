# O. Kallenberg, *Foundations of Modern Probability*, Theorem 8.5 (conditional distributions, disintegration)

- **Source:** O. Kallenberg, *Foundations of Modern Probability*
- **Domain:** Probability
- **Lean declaration:** `Dataset.KallenbergProbability.kallenberg_8_5_conditional_distributions` ([kallenberg_8_5_conditional_distributions.lean](kallenberg_8_5_conditional_distributions.lean))
- **Criteria:** [kallenberg_8_5_conditional_distributions.criteria.md](kallenberg_8_5_conditional_distributions.criteria.md)
- **Context:** [kallenberg_8_5_conditional_distributions.context.md](kallenberg_8_5_conditional_distributions.context.md)

## Statement

**Theorem 8.5 (conditional distributions, disintegration).** Let $\xi, \eta$ be random elements in $S, T$, where $T$ is Borel. Then $\mathcal{L}(\xi, \eta) = \mathcal{L}(\xi) \otimes \mu$ for a probability kernel $\mu : S \to T$, where $\mu$ is unique a.e. $\mathcal{L}(\xi)$ and satisfies

- **(i)** $\mathcal{L}(\eta \mid \xi) = \mu(\xi, \cdot)$ a.s.,
- **(ii)** $\mathbb{E}\big(f(\xi, \eta) \mid \xi\big) = \int \mu(\xi, dt)\, f(\xi, t)$ a.s., $f \ge 0$.

**Conditional distribution.** For any random element $\xi$ in a measurable space $(S, \mathcal{S})$, we define a *conditional distribution* of $\eta$, given $\xi$, as a random measure of the form $\mu(\xi, B) = P\{\eta \in B \mid \xi\}$ a.s., $B \in \mathcal{T}$, for a probability kernel $\mu : S \to T$.
