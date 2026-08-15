# Context: nikolski_B_1_3_nehari_theorem

**Statement:** [nikolski_B_1_3_nehari_theorem.md](nikolski_B_1_3_nehari_theorem.md) · **Criteria:** [nikolski_B_1_3_nehari_theorem.criteria.md](nikolski_B_1_3_nehari_theorem.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Nehari's theorem: Hankel operators and their symbols

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

**Hankel matrix and Hankel operator.** A Hankel matrix has entries depending only on $i+j$: the form is
$\sum_{i,j} x_i a_{i+j} y_j$. As an operator $H \colon H^2 \to H^2_-$ its matrix in the standard bases is
of this shape.

**Symbol.** $H_\varphi$ is the Hankel operator with symbol $\varphi \in L^\infty(\mathbb{T})$; its matrix
entries are $a_n = \hat\varphi(-n-1)$. The **index shift** is part of the definition and is easy to get
wrong by one.

**What the theorem asserts.** For a **bounded** Hankel operator $H$ there is $\varphi \in L^\infty$ with
$H = H_\varphi$ and $\|H_\varphi\| = \|\varphi\|_\infty = \operatorname{dist}(\varphi,H^\infty)$. Note
that the middle equality says $\varphi$ is a norm-minimal symbol: symbols are unique only modulo
$H^\infty$, and this one is chosen so that its $L^\infty$ norm equals the distance to $H^\infty$.

**All three claims concern one and the same $\varphi$.**

**Boundedness** means one constant bounds all finite sections uniformly; the two norms are infima taken in
$[0,\infty]$, so an unbounded form gets $\infty$ rather than a junk finite value.
