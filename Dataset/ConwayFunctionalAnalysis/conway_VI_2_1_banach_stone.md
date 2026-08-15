# J. B. Conway, *A Course in Functional Analysis*, Theorem VI.2.1 (the Banach–Stone theorem)

- **Source:** J. B. Conway, *A Course in Functional Analysis*
- **Domain:** Functional analysis
- **Lean declaration:** `Dataset.ConwayFunctionalAnalysis.conway_VI_2_1_banach_stone` ([conway_VI_2_1_banach_stone.lean](conway_VI_2_1_banach_stone.lean))
- **Criteria:** [conway_VI_2_1_banach_stone.criteria.md](conway_VI_2_1_banach_stone.criteria.md)
- **Context:** [conway_VI_2_1_banach_stone.context.md](conway_VI_2_1_banach_stone.context.md)

## Statement

**VI.2.1. The Banach–Stone Theorem.** If $X$ and $Y$ are compact and $T : C(X) \to C(Y)$ is a surjective isometry, then there is a homeomorphism $\tau : Y \to X$ and a function $\alpha$ in $C(Y)$ such that $|\alpha(y)| = 1$ for all $y$ and

$$(Tf)(y) = \alpha(y) f(\tau(y))$$

for all $f$ in $C(X)$ and $y$ in $Y$.
