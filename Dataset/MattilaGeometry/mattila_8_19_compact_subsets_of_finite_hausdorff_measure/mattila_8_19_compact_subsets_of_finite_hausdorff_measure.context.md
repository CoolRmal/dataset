# Context: mattila_8_19_compact_subsets_of_finite_hausdorff_measure

**Statement:** [mattila_8_19_compact_subsets_of_finite_hausdorff_measure.md](mattila_8_19_compact_subsets_of_finite_hausdorff_measure.md) · **Criteria:** [mattila_8_19_compact_subsets_of_finite_hausdorff_measure.criteria.md](mattila_8_19_compact_subsets_of_finite_hausdorff_measure.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Approximating $\mathcal{H}^s$ from inside by compact sets of finite measure

**Hausdorff measure and dimension.** $\mathcal{H}^s$ is the $s$-dimensional Hausdorff **outer** measure —
defined on *every* subset of $\mathbb{R}^n$, with no measurability required — normalized by Mattila's
diameter convention $\sum_i d(E_i)^s$. The Hausdorff **content** $\mathcal{H}^s_\infty$ is the same
infimum with **no** restriction on the diameters of the covering sets; it is not a measure but has the
same null sets. $\dim A$ is the Hausdorff dimension, the critical exponent at which $\mathcal{H}^s(A)$
jumps from $\infty$ to $0$; it takes values in $[0,n]$ and is naturally an extended real.

**"For $\mathcal{H}^s$ almost all $x \in A$"** means the exceptional points *inside $A$* form an
$\mathcal{H}^s$-null set — the measure is restricted to $A$, and nothing is said off $A$.

**Everything is $[0,+\infty]$-valued.** Hausdorff measures, energies and density integrals may be
infinite; a formalization that forces them into $\mathbb{R}$ either needs finiteness hypotheses the text
does not make, or silently uses a junk default.

**The setting** is a **compact metric space** $X$, and both sides of the identity concern $\mathcal{H}^s$
of subsets of $X$ computed with its own metric.

**The identity** $\mathcal{H}^s(X) = \sup\{\mathcal{H}^s(C) : C \subseteq X$ compact,
$\mathcal{H}^s(C) < \infty\}$ asserts **both** inequalities. The $\ge$ direction is trivial; the $\le$
direction is the theorem, and it is interesting precisely when $\mathcal{H}^s(X) = \infty$ — the supremum
of *finite* values is then still $\infty$.

**No finiteness hypothesis on $\mathcal{H}^s(X)$**, and the side condition $\mathcal{H}^s(C) < \infty$ is
part of the family being supremised over.
