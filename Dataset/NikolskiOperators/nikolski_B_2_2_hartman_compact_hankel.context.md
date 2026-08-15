# Context: nikolski_B_2_2_hartman_compact_hankel

**Statement:** [nikolski_B_2_2_hartman_compact_hankel.md](nikolski_B_2_2_hartman_compact_hankel.md) · **Criteria:** [nikolski_B_2_2_hartman_compact_hankel.criteria.md](nikolski_B_2_2_hartman_compact_hankel.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Hartman's theorem: compact Hankel operators

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

**$S_\infty$** denotes the compact operators, so "$H_f \in S_\infty$" is "$H_f$ is compact".

**$H^\infty + C$** is the **algebraic sum**: $\varphi = h + c$ with $h$ the boundary values of a bounded
analytic function and $c$ continuous on $\mathbb{T}$. It is a closed subalgebra of $L^\infty$, and the sum
is not direct.

**The theorem.** For $f \in L^\infty$: $H_f$ is compact **iff** $f \in H^\infty + C$. Equivalently, a
Hankel operator is compact iff it has a **continuous** symbol — because adding an $H^\infty$ function does
not change the operator.

**Compactness via tail blocks.** For a Hankel matrix, compactness is equivalent to the tail blocks having
small norm: for every $\varepsilon>0$ there is $N$ beyond which every finite window contributes at most
$\varepsilon$. Stating it this way avoids needing an operator-theoretic compactness predicate.

**Both directions are asserted.**
