# Context: nikolski_A_5_4_helson_szego

**Statement:** [nikolski_A_5_4_helson_szego.md](nikolski_A_5_4_helson_szego.md) · **Criteria:** [nikolski_A_5_4_helson_szego.criteria.md](nikolski_A_5_4_helson_szego.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## The Helson–Szegő theorem: five equivalent conditions

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

**$\mu$ is a finite Borel measure on $\mathbb{T}$**, and the five conditions characterise when it is a
"good" weight for Fourier analysis.

**Item (1): $(z^n)_{n\in\mathbb{Z}}$ is a basis of $L^2(\mu)$.** This means two things: two-sided norm
bounds $A\sum|c_k|^2 \le \|\sum c_kz^k\|^2_{L^2(\mu)} \le B\sum|c_k|^2$ on finitely supported coefficient
sequences, **and** completeness of the system. Both halves are needed.

**Item (2): the Riesz projection $P_+$** — the projection onto the nonnegative frequencies, **including
$k=0$** — is bounded on $L^2(\mu)$.

**Item (3): $\sin(\mathrm{Pol}_+,\mathrm{Pol}_-) > 0$** is an angle condition between the analytic and
anti-analytic polynomials: there is $\delta > 0$ with $\delta\|p\| \le \|p+q\|$ for all $p \in
\mathrm{Pol}_+$, $q \in \mathrm{Pol}_-$.

**Item (4)** writes $d\mu = |h|^2dm$ with $h \in H^2$ **outer** and
$\operatorname{dist}(\bar h/h, H^\infty) < 1$ — the strict inequality is essential.

**Item (5), condition (HS)**: $d\mu = w\,dm$ with $w = e^{u+\tilde v}$, $u,v$ real bounded, and
$\|v\|_\infty < \pi/2$. Here $\tilde v$ is the **harmonic conjugate** of $v$, and the bound $\pi/2$ is
attached to $v$, the function being conjugated — not to $u$ and not to $\tilde v$.

**All five are asserted equivalent** in one statement.
