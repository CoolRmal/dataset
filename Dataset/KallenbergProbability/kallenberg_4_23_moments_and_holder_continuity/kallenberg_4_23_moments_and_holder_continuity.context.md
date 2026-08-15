# Context: kallenberg_4_23_moments_and_holder_continuity

**Statement:** [kallenberg_4_23_moments_and_holder_continuity.md](kallenberg_4_23_moments_and_holder_continuity.md) · **Criteria:** [kallenberg_4_23_moments_and_holder_continuity.criteria.md](kallenberg_4_23_moments_and_holder_continuity.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Versions, local Hölder continuity, and the $\lesssim$ notation

**$f \lesssim g$** means $f \le cg$ for **some** constant $c < \infty$. In the moment hypothesis the
constant is therefore chosen once, before $s$ and $t$: a per-pair constant would make the hypothesis
empty.

**The hypothesis.** $\mathbb{E}\rho(X_s,X_t)^a \lesssim |s-t|^{d+b}$ for all $s,t \in \mathbb{R}^d$, with
$a,b>0$. The exponent on the right is $d + b$ where $d$ is the *dimension of the index space*; that
matching is what makes the theorem dimension-correct.

**A *version* of $X$** is a process $Y$ with $P\{X_t = Y_t\} = 1$ for each $t$ — a null set per time
point, not one null set for all times. The theorem produces such a $Y$ whose *paths* are Hölder; the
paths of $X$ itself need not be.

**Modulus of continuity and Hölder order.** $w_f(r) = \sup\{\rho'(f_s,f_t) : \rho(s,t) \le r\}$, and $f$
is Hölder of order $p$ when $w_f(r) \lesssim r^p$ as $r \to 0$.

**"Locally"** means the property holds on every **bounded** set, with a constant that may depend on the
set.

**One $Y$ works for every $p \in (0,b/a)$.** The exponent is quantified inside the existential over $Y$,
not outside it.
