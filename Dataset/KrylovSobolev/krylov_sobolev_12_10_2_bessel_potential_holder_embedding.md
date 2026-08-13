# N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Sobolev Spaces*, Lemma 12.10.2 (the embedding lemma)

- **Source:** N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Sobolev Spaces*
- **Domain:** PDE
- **Lean declaration:** `Dataset.KrylovSobolev.krylov_sobolev_12_10_2_bessel_potential_holder_embedding` ([krylov_sobolev_12_10_2_bessel_potential_holder_embedding.lean](krylov_sobolev_12_10_2_bessel_potential_holder_embedding.lean))
- **Criteria:** [krylov_sobolev_12_10_2_bessel_potential_holder_embedding.criteria.md](krylov_sobolev_12_10_2_bessel_potential_holder_embedding.criteria.md)

## Statement

**Lemma 12.10.2.** Let $p \in (1, \infty]$ and let

$$0 < \delta := \gamma - d/p < 1.$$

Then there is a constant $N$ such that, for any $\phi \in \mathcal{S}$ and $x, y \in \mathbb{R}^d$,

$$|\phi(x)| \le N\|(1 - \Delta)^{\gamma/2}\phi\|_{\mathcal{L}_p},$$

$$|\phi(x) - \phi(y)| \le N|x - y|^\delta\|(1 - \Delta)^{\gamma/2}\phi\|_{\mathcal{L}_p}. \tag{2}$$

**Notation.** $\mathcal{S}$ is the Schwartz space. By Definition 12.9.1, $(1 - \Delta)^{\gamma/2}$ is the pseudo-differential operator with symbol $(1 + |\xi|^2)^{\gamma/2}$, that is $(1-\Delta)^{\gamma/2}\phi = F^{-1}\big((1 + |\xi|^2)^{\gamma/2}F\phi\big)$, where $F$ is the Fourier transform. At $p = \infty$ the convention is $d/p = 0$, so $\delta = \gamma$.
