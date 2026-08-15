# Context: proposition_5_5_4

**Statement:** [proposition_5_5_4.md](proposition_5_5_4.md) · **Criteria:** [proposition_5_5_4.criteria.md](proposition_5_5_4.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Outer measure of an image, and differentiability at points of a set

**$\lambda$ and $\lambda(f(E))$.** $\lambda$ is Lebesgue measure on the line. The set $f(E)$ is a
forward image and need not be measurable, so $\lambda(f(E))$ is to be read as *outer* measure. No
measurability of the image is assumed anywhere, and assuming it would weaken the proposition.

**"Differentiable at every point of $E$".** This is differentiability of $f$ as a function on the line,
at each point of $E$ — the ordinary two-sided derivative, using values of $f$ at points *outside* $E$
as well. It is strictly stronger than differentiability of the restriction $f|_E$, or of $f$ "within
$E$": at an isolated point of $E$ every function is differentiable within $E$, so the within-version
is vacuous on sets with empty interior and the proposition would be false with it.

**No other assumption on $f$.** $f$ is an arbitrary function on $\mathbb{R}$; it is not assumed
measurable, continuous, or anything else off $E$. Consequently the derivative $f'$ carries meaning only
at points of $E$, and every use of it in the statement is confined to $E$.

**The right-hand integral may be infinite.** $\int_E |f'|$ is an integral of a nonnegative function and
is allowed to be $+\infty$; the inequality is then trivially true. It must not be read as an integral
that presupposes $|f'|$ integrable over $E$.

**The two "in particular" sentences are separate assertions.** (i) $f$ has Lusin's property (N) *on*
$E$ — for every null $A \subseteq E$, $f(A)$ is null. This is a claim about subsets of $E$; global
property (N) is false, since nothing is known about $f$ off $E$. (ii) If $|f'| \le L$ on $E$ then
$\lambda(f(E)) \le L\lambda(E)$, for every $L$ for which the bound holds — the bound is a hypothesis of
that clause, not of the proposition.
