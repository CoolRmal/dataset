# Context: grafakos_3_2_8_poisson_summation

**Statement:** [grafakos_3_2_8_poisson_summation.md](grafakos_3_2_8_poisson_summation.md) · **Criteria:** [grafakos_3_2_8_poisson_summation.criteria.md](grafakos_3_2_8_poisson_summation.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Poisson summation: the lattice, the character, and the two hypotheses

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

**The two hypotheses are independent.** (a) $f$ is continuous with the decay
$|f(x)| \le C(1+|x|)^{-n-\delta}$ for some $C,\delta>0$ — this makes $\sum_k f(x+k)$ converge absolutely
and defines a continuous periodic function. (b) $\widehat f$ restricted to $\mathbb{Z}^n$ is absolutely
summable — this is a hypothesis, not a consequence of (a), and it is what makes the left-hand side
converge. The decay hypothesis in particular gives $f \in L^1$, so $\widehat f$ is a genuine integral.

**$\mathbb{Z}^n$ inside $\mathbb{R}^n$.** Both sums are over the integer lattice: the left over the
frequencies $m \in \mathbb{Z}^n$ at which $\widehat f$ is sampled, the right over the translates by
lattice points $k \in \mathbb{Z}^n$. In a formalization the lattice points have to be transported into
the Euclidean space explicitly.

**The character carries the opposite sign to the transform**: $e^{+2\pi i m\cdot x}$, matching the
inverse transform. Getting the sign wrong replaces $f$ by $f(-\cdot)$.

**The identity holds at every $x$**, not almost everywhere: both sides are continuous. The "in
particular" statement is the case $x = 0$ and is printed as part of the theorem.
