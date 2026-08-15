# J. M. Lee, *Introduction to Smooth Manifolds*, Theorem 7.6 (Inverse Function Theorem)

- **Source:** J. M. Lee, *Introduction to Smooth Manifolds*
- **Domain:** Smooth manifolds
- **Lean declaration:** `Dataset.LeeSmoothManifolds.lee_7_6_inverse_function_theorem` ([lee_7_6_inverse_function_theorem.lean](lee_7_6_inverse_function_theorem.lean))
- **Criteria:** [lee_7_6_inverse_function_theorem.criteria.md](lee_7_6_inverse_function_theorem.criteria.md)
- **Context:** [lee_7_6_inverse_function_theorem.context.md](lee_7_6_inverse_function_theorem.context.md)

## Statement

**Theorem 7.6 (Inverse Function Theorem).** Suppose $U$ and $V$ are open subsets of $\mathbb{R}^n$, and $F \colon U \to V$ is a smooth map. If $DF(p)$ is nonsingular at some point $p \in U$, then there exist connected neighborhoods $U_0 \subset U$ of $p$ and $V_0 \subset V$ of $F(p)$ such that $F|_{U_0} \colon U_0 \to V_0$ is a diffeomorphism.
