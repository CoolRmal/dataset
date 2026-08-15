# Context: folland_2_44_approximate_identity

**Statement:** [folland_2_44_approximate_identity.md](folland_2_44_approximate_identity.md) · **Criteria:** [folland_2_44_approximate_identity.criteria.md](folland_2_44_approximate_identity.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Approximate identities and the meaning of "$U \to \{1\}$"

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

**The family $\{\psi_U\}$.** Indexed by a neighbourhood base $\mathcal{U}$ at the identity, with each
$\psi_U$ compactly supported inside $U$, nonnegative, and of total mass $1$. Condition (iii),
$\psi_U(x^{-1}) = \psi_U(x)$, is *symmetry*, and it is required only for the second (right-hand)
conclusion.

**"$\|\psi_U * f - f\|_p \to 0$ as $U \to \{1\}$" is a filter statement, and the quantifiers are the
subtle part.** It means: for every $\varepsilon > 0$ there is a neighbourhood $U$ of $1$ such that
**every** function $\psi$ satisfying (i)–(ii) with support inside $U$ already achieves
$\|\psi * f - f\|_p < \varepsilon$. The bound is uniform over all admissible bumps supported in $U$; it
is not a statement about one chosen family, and reading it as "there is a sequence $\psi_n$ with
$\|\psi_n * f - f\|_p \to 0$" is strictly weaker.

**Left and right.** $\psi * f \to f$ needs only (i)–(ii); $f * \psi \to f$ additionally needs symmetry
(iii). At $p = \infty$ the hypotheses change from $f \in L^p$ to left (resp. right) uniform continuity
of $f$.
