# Context: mattila_18_1_besicovitch_federer_projection

**Statement:** [mattila_18_1_besicovitch_federer_projection.md](mattila_18_1_besicovitch_federer_projection.md) · **Criteria:** [mattila_18_1_besicovitch_federer_projection.criteria.md](mattila_18_1_besicovitch_federer_projection.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Rectifiable and purely unrectifiable sets, and their projections

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

**The Grassmannian.** $G(n,k)$ is the set of $k$-dimensional **linear** subspaces of $\mathbb{R}^n$ (through
the origin), a compact manifold. $\gamma_{n,k}$ is its unique orthogonally invariant **probability**
measure: invariant under every linear isometry of $\mathbb{R}^n$ acting on subspaces, and of total mass
$1$. Both properties are needed for "for $\gamma_{n,k}$ almost all $V$" to mean anything, and the
Grassmannian has to carry a fixed measurable structure for the phrase to parse at all.

**$P_V$** is the orthogonal projection of $\mathbb{R}^n$ onto $V$; $\mathcal{H}^m$ of a subset of $V$ is
computed with the metric $V$ inherits from $\mathbb{R}^n$.

**$m$-rectifiable (15.3)** as above. **Purely $m$-unrectifiable**: $\mathcal{H}^m(E \cap F) = 0$ for
**every** $m$-rectifiable set $E$. The quantifier is over all rectifiable sets, not over some family.

**Part (1)** is a biconditional: $A$ is $m$-rectifiable **iff** for every $\mathcal{H}^m$ measurable
$B \subseteq A$ with $\mathcal{H}^m(B) > 0$, one has $\mathcal{H}^m(P_VB) > 0$ for $\gamma_{n,m}$-almost
all $V$. Note the inner quantifier structure: the "almost all $V$" is inside the "for every $B$", so the
null set of bad directions may depend on $B$.

**Part (2)** is the complementary biconditional: $A$ is purely $m$-unrectifiable **iff**
$\mathcal{H}^m(P_VA) = 0$ for $\gamma_{n,m}$-almost all $V$. Here the test set is $A$ itself.

**Hypotheses:** $A$ is $\mathcal{H}^m$ measurable with $\mathcal{H}^m(A) < \infty$. Finiteness is used.

**Both biconditionals, in both directions**, are asserted.
