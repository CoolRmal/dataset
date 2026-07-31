# Q. Kong, *A Short Course in Ordinary Differential Equations*, Theorem 1.5.3

- **Source:** Q. Kong, *A Short Course in Ordinary Differential Equations*
- **Domain:** ODE
- **Lean declaration:** `Dataset.KongODE.kong_1_5_3_differentiable_dependence` ([kong_1_5_3_differentiable_dependence.lean](kong_1_5_3_differentiable_dependence.lean))
- **Criteria:** [kong_1_5_3_differentiable_dependence.criteria.md](kong_1_5_3_differentiable_dependence.criteria.md)

## Statement

**Theorem 1.5.3.** Assume that $f \in C(D, \mathbb{R}^n)$, $\partial f/\partial x \in C(D, \mathbb{R}^{n \times n})$, and $\partial f / \partial \mu \in C(D, \mathbb{R}^{n \times k})$. Then IVP $(V[t_0, x_0, \mu])$ has a unique solution $x(t; t_0, x_0, \mu)$ which is $C^1$ in $t_0$, $x_0$, and $\mu$ in its domain. Furthermore, let

$$J(t; t_0, x_0, \mu) := \frac{\partial f}{\partial x}\big(t, x(t; t_0, x_0, \mu); \mu\big).$$

Then

**(a)** $\dfrac{\partial x}{\partial \mu}(t; t_0, x_0, \mu)$ is the solution of the IVP

$$z' = J(t; t_0, x_0, \mu) z + \frac{\partial f}{\partial \mu}\big(t, x(t; t_0, x_0, \mu); \mu\big), \qquad z(t_0) = 0;$$

**(b)** $\dfrac{\partial x}{\partial x_0}(t; t_0, x_0, \mu)$ is the solution of

$$z' = J(t; t_0, x_0, \mu) z, \qquad z(t_0) = I;$$

**(c)** $\dfrac{\partial x}{\partial t_0}(t; t_0, x_0, \mu)$ is the solution of

$$z' = J(t; t_0, x_0, \mu) z, \qquad z(t_0) = -f(t_0, x_0; \mu).$$

Here $I$ stands for the $n \times n$ identity matrix.

**IVP $(V[t_0, x_0, \mu])$.** The initial value problem with parameter $\mu \in \mathbb{R}^k$

$$x' = f(t, x; \mu), \qquad x(t_0) = x_0,$$

where $D \subseteq \mathbb{R} \times \mathbb{R}^n \times \mathbb{R}^k$ is the (open) domain of $f$ and $(t_0, x_0, \mu) \in D$.
