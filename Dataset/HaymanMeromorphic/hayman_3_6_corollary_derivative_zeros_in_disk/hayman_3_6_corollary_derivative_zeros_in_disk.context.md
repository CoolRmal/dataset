# Context: hayman_3_6_corollary_derivative_zeros_in_disk

**Statement:** [hayman_3_6_corollary_derivative_zeros_in_disk.md](hayman_3_6_corollary_derivative_zeros_in_disk.md) · **Criteria:** [hayman_3_6_corollary_derivative_zeros_in_disk.criteria.md](hayman_3_6_corollary_derivative_zeros_in_disk.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## The order of the quantifiers in the corollary

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

**"For all sufficiently large $l$"** comes **first**, before the function and the disc: there is a
threshold $l_0$, depending on nothing, such that for every $l \ge l_0$ the conclusion holds for *every*
$f$ and *every* disc satisfying the hypotheses. Moving the quantifier over $l$ inside — a threshold
depending on $f$ — is a strictly weaker statement and is not what "for all sufficiently large $l$, …
in every disk" says.

**The hypotheses on the disc.** $f$ is meromorphic at every point of the open disc $|z - z_0| < R$, and
has at least two **distinct** poles there. A pole is a point at which $f$ is meromorphic but not
analytic.

**The conclusion** is the existence of a zero of $f^{(l)}$ *inside that same disc*.
