# Context: kallenberg_3_4_disintegration

**Statement:** [kallenberg_3_4_disintegration.md](kallenberg_3_4_disintegration.md) · **Criteria:** [kallenberg_3_4_disintegration.criteria.md](kallenberg_3_4_disintegration.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Kernels, $\sigma$-finiteness, and disintegration

**Kernel.** $\mu \colon S \to T$ assigns to each $s \in S$ a measure $\mu_s$ on $T$, measurably in $s$.
Kallenberg distinguishes three finiteness notions, and they are **not** the same:

- *finite*: $\mu_s T < \infty$ for every $s$;
- *s-finite*: a countable **sum** of finite kernels;
- *$\sigma$-finite*: there is one measurable $f > 0$ on $S \times T$ with $\mu_s f_s < \infty$ for all
  $s$ — a single global witness, not a per-$s$ exhaustion.

The disintegration kernel of the theorem is $\sigma$-finite in this sense, and its fibres are a.e.
bounded only under an extra hypothesis.

**$\hat\rho_S = \rho(\cdot \times T)$** is the first marginal of $\rho$, and $\nu \sim \hat\rho_S$ means
mutual absolute continuity — the same null sets, in both directions. A *supporting measure* is any
$\sigma$-finite $\nu$ with that property.

**$\rho = \nu \otimes \mu$** is the composition-product: $\rho(A\times B) = \int_A \mu_s(B)\,\nu(ds)$.

**"Unique up to normalizations"** means: any two disintegrations $(\nu,\mu)$, $(\nu',\mu')$ differ by a
measurable density $c$ on $S$ — $\nu' = c\,\nu$ and $\mu_s = c(s)\mu'_s$ for $\nu$-a.e. $s$.

**The Borel hypothesis is on $T$ only**; $S$ carries nothing but a measurable structure.
