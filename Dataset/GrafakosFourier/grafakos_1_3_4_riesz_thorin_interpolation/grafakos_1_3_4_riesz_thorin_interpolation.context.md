# Context: grafakos_1_3_4_riesz_thorin_interpolation

**Statement:** [grafakos_1_3_4_riesz_thorin_interpolation.md](grafakos_1_3_4_riesz_thorin_interpolation.md) · **Criteria:** [grafakos_1_3_4_riesz_thorin_interpolation.criteria.md](grafakos_1_3_4_riesz_thorin_interpolation.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Finitely simple functions, complex interpolation, and the geometric mean

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

**"Finitely simple function"** means a simple function taking finitely many values, each on a set of
**finite** measure. This is the natural dense class in $L^p$ for $p < \infty$, and it is where $T$ is
assumed defined — $T$ is not assumed to be defined on all of $L^{p_0}$ or $L^{p_1}$.

**$T$ is linear over $\mathbb{C}$.** Complex linearity, not merely real linearity: the proof runs through
the three-lines lemma on a complex strip, and the theorem is false for merely real-linear $T$ with the
same constants.

**The exponents are mixed reciprocally**: $1/p = (1-\theta)/p_0 + \theta/p_1$, likewise for $q$, with
$0 < \theta < 1$ strictly inside. The endpoints $p_j, q_j = \infty$ are allowed, with $1/\infty = 0$.

**The constant is exactly $M_0^{1-\theta}M_1^{\theta}$** — the geometric mean, with $1-\theta$ on the
$0$-endpoint. No extra factor: unlike Marcinkiewicz, Riesz–Thorin loses nothing.

**The last sentence.** When $p < \infty$, the finitely simple functions are dense in $L^p$, so $T$ has a
unique bounded extension $L^p \to L^q$. That is an additional assertion of the theorem.
