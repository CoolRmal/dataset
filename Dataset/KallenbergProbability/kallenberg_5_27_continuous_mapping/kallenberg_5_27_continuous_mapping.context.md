# Context: kallenberg_5_27_continuous_mapping

**Statement:** [kallenberg_5_27_continuous_mapping.md](kallenberg_5_27_continuous_mapping.md) · **Criteria:** [kallenberg_5_27_continuous_mapping.criteria.md](kallenberg_5_27_continuous_mapping.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Notation

The linking condition constrains the whole **sequence** $f_n$ jointly with $f$; taking $f_n=f$ gives only the classical special case. No continuity is assumed of $f$ or any $f_n$ — measurability only. $\mathcal{S}$ denotes the Borel $\sigma$-field of $S$, so "Borel set $C \in \mathcal{S}$" makes membership of $C$ in that $\sigma$-field a genuine hypothesis of the theorem; do not read it as "any subset $C \subset S$". Since $C$ is Borel and $\xi$ is Borel measurable, "$\xi \in C$ a.s." is an ordinary probability-one statement about the event that $\xi$ lands in $C$. Likewise "$f$ is a.s. continuous at $\xi$" means the law of $\xi$ gives full probability to the set of continuity points of $f$ inside $S$; it does not mean that $f$ is continuous.
