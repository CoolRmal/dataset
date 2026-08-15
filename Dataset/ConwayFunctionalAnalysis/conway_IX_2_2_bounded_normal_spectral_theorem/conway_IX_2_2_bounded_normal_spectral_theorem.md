# J. B. Conway, *A Course in Functional Analysis*, Theorem IX.2.2 (the Spectral Theorem)

- **Source:** J. B. Conway, *A Course in Functional Analysis*
- **Domain:** Operator theory
- **Lean declaration:** `Dataset.ConwayFunctionalAnalysis.conway_IX_2_2_bounded_normal_spectral_theorem` ([conway_IX_2_2_bounded_normal_spectral_theorem.lean](conway_IX_2_2_bounded_normal_spectral_theorem.lean))
- **Criteria:** [conway_IX_2_2_bounded_normal_spectral_theorem.criteria.md](conway_IX_2_2_bounded_normal_spectral_theorem.criteria.md)
- **Context:** [conway_IX_2_2_bounded_normal_spectral_theorem.context.md](conway_IX_2_2_bounded_normal_spectral_theorem.context.md)

## Statement

**IX.2.2. The Spectral Theorem.** If $N$ is a normal operator, there is a unique spectral measure $E$ on the Borel subsets of $\sigma(N)$ such that:

- **(a)** $N = \displaystyle\int z \, dE(z)$;
- **(b)** if $G$ is a nonempty relatively open subset of $\sigma(N)$, $E(G) \ne 0$;
- **(c)** if $A \in \mathcal{B}(\mathcal{H})$, then $AN = NA$ and $AN^* = N^*A$ if and only if $A E(\Delta) = E(\Delta) A$ for every $\Delta$.
