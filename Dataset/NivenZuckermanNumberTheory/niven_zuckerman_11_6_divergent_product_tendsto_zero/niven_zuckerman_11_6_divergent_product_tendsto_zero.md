# I. Niven and H. S. Zuckerman, *An Introduction to the Theory of Numbers*, Third Edition, Lemma 11.6

- **Source:** I. Niven and H. S. Zuckerman, *An Introduction to the Theory of Numbers*, Third Edition
- **Domain:** Number theory
- **Lean declaration:** `Dataset.NivenZuckermanNumberTheory.niven_zuckerman_11_6_divergent_product_tendsto_zero` ([niven_zuckerman_11_6_divergent_product_tendsto_zero.lean](niven_zuckerman_11_6_divergent_product_tendsto_zero.lean))
- **Criteria:** [niven_zuckerman_11_6_divergent_product_tendsto_zero.criteria.md](niven_zuckerman_11_6_divergent_product_tendsto_zero.criteria.md)
- **Context:** [niven_zuckerman_11_6_divergent_product_tendsto_zero.context.md](niven_zuckerman_11_6_divergent_product_tendsto_zero.context.md)

## Statement

**Lemma 11.6.** Let $\sum c_j$ be a divergent series with $0 < c_j < 1$ for $j = 1, 2, \dots$. Then, given any real number $\varepsilon > 0$, there is an integer $N$ such that $\prod_{j=1}^{n}(1-c_j) < \varepsilon$ for every integer $n \ge N$.

**Notation.** Divergence of $\sum c_j$ means that the partial sums tend to $+\infty$; since all factors $1-c_j$ lie in $(0,1)$ the partial products are decreasing, so the conclusion says exactly that they tend to $0$.
