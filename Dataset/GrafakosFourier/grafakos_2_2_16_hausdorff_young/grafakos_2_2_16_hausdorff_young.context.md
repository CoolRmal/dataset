# Context: grafakos_2_2_16_hausdorff_young

**Statement:** [grafakos_2_2_16_hausdorff_young.md](grafakos_2_2_16_hausdorff_young.md) · **Criteria:** [grafakos_2_2_16_hausdorff_young.criteria.md](grafakos_2_2_16_hausdorff_young.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Notation

Grafakos normalises $\widehat f(\xi)=\int f(x)e^{-2\pi i x\cdot\xi}dx$, with the $2\pi$ in the exponent and no prefactor; every constant below depends on that choice.

$p'=p/(p-1)$, with $p'=\infty$ at $p=1$; both endpoints of $1\le p\le2$ are included. For $p>1$ the defining integral need not converge, so $\widehat f$ means the extension from a dense class. The inequality has **no** constant.
