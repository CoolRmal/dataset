# Context: bogachev_10_5_4_lifting

**Statement:** [bogachev_10_5_4_lifting.md](bogachev_10_5_4_lifting.md) · **Criteria:** [bogachev_10_5_4_lifting.criteria.md](bogachev_10_5_4_lifting.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Liftings of $\mathcal{L}^\infty$

**$\mathcal{L}^\infty_{\mathcal{A}}$ is a space of functions, not of classes.** Bogachev writes
$\mathcal{L}^\infty_{\mathcal{A}}$ (script $\mathcal{L}$, no quotient) for the set of *bounded
$\mathcal{A}$-measurable functions $X \to \mathbb{R}$ themselves. This is deliberate and is the
whole point of the theorem: $L^\infty(\mu)$ — the quotient by equality almost everywhere — carries
no information about individual points, and on the quotient the identity map already satisfies
every condition in Definition 10.5.1. A lifting is a rule that picks, out of each almost-everywhere
class, one genuine function, in such a way that the algebraic operations are respected *at every
point of $X$ and not merely almost everywhere*. Only condition (1), $L(f) = f$ a.e., is an
almost-everywhere statement; conditions (2)–(5) are exact equalities of functions.

**"Complete measure."** A measure $\mu$ on $(X,\mathcal{A})$ is complete when every subset of a
$\mu$-null set of $\mathcal{A}$ again belongs to $\mathcal{A}$ (and is then null). Lebesgue measure
on $\mathbb{R}^n$ is complete; Borel measure is not. Completeness is a hypothesis of the theorem,
not a convention, and the standard proof uses it.

**Reading the conditions.** In condition (3), $1$ denotes the constant function with value $1$, and
the conclusion "$L(f)(x) = 1$ for all $x$" says that $L(f)$ *is* that constant function. In
condition (4), $\mathbb{R}^1$ is Bogachev's notation for the real line, so $\alpha, \beta$ are
arbitrary real scalars. In condition (5), $fg$ is the pointwise product. Note that (4) and (5)
together say $L$ is a homomorphism of algebras, and (3) that it is unital; unitality does not follow
from the other conditions as stated, because (4) and (5) alone are also satisfied by $L = 0$.

**What the theorem asserts.** Only existence: for every complete probability measure there is at
least one lifting. Nothing is claimed about uniqueness, and no construction is asserted to be
canonical — the standard proof uses Zorn's lemma.
