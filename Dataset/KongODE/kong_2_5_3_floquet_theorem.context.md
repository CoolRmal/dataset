# Context: kong_2_5_3_floquet_theorem

**Statement:** [kong_2_5_3_floquet_theorem.md](kong_2_5_3_floquet_theorem.md) · **Criteria:** [kong_2_5_3_floquet_theorem.criteria.md](kong_2_5_3_floquet_theorem.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Floquet's theorem: what $P$ and $R$ are

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

**The setting.** $x' = A(t)x$ with $A$ continuous, real, and $\omega$-periodic for some $\omega>0$, and $X$
a fundamental matrix solution on **all** of $\mathbb{R}$ (solving the equation and nonsingular everywhere).

**The conclusion is a factorization $X(t) = P(t)e^{Rt}$** with:

- $R$ a **constant** matrix with **complex** entries — complex is essential, since a real logarithm of the
  transition matrix need not exist;
- $P$ a $C^1$, **complex** matrix-valued function that is $\omega$-periodic and **nonsingular at every
  $t$**.

Both the periodicity of $P$ and its invertibility are part of the statement; without invertibility the
factorization carries no information.

**Order of the factors.** $P(t)$ on the left, $e^{Rt}$ on the right. Matrices do not commute.

**$e^{Rt}$** is the matrix exponential of the scalar multiple $tR$.
