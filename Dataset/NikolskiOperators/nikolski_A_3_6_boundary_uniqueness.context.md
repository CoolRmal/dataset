# Context: nikolski_A_3_6_boundary_uniqueness

**Statement:** [nikolski_A_3_6_boundary_uniqueness.md](nikolski_A_3_6_boundary_uniqueness.md) · **Criteria:** [nikolski_A_3_6_boundary_uniqueness.criteria.md](nikolski_A_3_6_boundary_uniqueness.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Boundary uniqueness for Hardy functions

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

**The corollary has two parts.** First: if $g \in H^1$ and $g \ne 0$ then $\log|g^*| \in L^1(\mathbb{T})$ —
in particular $\log|g^*| > -\infty$ almost everywhere, so $g^*$ cannot vanish on a set of positive measure.
Second, the consequence: if $g \in H^1$ and $m\{t : g^*(t) = 0\} > 0$ then $g \equiv 0$.

**"$g = 0$" means identically zero on the disc**, not merely a.e. on the circle — though for Hardy
functions the two are equivalent, which is precisely the content.

**The vanishing hypothesis is about the boundary values**, holds on a set of **positive measure** (not
full measure, not everywhere), and is an almost-everywhere statement on that set.
