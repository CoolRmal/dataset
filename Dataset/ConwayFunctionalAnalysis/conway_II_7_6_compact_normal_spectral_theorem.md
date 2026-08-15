# J. B. Conway, *A Course in Functional Analysis*, Theorem II.7.6 (spectral theorem for compact normal operators)

- **Source:** J. B. Conway, *A Course in Functional Analysis*
- **Domain:** Operator theory
- **Lean declaration:** `Dataset.ConwayFunctionalAnalysis.conway_II_7_6_compact_normal_spectral_theorem` ([conway_II_7_6_compact_normal_spectral_theorem.lean](conway_II_7_6_compact_normal_spectral_theorem.lean))
- **Criteria:** [conway_II_7_6_compact_normal_spectral_theorem.criteria.md](conway_II_7_6_compact_normal_spectral_theorem.criteria.md)
- **Context:** [conway_II_7_6_compact_normal_spectral_theorem.context.md](conway_II_7_6_compact_normal_spectral_theorem.context.md)

## Statement

**II.7.6. Spectral Theorem for Compact Normal Operators.** If $T$ is a compact normal operator on the complex Hilbert space $\mathcal{H}$, then $T$ has only a countable number of distinct eigenvalues. If $\{\lambda_1, \lambda_2, \ldots\}$ are the distinct nonzero eigenvalues of $T$, and $P_n$ is the projection of $\mathcal{H}$ onto $\ker(T - \lambda_n)$, then $P_n P_m = P_m P_n = 0$ if $n \ne m$ and

$$T = \sum_{n=1}^{\infty} \lambda_n P_n,$$

where this series converges to $T$ in the metric defined by the norm on $\mathcal{B}(\mathcal{H})$.
