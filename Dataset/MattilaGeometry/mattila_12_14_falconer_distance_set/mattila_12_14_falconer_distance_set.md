# P. Mattila, *Geometry of Sets and Measures in Euclidean Spaces*, Theorem 12.14 (Falconer's distance set theorem)

- **Source:** P. Mattila, *Geometry of Sets and Measures in Euclidean Spaces*
- **Domain:** Geometric measure theory
- **Lean declaration:** `Dataset.MattilaGeometry.mattila_12_14_falconer_distance_set` ([mattila_12_14_falconer_distance_set.lean](mattila_12_14_falconer_distance_set.lean))
- **Criteria:** [mattila_12_14_falconer_distance_set.criteria.md](mattila_12_14_falconer_distance_set.criteria.md)
- **Context:** [mattila_12_14_falconer_distance_set.context.md](mattila_12_14_falconer_distance_set.context.md)

## Statement

**12.14. Theorem.** Let $A$ be a Borel set in $\mathbb{R}^n$.

1. If $\dim A > \dfrac{n+1}{2}$, then $\mathcal{L}^1(D(A)) > 0$.
2. If $\dfrac{n-1}{2} \le \dim A \le \dfrac{n+1}{2}$, then $\dim D(A) \ge \dim A - \dfrac{n-1}{2}$,

where $D(A) = \{|x-y| : x, y \in A\}$.
