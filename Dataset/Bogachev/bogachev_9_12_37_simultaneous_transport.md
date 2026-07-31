# Bogachev, *Measure Theory*, Corollary 9.12.37 (simultaneous transport)

- **Source:** V. I. Bogachev, *Measure Theory*, Volume II
- **Domain:** Measure theory
- **Lean declaration:** `Dataset.Bogachev.bogachev_9_12_37_simultaneous_transport` ([bogachev_9_12_37_simultaneous_transport.lean](bogachev_9_12_37_simultaneous_transport.lean))
- **Criteria:** [bogachev_9_12_37_simultaneous_transport.criteria.md](bogachev_9_12_37_simultaneous_transport.criteria.md)

## Statement

**9.12.37. Corollary.** Let $\mu_1, \dots, \mu_n$ be atomless Borel probability measures on a Souslin space $X$. Then, for every Borel probability measure $\nu$ on $X$, there exists a Borel transformation $T \colon X \to X$ such that

$$\mu_i \circ T^{-1} = \nu \quad \text{for all } i \le n.$$

**7.14.15. Definition.** Let $(M, \mathcal{M}, \mu)$ be a space with a nonnegative measure. An element $A \in \mathcal{M}$ is called an *atom* of the measure $\mu$ if $\mu(A) > 0$ and every element $B$ in $\mathcal{M}$ that is contained in $A$ has measure either zero or $\mu(A)$. A measure without atoms is called *atomless*.
