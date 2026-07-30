# J. B. Conway, *A Course in Functional Analysis*, Theorem V.13.3 (James's theorem)

- **Source:** J. B. Conway, *A Course in Functional Analysis*
- **Domain:** Functional analysis
- **Lean declaration:** `Dataset.ConwayFunctionalAnalysis.conway_V_13_3_james` ([conway_V_13_3_james.lean](conway_V_13_3_james.lean))
- **Criteria:** [conway_V_13_3_james.criteria.md](conway_V_13_3_james.criteria.md)

## Statement

**V.13.3. James's Theorem.** If $\mathcal{X}$ is a Banach space and $A$ is a closed convex subset of $\mathcal{X}$ such that for each $x^*$ in $\mathcal{X}^*$ there is an $x_0$ in $A$ with

$$|\langle x_0, x^* \rangle| = \sup \{ |\langle x, x^* \rangle| : x \in A \},$$

then $A$ is weakly compact.
