# Context: folland_2_69_convolution_factorization

**Statement:** [folland_2_69_convolution_factorization.md](folland_2_69_convolution_factorization.md) · **Criteria:** [folland_2_69_convolution_factorization.criteria.md](folland_2_69_convolution_factorization.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## The factorization theorem $L^1 * L^p = L^p$

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

**What the equation means.** $L^1(G) * L^p(G)$ denotes the set of all convolutions $g * h$ with
$g \in L^1$, $h \in L^p$. The assertion $L^1 * L^p = L^p$ is therefore two inclusions: the easy one
$L^1 * L^p \subseteq L^p$ (Proposition 2.40(a)), and the hard one — **every** $f \in L^p$ *factors* as
$g * h$ with $g \in L^1$ and $h \in L^p$. The factorization is exact, not approximate: this is
Cohen's factorization theorem, and it is the surprising half.

**Exponent range.** $1 \le p < \infty$ for the $L^p$ clause. The $p = \infty$ case is covered by the
separate assertions $L^1 * L^\infty = L^1 * C_{lu} = C_{lu}$.

**$C_{lu}(G)$, $C_{ru}(G)$** are the bounded *left*- and *right*-uniformly continuous functions on $G$;
left uniform continuity of $f$ means $\|L_yf - f\|_\infty \to 0$ as $y \to 1$.

**The $L^1$ factor sits on the left** in every one of these products, except in the two written with the
$L^1$ factor on the right, where the order is as printed.
