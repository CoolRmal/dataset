# Context: grafakos_2_1_6_hardy_littlewood_maximal

**Statement:** [grafakos_2_1_6_hardy_littlewood_maximal.md](grafakos_2_1_6_hardy_littlewood_maximal.md) · **Criteria:** [grafakos_2_1_6_hardy_littlewood_maximal.criteria.md](grafakos_2_1_6_hardy_littlewood_maximal.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Centred and uncentred maximal operators

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

**Two operators.** The *uncentred* maximal function $M f(x)$ is the supremum of the averages
$\frac{1}{|B|}\int_B |f|$ over **all** balls $B$ containing $x$; the *centred* $M^c f(x)$ takes the
supremum only over balls centred at $x$. Always $M^c f \le M f \le 2^n M^c f$, but they are different
operators and the theorem asserts the bounds for both.

**The supremum is over a set that is never empty and may be $+\infty$.** The natural home for a maximal
function is $[0,+\infty]$: it is $+\infty$ at points where $f$ is badly unbounded, and this is not a
defect. The operator is defined for *every* measurable $f$, with no integrability assumption.

**The constants are explicit.** $3^n$ for the weak $(1,1)$ estimate and $3^{n/p}p/(p-1)$ for the strong
$(p,p)$ estimate, for $1 < p < \infty$. They come from the Vitali covering lemma with a factor $3$; a
formalization with an unspecified constant states less.

**The displayed local estimate** $|\{Mf>\alpha\}| \le \frac{3^n}{\alpha}\int_{\{Mf>\alpha\}}|f|$ is
stronger than the weak $(1,1)$ bound, since the integral is only over the level set. Both are asserted
by the theorem.
