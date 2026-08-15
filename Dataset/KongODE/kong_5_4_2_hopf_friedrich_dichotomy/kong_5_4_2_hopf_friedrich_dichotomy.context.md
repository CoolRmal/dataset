# Context: kong_5_4_2_hopf_friedrich_dichotomy

**Statement:** [kong_5_4_2_hopf_friedrich_dichotomy.md](kong_5_4_2_hopf_friedrich_dichotomy.md) · **Criteria:** [kong_5_4_2_hopf_friedrich_dichotomy.criteria.md](kong_5_4_2_hopf_friedrich_dichotomy.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## The degenerate Hopf bifurcation

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

**The family.** $x' = F(x,\mu)$ on the plane, with $F$ analytic in $(x,\mu)$ near the origin and
$F(0,\mu)=0$ for every $\mu$ — so the origin is an equilibrium for every parameter value.

**The eigenvalue data.** The linearization $\partial F/\partial x(0,\mu)$ has eigenvalues
$\alpha(\mu)\pm i\beta(\mu)$ with $\alpha(0)=0$ and $\beta(0)=\beta>0$. Equivalently, at $\mu=0$ the
Jacobian has trace $0$ and determinant $\beta^2$; and the **degeneracy condition** $\alpha'(0)=0$ says the
trace has vanishing derivative in $\mu$ at $0$ — this is exactly the case *excluded* by the standard Hopf
theorem, which is why the conclusion is a dichotomy rather than a bifurcation.

**The dichotomy.** Either (a) the $\mu=0$ system is a **centre** — all nearby orbits are closed — and no
nearby $\mu\ne0$ system has a closed orbit; or (b) on **exactly one side** of $\mu=0$ (either $\mu>0$ only,
or $\mu<0$ only) there is a unique limit cycle $\Gamma(\mu)$ shrinking to the origin with period tending to
$2\pi/\beta$.

**"Unique limit cycle"** is uniqueness among nearby closed orbits, as a set of points — reparametrizations
of the same curve are the same cycle.

**$2\pi/\beta$** is the period of the linearized rotation.
