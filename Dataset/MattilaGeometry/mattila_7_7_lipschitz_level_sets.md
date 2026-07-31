# P. Mattila, *Geometry of Sets and Measures in Euclidean Spaces*, Theorem 7.7 (level sets of Lipschitz maps)

- **Source:** P. Mattila, *Geometry of Sets and Measures in Euclidean Spaces*
- **Domain:** Geometric measure theory
- **Lean declaration:** `Dataset.MattilaGeometry.mattila_7_7_lipschitz_level_sets` ([mattila_7_7_lipschitz_level_sets.lean](mattila_7_7_lipschitz_level_sets.lean))
- **Criteria:** [mattila_7_7_lipschitz_level_sets.criteria.md](mattila_7_7_lipschitz_level_sets.criteria.md)

## Statement

**7.7. Theorem.** Let $A \subset \mathbb{R}^n$ and let $f : A \to \mathbb{R}^m$ be a Lipschitz map. If $m < s < n$, then

$$\int^{*} \mathcal{H}^{s-m}\big(A \cap f^{-1}\{y\}\big) \, d\mathcal{L}^m y \;\le\; c(n,m)\,\mathrm{Lip}(f)^m\,\mathcal{H}^s(A).$$
