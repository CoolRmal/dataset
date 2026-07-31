# J. M. Lee, *Introduction to Smooth Manifolds*, Theorem 7.13 (Rank Theorem for Manifolds)

- **Source:** J. M. Lee, *Introduction to Smooth Manifolds*
- **Domain:** Smooth manifolds
- **Lean declaration:** `Dataset.LeeSmoothManifolds.lee_7_13_rank_theorem_for_manifolds` ([lee_7_13_rank_theorem_for_manifolds.lean](lee_7_13_rank_theorem_for_manifolds.lean))
- **Criteria:** [lee_7_13_rank_theorem_for_manifolds.criteria.md](lee_7_13_rank_theorem_for_manifolds.criteria.md)

## Statement

**Theorem 7.13 (Rank Theorem for Manifolds).** Suppose $M$ and $N$ are smooth manifolds of dimensions $m$ and $n$, respectively, and $F \colon M \to N$ is a smooth map with constant rank $k$. For each $p \in M$ there exist smooth coordinates $(x^1, \ldots, x^m)$ centered at $p$ and $(v^1, \ldots, v^n)$ centered at $F(p)$ in which $F$ has the coordinate representation

$$(x^1, \ldots, x^m) \mapsto (x^1, \ldots, x^k, 0, \ldots, 0).$$
