# Bogachev, *Measure Theory*, Theorem 4.6.3 (Nikodym–Vitali–Hahn–Saks)

- **Source:** V. I. Bogachev, *Measure Theory*, Volume I
- **Domain:** Measure theory
- **Lean declaration:** `Dataset.Bogachev.bogachev_4_6_3_nikodym_vitali_hahn_saks` ([bogachev_4_6_3_nikodym_vitali_hahn_saks.lean](bogachev_4_6_3_nikodym_vitali_hahn_saks.lean))
- **Criteria:** [bogachev_4_6_3_nikodym_vitali_hahn_saks.criteria.md](bogachev_4_6_3_nikodym_vitali_hahn_saks.criteria.md)
- **Context:** [bogachev_4_6_3_nikodym_vitali_hahn_saks.context.md](bogachev_4_6_3_nikodym_vitali_hahn_saks.context.md)

## Statement

**4.6.3. Theorem.** Let a sequence of measures $\mu_n$ in the space $\mathcal{M}(X, \mathcal{A})$ (the real measures of bounded variation on the $\sigma$-algebra $\mathcal{A}$) be such that $\lim_{n \to \infty} \mu_n(A)$ exists and is finite for every set $A \in \mathcal{A}$. Then:

1. the formula $\mu(A) = \lim_{n \to \infty} \mu_n(A)$ defines a measure $\mu \in \mathcal{M}(X, \mathcal{A})$;
2. there exist a nonnegative measure $\nu \in \mathcal{M}(X, \mathcal{A})$ and a bounded nondecreasing nonnegative function $\alpha$ on $[0, +\infty)$ such that $\lim_{t \to 0} \alpha(t) = 0$ and
$$\sup_n |\mu_n(A)| \le \alpha(\nu(A)), \quad \forall A \in \mathcal{A}.$$
In particular, $\sup_n \|\mu_n\| < \infty$ and the sequence $\{\mu_n\}$ is uniformly countably additive;
3. if a nonnegative measure $\lambda \in \mathcal{M}(X, \mathcal{A})$ is such that $\mu_n \ll \lambda$ for all $n$, then
$$\lim_{t \to 0} \sup \{ \mu_n(A) : A \in \mathcal{A},\ \lambda(A) \le t,\ n \in \mathbb{N} \} = 0.$$

**4.6.2. Definition.** Let $M$ be a family of real measures on a $\sigma$-algebra $\mathcal{A}$. This family is called *uniformly countably additive* if, for every sequence of pairwise disjoint sets $A_i$, the series $\sum_{i=1}^{\infty} \mu(A_i)$ converges uniformly in $\mu \in M$, i.e., for every $\varepsilon > 0$, there exists $n_\varepsilon$ such that

$$\left| \sum_{i=n}^{\infty} \mu(A_i) \right| < \varepsilon \quad \text{for all } n \ge n_\varepsilon \text{ and all } \mu \in M.$$
