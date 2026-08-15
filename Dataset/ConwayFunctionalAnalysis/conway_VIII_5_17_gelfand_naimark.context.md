# Context: conway_VIII_5_17_gelfand_naimark

**Statement:** [conway_VIII_5_17_gelfand_naimark.md](conway_VIII_5_17_gelfand_naimark.md) · **Criteria:** [conway_VIII_5_17_gelfand_naimark.criteria.md](conway_VIII_5_17_gelfand_naimark.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Representations of a $C^*$-algebra

**A representation $(\pi,\mathcal{H})$** of a $C^*$-algebra $\mathcal{A}$ is a $*$-homomorphism
$\pi \colon \mathcal{A} \to \mathcal{B}(\mathcal{H})$ into the bounded operators on a complex Hilbert
space: linear, multiplicative, and satisfying $\pi(a^*) = \pi(a)^*$. Completeness of $\mathcal{H}$ is
part of "Hilbert space".

**"$\pi$ is an isometry"** means $\|\pi(a)\| = \|a\|$ for every $a$ — the representation is faithful
and norm-preserving. For a linear map this is the same as being distance-preserving. This is the
Gelfand–Naimark theorem: every abstract $C^*$-algebra is a concrete algebra of operators.

**The second sentence is a separate assertion.** If $\mathcal{A}$ is separable then a separable
$\mathcal{H}$ can be chosen. The $\mathcal{H}$ and $\pi$ there are quantified afresh: the claim is not
that the space from the first sentence happens to be separable.

**No unitality is required.** Conway's statement covers $C^*$-algebras generally; the GNS construction
that proves it works without a unit.

**Where the Hilbert space lives.** The GNS construction builds $\mathcal{H}$ as a completion of a
quotient of $\mathcal{A}$ itself, so its cardinality is controlled by that of $\mathcal{A}$ — the
Hilbert space can be taken in the same universe.
