# P. Mattila, *Geometry of Sets and Measures in Euclidean Spaces*, Theorem 8.8 (Frostman's lemma)

- **Source:** P. Mattila, *Geometry of Sets and Measures in Euclidean Spaces*
- **Domain:** Geometric measure theory
- **Lean declaration:** `Dataset.MattilaGeometry.mattila_8_8_frostman_lemma` ([mattila_8_8_frostman_lemma.lean](mattila_8_8_frostman_lemma.lean))
- **Criteria:** [mattila_8_8_frostman_lemma.criteria.md](mattila_8_8_frostman_lemma.criteria.md)
- **Context:** [mattila_8_8_frostman_lemma.context.md](mattila_8_8_frostman_lemma.context.md)

## Statement

**Definition.** The $s$-dimensional Hausdorff content of $A$ is

$$\mathcal{H}^s_\infty(A) = \inf \sum_i d(E_i)^s,$$

where the infimum is over all countable covers $A \subset \bigcup_i E_i$.

**8.8. Theorem.** Let $B$ be a Borel set in $\mathbb{R}^n$. Then $\mathcal{H}^s(B) > 0$ if and only if there exists $\mu \in \mathcal{M}(B)$ such that

$$\mu(B(x,r)) < r^s \quad \text{for } x \in \mathbb{R}^n \text{ and } r > 0.$$

Moreover, we can find $\mu$ so that $\mu(B) > c\,\mathcal{H}^s_\infty(B)$, where $c > 0$ depends only on $n$.
