# Context: grafakos_5_6_6_vector_valued_maximal

**Statement:** [grafakos_5_6_6_vector_valued_maximal.md](grafakos_5_6_6_vector_valued_maximal.md) · **Criteria:** [grafakos_5_6_6_vector_valued_maximal.criteria.md](grafakos_5_6_6_vector_valued_maximal.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## The Fefferman–Stein vector-valued maximal inequalities

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

**The order of the two norms.** For a sequence $(f_j)$ one first forms, **pointwise in $x$**, the
$\ell^r$ norm $\bigl(\sum_j |f_j(x)|^r\bigr)^{1/r}$, and then takes the $L^1$ or $L^p$ norm of the
resulting function of $x$. Interchanging the two norms gives a different (and false) statement.

**$M$ acts on each $f_j$ separately**, and the $\ell^r$ norm is then formed from the numbers $Mf_j(x)$.

**The two inequalities.** The first is a weak $(1,1)$ bound, with the $L^{1,\infty}$ norm on the left and
the $L^1$ norm on the right, and an explicit constant $C_n(1 + (r-1)^{-1})$ that blows up as
$r \downarrow 1$. The second is a strong $(p,p)$ bound with constant $C_n\,c(p,r)$, where **$c(p,r)$ is
left unspecified by the text** — it depends only on $p$ and $r$. Pinning it to a particular closed
formula asserts an unproved sharper result.

**$C_n$ depends only on the dimension.** It is chosen before $p$ and $r$; if it were allowed to depend on
$r$ then the displayed $r$-dependence of the weak constant would be decorative.

**No hypotheses on the $f_j$** beyond measurability: no summability, no integrability. Both sides may be
$+\infty$, and the inequalities hold in $[0,+\infty]$.

**Exponent ranges** $1 < p < \infty$ and $1 < r < \infty$, both open.
