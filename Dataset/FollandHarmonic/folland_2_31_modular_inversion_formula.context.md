# Context: folland_2_31_modular_inversion_formula

**Statement:** [folland_2_31_modular_inversion_formula.md](folland_2_31_modular_inversion_formula.md) · **Criteria:** [folland_2_31_modular_inversion_formula.criteria.md](folland_2_31_modular_inversion_formula.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## The inversion formula and the two conventions for $\Delta$

**Standing conventions of Chapter 2.** $G$ is a locally compact (Hausdorff) group with a fixed **left**
Haar measure $\lambda$, and $\int \dots dx$ always means integration against it. Translations are
$L_yf(x) = f(y^{-1}x)$ and $R_yf(x) = f(xy)$ — note the inverse on the left one and its absence on the
right one. Convolution is $f*g(x) = \int f(y)\,g(y^{-1}x)\,dy$; it is not commutative unless $G$ is
abelian, so which factor is on the left always matters.

**The modular function $\Delta$.** Folland defines $\Delta \colon G \to (0,\infty)$ by
$\lambda(Ex) = \Delta(x)\lambda(E)$: it measures how much a *right* translation distorts a left Haar
measure. It is a continuous homomorphism, independent of which left Haar measure is used, and $G$ is
*unimodular* when $\Delta \equiv 1$ — equivalently when some (hence every) left Haar measure is also
right invariant. Abelian, compact and discrete groups are unimodular; the $ax+b$ group is not.

> **Convention warning.** The modular function is defined with the opposite convention in different
> sources, and the two differ by inversion. Folland's $\Delta$ satisfies $\lambda(Ex) = \Delta(x)\lambda(E)$;
> the convention in which the pushforward of $\lambda$ along $y \mapsto yx$ is scaled gives
> $\lambda(Ex^{-1}) = \Delta'(x)\lambda(E)$, so that $\Delta'(x) = \Delta(x)^{-1} = \Delta(x^{-1})$. Any
> statement in which $\Delta$ appears at a single point — as opposed to in an equation like
> $\Delta \equiv 1$ or $\Delta_G|_H = \Delta_H$, which are convention-independent — has to be read with the
> right one.

**What the formula says.** Integration against a left Haar measure is invariant under
$x \mapsto x^{-1}$ *once the integrand is weighted by* $\Delta(x^{-1})$. Equivalently,
$\Delta(x^{-1})\,d\lambda(x)$ is a right Haar measure. On a unimodular group the weight is $1$ and the
formula reduces to invariance of $\lambda$ under inversion.

**The weight is $\Delta(x^{-1})$, evaluated at the *inverse*.** This is the point at which the
convention warning above bites hardest: under the opposite convention the same weight is written
$\Delta'(x)$, with no inverse. Whichever convention a formalization adopts, the weight it writes must be
the one satisfying $\lambda(Ex) = \Delta(x)^{-1}\!\cdot$ — that is, the reciprocal of the factor by
which right translation by $x$ scales $\lambda$.

**$f \in L^1(G)$** — the identity is asserted for every integrable $f$, not only for continuous
compactly supported ones. Both sides are then genuine finite integrals.
