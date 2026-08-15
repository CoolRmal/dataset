# Context: nikolski_B_3_2_nevanlinna_pick_interpolation

**Statement:** [nikolski_B_3_2_nevanlinna_pick_interpolation.md](nikolski_B_3_2_nevanlinna_pick_interpolation.md) · **Criteria:** [nikolski_B_3_2_nevanlinna_pick_interpolation.criteria.md](nikolski_B_3_2_nevanlinna_pick_interpolation.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## The Pick matrix and Nevanlinna–Pick interpolation

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

**The problem.** Given **distinct** nodes $\lambda_1,\dots,\lambda_n$ in $\mathbb{D}$ and values
$w_1,\dots,w_n$, find $f \in H^\infty$ with $f(\lambda_k) = w_k$ and $\|f\|_\infty \le 1$ — a **Schur
function**, i.e. analytic on the disc with modulus at most $1$ there. Distinctness of the nodes is
essential: with repeated nodes the interpolation conditions can be inconsistent and the Pick matrix is not
the right object.

**The Pick matrix** has entries $\dfrac{1-w_i\bar w_j}{1-\lambda_i\bar\lambda_j}$; the denominators are
nonzero exactly because the nodes lie in the open disc.

**Solvability $\iff$ the Pick matrix is positive semidefinite**, expressed as the Hermitian quadratic form
condition $\sum_{i,j}a_i\bar a_j\frac{1-w_i\bar w_j}{1-\lambda_i\bar\lambda_j} \ge 0$ for all complex
$a_i$.

**The uniqueness clause** is conditional on solvability: the solution is unique **iff** the Pick matrix is
degenerate (singular, i.e. rank $< n$). "Unique" means any two solutions agree **on the disc**; two
$H^\infty$ functions equal on the disc are the same element, but a formalization that compares total
functions on $\mathbb{C}$ would be asserting something else.
