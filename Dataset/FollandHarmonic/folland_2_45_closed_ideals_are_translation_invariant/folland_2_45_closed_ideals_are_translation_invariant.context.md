# Context: folland_2_45_closed_ideals_are_translation_invariant

**Statement:** [folland_2_45_closed_ideals_are_translation_invariant.md](folland_2_45_closed_ideals_are_translation_invariant.md) · **Criteria:** [folland_2_45_closed_ideals_are_translation_invariant.criteria.md](folland_2_45_closed_ideals_are_translation_invariant.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Ideals in $L^1(G)$ and translation invariance

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

**"Closed subspace of $L^1(G)$"** means a linear subspace that is closed in the $L^1$ norm topology.
Closedness is essential: the theorem is false for non-closed subspaces.

**Left and right ideals.** $I$ is a *left* ideal when $g * f \in I$ for every $g \in L^1(G)$ and
$f \in I$ — the arbitrary element multiplies **on the left**. It is a *right* ideal when
$f * g \in I$ with the member of $I$ on the left. On a non-abelian group these are different
conditions, and the theorem pairs left ideals with *left* translations and right ideals with *right*
translations.

**"Closed under left translations"** means $L_yf \in I$ for every $y \in G$ and $f \in I$, where
$L_yf(x) = f(y^{-1}x)$.

**Both equivalences are asserted**, and each is a genuine biconditional. The hard direction is that a
translation-invariant closed subspace absorbs convolution, which is proved by approximating $g$ by
combinations of point masses.
