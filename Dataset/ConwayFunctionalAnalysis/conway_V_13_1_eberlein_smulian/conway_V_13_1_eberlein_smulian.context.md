# Context: conway_V_13_1_eberlein_smulian

**Statement:** [conway_V_13_1_eberlein_smulian.md](conway_V_13_1_eberlein_smulian.md) · **Criteria:** [conway_V_13_1_eberlein_smulian.criteria.md](conway_V_13_1_eberlein_smulian.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Weak topology, weak cluster points, and weak compactness

**The weak topology** on a Banach space $\mathcal{X}$ is the coarsest topology making every
$x^* \in \mathcal{X}^*$ continuous. It is not metrizable on an infinite-dimensional space, which is
exactly why the theorem is surprising: it says that for weak compactness, sequences suffice.

**(a) Weakly convergent subsequence.** A subsequence — a reindexing along a strictly increasing
$\varphi \colon \mathbb{N} \to \mathbb{N}$ — converging in the weak topology to *some* point of
$\mathcal{X}$. The limit is not required to lie in $A$.

**(b) Weak cluster point.** A point $x$ such that every weak neighbourhood of $x$ contains $u_n$ for
infinitely many $n$. This is a genuinely weaker-looking condition than (a) in a non-metrizable
topology, and the equivalence with (a) is part of the theorem.

**(c) The weak closure of $A$ is weakly compact.** Closure and compactness both in the weak topology.
"Weakly compact" is compactness of the set in that topology, not sequential compactness — the
equivalence of the two is again what is being asserted.

**$A$ is an arbitrary subset.** No convexity, no boundedness, no closedness is assumed.
