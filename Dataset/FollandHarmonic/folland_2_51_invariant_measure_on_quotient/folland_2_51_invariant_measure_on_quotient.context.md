# Context: folland_2_51_invariant_measure_on_quotient

**Statement:** [folland_2_51_invariant_measure_on_quotient.md](folland_2_51_invariant_measure_on_quotient.md) · **Criteria:** [folland_2_51_invariant_measure_on_quotient.criteria.md](folland_2_51_invariant_measure_on_quotient.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Homogeneous spaces, $\Delta_G|_H = \Delta_H$, and Weil's formula

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

**$G/H$ and its topology.** $H$ is a **closed** subgroup, and $G/H$ is the space of left cosets $xH$
with the quotient topology, which is locally compact Hausdorff exactly because $H$ is closed. The action
of $G$ on $G/H$ is $g \cdot (xH) = (gx)H$, and a measure $\mu$ on $G/H$ is $G$-invariant when its
pushforward under each such translation is itself.

**$\Delta_G|_H = \Delta_H$.** Two *different* modular functions: $\Delta_G$ is that of the big group,
restricted to $H$; $\Delta_H$ is the modular function of $H$ computed intrinsically, from a Haar measure
on $H$. They are functions on $H$ and the condition compares them there. Since the equality is between
two modular functions, it is insensitive to which of the two sign conventions is used, provided the same
one is used on both sides.

**$Pf$ and Weil's formula.** $Pf(xH) = \int_H f(x\xi)\,d\xi$ averages $f$ over the coset; the integrand
$\xi \mapsto f(x\xi)$ depends on the representative $x$, but the resulting function of $xH$ does not
change if $x$ is replaced by $xh$, precisely because $\xi$ ranges over all of $H$ against a Haar measure
on $H$. Formula (2.52) then says the Haar integral on $G$ factors as an integral over $G/H$ of these
averages.

**What is asserted.** Existence of a nonzero $G$-invariant Radon measure on $G/H$ **iff**
$\Delta_G|_H = \Delta_H$; and, when it exists, uniqueness up to a positive scalar and — for a suitable
normalization — Weil's formula for all $f \in C_c(G)$.
