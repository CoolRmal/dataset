# Q. Kong, *A Short Course in Ordinary Differential Equations*, Theorem 1.3.3

- **Source:** Q. Kong, *A Short Course in Ordinary Differential Equations*
- **Domain:** ODE
- **Lean declaration:** `Dataset.KongODE.kong_1_3_3_nth_order_scalar_ivp` ([kong_1_3_3_nth_order_scalar_ivp.lean](kong_1_3_3_nth_order_scalar_ivp.lean))
- **Criteria:** [kong_1_3_3_nth_order_scalar_ivp.criteria.md](kong_1_3_3_nth_order_scalar_ivp.criteria.md)

## Statement

**Theorem 1.3.3.** Let $D$ be an open subset of $\mathbb{R} \times \mathbb{R}^n$ and $(t_0, a_1, a_2, \dots, a_n) \in D$.

**(a)** Assume $g \in C(D, \mathbb{R}^n)$. Then there exists a $\gamma > 0$ such that IVP (1.3.10) has at least one solution which exists for $|t - t_0| \le \gamma$.

**(b)** Assume $g \in C(D, \mathbb{R}^n)$, and as a function of $(t, y_1, y_2, \dots, y_n)$, $g$ is locally Lipschitz in $(y_1, y_2, \dots, y_n)$ on $D$. Then there exists a $\gamma > 0$ such that IVP (1.3.10) has a unique solution which exists for $|t - t_0| \le \gamma$.

**IVP (1.3.10).** The initial value problem for the $n$-th order scalar equation

$$y^{(n)} = g\big(t, y, y', \dots, y^{(n-1)}\big), \qquad y^{(i-1)}(t_0) = a_i \quad (i = 1, \dots, n),$$

which is equivalent, via $(y_1, y_2, \dots, y_n) = \big(y, y', \dots, y^{(n-1)}\big)$, to the first-order companion system

$$y_1' = y_2, \quad y_2' = y_3, \quad \dots, \quad y_{n-1}' = y_n, \quad y_n' = g(t, y_1, \dots, y_n), \qquad y_i(t_0) = a_i .$$
