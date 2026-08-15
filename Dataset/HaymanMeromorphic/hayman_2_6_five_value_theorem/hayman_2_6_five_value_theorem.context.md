# Context: hayman_2_6_five_value_theorem

**Statement:** [hayman_2_6_five_value_theorem.md](hayman_2_6_five_value_theorem.md) · **Criteria:** [hayman_2_6_five_value_theorem.criteria.md](hayman_2_6_five_value_theorem.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Sharing values ignoring multiplicity

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

**$E_j(a)$ is a set of points, with no multiplicity data**: $E_j(a) = \{z : f_j(z) = a\}$. The
hypothesis $E_1(a) = E_2(a)$ says the two functions take the value $a$ at exactly the same points — but
possibly to different orders. This is the "ignoring multiplicity" version, which is what makes five
values necessary; with multiplicities the number drops to four.

**Five *distinct* values.** The hypothesis is for five pairwise different $a$; the number is sharp.

**The conclusion is a disjunction**: either $f_1 \equiv f_2$, or **both** are constant. The second
alternative is not vacuous, and it requires both functions to be constant — with $E_1(a) = E_2(a)$ for
five values, one constant function forces the other to be constant too, but that is a conclusion, not
something to be assumed.

**Both functions are meromorphic on the whole plane.**
