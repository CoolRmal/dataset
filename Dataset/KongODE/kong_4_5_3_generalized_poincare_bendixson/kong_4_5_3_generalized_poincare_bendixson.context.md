# Context: kong_4_5_3_generalized_poincare_bendixson

**Statement:** [kong_4_5_3_generalized_poincare_bendixson.md](kong_4_5_3_generalized_poincare_bendixson.md) · **Criteria:** [kong_4_5_3_generalized_poincare_bendixson.criteria.md](kong_4_5_3_generalized_poincare_bendixson.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Semi-orbits, limit sets and graphics

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

**Semi-orbits and limit sets.** For a solution $x$, $\Gamma^+=\{x(t):t\ge0\}$ and $\Gamma^-=\{x(t):t\le0\}$;
$\Omega(\Gamma^+)$ is the $\omega$-limit set — the points $y$ with $x(t_j)\to y$ for some $t_j\to+\infty$ —
and $A(\Gamma^-)$ the $\alpha$-limit set, with $t_j\to-\infty$. They are sets of *subsequential* limits, so
they can be large even when no limit exists.

**Closed orbit** means the orbit of a **nonconstant** periodic solution — an equilibrium is not a closed
orbit, and the period must be strictly positive.

**Graphic.** A connected set made of finitely many equilibria together with orbits each of which tends to
an equilibrium of the set as $t\to\pm\infty$ — a "polycycle" of separatrices. It is the possibility that
distinguishes the *generalized* Poincaré–Bendixson theorem from the classical one.

**The four cases.** (a) the $\omega$-limit set is a single equilibrium; (b) the given orbit $\Gamma$ is
itself closed; (c) the limit set is a closed orbit; (d) the limit set is a graphic. Note (b) is about
$\Gamma$ and (c) about $\Omega(\Gamma^+)$ — they are different statements.

**The last sentence is a second assertion**: the same conclusion with $\Gamma^-$ and $A(\Gamma^-)$ in place
of $\Gamma^+$ and $\Omega(\Gamma^+)$.

**The hypotheses**: the system is planar; $\Gamma^+$ lies in a compact $E$; and (A-2) has at most finitely
many equilibria **in $E$**.
