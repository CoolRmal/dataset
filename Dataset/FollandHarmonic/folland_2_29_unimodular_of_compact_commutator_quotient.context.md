# Context: folland_2_29_unimodular_of_compact_commutator_quotient

**Statement:** [folland_2_29_unimodular_of_compact_commutator_quotient.md](folland_2_29_unimodular_of_compact_commutator_quotient.md) · **Criteria:** [folland_2_29_unimodular_of_compact_commutator_quotient.criteria.md](folland_2_29_unimodular_of_compact_commutator_quotient.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## The closed commutator subgroup and unimodularity

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

**$[G,G]$ here is the *closed* commutator subgroup**: the smallest **closed** subgroup containing all
commutators $xyx^{-1}y^{-1}$, i.e. the closure of the abstract commutator subgroup. In a topological
group the algebraic commutator subgroup need not be closed, and the quotient by it need not be
Hausdorff, so the closure is not a technical convenience — it is part of the definition.

**$G/[G,G]$ compact** is the hypothesis; $G$ itself is not assumed compact.

**The conclusion is unimodularity**: $\Delta(x) = 1$ for every $x \in G$. It is a statement about all
group elements, so a formalization asserting it at one distinguished point says nothing.

**Why the statement is true.** $\Delta$ is a homomorphism into the abelian group $(0,\infty)$, so it
kills commutators and, being continuous, kills their closed subgroup; it therefore factors through the
compact group $G/[G,G]$, whose only compact subgroup image in $(0,\infty)$ is $\{1\}$.
