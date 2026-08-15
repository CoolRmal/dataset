# Context: hayman_3_8_tumura_clunie_form

**Statement:** [hayman_3_8_tumura_clunie_form.md](hayman_3_8_tumura_clunie_form.md) · **Criteria:** [hayman_3_8_tumura_clunie_form.criteria.md](hayman_3_8_tumura_clunie_form.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Finitely many poles and zeros forces an explicit form

**Nevanlinna's functions.** For $f$ meromorphic in $|z| < R_0$ and a value $a$ (finite or $\infty$):

- $n(t,a)$ counts the roots of $f(z) = a$ in $|z| \le t$ **with multiplicity**;
- $\bar n(t,a)$ counts them **without** multiplicity — each point once, however high its order;
- $N(r,a) = \int_0^r \frac{n(t,a)-n(0,a)}{t}\,dt + n(0,a)\log r$ is the logarithmic counting function,
  and $\bar N(r,a)$ is the same with $\bar n$ in place of $n$;
- $m(r,a)$ is the proximity function, measuring how close $f$ comes to $a$ on $|z| = r$;
- $T(r,f) = m(r,\infty) + N(r,\infty)$ is the **characteristic**, the basic growth measure.

$N$ and $\bar N$ are genuinely different, and the theorems below turn on which one appears: $\bar N$ is
the "ignore multiplicity" version, and $N - \bar N$ measures ramification.

**The three deficiency-type quantities** (defined when $T(r,f) \to \infty$):
$$\delta(a) = \varliminf_{r\to R_0}\frac{m(r,a)}{T(r)}, \qquad
\Theta(a) = 1 - \varlimsup_{r\to R_0}\frac{\bar N(r,a)}{T(r)}, \qquad
\theta(a) = \varliminf_{r\to R_0}\frac{N(r,a)-\bar N(r,a)}{T(r)}.$$
Note $\delta$ and $\theta$ use lower limits and $\Theta$ an upper one; all three lie in $[0,1]$, and all
three vanish for all but countably many $a$.

**Admissible.** $f$ is admissible in $|z| < R_0$ when either $R_0 = +\infty$ and $f$ is non-constant, or
$R_0 < +\infty$ and a growth condition (2.8) holds. In the plane — the case of these problems — being
admissible amounts to $T(r,f) \to \infty$ as $r \to \infty$.

**$S(r,f)$** denotes *any* quantity satisfying the conclusions of Theorem 2.2; all that is used is
$S(r,f) = o\{T(r,f)\}$. It is an error-term placeholder, not a specific function.

**The hypotheses.** $f$ is meromorphic on the whole plane with only finitely many poles, and both $f$
and $f^{(l)}$ have only finitely many zeros, for some $l \ge 2$. The restriction $l \ge 2$ is genuine —
the case $l = 1$ is different.

**First conclusion.** $f(z) = \frac{P_1(z)}{P_2(z)}e^{P_3(z)}$ with $P_1,P_2,P_3$ polynomials. Since $f$
has poles exactly at the zeros of $P_2$, the identity is an identity of functions away from those zeros;
$P_2$ must be a nonzero polynomial for the expression to mean anything.

**Second conclusion.** Under the *stronger* hypothesis that $f$ and $f^{(l)}$ have **no** zeros at all,
$f$ is either $e^{Az+B}$ or $(Az+B)^{-n}$ for some $n \ge 1$. The second shape is a negative power, so
the identity holds away from the zero of $Az+B$.

**Poles.** A pole of $f$ is a point at which $f$ is meromorphic but not analytic; "finitely many poles"
is finiteness of that set.
