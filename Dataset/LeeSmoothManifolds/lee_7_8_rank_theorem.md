# J. M. Lee, *Introduction to Smooth Manifolds*, Theorem 7.8 (Rank Theorem)

- **Source:** J. M. Lee, *Introduction to Smooth Manifolds*
- **Domain:** Smooth manifolds
- **Lean declaration:** `Dataset.LeeSmoothManifolds.lee_7_8_rank_theorem` ([lee_7_8_rank_theorem.lean](lee_7_8_rank_theorem.lean))
- **Criteria:** [lee_7_8_rank_theorem.criteria.md](lee_7_8_rank_theorem.criteria.md)

## Statement

**Theorem 7.8 (Rank Theorem).** Suppose $U \subset \mathbb{R}^m$ and $V \subset \mathbb{R}^n$ are open sets and $F \colon U \to V$ is a smooth map with constant rank $k$. For any $p \in U$, there exist smooth coordinate charts centered at $p$ and $F(p)$, with $U_0 \subset U$ and $F(U_0) \subset V_0 \subset V$, such that

$$\psi \circ F \circ \varphi^{-1}(x^1, \ldots, x^k, x^{k+1}, \ldots, x^m) = (x^1, \ldots, x^k, 0, \ldots, 0).$$
