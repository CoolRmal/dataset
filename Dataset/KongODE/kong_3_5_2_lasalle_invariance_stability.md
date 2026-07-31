# Q. Kong, *A Short Course in Ordinary Differential Equations*, Theorem 3.5.2

- **Source:** Q. Kong, *A Short Course in Ordinary Differential Equations*
- **Domain:** ODE
- **Lean declaration:** `Dataset.KongODE.kong_3_5_2_lasalle_invariance_stability` ([kong_3_5_2_lasalle_invariance_stability.lean](kong_3_5_2_lasalle_invariance_stability.lean))
- **Criteria:** [kong_3_5_2_lasalle_invariance_stability.criteria.md](kong_3_5_2_lasalle_invariance_stability.criteria.md)

## Statement

**Theorem 3.5.2.** Let $D = \{x \in \mathbb{R}^n : |x| \le l\}$ for some $l > 0$ and $V \in C^1(D, \mathbb{R})$. Assume that $V(x)$ is positive definite and $\dot V(x)$ is negative semi-definite. Moreover, if the set

$$D_0 := \{x \in D : \dot V(x) = 0\}$$

does not contain any nontrivial orbit of Eq. (A), then the zero solution of Eq. (A) is uniformly stable and asymptotically stable.

**Eq. (A).** The autonomous system $x' = f(x)$ with $f(0) = 0$, so that $x \equiv 0$ is a solution.

**Orbital derivative.** $\dot V(x) = \nabla V(x) \cdot f(x)$, the derivative of $V$ along the solutions of (A). $V$ is *positive definite* on $D$ if $V(0) = 0$ and $V(x) > 0$ for $x \in D$ with $x \ne 0$; $\dot V$ is *negative semi-definite* on $D$ if $\dot V(x) \le 0$ for all $x \in D$. A *nontrivial orbit* is the orbit of a solution of (A) other than $x \equiv 0$.
