# Context: hayman_2_5_deficient_small_functions

**Statement:** [hayman_2_5_deficient_small_functions.md](hayman_2_5_deficient_small_functions.md) · **Criteria:** [hayman_2_5_deficient_small_functions.criteria.md](hayman_2_5_deficient_small_functions.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Three small meromorphic target functions

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

**The $a_\nu$ are *functions*, not constants.** Theorem 2.5 replaces the three fixed values of the
second fundamental theorem by three meromorphic functions that grow more slowly than $f$. They must be
pairwise distinct as functions.

**Condition (2.10), $T(r,a_\nu) = o\{T(r,f)\}$**, is what "small" means: the ratio of characteristics
tends to $0$. It is a hypothesis on each of the three.

**$\bar N\bigl(r, \frac1{f-a_\nu}\bigr)$** is the reduced counting function of the **zeros** of
$f - a_\nu$ — that is what the reciprocal notation means: the $a_\nu$-points of $f$, counted without
multiplicity.

**$\{1+o(1)\}T(r,f)$ and $S(r,f)$.** Both are error terms of size $o\{T(r,f)\}$. The clean way to read
(2.11) is: for every $\varepsilon > 0$, for all sufficiently large $r$,
$(1-\varepsilon)T(r,f) \le \sum_\nu \bar N(r, 1/(f-a_\nu)) + \varepsilon T(r,f)$.

**The statement is asymptotic**: it holds for all large $r$, not for every $r$.
