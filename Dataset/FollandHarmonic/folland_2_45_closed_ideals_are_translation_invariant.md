# G. B. Folland, *A Course in Abstract Harmonic Analysis*, Second Edition, Theorem 2.45 (closed ideals of $\mathcal{L}^1(G)$ are the translation-invariant subspaces)

- **Source:** G. B. Folland, *A Course in Abstract Harmonic Analysis*, Second Edition
- **Domain:** Harmonic analysis
- **Lean declaration:** `Dataset.FollandHarmonic.folland_2_45_closed_ideals_are_translation_invariant` ([folland_2_45_closed_ideals_are_translation_invariant.lean](folland_2_45_closed_ideals_are_translation_invariant.lean))
- **Criteria:** [folland_2_45_closed_ideals_are_translation_invariant.criteria.md](folland_2_45_closed_ideals_are_translation_invariant.criteria.md)

## Statement

**2.45 Theorem.** Let $I$ be a closed subspace of $L^1(G)$. Then $I$ is a left ideal if and only if it is closed under left translations, and $I$ is a right ideal if and only if it is closed under right translations.

**Notation.** Throughout, $G$ is a locally compact group with a fixed left Haar measure, $L_yf(x) = f(y^{-1}x)$ and $R_yf(x) = f(xy)$ are the left and right translates of $f$, and $f*g(x) = \int f(y)g(y^{-1}x)\,dy$ is convolution. $\mathcal{L}^1(G)$ is a Banach algebra under convolution.
