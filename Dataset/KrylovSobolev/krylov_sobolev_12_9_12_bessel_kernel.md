# N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Sobolev Spaces*, Theorem 12.9.12 (the kernel of $(1-\Delta)^{-\gamma/2}$)

- **Source:** N. V. Krylov, *Lectures on Elliptic and Parabolic Equations in Sobolev Spaces*
- **Domain:** Harmonic analysis
- **Lean declaration:** `Dataset.KrylovSobolev.krylov_sobolev_12_9_12_bessel_kernel` ([krylov_sobolev_12_9_12_bessel_kernel.lean](krylov_sobolev_12_9_12_bessel_kernel.lean))
- **Criteria:** [krylov_sobolev_12_9_12_bessel_kernel.criteria.md](krylov_sobolev_12_9_12_bessel_kernel.criteria.md)

## Statement

**Theorem 12.9.12.** If $\gamma > 0$, then for any $\phi \in \mathcal{S}$ we have

$$(1-\Delta)^{-\gamma/2}\phi(x) = \int_{\mathbb{R}^d} G(x-y)\phi(y)\,dy \tag{9}$$

and $G$ is a function depending only on $|x|$. Furthermore, $G \ge 0$ and $\|G\|_{\mathcal{L}_1} = 1$.

**Notation.** $\mathcal{S}$ is the Schwartz space of rapidly decreasing infinitely differentiable functions on $\mathbb{R}^d$. **Definition 12.9.1.** By $(1-\Delta)^{\gamma/2}$ we mean the pseudo-differential operator of order $\gamma$ with symbol $(1+|\xi|^2)^{\gamma/2}$, that is, the operator characterized on $\mathcal{S}$ by

$$F\big((1-\Delta)^{\gamma/2}\phi\big)(\xi) = (1+|\xi|^2)^{\gamma/2}\tilde\phi(\xi),$$

where $F(u)(\xi) = \tilde{u}(\xi) = c_d\int_{\mathbb{R}^d} e^{-i\xi\cdot x}u(x)\,dx$, $c_d = (2\pi)^{-d/2}$, is Krylov's normalization of the Fourier transform.
