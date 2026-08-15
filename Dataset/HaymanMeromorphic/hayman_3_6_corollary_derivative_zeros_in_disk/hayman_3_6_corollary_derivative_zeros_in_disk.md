# W. K. Hayman, *Meromorphic Functions*, Corollary to Theorem 3.6

- **Source:** W. K. Hayman, *Meromorphic Functions*
- **Domain:** Complex analysis
- **Lean declaration:** `Dataset.HaymanMeromorphic.hayman_3_6_corollary_derivative_zeros_in_disk` ([hayman_3_6_corollary_derivative_zeros_in_disk.lean](hayman_3_6_corollary_derivative_zeros_in_disk.lean))
- **Criteria:** [hayman_3_6_corollary_derivative_zeros_in_disk.criteria.md](hayman_3_6_corollary_derivative_zeros_in_disk.criteria.md)
- **Context:** [hayman_3_6_corollary_derivative_zeros_in_disk.context.md](hayman_3_6_corollary_derivative_zeros_in_disk.context.md)

## Statement

**Corollary.** For all sufficiently large $l$, $f^{(l)}(z)$ has zeros in every disk in which $f(z)$ is meromorphic and has at least two distinct poles.

**Notation.** For a function $f$ meromorphic in $|z| < R_0$, $m(r,a)$, $N(r,a)$ and $T(r,f) = m(r,\infty)+N(r,\infty)$ are Nevanlinna's proximity, counting and characteristic functions; $n(t,a)$ counts the roots of $f(z)=a$ in $|z| \le t$ with multiplicity and $\bar n(t,a)$ counts them without. Correspondingly $\bar N(r,a) = \int_0^r \frac{\bar n(t,a)-\bar n(0,a)}{t}\,dt + \bar n(0,a)\log r$. Assuming $T(r,f)\to\infty$ as $r\to R_0$, one sets $\delta(a) = \varliminf_{r\to R_0} \frac{m(r,a)}{T(r)}$, $\Theta(a) = 1 - \varlimsup_{r\to R_0}\frac{\bar N(r,a)}{T(r)}$ and $\theta(a) = \varliminf_{r\to R_0}\frac{N(r,a)-\bar N(r,a)}{T(r)}$. $f$ is *admissible* in $|z|<R_0$ when $R_0 = +\infty$ and $f$ is not constant, or $R_0<+\infty$ and (2.8) holds; $S(r,f)$ denotes any quantity satisfying the conclusions of Theorem 2.2, so $S(r,f)=o\{T(r,f)\}$.
