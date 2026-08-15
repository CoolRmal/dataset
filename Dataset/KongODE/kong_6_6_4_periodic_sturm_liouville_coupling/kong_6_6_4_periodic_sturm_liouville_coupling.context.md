# Context: kong_6_6_4_periodic_sturm_liouville_coupling

**Statement:** [kong_6_6_4_periodic_sturm_liouville_coupling.md](kong_6_6_4_periodic_sturm_liouville_coupling.md) · **Criteria:** [kong_6_6_4_periodic_sturm_liouville_coupling.criteria.md](kong_6_6_4_periodic_sturm_liouville_coupling.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Periodic, Dirichlet and Neumann spectra and their interlacing

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

**The equation in quasi-derivative form.** $(p(x)y')' = (q(x)-\lambda w(x))y$ on $[a,b]$, with $p,q,w$
continuous, $p>0$ and $w>0$. Note it is $py'$, not $y'$, that is differentiated: $y$ has a derivative $y'$
and the *product* $py'$ is again differentiable. Writing the equation as $py'' + p'y' = \dots$ presupposes
$p$ differentiable, which is not assumed.

**Three boundary conditions, three spectra.** $\lambda_n$ are the eigenvalues of the **periodic** problem
$y(a)=y(b)$, $p(a)y'(a)=p(b)y'(b)$; $\mu_n$ those of the **Dirichlet** problem $y(a)=y(b)=0$; $\nu_n$ those
of the **Neumann** problem $y'(a)=y'(b)=0$. All three sequences are *produced* by the theorem.

**The notation $\{\mu_i,\nu_j\}$** in the interlacing chain means the stated inequality holds for each of
$\mu_i$ and $\nu_j$ separately; **no order is asserted between $\mu_i$ and $\nu_j$**. The chain alternates
strict and non-strict inequalities in a specific pattern, and that pattern is part of the theorem.

**Geometric simplicity.** An eigenvalue is geometrically simple when its eigenspace is one-dimensional and
geometrically double when it is two-dimensional. Part (a) says $\lambda_0$ is always simple, and that
$\lambda_n$ is double exactly when it is simultaneously a Dirichlet and a Neumann eigenvalue.

**Zero counting.** Part (b) counts zeros of eigenfunctions: those for $\lambda_0$ have **no** zeros in the
closed $[a,b]$; those for $\lambda_{2n+1}$ and $\lambda_{2n+2}$ have exactly $2n+2$ zeros in the
**half-open** $[a,b)$. The closed/half-open distinction is deliberate — with periodic boundary conditions
$y(a)$ and $y(b)$ are equal, so counting both would double-count.
