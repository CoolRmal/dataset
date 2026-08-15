# G. B. Folland, *A Course in Abstract Harmonic Analysis*, Second Edition, 2.29 Proposition

- **Source:** G. B. Folland, *A Course in Abstract Harmonic Analysis*, Second Edition
- **Domain:** Harmonic analysis
- **Lean declaration:** `Dataset.FollandHarmonic.folland_2_29_unimodular_of_compact_commutator_quotient` ([folland_2_29_unimodular_of_compact_commutator_quotient.lean](folland_2_29_unimodular_of_compact_commutator_quotient.lean))
- **Criteria:** [folland_2_29_unimodular_of_compact_commutator_quotient.criteria.md](folland_2_29_unimodular_of_compact_commutator_quotient.criteria.md)
- **Context:** [folland_2_29_unimodular_of_compact_commutator_quotient.context.md](folland_2_29_unimodular_of_compact_commutator_quotient.context.md)

## Statement

**2.29 Proposition.** If $G/[G,G]$ is compact, then $G$ is unimodular.

**Notation.** $[G,G]$ denotes the smallest **closed** subgroup of $G$ containing all elements of the form $[x,y] = xyx^{-1}y^{-1}$; it is called the commutator subgroup of $G$, and it is normal since $z[x,y]z^{-1} = [zxz^{-1}, zyz^{-1}]$. Throughout, $G$ is a locally compact group with a fixed left Haar measure, $L_yf(x) = f(y^{-1}x)$ and $R_yf(x) = f(xy)$ are the left and right translates of $f$, and $f*g(x) = \int f(y)g(y^{-1}x)\,dy$ is convolution. $\mathcal{L}^1(G)$ is a Banach algebra under convolution. The modular function $\Delta : G \to (0,\infty)$ is determined by $\lambda(Ex) = \Delta(x)\lambda(E)$ for a left Haar measure $\lambda$; $G$ is *unimodular* when $\Delta \equiv 1$.
