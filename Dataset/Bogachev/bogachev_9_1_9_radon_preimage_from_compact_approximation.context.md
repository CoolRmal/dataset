# Context: bogachev_9_1_9_radon_preimage_from_compact_approximation

**Statement:** [bogachev_9_1_9_radon_preimage_from_compact_approximation.md](bogachev_9_1_9_radon_preimage_from_compact_approximation.md) · **Criteria:** [bogachev_9_1_9_radon_preimage_from_compact_approximation.criteria.md](bogachev_9_1_9_radon_preimage_from_compact_approximation.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Radon measures, $|\nu|$ and $\|\nu\|$, and image measures of non-measurable maps

**The measures are signed and Radon.** As everywhere in Bogachev's Chapter 9, $\nu$ is a finite
signed Borel measure. It is *Radon* when its total variation $|\nu|$ is inner regular with respect to
compact sets: $|\nu|(B) = \sup\{|\nu|(K) : K \subseteq B \text{ compact}\}$ for every Borel $B$. Radon
is inner regularity, not outer regularity, and the measure produced by the theorem is required to be
Radon too — that is what makes the conclusion useful.

**$|\nu|$ and $\|\nu\|$.** $|\nu|$ is the total variation *measure* (a nonnegative measure);
$\|\nu\| = |\nu|(Y)$ is the total variation *norm* (a number). The hypothesis
$\lim_n |\nu|(f(K_n)) = \|\nu\|$ therefore says: the images of the compacta capture, in the limit,
all of the mass of $\nu$. Note $|\nu|$ is applied to the sets $f(K_n)$, which are not assumed
measurable; for a nonnegative measure this is legitimate and means the outer measure.

**$f$ is barely a function.** No global measurability or continuity of $f$ is assumed — only that $f$
is continuous on each $K_n$. This is what the theorem is *for*: it manufactures a Radon measure on $X$
whose image is $\nu$ out of a map with no global regularity. Adding `Measurable f` or `Continuous f`
to the hypotheses assumes away the content.

**"$\mu \circ f^{-1} = \nu$" for such an $f$.** Since $f^{-1}(A)$ need not be measurable, the equation
cannot mean a pushforward measure. It means that $f$ is measurable *with respect to $\mu$* and that the
resulting image measure is $\nu$: for every Borel $A \subseteq Y$ there is a $\mu$-measurable set $B$
that agrees with $f^{-1}(A)$ up to a $|\mu|$-null set, with $\mu(B) = \nu(A)$.

**The compacta increase.** $K_n \subseteq K_{n+1}$ is part of the hypothesis; the increasing structure
is what lets the images exhaust the mass.

**The last sentence is a separate assertion.** "In particular, this is true if $X$ and $Y$ are compact
and $f$ is a continuous surjection" is a second claim, with its own hypotheses and no
compact-approximation assumption. It is part of the printed theorem.
