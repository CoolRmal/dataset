# O. Kallenberg, *Foundations of Modern Probability*, Theorem 5.25 (portmanteau theorem, Alexandrov)

- **Source:** O. Kallenberg, *Foundations of Modern Probability*
- **Domain:** Probability
- **Lean declaration:** `Dataset.KallenbergProbability.kallenberg_5_25_portmanteau` ([kallenberg_5_25_portmanteau.lean](kallenberg_5_25_portmanteau.lean))
- **Criteria:** [kallenberg_5_25_portmanteau.criteria.md](kallenberg_5_25_portmanteau.criteria.md)
- **Context:** [kallenberg_5_25_portmanteau.context.md](kallenberg_5_25_portmanteau.context.md)

## Statement

**Theorem 5.25 (portmanteau theorem, Alexandrov).** Let $\xi, \xi_1, \xi_2, \dots$ be random elements in a metric space $(S, \mathcal{S})$ with classes $\mathcal{G}, \mathcal{F}$ of open and closed sets. Then these conditions are equivalent:

- **(i)** $\xi_n \to \xi$ in distribution,
- **(ii)** $\displaystyle\liminf_{n \to \infty} P\{\xi_n \in G\} \ge P\{\xi \in G\}$, $G \in \mathcal{G}$,
- **(iii)** $\displaystyle\limsup_{n \to \infty} P\{\xi_n \in F\} \le P\{\xi \in F\}$, $F \in \mathcal{F}$,
- **(iv)** $P\{\xi_n \in B\} \to P\{\xi \in B\}$, $B \in \mathcal{S}_\xi$.

**Continuity sets.** For a random element $\xi$ in a metric space $S$ with Borel $\sigma$-field $\mathcal{S}$, let $\mathcal{S}_\xi$ denote the class of sets $B \in \mathcal{S}$ with $\xi \notin \partial B$ a.s., called the *$\xi$-continuity sets*.
