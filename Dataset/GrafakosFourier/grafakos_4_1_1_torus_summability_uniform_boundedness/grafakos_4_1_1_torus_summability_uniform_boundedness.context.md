# Context: grafakos_4_1_1_torus_summability_uniform_boundedness

**Statement:** [grafakos_4_1_1_torus_summability_uniform_boundedness.md](grafakos_4_1_1_torus_summability_uniform_boundedness.md) · **Criteria:** [grafakos_4_1_1_torus_summability_uniform_boundedness.criteria.md](grafakos_4_1_1_torus_summability_uniform_boundedness.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Summability methods on the torus and uniform boundedness

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

**The torus and its Fourier analysis.** $\mathbb{T}^n = \mathbb{R}^n/\mathbb{Z}^n$ with normalized
Haar measure; the characters are $e^{2\pi i m\cdot x}$ for $m \in \mathbb{Z}^n$, and
$\widehat f(m) = \int_{\mathbb{T}^n} f(x)e^{-2\pi i m\cdot x}dx$.

**The multipliers $a(m,R)$.** Three conditions: (1) for each $R$ only finitely many $m$ have
$a(m,R) \ne 0$ — this is what makes $S_R(f)$ a *finite* sum and hence well defined for any $f$; (2) a
single bound $M_0$ works for all $m$ and all $R$; (3) for each fixed $m$, $a(m,R) \to a_m$ as
$R \to \infty$. Condition (2) is uniform in both variables, and condition (3) is pointwise in $m$ — the
convergence is not assumed uniform.

**$S_R$ and $A$.** $S_R(f)$ is defined for every $f \in L^p$ because the sum is finite. $A(h)$ is defined
only for $h \in C^\infty$, where $\widehat h(m)$ decays rapidly enough for the series to converge; the
theorem produces a bounded extension $\widetilde A$ to all of $L^p$.

**What is asserted.** An equivalence — $S_R(f)$ converges in $L^p$ for every $f \in L^p$ **iff** the
operator norms $\|S_R\|_{L^p\to L^p}$ are uniformly bounded — and then a "furthermore" clause: the same
bound $K$ controls $A$ on $C^\infty$, $A$ extends to a bounded $\widetilde A$ on $L^p$, and
$S_R(f) \to \widetilde A(f)$ in $L^p$ for every $f$. The constant $K$ is the *same* in all of these.

**"Converges in $L^p$"** means to *some* limit in $L^p$; identifying the limit as $\widetilde A f$ is
part of the conclusion, not of the hypothesis.
