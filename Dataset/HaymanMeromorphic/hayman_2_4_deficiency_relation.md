# W. K. Hayman, *Meromorphic Functions*, Theorem 2.4 (Nevanlinna's theorem on deficient values)

- **Source:** W. K. Hayman, *Meromorphic Functions*
- **Domain:** Complex analysis
- **Lean declaration:** `Dataset.HaymanMeromorphic.hayman_2_4_deficiency_relation` ([hayman_2_4_deficiency_relation.lean](hayman_2_4_deficiency_relation.lean))
- **Criteria:** [hayman_2_4_deficiency_relation.criteria.md](hayman_2_4_deficiency_relation.criteria.md)
- **Context:** [hayman_2_4_deficiency_relation.context.md](hayman_2_4_deficiency_relation.context.md)

## Statement

**Theorem 2.4.** Suppose that $f(z)$ is admissible in $|z| < R_0$. Then the set of values $a$ for which $\Theta(a) > 0$ is countable, and we have, on summing over all such values $a$

$$\sum_a \{\delta(a)+\theta(a)\} \le \sum_a \Theta(a) \le 2.$$

**Notation.** For a function $f$ meromorphic in $|z| < R_0$, $m(r,a)$, $N(r,a)$ and $T(r,f) = m(r,\infty)+N(r,\infty)$ are Nevanlinna's proximity, counting and characteristic functions; $n(t,a)$ counts the roots of $f(z)=a$ in $|z| \le t$ with multiplicity and $\bar n(t,a)$ counts them without. Correspondingly $\bar N(r,a) = \int_0^r \frac{\bar n(t,a)-\bar n(0,a)}{t}\,dt + \bar n(0,a)\log r$. Assuming $T(r,f)\to\infty$ as $r\to R_0$, one sets $\delta(a) = \varliminf_{r\to R_0} \frac{m(r,a)}{T(r)}$, $\Theta(a) = 1 - \varlimsup_{r\to R_0}\frac{\bar N(r,a)}{T(r)}$ and $\theta(a) = \varliminf_{r\to R_0}\frac{N(r,a)-\bar N(r,a)}{T(r)}$. $f$ is *admissible* in $|z|<R_0$ when $R_0 = +\infty$ and $f$ is not constant, or $R_0<+\infty$ and (2.8) holds; $S(r,f)$ denotes any quantity satisfying the conclusions of Theorem 2.2, so $S(r,f)=o\{T(r,f)\}$.
