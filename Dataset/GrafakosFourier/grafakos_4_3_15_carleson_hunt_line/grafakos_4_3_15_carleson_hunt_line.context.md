# Context: grafakos_4_3_15_carleson_hunt_line

**Statement:** [grafakos_4_3_15_carleson_hunt_line.md](grafakos_4_3_15_carleson_hunt_line.md) · **Criteria:** [grafakos_4_3_15_carleson_hunt_line.criteria.md](grafakos_4_3_15_carleson_hunt_line.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## The Carleson maximal operator

**Grafakos's normalization of the Fourier transform.**
$\widehat f(\xi) = \int_{\mathbb{R}^n} f(x)\,e^{-2\pi i x\cdot\xi}\,dx$, with the $2\pi$ in the
exponent and **no** prefactor. The inverse transform is $f^{\vee}(x) = \int f(\xi)e^{+2\pi i x\cdot\xi}d\xi$,
differing only in the sign of the exponent. With this normalization the transform is an isometry of
$L^2$ on the nose, inversion has no constant, and $\widehat{f}$ of a Schwartz function is Schwartz.
Other books put $e^{-ix\xi}$ with a $(2\pi)^{-n/2}$ prefactor; every constant in this chapter depends on
the choice, so a formalization must use Grafakos's.

**Weak $L^p$.** $\|F\|_{L^{p,\infty}} = \sup_{\alpha>0}\alpha\,\nu(\{|F|>\alpha\})^{1/p}$; the weak-type
bound $\|Tf\|_{L^{p,\infty}} \le A\|f\|_{L^p}$ is the same as
$\nu(\{|Tf|>\alpha\}) \le (A\|f\|_{L^p}/\alpha)^p$ for every $\alpha>0$. It is strictly weaker than the
strong-type bound.

**$\mathcal{C}^{**}$ is a maximal operator, not a limit.** It is the supremum over the truncation
parameter $R>0$ of the modulus of the partial Fourier integral
$\int_{|\xi|\le R}\widehat f(\xi)e^{2\pi i x\xi}d\xi$. The theorem bounds this supremum in $L^p$; the
almost-everywhere convergence of the partial integrals is a *consequence* of the bound, not the
statement.

**The truncation window is symmetric**, $\{|\xi| \le R\}$, and the reconstruction character has the
$+2\pi i$ sign of the inverse transform.

**The test class.** $C_0^\infty(\mathbb{R})$ — smooth compactly supported functions — on which
$\widehat f$ is Schwartz and every integral converges. The theorem asserts nothing beyond the
inequality on this class: no extension of $\mathcal{C}^{**}$ to $L^p$ and no convergence statement.

**The constant depends on $p$ only** and is chosen after $p$; it is finite but unspecified. The range is
$1 < p < \infty$, both endpoints excluded — the result is false at $p = 1$.
