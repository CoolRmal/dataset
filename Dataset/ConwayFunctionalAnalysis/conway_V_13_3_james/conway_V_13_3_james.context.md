# Context: conway_V_13_3_james

**Statement:** [conway_V_13_3_james.md](conway_V_13_3_james.md) · **Criteria:** [conway_V_13_3_james.criteria.md](conway_V_13_3_james.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## James's theorem: what the attainment hypothesis says

**$\langle x, x^*\rangle$** is the value $x^*(x)$ of the functional $x^*$ at the point $x$; the pairing
notation carries no inner product with it. The quantity being maximised is the *modulus*
$|\langle x, x^*\rangle|$, a nonnegative real.

**The hypothesis.** For every $x^* \in \mathcal{X}^*$ there exists $x_0 \in A$ at which the supremum of
$|\langle \cdot, x^*\rangle|$ over $A$ is *attained*. Phrasing it as attainment, rather than as an
equation involving the supremum, is what keeps the statement meaningful: it says nothing about the value
of the supremum and does not require it to be finite a priori — though attainment forces it to be.

**The conclusion.** $A$ is compact in the weak topology. Note it is $A$ itself, not its weak closure:
$A$ is assumed norm-closed and convex, hence weakly closed, so the two coincide here.

**No boundedness hypothesis.** Boundedness is a consequence: if $A$ were unbounded, some functional
would be unbounded on it and could not attain its supremum.

**One direction only.** The converse (a weakly compact set supports every functional) is elementary; the
theorem is the stated implication.
