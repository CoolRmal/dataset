# J. B. Conway, *A Course in Functional Analysis*, Theorem VIII.3.6 (characterizations of positive elements of a $C^*$-algebra)

- **Source:** J. B. Conway, *A Course in Functional Analysis*
- **Domain:** Operator algebras
- **Lean declaration:** `Dataset.ConwayFunctionalAnalysis.conway_VIII_3_6_positive_element_characterizations` ([conway_VIII_3_6_positive_element_characterizations.lean](conway_VIII_3_6_positive_element_characterizations.lean))
- **Criteria:** [conway_VIII_3_6_positive_element_characterizations.criteria.md](conway_VIII_3_6_positive_element_characterizations.criteria.md)

## Statement

**VIII.3.6. Theorem.** If $\mathcal{A}$ is a $C^*$-algebra and $a \in \mathcal{A}$, then the following statements are equivalent.

- **(a)** $a \ge 0$.
- **(b)** $a = b^2$ for some $b$ in $\operatorname{Re} \mathcal{A}$.
- **(c)** $a = x^* x$ for some $x$ in $\mathcal{A}$.
- **(d)** $a = a^*$ and $\|t - a\| \le t$ for all $t \ge \|a\|$.
- **(e)** $a = a^*$ and $\|t - a\| \le t$ for some $t \ge \|a\|$.
