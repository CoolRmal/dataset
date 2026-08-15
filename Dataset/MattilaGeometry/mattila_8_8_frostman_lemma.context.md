# Context: mattila_8_8_frostman_lemma

**Statement:** [mattila_8_8_frostman_lemma.md](mattila_8_8_frostman_lemma.md) · **Criteria:** [mattila_8_8_frostman_lemma.criteria.md](mattila_8_8_frostman_lemma.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Frostman's lemma: $\mathcal{M}(B)$, content, and the growth bound

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

**$\mathcal{M}(B)$** denotes the nonzero finite Radon measures **with compact support contained in $B$**.
All three clauses matter: nonzero (or the growth bound is vacuous), finite Radon, and supported inside
$B$.

**The growth bound** is the **strict** inequality $\mu(B(x,r)) < r^s$ for **every** $x \in \mathbb{R}^n$
and **every** $r > 0$ — not only for $x \in B$ and not only for small $r$.

**The biconditional** is with $\mathcal{H}^s(B) > 0$, the Hausdorff **measure**, not the content.

**The quantitative refinement** is a strengthening of the forward direction: one may in addition require
$\mu(B) > c\,\mathcal{H}^s_\infty(B)$, where the Hausdorff **content** $\mathcal{H}^s_\infty$ is the
infimum of $\sum_i d(E_i)^s$ over countable covers with **no** diameter restriction, and $c > 0$ depends
only on $n$ — so $c$ is quantified before $s$ and $B$.
