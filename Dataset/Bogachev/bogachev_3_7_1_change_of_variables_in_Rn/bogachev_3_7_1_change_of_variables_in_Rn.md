# Bogachev, *Measure Theory*, Theorem 3.7.1 (change of variables)

- **Source:** V. I. Bogachev, *Measure Theory*, Volume I
- **Domain:** Analysis
- **Lean declaration:** `Dataset.Bogachev.bogachev_3_7_1_change_of_variables_in_Rn` ([bogachev_3_7_1_change_of_variables_in_Rn.lean](bogachev_3_7_1_change_of_variables_in_Rn.lean))
- **Criteria:** [bogachev_3_7_1_change_of_variables_in_Rn.criteria.md](bogachev_3_7_1_change_of_variables_in_Rn.criteria.md)
- **Context:** [bogachev_3_7_1_change_of_variables_in_Rn.context.md](bogachev_3_7_1_change_of_variables_in_Rn.context.md)

## Statement

**3.7.1. Theorem.** If the mapping $F$ is injective on $U$, then, for any measurable set $A \subset U$ and any Borel function $g \in L^1(\mathbb{R}^n)$, one has the equality

$$\int_A g(F(x)) \, |J_F(x)| \, dx = \int_{F(A)} g(y) \, dy.$$

*(Context from the surrounding text: $U \subset \mathbb{R}^n$ is an open set and $F \colon U \to \mathbb{R}^n$ is a continuously differentiable mapping; $J_F(x) = \det F'(x)$ denotes its Jacobian.)*
