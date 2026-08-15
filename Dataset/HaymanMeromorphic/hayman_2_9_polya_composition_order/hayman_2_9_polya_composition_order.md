# W. K. Hayman, *Meromorphic Functions*, Theorem 2.9 (a theorem of Pólya)

- **Source:** W. K. Hayman, *Meromorphic Functions*
- **Domain:** Complex analysis
- **Lean declaration:** `Dataset.HaymanMeromorphic.hayman_2_9_polya_composition_order` ([hayman_2_9_polya_composition_order.lean](hayman_2_9_polya_composition_order.lean))
- **Criteria:** [hayman_2_9_polya_composition_order.criteria.md](hayman_2_9_polya_composition_order.criteria.md)
- **Context:** [hayman_2_9_polya_composition_order.context.md](hayman_2_9_polya_composition_order.context.md)

## Statement

**Theorem 2.9.** Suppose that $f(z)$, $g(z)$ are integral functions and that $\phi(z) = g\{f(z)\}$ has finite order. Then either $f(z)$ is a polynomial or $g(z)$ has zero order.

**Notation.** An *integral function* is an entire function. Writing $M(r,f) = \max_{|z|=r}|f(z)|$, the function $f$ has *finite order* when $\log M(r,f) = O(r^k)$ for some $k$, and *zero order* when $\log M(r,f) = O(r^\varepsilon)$ for every $\varepsilon > 0$.
