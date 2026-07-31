# Bogachev, *Measure Theory*, Theorem 9.1.9 (Radon preimages)

- **Source:** V. I. Bogachev, *Measure Theory*, Volume II
- **Domain:** Measure theory
- **Lean declaration:** `Dataset.Bogachev.bogachev_9_1_9_radon_preimage_from_compact_approximation` ([bogachev_9_1_9_radon_preimage_from_compact_approximation.lean](bogachev_9_1_9_radon_preimage_from_compact_approximation.lean))
- **Criteria:** [bogachev_9_1_9_radon_preimage_from_compact_approximation.criteria.md](bogachev_9_1_9_radon_preimage_from_compact_approximation.criteria.md)

## Statement

**9.1.9. Theorem.** Let $f$ be a mapping from a topological space $X$ to a topological space $Y$ with a Radon measure $\nu$. Suppose that there exists an increasing sequence of compact sets $K_n \subset X$ such that $f$ is continuous on every $K_n$ and

$$\lim_{n \to \infty} |\nu|\bigl(f(K_n)\bigr) = \|\nu\|.$$

Then, there exists a Radon measure $\mu$ on $X$ with $\mu \circ f^{-1} = \nu$. In addition, this measure can be chosen with the property $\|\nu\| = \|\mu\|$. In particular, this is true if $X$ and $Y$ are compact and $f$ is a continuous surjection.
