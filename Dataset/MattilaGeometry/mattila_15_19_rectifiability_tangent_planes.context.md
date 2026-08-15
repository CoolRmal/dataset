# Context: mattila_15_19_rectifiability_tangent_planes

**Statement:** [mattila_15_19_rectifiability_tangent_planes.md](mattila_15_19_rectifiability_tangent_planes.md) · **Criteria:** [mattila_15_19_rectifiability_tangent_planes.criteria.md](mattila_15_19_rectifiability_tangent_planes.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Rectifiability, linear approximability and approximate tangent planes

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

**$m$-rectifiable (15.3).** There are countably many **Lipschitz** maps $f_i \colon \mathbb{R}^m \to
\mathbb{R}^n$ with $\mathcal{H}^m\bigl(E \setminus \bigcup_i f_i(\mathbb{R}^m)\bigr) = 0$. Each $f_i$ is
Lipschitz on all of $\mathbb{R}^m$; "countably many" is essential, and the exceptional set is null rather
than empty.

**$m$-linearly approximable (15.7).** For $\mathcal{H}^m$-almost every $a \in E$: **for every** $\eta > 0$
there are $r_0, \lambda > 0$ and an affine $m$-plane $W \ni a$ such that for all $0 < r < r_0$,
$\mathcal{H}^m(E \cap B(x,\eta r)) \ge \lambda r^m$ for every $x \in W \cap B(a,r)$ — $E$ is *dense enough*
near every point of the plane — **and** $\mathcal{H}^m(E \cap B(a,r) \setminus W(\eta r)) < \eta r^m$ — $E$
does not stray far from the plane. Here $W(\eta r)$ is the $\eta r$-neighbourhood of $W$. Both inequalities
are needed; each alone is much weaker.

**Approximate tangent plane (15.17)** requires **two** things at $a$: positive upper $m$-density of $E$ at
$a$, **and** that the part of $E$ outside every cone around the plane is negligible at small scales.
Positive density alone does not make a plane a tangent plane.

**Uniqueness versus existence.** The equivalence separates "there is an approximate tangent plane at
almost every point" from "there is a **unique** one"; keeping the two items distinct is part of the
statement.

**All four conditions are asserted equivalent**, as one equivalence.
