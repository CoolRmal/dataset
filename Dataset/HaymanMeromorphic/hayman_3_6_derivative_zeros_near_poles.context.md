# Context: hayman_3_6_derivative_zeros_near_poles

**Statement:** [hayman_3_6_derivative_zeros_near_poles.md](hayman_3_6_derivative_zeros_near_poles.md) · **Criteria:** [hayman_3_6_derivative_zeros_near_poles.criteria.md](hayman_3_6_derivative_zeros_near_poles.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## The largest pole-free circle and the two cases

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

**The setting.** $f$ is meromorphic in $|z-z_0| < R$ with at least two distinct poles there, and $r$ is
the radius of the **largest** circle centred at $z_0$ whose interior contains no pole. Maximality is
what makes the two cases exhaustive: by definition there is at least one pole on $|z-z_0| = r$.

**Case (i): at least two distinct poles on that circle.** Then for every $\delta > 0$, the equation
$f^{(l)}(z) = 0$ has roots in $|z-z_0| < \delta$ once $l$ is large enough — the zeros of the high
derivatives accumulate at the **centre**. Note the order: $\delta$ first, then "for all large $l$".

**Case (ii): exactly one pole on that circle.** Then for all sufficiently small $\delta$,
$f^{(l)}(z) \to \infty$ as $l \to \infty$ **uniformly** on the closed disc $|z-z_0| \le \delta$. Uniform
divergence means the *infimum* of $|f^{(l)}|$ over that disc tends to $\infty$, not merely that each
point diverges.

**Both cases are asserted**, as two implications with different triggers.
