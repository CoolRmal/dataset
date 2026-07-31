# Q. Kong, *A Short Course in Ordinary Differential Equations*, Theorem 2.5.3 (Floquet Theorem)

- **Source:** Q. Kong, *A Short Course in Ordinary Differential Equations*
- **Domain:** ODE
- **Lean declaration:** `Dataset.KongODE.kong_2_5_3_floquet_theorem` ([kong_2_5_3_floquet_theorem.lean](kong_2_5_3_floquet_theorem.lean))
- **Criteria:** [kong_2_5_3_floquet_theorem.criteria.md](kong_2_5_3_floquet_theorem.criteria.md)

## Statement

**Theorem 2.5.3 (Floquet Theorem).** Let $X(t)$ be a fundamental matrix solution of Eq. (H-p). Then there exists an $R \in \mathbb{C}^{n \times n}$ and a nonsingular $\omega$-periodic $P \in C^1(\mathbb{R}, \mathbb{C}^{n \times n})$ such that

$$X(t) = P(t)\, e^{Rt}.$$

**Eq. (H-p).** The homogeneous linear system with $\omega$-periodic coefficients

$$x' = A(t) x, \qquad A \in C\big(\mathbb{R}, \mathbb{R}^{n \times n}\big), \quad A(t + \omega) = A(t) \ \text{ for all } t \in \mathbb{R},$$

where $\omega > 0$. A *fundamental matrix solution* is a matrix-valued $X$ with $X'(t) = A(t) X(t)$ and $X(t)$ nonsingular for all $t \in \mathbb{R}$.
