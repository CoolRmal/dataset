# Context: folland_2_40_convolution_lp_bound

**Statement:** [folland_2_40_convolution_lp_bound.md](folland_2_40_convolution_lp_bound.md) · **Criteria:** [folland_2_40_convolution_lp_bound.criteria.md](folland_2_40_convolution_lp_bound.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Convolution on a locally compact group: the three parts

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

**Convolution is one-sided.** $f * g(x) = \int f(y)g(y^{-1}x)\,dy$. On a non-abelian group $f*g$ and
$g*f$ are different functions, and the theorem treats them differently — this asymmetry is the whole
structure of the proposition.

**Part (a)** has three assertions: the defining integral converges absolutely for almost every $x$ (so
$f*g$ is defined a.e.); $f*g \in L^p$; and Young's inequality $\|f*g\|_p \le \|f\|_1\|g\|_p$. The first
is not a technicality — without it the second and third are statements about a function defined by a
possibly divergent integral.

**Part (b)** repeats (a) for $g*f$ **under the hypothesis that $G$ is unimodular**. On a non-unimodular
group the bound genuinely fails for $g*f$.

**Part (c)** is the substitute for (b) without unimodularity: if $f$ has compact support then
$g*f \in L^p$ still holds — but note that no norm bound is claimed here, only membership.

**The exponent range is $1 \le p \le \infty$**, endpoints included.
