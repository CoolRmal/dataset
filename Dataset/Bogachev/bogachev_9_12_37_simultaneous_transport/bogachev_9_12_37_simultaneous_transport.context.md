# Context: bogachev_9_12_37_simultaneous_transport

**Statement:** [bogachev_9_12_37_simultaneous_transport.md](bogachev_9_12_37_simultaneous_transport.md) · **Criteria:** [bogachev_9_12_37_simultaneous_transport.criteria.md](bogachev_9_12_37_simultaneous_transport.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Souslin spaces, atoms, and image measures

**Souslin space.** A Hausdorff topological space that is the continuous image of a Polish space —
equivalently, in Bogachev's phrasing, a Hausdorff space that is an analytic set. Every Polish space is
Souslin, but Souslin is strictly more general (e.g. analytic non-Borel subsets of $\mathbb{R}$ with
the induced topology). The hypothesis cannot simply be replaced by "Polish": that would state a
special case.

**Atom and atomless.** Definition 7.14.15, quoted with the statement: $A$ is an atom of $\mu$ when
$\mu(A)>0$ and every measurable $B \subseteq A$ has $\mu(B) \in \{0, \mu(A)\}$. A measure is atomless
when it has no atoms, i.e. every measurable set of positive measure contains a measurable subset of
strictly smaller positive measure. This is **not** the same condition as "$\mu(\{x\}) = 0$ for every
point $x$" — the two agree on nice spaces but are different definitions, and the book's is the one in
force.

**$\mu_i \circ T^{-1}$.** The image (pushforward) measure: $(\mu_i \circ T^{-1})(B) = \mu_i(T^{-1}(B))$
for Borel $B$. The equation $\mu_i \circ T^{-1} = \nu$ therefore says $T$ transports each $\mu_i$ onto
$\nu$. "Borel transformation" means $T \colon X \to X$ is Borel measurable — measurability is part of
the assertion, not an afterthought, since without it the preimages $T^{-1}(B)$ need not be measurable.

**The force of the statement is the order of the quantifiers.** One and the same $T$ works for all
$i \le n$ simultaneously. Applying the one-measure isomorphism theorem separately to each $\mu_i$
gives $n$ different maps and is a strictly weaker (and much easier) assertion.

**$\nu$ is arbitrary.** The target measure is any Borel probability measure on $X$: it may have atoms,
it may be a point mass. Only the sources $\mu_1,\dots,\mu_n$ are assumed atomless. Assuming $\nu$
atomless as well weakens the corollary.
