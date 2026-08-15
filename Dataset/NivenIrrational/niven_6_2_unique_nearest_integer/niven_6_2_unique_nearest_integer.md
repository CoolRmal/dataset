# I. Niven, *Numbers: Rational and Irrational*, Theorem 6.2 (approximation by integers)

- **Source:** I. Niven, *Numbers: Rational and Irrational*
- **Domain:** Number theory
- **Lean declaration:** `Dataset.NivenIrrational.niven_6_2_unique_nearest_integer` ([niven_6_2_unique_nearest_integer.lean](niven_6_2_unique_nearest_integer.lean))
- **Criteria:** [niven_6_2_unique_nearest_integer.criteria.md](niven_6_2_unique_nearest_integer.criteria.md)
- **Context:** [niven_6_2_unique_nearest_integer.context.md](niven_6_2_unique_nearest_integer.context.md)

## Statement

**Theorem 6.2.** Corresponding to any irrational number $\alpha$ there is a unique integer $m$ such that

$$-\frac{1}{2} < \alpha - m < \frac{1}{2}.$$

**Notation.** The irrationality of $\alpha$ is what rules out the tie $\alpha = n + \tfrac12$, which is exactly the case in which two integers would be equally close.
