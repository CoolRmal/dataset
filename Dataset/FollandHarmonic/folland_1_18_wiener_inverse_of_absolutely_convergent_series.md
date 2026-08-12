# G. B. Folland, *A Course in Abstract Harmonic Analysis*, Second Edition, 1.18 Corollary (Wiener)

- **Source:** G. B. Folland, *A Course in Abstract Harmonic Analysis*, Second Edition
- **Domain:** Harmonic analysis
- **Lean declaration:** `Dataset.FollandHarmonic.folland_1_18_wiener_inverse_of_absolutely_convergent_series` ([folland_1_18_wiener_inverse_of_absolutely_convergent_series.lean](folland_1_18_wiener_inverse_of_absolutely_convergent_series.lean))
- **Criteria:** [folland_1_18_wiener_inverse_of_absolutely_convergent_series.criteria.md](folland_1_18_wiener_inverse_of_absolutely_convergent_series.criteria.md)

## Statement

**1.18 Corollary.** If $f(e^{i\theta}) = \sum a_n e^{in\theta}$ with $\sum |a_n| < \infty$, and $f$ never vanishes, then $1/f(e^{i\theta}) = \sum b_n e^{in\theta}$ with $\sum |b_n| < \infty$.

**Notation.** The sums run over all $n \in \mathbb{Z}$. The corollary is read off from Theorem 1.17, which identifies the Gelfand spectrum $\sigma(\ell^1)$ of the convolution algebra $\ell^1(\mathbb{Z})$ with the unit circle $\mathbb{T}$ in such a way that the Gelfand transform becomes $\widehat{a}(e^{i\theta}) = \sum_{-\infty}^{\infty} a_n e^{in\theta}$.
