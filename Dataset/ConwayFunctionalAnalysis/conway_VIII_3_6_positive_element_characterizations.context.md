# Context: conway_VIII_3_6_positive_element_characterizations

**Statement:** [conway_VIII_3_6_positive_element_characterizations.md](conway_VIII_3_6_positive_element_characterizations.md) · **Criteria:** [conway_VIII_3_6_positive_element_characterizations.criteria.md](conway_VIII_3_6_positive_element_characterizations.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Positivity in a $C^*$-algebra, $\operatorname{Re}\mathcal{A}$, and the scalar $t$

**$a \ge 0$** in a $C^*$-algebra is Conway's spectral definition: $a = a^*$ and
$\sigma(a) \subseteq [0,\infty)$. That this coincides with the order coming from the cone of elements
$x^*x$ is precisely part of what the theorem proves.

**$\operatorname{Re}\mathcal{A}$** denotes the set of *self-adjoint* (hermitian) elements of
$\mathcal{A}$ — those with $b = b^*$. It is a real subspace, not a complex one, and "Re" here has
nothing to do with taking a real part of a scalar.

**The scalar $t$ in (d) and (e).** In $\|t - a\| \le t$ the symbol $t$ is a *real* number, and
$t - a$ means $t \cdot 1 - a$, the scalar multiple of the unit minus $a$. So the algebra must be
unital for (d) and (e) to parse. The condition $t \ge \|a\|$ constrains which $t$ are considered:
(d) demands the norm bound for **all** such $t$, (e) for **at least one**. That the "for some" version
already implies positivity is the surprising half of the theorem, so the two items must be kept apart.

**The self-adjointness clause appears in both (d) and (e).** It is not redundant: without it the norm
condition alone does not force $a$ to be hermitian.

**All five items are one equivalence.** The content is the cycle, not any single implication.
