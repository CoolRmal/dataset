# Context: nikolski_A_1_3_beurling_invariant_subspaces

**Statement:** [nikolski_A_1_3_beurling_invariant_subspaces.md](nikolski_A_1_3_beurling_invariant_subspaces.md) · **Criteria:** [nikolski_A_1_3_beurling_invariant_subspaces.criteria.md](nikolski_A_1_3_beurling_invariant_subspaces.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Beurling's theorem: shift-invariant subspaces of $L^2(\mathbb{T})$

**Hardy spaces, in two guises.** $H^p(\mathbb{D})$ is the space of functions holomorphic on the open unit
disc with $\sup_{r<1}\int_{\mathbb{T}}|f_r|^p\,dm < \infty$, where $f_r(t) = f(re^{it})$ and $m$ is
normalized Lebesgue measure on the circle. Every such $f$ has **radial boundary values**
$f^*(t) = \lim_{r\to1}f(re^{it})$ for almost every $t$, and $f \mapsto f^*$ identifies $H^p(\mathbb{D})$
with the closed subspace of $L^p(\mathbb{T})$ of functions whose negative Fourier coefficients vanish. Both
pictures are used, and a statement has to say which one it means — an equality "on the disc" and an
equality "almost everywhere on the circle" are different assertions.

**$H^2_-$** is the orthogonal complement of $H^2$ in $L^2(\mathbb{T})$: the closed span of $z^{-n}$,
$n \ge 1$.

**Inner and outer.** $\theta \in H^\infty$ is **inner** when $|\theta^*| = 1$ almost everywhere on
$\mathbb{T}$. $f \in H^2$ is **outer** when the smallest closed shift-invariant subspace containing it is
all of $H^2$; equivalently $\log|f^*|$ is the Poisson integral of $\log|f|$. "Outer" is not "non-vanishing"
and is not "no inner factor other than a constant" as a formal definition, though those are consequences.

**$\tilde v$** denotes the harmonic **conjugate** of $v$ (the Hilbert transform on the circle), not a
complex conjugate. This is a notational trap: $\bar h$ is complex conjugation, $\tilde v$ is conjugation in
the harmonic-analysis sense.

**$\operatorname{dist}(\varphi,H^\infty)$** is the $L^\infty$ distance from $\varphi$ to the bounded
analytic functions — an infimum over a set of functions, taken in $[0,\infty]$ so that a degenerate case
does not silently become $0$.

**The setting.** $E \subseteq L^2(\mathbb{T})$ is a **closed linear subspace** with $zE \subseteq E$ and
$zE \ne E$ — invariant under multiplication by $z = e^{it}$, and *properly* so. Closedness is essential and
so is the strictness of the inclusion: for $zE = E$ the conclusion is false (those are the
doubly-invariant subspaces, which are $\chi_S L^2$ for measurable $S$).

**The conclusion.** There is a **unimodular** measurable $\Theta$ ($|\Theta| = 1$ a.e. on $\mathbb{T}$)
with $E = \Theta H^2$ — an exact equality of subspaces of $L^2$, not an inclusion and not a closure.

**Uniqueness up to a unimodular constant.** Any other unimodular $\eta$ with $E = \eta H^2$ satisfies
$\eta = c\Theta$ a.e. for some constant $c$ with $|c| = 1$. The constant is a single number, not a
function.

**Everything is up to almost-everywhere equality**, since the members of $L^2$ are equivalence classes.
