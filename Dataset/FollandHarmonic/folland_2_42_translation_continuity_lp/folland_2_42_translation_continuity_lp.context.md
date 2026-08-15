# Context: folland_2_42_translation_continuity_lp

**Statement:** [folland_2_42_translation_continuity_lp.md](folland_2_42_translation_continuity_lp.md) · **Criteria:** [folland_2_42_translation_continuity_lp.criteria.md](folland_2_42_translation_continuity_lp.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Continuity of translation in $L^p$

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

**What is asserted.** As $y \to 1$ in $G$, both $\|L_yf - f\|_p \to 0$ and $\|R_yf - f\|_p \to 0$. That
is: translation acts continuously on $L^p$ at the identity — and hence, by the group property,
everywhere.

**$p < \infty$ is essential.** At $p = \infty$ the statement is false: the indicator of a half-line in
$\mathbb{R}$ has $\|L_yf - f\|_\infty = 1$ for every $y \ne 0$. The functions for which it does hold at
$p=\infty$ are exactly the uniformly continuous ones, which is the content of Proposition 2.44's
$p=\infty$ clause.

**Both translations.** The right-translation statement is not a consequence of the left one on a
non-unimodular group — $R_y$ is not an isometry of $L^p$ there — so it is a separate assertion.

**"as $y \to 1$"** is a limit along the whole neighbourhood filter of the identity, not along a
sequence: $G$ need not be first countable.
