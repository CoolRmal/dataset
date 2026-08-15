# W. K. Hayman, *Meromorphic Functions*, Theorem 2.5 (deficient functions)

- **Source:** W. K. Hayman, *Meromorphic Functions*
- **Domain:** Complex analysis
- **Lean declaration:** `Dataset.HaymanMeromorphic.hayman_2_5_deficient_small_functions` ([hayman_2_5_deficient_small_functions.lean](hayman_2_5_deficient_small_functions.lean))
- **Criteria:** [hayman_2_5_deficient_small_functions.criteria.md](hayman_2_5_deficient_small_functions.criteria.md)
- **Context:** [hayman_2_5_deficient_small_functions.context.md](hayman_2_5_deficient_small_functions.context.md)

## Statement

**Theorem 2.5.** If $f(z)$ is meromorphic and admissible in $|z| < R_0$ and $a_1(z)$, $a_2(z)$, $a_3(z)$ are distinct meromorphic functions satisfying for $\nu = 1, 2$, and $3$

$$T\{r, a_\nu(z)\} = o\{T(r,f)\}, \quad \text{as } r \to R_0, \tag{2.10}$$

then

$$\{1+o(1)\}T(r,f) \le \sum_{\nu=1}^{3} \bar N\left(r, \frac{1}{f-a_\nu}\right) + S(r,f), \tag{2.11}$$

as $r \to R_0$, where $S(r,f)$ satisfies the conclusions of Theorem 2.2.

**Notation.** For a function $f$ meromorphic in $|z| < R_0$, $m(r,a)$, $N(r,a)$ and $T(r,f) = m(r,\infty)+N(r,\infty)$ are Nevanlinna's proximity, counting and characteristic functions; $n(t,a)$ counts the roots of $f(z)=a$ in $|z| \le t$ with multiplicity and $\bar n(t,a)$ counts them without. Correspondingly $\bar N(r,a) = \int_0^r \frac{\bar n(t,a)-\bar n(0,a)}{t}\,dt + \bar n(0,a)\log r$. Assuming $T(r,f)\to\infty$ as $r\to R_0$, one sets $\delta(a) = \varliminf_{r\to R_0} \frac{m(r,a)}{T(r)}$, $\Theta(a) = 1 - \varlimsup_{r\to R_0}\frac{\bar N(r,a)}{T(r)}$ and $\theta(a) = \varliminf_{r\to R_0}\frac{N(r,a)-\bar N(r,a)}{T(r)}$. $f$ is *admissible* in $|z|<R_0$ when $R_0 = +\infty$ and $f$ is not constant, or $R_0<+\infty$ and (2.8) holds; $S(r,f)$ denotes any quantity satisfying the conclusions of Theorem 2.2, so $S(r,f)=o\{T(r,f)\}$.
