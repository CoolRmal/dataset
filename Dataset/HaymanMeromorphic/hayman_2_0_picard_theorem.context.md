# Context: hayman_2_0_picard_theorem

**Statement:** [hayman_2_0_picard_theorem.md](hayman_2_0_picard_theorem.md) · **Criteria:** [hayman_2_0_picard_theorem.criteria.md](hayman_2_0_picard_theorem.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Transcendental meromorphic functions and Picard's theorem

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

**Transcendental, for a meromorphic function on the plane, means "not rational".** For an *entire*
function it means "not a polynomial"; for a meromorphic one the corresponding notion is that $f$ is not
a quotient of polynomials. A rational function does take some values only finitely often, so the
hypothesis cannot be dropped.

**"Assumes the value $a$ infinitely often"** means the solution set $\{z : f(z) = a\}$ is infinite. The
theorem does **not** say the exceptional values are omitted — a value may be attained finitely often and
still be exceptional.

**"All values in the plane except at most two"** bounds the number of exceptional values by $2$; it says
nothing about which two, and the bound is sharp ($e^z$ omits $0$ and $\infty$). Hayman writes "in the
plane", so the exceptional set is a set of complex numbers; the sharper statement on the Riemann sphere,
in which $\infty$ also counts as a value, is a strengthening.
