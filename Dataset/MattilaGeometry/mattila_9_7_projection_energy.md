# P. Mattila, *Geometry of Sets and Measures in Euclidean Spaces*, Theorem 9.7 (projections and Riesz energy)

- **Source:** P. Mattila, *Geometry of Sets and Measures in Euclidean Spaces*
- **Domain:** Geometric measure theory
- **Lean declaration:** `Dataset.MattilaGeometry.mattila_9_7_projection_energy` ([mattila_9_7_projection_energy.lean](mattila_9_7_projection_energy.lean))
- **Criteria:** [mattila_9_7_projection_energy.criteria.md](mattila_9_7_projection_energy.criteria.md)

## Statement

**Definition.** The Riesz $s$-energy of $\mu$ is

$$I_s(\mu) = \iint |x-y|^{-s} \, d\mu x \, d\mu y.$$

The Grassmannian $G(n,m)$ is the space of $m$-dimensional linear subspaces of $\mathbb{R}^n$, and $\gamma_{n,m}$ is its orthogonally invariant probability measure.

**9.7. Theorem.** Let $\mu$ be a Radon measure on $\mathbb{R}^n$ with compact support and with $I_m(\mu) < \infty$. Then $P_{V\#}\mu \ll \mathcal{H}^m$ for $\gamma_{n,m}$ almost all $V \in G(n,m)$ and

$$\int \int_V D(P_{V\#}\mu, u)^2 \, d\mathcal{H}^m u \, d\gamma_{n,m} V < c\, I_m(\mu),$$

where $c$ is a constant depending only on $n$ and $m$.
