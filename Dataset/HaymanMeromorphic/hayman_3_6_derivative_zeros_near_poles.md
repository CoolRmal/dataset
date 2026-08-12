# W. K. Hayman, *Meromorphic Functions*, Theorem 3.6 (derivatives near the poles of $f$)

- **Source:** W. K. Hayman, *Meromorphic Functions*
- **Domain:** Complex analysis
- **Lean declaration:** `Dataset.HaymanMeromorphic.hayman_3_6_derivative_zeros_near_poles` ([hayman_3_6_derivative_zeros_near_poles.lean](hayman_3_6_derivative_zeros_near_poles.lean))
- **Criteria:** [hayman_3_6_derivative_zeros_near_poles.criteria.md](hayman_3_6_derivative_zeros_near_poles.criteria.md)

## Statement

**Theorem 3.6.** Suppose that $f(z)$ is meromorphic in $|z-z_0| < R$, where $0 < R \le \infty$, and has at least two distinct poles there. Let $r$ be the radius of the largest circle with centre $z_0$ containing no pole of $f(z)$ in its interior. Then

(i) if the circle $|z-z_0| = r$ contains at least two distinct poles of $f(z)$, then for every positive $\delta$, the equation $f^{(l)}(z) = 0$ has roots in $|z-z_0| < \delta$, when $l$ is sufficiently large;

(ii) if the circle $|z-z_0| = r$ contains only one pole of $f(z)$, then if $\delta$ is sufficiently small, $f^{(l)}(z) \to \infty$ as $l \to \infty$ uniformly in $|z-z_0| \le \delta$.

**Notation.** For a function $f$ meromorphic in $|z| < R_0$, $m(r,a)$, $N(r,a)$ and $T(r,f) = m(r,\infty)+N(r,\infty)$ are Nevanlinna's proximity, counting and characteristic functions; $n(t,a)$ counts the roots of $f(z)=a$ in $|z| \le t$ with multiplicity and $\bar n(t,a)$ counts them without. Correspondingly $\bar N(r,a) = \int_0^r \frac{\bar n(t,a)-\bar n(0,a)}{t}\,dt + \bar n(0,a)\log r$. Assuming $T(r,f)\to\infty$ as $r\to R_0$, one sets $\delta(a) = \varliminf_{r\to R_0} \frac{m(r,a)}{T(r)}$, $\Theta(a) = 1 - \varlimsup_{r\to R_0}\frac{\bar N(r,a)}{T(r)}$ and $\theta(a) = \varliminf_{r\to R_0}\frac{N(r,a)-\bar N(r,a)}{T(r)}$. $f$ is *admissible* in $|z|<R_0$ when $R_0 = +\infty$ and $f$ is not constant, or $R_0<+\infty$ and (2.8) holds; $S(r,f)$ denotes any quantity satisfying the conclusions of Theorem 2.2, so $S(r,f)=o\{T(r,f)\}$.
