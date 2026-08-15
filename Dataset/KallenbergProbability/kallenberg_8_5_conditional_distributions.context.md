# Context: kallenberg_8_5_conditional_distributions

**Statement:** [kallenberg_8_5_conditional_distributions.md](kallenberg_8_5_conditional_distributions.md) · **Criteria:** [kallenberg_8_5_conditional_distributions.criteria.md](kallenberg_8_5_conditional_distributions.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Conditional distributions as probability kernels

**Probability kernel.** $\mu \colon S \to T$ with each $\mu_s$ a probability measure on $T$ and
$s \mapsto \mu_s(B)$ measurable for each Borel $B$. "Probability kernel" is stronger than "kernel": every
fibre has total mass exactly $1$.

**$\mathcal{L}(\xi,\eta) = \mathcal{L}(\xi)\otimes\mu$** says the joint law of the pair is the
composition-product of the law of $\xi$ with the kernel — i.e. for measurable rectangles,
$P\{\xi \in A, \eta \in B\} = \int_A \mu_s(B)\,\mathcal{L}(\xi)(ds)$.

**The Borel hypothesis is on $T$ only.** $S$ carries only a measurable structure; the existence of regular
conditional distributions is what needs the target to be standard Borel.

**Uniqueness is a.e.**, with respect to the law of $\xi$: two kernels satisfying the identity agree for
$\mathcal{L}(\xi)$-almost every $s$.

**(i) and (ii)** spell out what the kernel does: it is a version of the conditional distribution of $\eta$
given $\xi$, and it computes conditional expectations of jointly measurable non-negative $f$ — note $f$
depends on **both** arguments.
