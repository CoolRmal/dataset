# Context: mattila_14_10_marstrand_density_integer

**Statement:** [mattila_14_10_marstrand_density_integer.md](mattila_14_10_marstrand_density_integer.md) · **Criteria:** [mattila_14_10_marstrand_density_integer.criteria.md](mattila_14_10_marstrand_density_integer.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Marstrand's density theorem

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

**$\Theta^s(\mu,a)$, the $s$-density of a measure**, is the **limit** as $r \downarrow 0$ of
$\frac{\mu(B(a,r))}{(2r)^s}$ — a genuine limit, not an upper or lower density. The normalization is by
$(2r)^s$, the $s$-th power of the *diameter*, matching Mattila's convention throughout the book; using
$r^s$ changes every constant.

**"Exists and is positive and finite in a set of positive $\mu$ measure."** There is a set $E$ with
$\mu(E) > 0$ such that at every $a \in E$ the limit exists and lies strictly between $0$ and $\infty$. The
value is allowed to vary with $a$; only its positivity and finiteness are asserted.

**Radon measure** on $\mathbb{R}^n$: a Borel measure finite on compact sets, inner regular with respect to
compacts. No absolute continuity or self-similarity is assumed.

**The conclusion is that $s$ is an integer** — a striking rigidity statement: fractional dimensions admit
no measure with a positive finite density almost everywhere.
