# P. Mattila, *Geometry of Sets and Measures in Euclidean Spaces*, Theorem 6.2 (upper density estimates)

- **Source:** P. Mattila, *Geometry of Sets and Measures in Euclidean Spaces*
- **Domain:** Geometric measure theory
- **Lean declaration:** `Dataset.MattilaGeometry.mattila_6_2_hausdorff_density_estimates` ([mattila_6_2_hausdorff_density_estimates.lean](mattila_6_2_hausdorff_density_estimates.lean))
- **Criteria:** [mattila_6_2_hausdorff_density_estimates.criteria.md](mattila_6_2_hausdorff_density_estimates.criteria.md)

## Statement

**6.1. Definition.** The upper $s$-dimensional density of $A$ at $x$ is

$$\Theta^{*s}(A, x) = \limsup_{r \downarrow 0} (2r)^{-s}\,\mathcal{H}^s(A \cap B(x,r)).$$

**6.2. Theorem.** Suppose $A \subset \mathbb{R}^n$ with $\mathcal{H}^s(A) < \infty$.

1. $2^{-s} \le \Theta^{*s}(A, x) \le 1$ for $\mathcal{H}^s$ almost all $x \in A$.
2. If $A$ is $\mathcal{H}^s$ measurable, $\Theta^{*s}(A, x) = 0$ for $\mathcal{H}^s$ almost all $x \in \mathbb{R}^n \setminus A$.
