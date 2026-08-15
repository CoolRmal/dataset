# Context: grafakos_2_2_16_hausdorff_young

**Statement:** [grafakos_2_2_16_hausdorff_young.md](grafakos_2_2_16_hausdorff_young.md) · **Criteria:** [grafakos_2_2_16_hausdorff_young.criteria.md](grafakos_2_2_16_hausdorff_young.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## The Fourier transform on $L^p$ and the conjugate exponent

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

**$p'$, the conjugate exponent**, is defined by $1/p + 1/p' = 1$, i.e. $p' = p/(p-1)$. For $p = 1$ this
is $p' = \infty$, and for $p = 2$ it is $p' = 2$. Both endpoints of the range $1 \le p \le 2$ are
included, so the $p=1$ case — where the inequality is $\|\widehat f\|_\infty \le \|f\|_1$ — must be
covered, and the value $\infty$ has to be reachable.

**$\widehat f$ for $f \in L^p$ is not the defining integral.** For $p > 1$ the integral
$\int f(x)e^{-2\pi i x\xi}dx$ need not converge. The transform is defined by continuous extension from
a dense class (Schwartz functions, or $L^1 \cap L^p$): $\widehat f$ is the $L^{p'}$ limit of
$\widehat{f_j}$ for any sequence $f_j$ of Schwartz functions converging to $f$ in $L^p$. A statement
about "$\widehat f$" for $f \in L^p$ therefore has to say which object it means.

**The constant is $1$.** The inequality is $\|\widehat f\|_{p'} \le \|f\|_p$ with no implied constant —
that is the content of Hausdorff–Young at this normalization, obtained by interpolating the trivial
$L^1 \to L^\infty$ bound with the Plancherel equality.

**The range $1 \le p \le 2$ is sharp**: for $p > 2$ the inequality fails, and $\widehat f$ need not even
be a function.
