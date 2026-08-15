# Context: grafakos_1_3_2_marcinkiewicz_interpolation

**Statement:** [grafakos_1_3_2_marcinkiewicz_interpolation.md](grafakos_1_3_2_marcinkiewicz_interpolation.md) · **Criteria:** [grafakos_1_3_2_marcinkiewicz_interpolation.criteria.md](grafakos_1_3_2_marcinkiewicz_interpolation.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Sublinear operators, weak type, and the explicit constant

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

**"Defined on $L^{p_0} + L^{p_1}$"** means $T$ accepts every function that splits as a sum of a
$L^{p_0}$ and a $L^{p_1}$ function — a class that contains both $L^{p_0}$ and $L^{p_1}$ and every
$L^p$ in between. $T$ takes values in the *measurable* functions on $Y$: measurability of the output is
an assumption on $T$, not a consequence.

**Sublinear** means $|T(f+g)| \le |Tf| + |Tg|$ pointwise and $|T(cf)| = |c||Tf|$; $T$ need not be
linear, which is what makes the theorem applicable to maximal operators.

**The hypotheses are weak-type; the conclusion is strong-type.** That gain is the point of
Marcinkiewicz interpolation, and is what distinguishes it from Riesz–Thorin, where the endpoint
hypotheses are already strong-type.

**The exponent range.** $0 < p_0 < p_1 \le \infty$ — sub-unit exponents are allowed at the bottom, and
$p_1 = \infty$ at the top, and the conclusion is for $p_0 < p < p_1$.

**The constant is explicit** and depends only on $p, p_0, p_1, A_0, A_1$ through the printed formula. It
is not an unspecified $C$: a formalization that existentially quantifies the constant states a
materially weaker theorem.
