# Q. Kong, *A Short Course in Ordinary Differential Equations*, Theorem 4.5.3

- **Source:** Q. Kong, *A Short Course in Ordinary Differential Equations*
- **Domain:** ODE
- **Lean declaration:** `Dataset.KongODE.kong_4_5_3_generalized_poincare_bendixson` ([kong_4_5_3_generalized_poincare_bendixson.lean](kong_4_5_3_generalized_poincare_bendixson.lean))
- **Criteria:** [kong_4_5_3_generalized_poincare_bendixson.criteria.md](kong_4_5_3_generalized_poincare_bendixson.criteria.md)

## Statement

**Theorem 4.5.3.** Let $x(t)$ be a solution of system (A-2) and $\Gamma$ its orbit. Assume $\Gamma^+$ is contained in a compact set $E \subset \mathbb{R}^2$ and system (A-2) has at most a finite number of equilibria in $E$. Then one of the following four statements is true:

**(a)** $\Omega(\Gamma^+)$ contains only one equilibrium of system (A-2);

**(b)** $\Gamma$ is a closed orbit;

**(c)** $\Omega(\Gamma^+)$ is a closed orbit;

**(d)** $\Omega(\Gamma^+)$ is a graphic for System (A-2).

The same conclusion holds when $\Gamma^+$ and $\Omega(\Gamma^+)$ are replaced by $\Gamma^-$ and $A(\Gamma^-)$, respectively.

**System (A-2).** The planar autonomous system $x' = f(x)$, $x \in \mathbb{R}^2$.

**Semi-orbits and limit sets.** $\Gamma^+ = \{x(t) : t \ge 0\}$ and $\Gamma^- = \{x(t) : t \le 0\}$ are the positive and negative semi-orbits of $x$;

$$\Omega(\Gamma^+) = \{y : x(t_j) \to y \text{ for some } t_j \to +\infty\}, \qquad A(\Gamma^-) = \{y : x(t_j) \to y \text{ for some } t_j \to -\infty\}$$

are the $\omega$-limit set and the $\alpha$-limit set. A *closed orbit* is the orbit of a nonconstant periodic solution. A *graphic* is a connected set consisting of finitely many equilibria together with orbits each of which tends to an equilibrium of the set as $t \to \pm\infty$.
