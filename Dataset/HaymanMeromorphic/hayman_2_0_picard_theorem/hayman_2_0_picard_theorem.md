# W. K. Hayman, *Meromorphic Functions*, §2.0 (Picard's theorem)

- **Source:** W. K. Hayman, *Meromorphic Functions*
- **Domain:** Complex analysis
- **Lean declaration:** `Dataset.HaymanMeromorphic.hayman_2_0_picard_theorem` ([hayman_2_0_picard_theorem.lean](hayman_2_0_picard_theorem.lean))
- **Criteria:** [hayman_2_0_picard_theorem.criteria.md](hayman_2_0_picard_theorem.criteria.md)
- **Context:** [hayman_2_0_picard_theorem.context.md](hayman_2_0_picard_theorem.context.md)

## Statement

**§2.0 (Picard's theorem).** *A transcendental meromorphic function assumes infinitely often all values in the plane except at most two.*

Hayman states this in the introduction to Chapter 2 as the special case of the second fundamental theorem that the chapter is built around: "The result contains as a special case Picard's theorem that a transcendental meromorphic function assumes infinitely often all values in the plane except at most two." A meromorphic function on the whole plane is *transcendental* when it is not a rational function, and "assumes the value $a$ infinitely often" means the set $\{z : f(z) = a\}$ is infinite. The exceptional set is therefore a set of at most two complex numbers, and the claim is that every other value is attained at infinitely many points.

**Notation.** For a function $f$ meromorphic in $|z| < R_0$, $m(r,a)$, $N(r,a)$ and $T(r,f) = m(r,\infty)+N(r,\infty)$ are Nevanlinna's proximity, counting and characteristic functions; $n(t,a)$ counts the roots of $f(z)=a$ in $|z| \le t$ with multiplicity and $\bar n(t,a)$ counts them without. Correspondingly $\bar N(r,a) = \int_0^r \frac{\bar n(t,a)-\bar n(0,a)}{t}\,dt + \bar n(0,a)\log r$. Assuming $T(r,f)\to\infty$ as $r\to R_0$, one sets $\delta(a) = \varliminf_{r\to R_0} \frac{m(r,a)}{T(r)}$, $\Theta(a) = 1 - \varlimsup_{r\to R_0}\frac{\bar N(r,a)}{T(r)}$ and $\theta(a) = \varliminf_{r\to R_0}\frac{N(r,a)-\bar N(r,a)}{T(r)}$. $f$ is *admissible* in $|z|<R_0$ when $R_0 = +\infty$ and $f$ is not constant, or $R_0<+\infty$ and (2.8) holds; $S(r,f)$ denotes any quantity satisfying the conclusions of Theorem 2.2, so $S(r,f)=o\{T(r,f)\}$.
