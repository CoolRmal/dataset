# Context: kong_1_3_3_nth_order_scalar_ivp

**Statement:** [kong_1_3_3_nth_order_scalar_ivp.md](kong_1_3_3_nth_order_scalar_ivp.md) · **Criteria:** [kong_1_3_3_nth_order_scalar_ivp.criteria.md](kong_1_3_3_nth_order_scalar_ivp.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## The $n$-th order scalar IVP and its companion system

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

**The equation is scalar of order $n$.** $y^{(n)} = g(t,y,y',\dots,y^{(n-1)})$ with $g$ taking $n$ real
state arguments and returning a real number. The $n$ initial conditions $y^{(i-1)}(t_0) = a_i$ are imposed
together.

**The companion system.** Setting $(y_1,\dots,y_n) = (y,y',\dots,y^{(n-1)})$ turns the scalar equation into
the first-order system $y_1'=y_2,\dots,y_{n-1}'=y_n,\ y_n'=g(t,y_1,\dots,y_n)$ with $y_i(t_0)=a_i$. The two
formulations are equivalent, and either is a faithful rendering — but a formalization must express the
*scalar $n$-th order* problem, not an arbitrary first-order system with an $n$-dimensional field.

**Part (a) versus part (b).** Continuity alone gives existence of *at least one* solution on some
$|t-t_0|\le\gamma$ (Peano). Adding local Lipschitz dependence **on the state variables only** gives
existence *and* uniqueness (Picard–Lindelöf). Part (b) asserts both; asserting only uniqueness would be a
different statement.

**"Locally Lipschitz in $(y_1,\dots,y_n)$ on $D$"** means each point of $D$ has a neighbourhood on which
one Lipschitz constant works for the state variables, uniformly in $t$; no Lipschitz condition in $t$ is
assumed.

**The interval is the symmetric closed one** $|t-t_0|\le\gamma$, and $\gamma$ is produced by the theorem.
