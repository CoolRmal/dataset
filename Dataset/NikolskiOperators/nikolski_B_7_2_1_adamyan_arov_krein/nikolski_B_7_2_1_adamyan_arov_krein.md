# N. K. Nikolski, *Operators, Functions, and Systems: An Easy Reading*, Theorem 7.2.1 (V. Adamyan, D. Arov, and M. Krein)

- **Source:** N. K. Nikolski, *Operators, Functions, and Systems: An Easy Reading*, Volume 1: Hardy, Hankel, and Toeplitz (Part B)
- **Domain:** Operator theory
- **Lean declaration:** `Dataset.NikolskiOperators.nikolski_B_7_2_1_adamyan_arov_krein` ([nikolski_B_7_2_1_adamyan_arov_krein.lean](nikolski_B_7_2_1_adamyan_arov_krein.lean))
- **Criteria:** [nikolski_B_7_2_1_adamyan_arov_krein.criteria.md](nikolski_B_7_2_1_adamyan_arov_krein.criteria.md)
- **Context:** [nikolski_B_7_2_1_adamyan_arov_krein.context.md](nikolski_B_7_2_1_adamyan_arov_krein.context.md)

## Statement

**7.2.1. Theorem (V. Adamyan, D. Arov, and M. Krein, 1971).** Let $H_\varphi$ be a Hankel operator and let $R_n$ be the set of rational functions tending to $0$ at infinity and having all poles in $\mathbb{D}$ such that their total multiplicity is less than or equal to $n$. Then

$$s_n(H_\varphi) = \min\{\|H_\varphi - H_\psi\| : \operatorname{rank} H_\psi \le n\} = \operatorname{dist}_{L^\infty}(\varphi, R_n + H^\infty) = \min\{\|H_{\bar{B}\varphi}\| : B \text{ is a Blaschke product of degree} \le n\},$$

where the degree $\deg \Theta$ of an inner function $\Theta$ is equal to $n$ if $\Theta$ is a finite Blaschke product with $n$ zeros (counting multiplicities) and $\infty$ otherwise.
