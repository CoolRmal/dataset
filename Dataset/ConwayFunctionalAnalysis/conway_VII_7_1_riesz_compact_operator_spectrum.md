# J. B. Conway, *A Course in Functional Analysis*, Theorem VII.7.1 (F. Riesz; the spectrum of a compact operator)

- **Source:** J. B. Conway, *A Course in Functional Analysis*
- **Domain:** Operator theory
- **Lean declaration:** `Dataset.ConwayFunctionalAnalysis.conway_VII_7_1_riesz_compact_operator_spectrum` ([conway_VII_7_1_riesz_compact_operator_spectrum.lean](conway_VII_7_1_riesz_compact_operator_spectrum.lean))
- **Criteria:** [conway_VII_7_1_riesz_compact_operator_spectrum.criteria.md](conway_VII_7_1_riesz_compact_operator_spectrum.criteria.md)

## Statement

**VII.7.1. Theorem. (F. Riesz)** If $\dim \mathcal{X} = \infty$ and $A \in \mathcal{B}_0(\mathcal{X})$, then one and only one of the following possibilities occurs.

- **(a)** $\sigma(A) = \{0\}$.
- **(b)** $\sigma(A) = \{0, \lambda_1, \ldots, \lambda_n\}$, where for $1 \le k \le n$, $\lambda_k \ne 0$, each $\lambda_k$ is an eigenvalue of $A$, and $\dim \ker(A - \lambda_k) < \infty$.
- **(c)** $\sigma(A) = \{0, \lambda_1, \lambda_2, \ldots\}$, where for each $k \ge 1$, $\lambda_k$ is an eigenvalue of $A$, $\dim \ker(A - \lambda_k) < \infty$, and, moreover, $\lim \lambda_k = 0$.
