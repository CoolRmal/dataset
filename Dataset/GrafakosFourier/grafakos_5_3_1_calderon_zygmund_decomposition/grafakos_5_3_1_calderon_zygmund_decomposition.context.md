# Context: grafakos_5_3_1_calderon_zygmund_decomposition

**Statement:** [grafakos_5_3_1_calderon_zygmund_decomposition.md](grafakos_5_3_1_calderon_zygmund_decomposition.md) · **Criteria:** [grafakos_5_3_1_calderon_zygmund_decomposition.criteria.md](grafakos_5_3_1_calderon_zygmund_decomposition.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## The Calderón–Zygmund decomposition at height $\alpha$

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

**What is produced.** Given $f \in L^1$ and $\alpha>0$: a splitting $f = g + b$ into a "good" part $g$,
bounded by $2^n\alpha$ and no larger than $f$ in $L^1$, and a "bad" part $b$ that decomposes into pieces
$b_j$ each living on its own dyadic cube $Q_j$, each of mean zero, each with
$\|b_j\|_1 \le 2^{n+1}\alpha|Q_j|$, and with the cubes disjoint and of total volume at most
$\alpha^{-1}\|f\|_1$.

**Dyadic cubes.** The cubes $\prod_i [k_i 2^{s}, (k_i+1)2^{s})$ with $s \in \mathbb{Z}$,
$k \in \mathbb{Z}^n$. They are half-open, so distinct dyadic cubes of the same scale are genuinely
disjoint, and any two dyadic cubes are either nested or disjoint. The selected family is *pairwise
disjoint*, which for dyadic cubes is a real restriction (it says no selected cube contains another).

**The family of cubes may be finite or empty.** For $\|f\|_1 \le$ nothing is selected when $f$ is small
relative to $\alpha$; a formalization indexing the cubes by all of $\mathbb{N}$ forces an infinite
family and asserts something false in those cases.

**The mean-zero condition** $\int_{Q_j} b_j = 0$ is over the cube, but since $b_j$ is supported there it
is the same as $\int_{\mathbb{R}^n} b_j = 0$ — provided $b_j$ is genuinely integrable, which has to be
part of the assertion for the condition to carry information.

**The constants $2^n$, $2^{n+1}$ and $\alpha^{-1}$ are explicit** and come from the stopping-time
construction.
