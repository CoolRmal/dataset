# V. I. Bogachev, *Gaussian Measures*, Theorem 4.3.1 (the Gaussian isoperimetric inequality)

- **Source:** V. I. Bogachev, *Gaussian Measures*
- **Domain:** Measure theory
- **Lean declaration:** `Dataset.BogachevGaussian.bogachev_gaussian_4_3_1_isoperimetric_inequality` ([bogachev_gaussian_4_3_1_isoperimetric_inequality.lean](bogachev_gaussian_4_3_1_isoperimetric_inequality.lean))
- **Criteria:** [bogachev_gaussian_4_3_1_isoperimetric_inequality.criteria.md](bogachev_gaussian_4_3_1_isoperimetric_inequality.criteria.md)
- **Context:** [bogachev_gaussian_4_3_1_isoperimetric_inequality.context.md](bogachev_gaussian_4_3_1_isoperimetric_inequality.context.md)

## Statement

**Theorem 4.3.1.** Let $\gamma_n$ be the standard Gaussian measure on $\mathbb{R}^n$ and let $U$ be the closed unit ball in $\mathbb{R}^n$ centered at the origin. For every measurable set $A \subset \mathbb{R}^n$, the following inequality holds true:

$$\Phi^{-1}\big(\gamma_n(A+rU)\big) \ge \Phi^{-1}\big(\gamma_n(A)\big) + r, \qquad \forall r > 0. \tag{4.3.1}$$

**Notation.** $\gamma_n$ is the standard Gaussian measure on $\mathbb{R}^n$, $\Phi$ is the standard normal distribution function $\Phi(x) = \gamma_1((-\infty,x])$, and $\Phi^{-1}$ is its inverse with the convention $\Phi^{-1}(0) = -\infty$ and $\Phi^{-1}(1) = +\infty$. $A + rU = \{a + ru : a \in A,\ u \in U\}$ is the Minkowski sum of $A$ with the closed ball of radius $r$; it is the closed $r$-neighbourhood of $A$ in the Euclidean metric whenever $A$ is closed, and in general it is contained in $\{z : \operatorname{dist}(z,A) \le r\}$.
