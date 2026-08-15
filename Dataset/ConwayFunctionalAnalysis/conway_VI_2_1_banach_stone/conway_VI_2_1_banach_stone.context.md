# Context: conway_VI_2_1_banach_stone

**Statement:** [conway_VI_2_1_banach_stone.md](conway_VI_2_1_banach_stone.md) · **Criteria:** [conway_VI_2_1_banach_stone.criteria.md](conway_VI_2_1_banach_stone.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## $C(X)$ for compact $X$, and the direction of $\tau$

**$C(X)$** is the algebra of continuous *complex-valued* functions on the compact Hausdorff space $X$,
with the supremum norm. For compact $X$ every continuous function is bounded, so $C(X)$ coincides with
the bounded continuous functions. Conway's "compact" includes Hausdorff.

**"Surjective isometry"** means a linear map that preserves the norm and is onto — an isometric
isomorphism of Banach spaces. Nothing multiplicative is assumed: the theorem's content is that a purely
metric isomorphism of the Banach spaces is forced to come from a homeomorphism of the underlying
spaces.

**The direction of $\tau$.** $\tau$ goes from $Y$ to $X$, so that $f \circ \tau$ makes sense for
$f \in C(X)$ and yields a function on $Y$. Producing a homeomorphism $X \to Y$ instead would leave the
formula $(Tf)(y) = \alpha(y)f(\tau(y))$ ill-typed.

**$\alpha$.** A continuous function on $Y$ of constant modulus $1$ — a unimodular multiplier, not
necessarily constant. The formula must hold for every $f$ and every $y$.
