# Context: nikolski_B_7_2_1_adamyan_arov_krein

**Statement:** [nikolski_B_7_2_1_adamyan_arov_krein.md](nikolski_B_7_2_1_adamyan_arov_krein.md) · **Criteria:** [nikolski_B_7_2_1_adamyan_arov_krein.criteria.md](nikolski_B_7_2_1_adamyan_arov_krein.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## The AAK theorem: four equal quantities

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

**$s_n(H_\varphi)$**, the $n$-th singular (approximation) number: the distance from $H_\varphi$, in
operator norm, to the operators of rank at most $n$. "Rank at most $n$" is naturally expressed as
factoring through an $n$-dimensional space.

**The four quantities asserted equal:**

1. $s_n(H_\varphi)$ — distance to **arbitrary** operators of rank $\le n$;
2. $\min\{\|H_\varphi - H_\psi\| : \operatorname{rank}H_\psi \le n\}$ — distance to **Hankel** operators of
   rank $\le n$. That this is the same number is the surprising part;
3. $\operatorname{dist}_{L^\infty}(\varphi, R_n + H^\infty)$, where $R_n$ is the set of rational functions
   vanishing at $\infty$ (numerator degree strictly less than denominator degree) with all poles in
   $\mathbb{D}$ and total multiplicity $\le n$ — and $R_n$ **contains the zero function**, so degree $0$
   is admitted;
4. $\min\{\|H_{\bar B\varphi}\| : B$ a finite Blaschke product of degree $\le n\}$, where the degree of a
   finite Blaschke product is its number of zeros with multiplicity.

**All four live in $[0,\infty]$**, so that a degenerate case does not silently collapse to $0$, and all
four are asserted **equal** — three chained equalities.
