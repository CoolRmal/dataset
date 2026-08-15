# Context: hayman_2_4_deficiency_relation

**Statement:** [hayman_2_4_deficiency_relation.md](hayman_2_4_deficiency_relation.md) · **Criteria:** [hayman_2_4_deficiency_relation.criteria.md](hayman_2_4_deficiency_relation.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## The deficiency relation

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

**What the theorem says.** Two assertions. First, $\{a : \Theta(a) > 0\}$ is countable — so the sum that
follows has countably many nonzero terms. Second, the chain
$\sum_a\{\delta(a)+\theta(a)\} \le \sum_a \Theta(a) \le 2$: both inequalities are asserted, and the
right-hand bound $2$ is the famous one (it is what makes Picard's theorem a corollary).

**The sum over an uncountable index.** All three quantities are nonnegative and vanish for all but
countably many $a$, so $\sum_a$ means the supremum of the finite partial sums. A statement that asserts
the bound for every finite subsum is equivalent to the printed one and avoids having to construct the
countable indexing first.

**$a$ ranges over the extended plane**, $\infty$ included; $\Theta(\infty)$ is the deficiency at the
poles.

**Admissibility** in the plane is $T(r,f) \to \infty$, which for a meromorphic function on $\mathbb{C}$ is
the same as $f$ being non-constant.
