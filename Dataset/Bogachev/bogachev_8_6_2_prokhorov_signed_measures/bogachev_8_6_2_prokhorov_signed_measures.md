# Bogachev, *Measure Theory*, Theorem 8.6.2 (Prokhorov compactness)

- **Source:** V. I. Bogachev, *Measure Theory*, Volume II
- **Domain:** Measure theory
- **Lean declaration:** `Dataset.Bogachev.bogachev_8_6_2_prokhorov_signed_measures` ([bogachev_8_6_2_prokhorov_signed_measures.lean](bogachev_8_6_2_prokhorov_signed_measures.lean))
- **Criteria:** [bogachev_8_6_2_prokhorov_signed_measures.criteria.md](bogachev_8_6_2_prokhorov_signed_measures.criteria.md)
- **Context:** [bogachev_8_6_2_prokhorov_signed_measures.context.md](bogachev_8_6_2_prokhorov_signed_measures.context.md)

## Statement

**8.6.2. Theorem.** Let $X$ be a complete separable metric space and let $M$ be a family of Borel measures on $X$. Then the following conditions are equivalent:

1. every sequence $\{\mu_n\} \subset M$ contains a weakly convergent subsequence;
2. the family $M$ is uniformly tight and uniformly bounded in the variation norm.

The above conditions are equivalent for any complete metric space $X$ if $M \subset \mathcal{M}_t(X)$ (the space of tight measures on $X$).
