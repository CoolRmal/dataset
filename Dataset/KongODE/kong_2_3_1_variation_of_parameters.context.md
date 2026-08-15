# Context: kong_2_3_1_variation_of_parameters

**Statement:** [kong_2_3_1_variation_of_parameters.md](kong_2_3_1_variation_of_parameters.md) · **Criteria:** [kong_2_3_1_variation_of_parameters.criteria.md](kong_2_3_1_variation_of_parameters.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Fundamental matrix solutions and the variation-of-parameters formula

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

**Fundamental matrix solution.** A matrix-valued $X$ on $(a,b)$ with $X'(t) = A(t)X(t)$ **and** $X(t)$
nonsingular for every $t$. Invertibility is part of the definition, and it is what makes $X^{-1}(s)$
meaningful in the formula.

**"The general solution of (NH) is …"** is an *equivalence*, not a formula produced out of thin air: a
function $y$ solves the inhomogeneous system exactly when it has the displayed shape for **some** constant
vector $c$. The $c$ is quantified after $y$ — each solution has its own.

**The integral is oriented.** $\int_{t_0}^{t}$ with $t$ allowed on either side of $t_0$; the interval
integral changes sign when the endpoints are swapped, which the set-integral over $[t_0,t]$ does not.

**The order of the factors.** $X(t)X^{-1}(s)f(s)$ — matrices do not commute, and $X(t)$ sits outside the
integral in $s$ while $X^{-1}(s)$ sits inside.

**The second display** is the special case solving the IVP with $x(t_0)=x_0$, obtained by taking
$c = X^{-1}(t_0)x_0$; it asserts existence *and* uniqueness of the solution with that initial value.
