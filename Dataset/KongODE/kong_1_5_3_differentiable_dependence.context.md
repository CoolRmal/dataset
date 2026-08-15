# Context: kong_1_5_3_differentiable_dependence

**Statement:** [kong_1_5_3_differentiable_dependence.md](kong_1_5_3_differentiable_dependence.md) · **Criteria:** [kong_1_5_3_differentiable_dependence.criteria.md](kong_1_5_3_differentiable_dependence.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Differentiable dependence on data and parameters

**$C(D, \mathbb{R}^m)$ means *jointly* continuous.** Kong writes $f \in C(D,\mathbb{R}^m)$ for a function
continuous on $D$ as a function of all its variables together. Continuity in each variable separately is
strictly weaker and is not what is meant.

**"Solution" means a genuinely differentiable function.** A solution of $x' = f(t,x)$ on an interval is a
differentiable $x$ with $x'(t) = f(t,x(t))$ at every point of the interval — at the endpoints, the
one-sided derivative within the interval. A formalization that asserts the identity only for the values of
some derivative operator, without asserting differentiability, says nothing where the derivative does not
exist.

**Solutions must stay in the domain.** Where $f$ is defined only on $D$, the requirement $(t,x(t)) \in D$
is part of being a solution — both for the solution produced and for every competitor in a uniqueness
claim.

**The IVP with a parameter.** $x' = f(t,x;\mu)$, $x(t_0)=x_0$, with $\mu \in \mathbb{R}^k$ and $f$ defined
on an **open** $D \subseteq \mathbb{R}\times\mathbb{R}^n\times\mathbb{R}^k$. The solution is written
$x(t;t_0,x_0,\mu)$ — a function of the time *and* of all the data.

**$\partial f/\partial x$ and $\partial f/\partial\mu$** are the Jacobian matrices in the state and in the
parameter, of sizes $n\times n$ and $n\times k$; both are assumed continuous on $D$, which is what makes
the flow $C^1$.

**$J(t;t_0,x_0,\mu)$ is the Jacobian evaluated along the solution**, i.e. at the moving point
$(t,x(t;t_0,x_0,\mu);\mu)$ — not at the initial point.

**The three variational equations.** All three are linear systems with the same coefficient $J$; they
differ only in their initial value at $t=t_0$: $0$ for $\partial x/\partial\mu$ (with the inhomogeneous
term $\partial f/\partial\mu$ added), the identity matrix $I$ for $\partial x/\partial x_0$, and
$-f(t_0,x_0;\mu)$ for $\partial x/\partial t_0$. The minus sign in the last one is not a typo.

**"$C^1$ in its domain"** is joint $C^1$ dependence on $(t,t_0,x_0,\mu)$ on the open set where the solution
is defined.
