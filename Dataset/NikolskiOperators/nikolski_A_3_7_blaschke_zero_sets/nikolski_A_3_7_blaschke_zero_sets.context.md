# Context: nikolski_A_3_7_blaschke_zero_sets

**Statement:** [nikolski_A_3_7_blaschke_zero_sets.md](nikolski_A_3_7_blaschke_zero_sets.md) · **Criteria:** [nikolski_A_3_7_blaschke_zero_sets.criteria.md](nikolski_A_3_7_blaschke_zero_sets.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Notation

The zero sequence lists **every** zero, **repeated according to multiplicity**. $b_\lambda$ is the Möbius factor. $|B| \le 1$ holds on the disc while $|B| = 1$ holds a.e. on the circle — two different venues.

In the extension clause of 3.7.3, $\operatorname{clos}$ denotes closure, and $\bar{\lambda}_n$ is the complex conjugate of $\lambda_n$. Each factor $b_\lambda$ is analytic on the whole plane except for a single pole at $1/\bar{\lambda}$, the reflection of $\lambda$ in the unit circle, so the set removed from $\mathbb{C}$ is the closure of the conjugate-reciprocal points $\{1/\bar{\lambda}_n\}$ — exactly where the factors have their poles. Do not read the excluded set as $\{1/\lambda_n\}$ without the conjugation: that is the mirror image of the poles across the real axis, and off its closure the product need not converge.
