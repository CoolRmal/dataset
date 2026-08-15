# Context: hayman_3_4_derivative_deficiency_bound

**Statement:** [hayman_3_4_derivative_deficiency_bound.md](hayman_3_4_derivative_deficiency_bound.md) · **Criteria:** [hayman_3_4_derivative_deficiency_bound.criteria.md](hayman_3_4_derivative_deficiency_bound.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Deficiencies of a derivative

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

**$\psi = f^{(l)}$**, the $l$-th derivative of a transcendental meromorphic $f$ in the plane, with
$l \ge 1$.

**$\Theta(a,\psi)$** is Nevanlinna's $\Theta$ computed for $\psi$: $1 - \varlimsup \bar N(r,a)/T(r,\psi)$.
The reduced counting function is the one that appears.

**The sum excludes $a = \infty$.** The bound $\sum_{a\ne\infty}\Theta(a,\psi) \le 1 + \frac1{l+1}$ is
over *finite* values only, and is strictly better than the bound $2$ of Theorem 2.4 — that improvement
is the content. It depends on $l$ and tends to $1$ as $l \to \infty$.

**The "in particular" clause** is a separate assertion: $\psi$ takes every finite value infinitely often
with at most one exception. It follows from the bound (since a value taken finitely often has
$\Theta = 1$, and two such would give $2 > 1 + \frac1{l+1}$), but it is printed as part of the theorem.

**Transcendental** for a meromorphic function on the plane means not rational.
