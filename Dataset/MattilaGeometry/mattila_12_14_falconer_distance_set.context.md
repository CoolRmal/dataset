# Context: mattila_12_14_falconer_distance_set

**Statement:** [mattila_12_14_falconer_distance_set.md](mattila_12_14_falconer_distance_set.md) · **Criteria:** [mattila_12_14_falconer_distance_set.criteria.md](mattila_12_14_falconer_distance_set.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## The distance set and Falconer-type estimates

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

**$D(A) = \{|x-y| : x,y \in A\}$** is a set of **distances** — a subset of $\mathbb{R}$, and in particular
of $[0,\infty)$ — not a set of pairs and not a subset of $\mathbb{R}^n$. The ambient metric is the
Euclidean one.

**Two separate parts, with different hypotheses and different conclusions.** (1) If
$\dim A > \frac{n+1}{2}$ then $D(A)$ has **positive Lebesgue measure**. (2) If
$\frac{n-1}{2} < \dim A < \frac{n+1}{2}$ — a **two-sided** hypothesis — then $\dim D(A) > \dim A -
\frac{n-1}{2}$, a strict dimension gain.

**All inequalities are strict**, and $D(A)$ is not assumed measurable — Lebesgue outer measure applies to
every set.
