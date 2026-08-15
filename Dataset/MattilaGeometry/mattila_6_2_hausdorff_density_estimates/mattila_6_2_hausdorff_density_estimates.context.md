# Context: mattila_6_2_hausdorff_density_estimates

**Statement:** [mattila_6_2_hausdorff_density_estimates.md](mattila_6_2_hausdorff_density_estimates.md) · **Criteria:** [mattila_6_2_hausdorff_density_estimates.criteria.md](mattila_6_2_hausdorff_density_estimates.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Upper densities of a set of finite Hausdorff measure

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

**Upper density (6.1).** $\Theta^{*s}(A,x) = \limsup_{r\downarrow0}(2r)^{-s}\mathcal{H}^s(A\cap B(x,r))$ —
a **limsup**, normalized by the diameter $2r$. It is defined for every $x \in \mathbb{R}^n$ and every set
$A$, measurable or not.

**Part (1) needs no measurability**: for $\mathcal{H}^s$-almost every $x \in A$,
$2^{-s} \le \Theta^{*s}(A,x) \le 1$. Both bounds are asserted, and the lower bound $2^{-s}$ is the
diameter-convention constant.

**Part (2) does need measurability**: if $A$ is $\mathcal{H}^s$ measurable, then $\Theta^{*s}(A,x) = 0$ for
$\mathcal{H}^s$-almost every $x$ **outside** $A$. So the measurability hypothesis attaches to part (2)
only, and part (2) is about the complement.

**$\mathcal{H}^s(A) < \infty$** is a standing hypothesis for both parts.
