# G. B. Folland, *A Course in Abstract Harmonic Analysis*, Theorem 3.34 (Gelfand–Raikov)

- **Source:** G. B. Folland, *A Course in Abstract Harmonic Analysis*
- **Domain:** Abstract harmonic analysis
- **Lean declaration:** `Dataset.FollandHarmonic.folland_3_34_gelfand_raikov` ([folland_3_34_gelfand_raikov.lean](folland_3_34_gelfand_raikov.lean))
- **Criteria:** [folland_3_34_gelfand_raikov.criteria.md](folland_3_34_gelfand_raikov.criteria.md)
- **Context:** [folland_3_34_gelfand_raikov.context.md](folland_3_34_gelfand_raikov.context.md)

## Statement

**3.34 Theorem (The Gelfand–Raikov Theorem).** If $G$ is any locally compact group, the irreducible unitary representations of $G$ separate points on $G$. That is, if $x$ and $y$ are distinct points of $G$, there is an irreducible representation $\pi$ such that $\pi(x) \neq \pi(y)$.

**Notation.** A *unitary representation* of $G$ is a homomorphism $\pi$ from $G$ into the group of unitary operators on some nonzero complex Hilbert space $\mathcal{H}_\pi$ that is continuous for the strong operator topology, i.e. $x \mapsto \pi(x)v$ is continuous for each $v \in \mathcal{H}_\pi$. It is *irreducible* if the only closed $\pi$-invariant subspaces of $\mathcal{H}_\pi$ are $\{0\}$ and $\mathcal{H}_\pi$.
