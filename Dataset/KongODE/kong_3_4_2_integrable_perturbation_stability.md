# Q. Kong, *A Short Course in Ordinary Differential Equations*, Theorem 3.4.2

- **Source:** Q. Kong, *A Short Course in Ordinary Differential Equations*
- **Domain:** ODE
- **Lean declaration:** `Dataset.KongODE.kong_3_4_2_integrable_perturbation_stability` ([kong_3_4_2_integrable_perturbation_stability.lean](kong_3_4_2_integrable_perturbation_stability.lean))
- **Criteria:** [kong_3_4_2_integrable_perturbation_stability.criteria.md](kong_3_4_2_integrable_perturbation_stability.criteria.md)

## Statement

**Theorem 3.4.2.** Assume that there exists a function $p \in C\big([0, \infty), [0, \infty)\big)$ such that

$$\int_0^{\infty} p(t)\, dt < \infty, \qquad \text{and} \qquad |r(t, x)| \le p(t)\,|x| \ \text{ for sufficiently small } |x| \text{ and all } t \in [0, \infty).$$

**(a)** If Eq. (H) is uniformly stable, then the zero solution of Eq. (3.4.6) is uniformly stable.

**(b)** If Eq. (H) is uniformly stable and asymptotically stable, then the zero solution of Eq. (3.4.6) is uniformly stable and asymptotically stable.

**Eq. (H).** The homogeneous linear system $x' = A(t) x$.

**Eq. (3.4.6).** The perturbed system $x' = A(t) x + r(t, x)$.

**Stability.** The zero solution is *uniformly stable* if for every $\varepsilon > 0$ there is a $\delta > 0$, independent of $t_0$, such that every solution $x$ with $|x(t_0)| < \delta$ satisfies $|x(t)| < \varepsilon$ for all $t \ge t_0$; it is *asymptotically stable* if in addition there is a $\delta > 0$, independent of $t_0$, such that $|x(t_0)| < \delta$ implies $x(t) \to 0$ as $t \to \infty$.
