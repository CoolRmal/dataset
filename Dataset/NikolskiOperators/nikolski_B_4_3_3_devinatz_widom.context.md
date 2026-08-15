# Context: nikolski_B_4_3_3_devinatz_widom

**Statement:** [nikolski_B_4_3_3_devinatz_widom.md](nikolski_B_4_3_3_devinatz_widom.md) · **Criteria:** [nikolski_B_4_3_3_devinatz_widom.criteria.md](nikolski_B_4_3_3_devinatz_widom.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Invertibility of a Toeplitz operator with unimodular symbol

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

**Toeplitz operator.** $T_u$ acts on $H^2$ by $f \mapsto P_+(uf)$; its matrix entries depend on $i-j$
(contrast Hankel, where they depend on $i+j$).

**The hypothesis** is $|u| = 1$ **almost everywhere** on $\mathbb{T}$ — a unimodular symbol, not a
continuous or analytic one.

**The four conditions.** (1) $T_u$ is invertible. (2) **Both** $\operatorname{dist}(u,H^\infty) < 1$ and
$\operatorname{dist}(\bar u,H^\infty) < 1$ — dropping either makes the condition strictly weaker. (3) There
is an **outer** $h \in H^\infty$ with $\|u-h\|_\infty < 1$. (4) $u = e^{i(c+a+\tilde b)}$ with $a,b$ real
bounded, $c$ a real constant, and $\|a\|_\infty < \pi/2$ — the bound is on **$a$**, the
un-conjugated function, while $\tilde b$ is the harmonic conjugate of $b$.

**All inequalities are strict**, and all four items are asserted equivalent in one statement.
