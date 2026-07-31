# Q. Kong, *A Short Course in Ordinary Differential Equations*, Theorem 2.3.1 (Variation of Parameters Formula)

- **Source:** Q. Kong, *A Short Course in Ordinary Differential Equations*
- **Domain:** ODE
- **Lean declaration:** `Dataset.KongODE.kong_2_3_1_variation_of_parameters` ([kong_2_3_1_variation_of_parameters.lean](kong_2_3_1_variation_of_parameters.lean))
- **Criteria:** [kong_2_3_1_variation_of_parameters.criteria.md](kong_2_3_1_variation_of_parameters.criteria.md)

## Statement

**Theorem 2.3.1 (Variation of Parameters Formula).** Let $X(t)$ be a fundamental matrix solution of Eq. (H) and $t_0 \in (a,b)$. Then the general solution of Eq. (NH) is

$$x = X(t) c + \int_{t_0}^{t} X(t) X^{-1}(s) f(s)\, ds .$$

In particular, the solution of the IVP consisting of Eq. (NH) and the IC $x(t_0) = x_0$ is

$$x = X(t) X^{-1}(t_0) x_0 + \int_{t_0}^{t} X(t) X^{-1}(s) f(s)\, ds .$$

**Eq. (H).** The homogeneous linear system $x' = A(t) x$ on the interval $(a,b)$, with $A \in C\big((a,b), \mathbb{R}^{n \times n}\big)$. A *fundamental matrix solution* is a matrix-valued $X$ with $X'(t) = A(t) X(t)$ and $X(t)$ nonsingular on $(a,b)$.

**Eq. (NH).** The corresponding nonhomogeneous system $x' = A(t) x + f(t)$ on $(a,b)$, with $f \in C\big((a,b), \mathbb{R}^n\big)$.
