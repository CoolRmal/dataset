# G. B. Folland, *A Course in Abstract Harmonic Analysis*, Second Edition, Theorem 4.81 (characterization of uniformly almost periodic functions)

- **Source:** G. B. Folland, *A Course in Abstract Harmonic Analysis*, Second Edition
- **Domain:** Harmonic analysis
- **Lean declaration:** `Dataset.FollandHarmonic.folland_4_81_almost_periodic_characterization` ([folland_4_81_almost_periodic_characterization.lean](folland_4_81_almost_periodic_characterization.lean))
- **Criteria:** [folland_4_81_almost_periodic_characterization.criteria.md](folland_4_81_almost_periodic_characterization.criteria.md)
- **Context:** [folland_4_81_almost_periodic_characterization.context.md](folland_4_81_almost_periodic_characterization.context.md)

## Statement

**4.81 Theorem.** If $f$ is a bounded continuous function on $G$, the following are equivalent:

a. $f$ is the restriction to $G$ of a continuous function on $bG$.

b. $f$ is the uniform limit of linear combinations of characters on $G$.

c. $f$ is uniformly almost periodic.

**Notation.** $G$ is a locally compact abelian group and $\widehat{G}$ its dual group of continuous characters $\xi : G \to \mathbb{T}$, with the pairing written $\langle x,\xi\rangle = \xi(x)$. $bG$ is the Bohr compactification of $G$, and $f$ is *uniformly almost periodic* when the set of its right translates $\{R_yf : y \in G\}$, where $R_yf(x) = f(xy)$, is totally bounded in the uniform norm.
