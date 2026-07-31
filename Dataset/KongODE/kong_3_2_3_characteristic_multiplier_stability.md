# Q. Kong, *A Short Course in Ordinary Differential Equations*, Theorem 3.2.3

- **Source:** Q. Kong, *A Short Course in Ordinary Differential Equations*
- **Domain:** ODE
- **Lean declaration:** `Dataset.KongODE.kong_3_2_3_characteristic_multiplier_stability` ([kong_3_2_3_characteristic_multiplier_stability.lean](kong_3_2_3_characteristic_multiplier_stability.lean))
- **Criteria:** [kong_3_2_3_characteristic_multiplier_stability.criteria.md](kong_3_2_3_characteristic_multiplier_stability.criteria.md)

## Statement

**Theorem 3.2.3.** Let $\mu_i$, $i = 1, \dots, n$, be the characteristic multipliers of Eq. (H-p). Then

**(a)** Equation (H-p) is uniformly stable $\iff$ $|\mu_i| \le 1$, $i = 1, \dots, n$, and $|\mu_i| = 1$ occurs only when the $\mu_i$'s are in the diagonal Jordan block of the transition matrix $V$;

**(b)** Equation (H-p) is asymptotically stable $\iff$ $|\mu_i| < 1$, $i = 1, \dots, n$;

**(c)** Equation (H-p) is unstable $\iff$ there exists an $i \in \{1, \dots, n\}$ such that either $|\mu_i| > 1$, or $|\mu_i| = 1$ which occurs when $\mu_i$ is not in the diagonal Jordan block of the transition matrix $V$.

**Eq. (H-p).** The homogeneous linear system with $\omega$-periodic coefficients $x' = A(t) x$, where $A(t + \omega) = A(t)$ for all $t$ and $\omega > 0$.

**Transition matrix and characteristic multipliers.** If $X(t)$ is a fundamental matrix solution of (H-p), the *transition matrix* is the constant nonsingular matrix $V = X(\omega) X^{-1}(0)$ (equivalently, up to similarity, the matrix $V$ with $X(t + \omega) = X(t) V$); the *characteristic multipliers* $\mu_1, \dots, \mu_n$ are the eigenvalues of $V$, listed with algebraic multiplicity. The multiplier $\mu_i$ is *in the diagonal Jordan block* of $V$ when every Jordan block of $V$ belonging to $\mu_i$ is $1 \times 1$.
