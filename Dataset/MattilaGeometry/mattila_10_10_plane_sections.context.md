# Context: mattila_10_10_plane_sections

**Statement:** [mattila_10_10_plane_sections.md](mattila_10_10_plane_sections.md) · **Criteria:** [mattila_10_10_plane_sections.criteria.md](mattila_10_10_plane_sections.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Affine slices of a set of finite Hausdorff measure

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

**$W_a$ and the slicing.** For $W \in G(n,n-m)$ and $a \in W^\perp$, $W_a = W + a$ is the affine
translate of $W$ through $a$; as $a$ ranges over $W^\perp$ these translates partition $\mathbb{R}^n$. The
slice studied is $A \cap W_a$, and the parameter $a$ carries $\mathcal{H}^m$ on the $m$-dimensional space
$W^\perp$.

**Two clauses with different quantifiers over $W$.** Clause (1) holds for **all** $W$: for
$\mathcal{H}^m$-almost every $a$, the slice has finite $\mathcal{H}^{t-m}$ measure. Clause (2) holds only
for $\gamma$-**almost all** $W$: the set of $a$ whose slice has Hausdorff dimension exactly $t-m$ has
positive $\mathcal{H}^m$ measure. Interchanging "all" and "almost all" changes the theorem in both places.

**Hypotheses.** $m < t < n$, and $A$ Borel with $0 < \mathcal{H}^t(A) < \infty$ — both bounds are used.
