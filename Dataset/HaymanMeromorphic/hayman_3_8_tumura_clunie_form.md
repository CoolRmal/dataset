# W. K. Hayman, *Meromorphic Functions*, Theorem 3.8 (Tumura–Clunie theory)

- **Source:** W. K. Hayman, *Meromorphic Functions*
- **Domain:** Complex analysis
- **Lean declaration:** `Dataset.HaymanMeromorphic.hayman_3_8_tumura_clunie_form` ([hayman_3_8_tumura_clunie_form.lean](hayman_3_8_tumura_clunie_form.lean))
- **Criteria:** [hayman_3_8_tumura_clunie_form.criteria.md](hayman_3_8_tumura_clunie_form.criteria.md)

## Statement

**Theorem 3.8.** Suppose that $f(z)$ is meromorphic and has only a finite number of poles in the plane, and that $f(z)$, $f^{(l)}(z)$ have only a finite number of zeros for some $l \ge 2$. Then

$$f(z) = \frac{P_1(z)}{P_2(z)}e^{P_3(z)},$$

where $P_1$, $P_2$, $P_3$ are polynomials. If, further, $f(z)$ and $f^{(l)}(z)$ have no zeros, then $f(z) = e^{Az+B}$ or $f(z) = (Az+B)^{-n}$.

**Notation.** For a function $f$ meromorphic in $|z| < R_0$, $m(r,a)$, $N(r,a)$ and $T(r,f) = m(r,\infty)+N(r,\infty)$ are Nevanlinna's proximity, counting and characteristic functions; $n(t,a)$ counts the roots of $f(z)=a$ in $|z| \le t$ with multiplicity and $\bar n(t,a)$ counts them without. Correspondingly $\bar N(r,a) = \int_0^r \frac{\bar n(t,a)-\bar n(0,a)}{t}\,dt + \bar n(0,a)\log r$. Assuming $T(r,f)\to\infty$ as $r\to R_0$, one sets $\delta(a) = \varliminf_{r\to R_0} \frac{m(r,a)}{T(r)}$, $\Theta(a) = 1 - \varlimsup_{r\to R_0}\frac{\bar N(r,a)}{T(r)}$ and $\theta(a) = \varliminf_{r\to R_0}\frac{N(r,a)-\bar N(r,a)}{T(r)}$. $f$ is *admissible* in $|z|<R_0$ when $R_0 = +\infty$ and $f$ is not constant, or $R_0<+\infty$ and (2.8) holds; $S(r,f)$ denotes any quantity satisfying the conclusions of Theorem 2.2, so $S(r,f)=o\{T(r,f)\}$.
