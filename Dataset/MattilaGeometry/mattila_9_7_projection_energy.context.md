# Context: mattila_9_7_projection_energy

**Statement:** [mattila_9_7_projection_energy.md](mattila_9_7_projection_energy.md) · **Criteria:** [mattila_9_7_projection_energy.criteria.md](mattila_9_7_projection_energy.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Riesz energies and projections of measures

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

**Riesz $s$-energy.** $I_s(\mu) = \iint |x-y|^{-s}\,d\mu x\,d\mu y$ — a double integral of a nonnegative
kernel, so it lives in $[0,\infty]$ and the hypothesis $I_m(\mu)<\infty$ is a genuine restriction. The
kernel is singular on the diagonal; nothing is excised.

**$P_{V\#}\mu$** is the pushforward of $\mu$ under the orthogonal projection onto $V$ — a measure on $V$.
The first conclusion is that for $\gamma_{n,m}$-almost every $V$ this pushforward is absolutely continuous
with respect to $\mathcal{H}^m$ on $V$.

**$D(P_{V\#}\mu,u)$** is then the density (Radon–Nikodym derivative) of that pushforward at $u \in V$. The
second conclusion is the energy bound
$\int\int_V D(P_{V\#}\mu,u)^2\,d\mathcal{H}^m u\,d\gamma_{n,m}V < c\,I_m(\mu)$ with $c$ depending only on
$n$ and $m$ — quantified before $\mu$.

**Hypotheses on $\mu$**: Radon (finite on compacts, inner regular) and **compactly supported**, together
with the energy hypothesis.
