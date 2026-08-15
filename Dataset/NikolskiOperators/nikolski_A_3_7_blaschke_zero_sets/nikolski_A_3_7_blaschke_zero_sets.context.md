# Context: nikolski_A_3_7_blaschke_zero_sets

**Statement:** [nikolski_A_3_7_blaschke_zero_sets.md](nikolski_A_3_7_blaschke_zero_sets.md) · **Criteria:** [nikolski_A_3_7_blaschke_zero_sets.criteria.md](nikolski_A_3_7_blaschke_zero_sets.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## The Blaschke condition and Blaschke products

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

**The Blaschke condition** on a sequence $(\lambda_n)$ in $\mathbb{D}$ is $\sum_n(1-|\lambda_n|) < \infty$.

**Lemma 3.7.1** says the zero sequence of a nonzero $f$ with $\lim_{r\to1}\int_{\mathbb{T}}\log|f_r|\,dm <
\infty$ — in particular of any nonzero $f \in H^p$, $p>0$ — satisfies it. Zeros are **repeated according to
multiplicity**, so the sequence lists each zero as many times as its order, and it lists *all* the zeros.

**Lemma 3.7.3** is the converse construction: from a Blaschke sequence, the product $B = \prod_n b_{\lambda_n}$
of Möbius factors converges locally uniformly on $\mathbb{D}$, satisfies $|B| \le 1$ on $\mathbb{D}$ and
$|B^*| = 1$ a.e. on $\mathbb{T}$, and has **exactly** the $\lambda_n$ as zeros, with multiplicities.

**Together they are a biconditional**: a sequence in $\mathbb{D}$ is the zero sequence (with
multiplicities) of some nonzero $H^p$ function iff it satisfies the Blaschke condition.

**Counting with multiplicity** has to be said explicitly: for each $z$ in the disc, the number of indices
$n$ with $\lambda_n = z$ equals the order of vanishing of $f$ at $z$, and that fibre is finite.
