# Context: mattila_7_7_lipschitz_level_sets

**Statement:** [mattila_7_7_lipschitz_level_sets.md](mattila_7_7_lipschitz_level_sets.md) · **Criteria:** [mattila_7_7_lipschitz_level_sets.criteria.md](mattila_7_7_lipschitz_level_sets.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## The co-area inequality for Lipschitz maps

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

**$\int^{*}$ is the *upper* integral**: the infimum of $\int g\,d\mathcal{L}^m$ over measurable
$g \ge$ the integrand. It is used because $y \mapsto \mathcal{H}^{s-m}(A \cap f^{-1}\{y\})$ is not known to
be measurable — no measurability of $A$ or of the slice function is assumed anywhere in the theorem.

**$f$ is Lipschitz on $A$**, not on $\mathbb{R}^n$, and $\mathrm{Lip}(f)$ is its Lipschitz constant on $A$.

**The right-hand side** is $c(n,m)\,\mathrm{Lip}(f)^m\,\mathcal{H}^s(A)$: a constant depending only on the
two dimensions, chosen **before** $s$, $A$ and $f$; the Lipschitz constant to the power $m$; and the
$\mathcal{H}^s$ measure of $A$.

**The range condition $m < s < n$** is two inequalities, both hypotheses.
