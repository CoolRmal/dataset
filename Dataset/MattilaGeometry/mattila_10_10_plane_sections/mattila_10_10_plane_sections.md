# P. Mattila, *Geometry of Sets and Measures in Euclidean Spaces*, Theorem 10.10 (plane sections)

- **Source:** P. Mattila, *Geometry of Sets and Measures in Euclidean Spaces*
- **Domain:** Geometric measure theory
- **Lean declaration:** `Dataset.MattilaGeometry.mattila_10_10_plane_sections` ([mattila_10_10_plane_sections.lean](mattila_10_10_plane_sections.lean))
- **Criteria:** [mattila_10_10_plane_sections.criteria.md](mattila_10_10_plane_sections.criteria.md)
- **Context:** [mattila_10_10_plane_sections.context.md](mattila_10_10_plane_sections.context.md)

## Statement

**Definition.** The Grassmannian $G(n,k)$ is the space of $k$-dimensional linear subspaces of $\mathbb{R}^n$, and $\gamma_{n,k}$ is its orthogonally invariant probability measure.

**10.10. Theorem.** Let $m < t < n$ and let $A \subset \mathbb{R}^n$ be a Borel set with $0 < \mathcal{H}^t(A) < \infty$. Then

1. for all $W \in G(n, n-m)$, $\mathcal{H}^{t-m}(A \cap W_a) < \infty$ for $\mathcal{H}^m$ almost all $a \in W^{\perp}$, and
2. for $\gamma_{n,n-m}$ almost all $W \in G(n, n-m)$,
$$\mathcal{H}^m\big(\{a \in W^{\perp} : \dim(A \cap W_a) = t - m\}\big) > 0.$$
