# J. M. Lee, *Introduction to Smooth Manifolds*, Theorem 10.16 (Whitney Approximation Theorem)

- **Source:** J. M. Lee, *Introduction to Smooth Manifolds*
- **Domain:** Smooth manifolds
- **Lean declaration:** `Dataset.LeeSmoothManifolds.lee_10_16_whitney_approximation_theorem` ([lee_10_16_whitney_approximation_theorem.lean](lee_10_16_whitney_approximation_theorem.lean))
- **Criteria:** [lee_10_16_whitney_approximation_theorem.criteria.md](lee_10_16_whitney_approximation_theorem.criteria.md)
- **Context:** [lee_10_16_whitney_approximation_theorem.context.md](lee_10_16_whitney_approximation_theorem.context.md)

## Statement

**Theorem 10.16 (Whitney Approximation Theorem).** Let $M$ be a smooth manifold and let $F \colon M \to \mathbb{R}^k$ be a continuous function. Given any positive continuous function $\delta \colon M \to \mathbb{R}$, there exists a smooth function $F' \colon M \to \mathbb{R}^k$ that is $\delta$-close to $F$. If $F$ is smooth on a closed subset $A \subset M$, then $F'$ can be chosen to be equal to $F$ on $A$.
