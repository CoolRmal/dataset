# V. I. Bogachev, *Gaussian Measures*, Theorem 4.2.1 (Ehrhard's inequality)

- **Source:** V. I. Bogachev, *Gaussian Measures*
- **Domain:** Measure theory
- **Lean declaration:** `Dataset.BogachevGaussian.bogachev_gaussian_4_2_1_ehrhard_inequality` ([bogachev_gaussian_4_2_1_ehrhard_inequality.lean](bogachev_gaussian_4_2_1_ehrhard_inequality.lean))
- **Criteria:** [bogachev_gaussian_4_2_1_ehrhard_inequality.criteria.md](bogachev_gaussian_4_2_1_ehrhard_inequality.criteria.md)
- **Context:** [bogachev_gaussian_4_2_1_ehrhard_inequality.context.md](bogachev_gaussian_4_2_1_ehrhard_inequality.context.md)

## Statement

**Theorem 4.2.1.** Let $A$ and $B$ be two convex sets in $\mathbb{R}^n$. Then one has for all $\lambda \in [0,1]$:

$$\Phi^{-1}\big\{\gamma_n\big(\lambda A + (1-\lambda)B\big)\big\} \ge \lambda\Phi^{-1}\{\gamma_n(A)\} + (1-\lambda)\Phi^{-1}\{\gamma_n(B)\}. \tag{4.2.1}$$

**Notation.** $\gamma_n$ is the standard Gaussian measure on $\mathbb{R}^n$, $\Phi$ is the standard normal distribution function $\Phi(x) = \gamma_1((-\infty,x])$, and $\Phi^{-1}$ is its inverse with the convention $\Phi^{-1}(0) = -\infty$ and $\Phi^{-1}(1) = +\infty$. $\lambda A + (1-\lambda)B = \{\lambda x + (1-\lambda)y : x \in A,\ y \in B\}$ is the Minkowski combination of the two sets.
