# Context: hayman_2_9_polya_composition_order

**Statement:** [hayman_2_9_polya_composition_order.md](hayman_2_9_polya_composition_order.md) · **Criteria:** [hayman_2_9_polya_composition_order.criteria.md](hayman_2_9_polya_composition_order.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Order of growth and composition

**$M(r,f) = \max_{|z|=r}|f(z)|$**, the maximum modulus. By the maximum principle it is also the maximum
over the closed disc $|z| \le r$, which is the more convenient form.

**Finite order** means $\log M(r,f) = O(r^k)$ for some $k$ — equivalently $|f(z)| \le e^{r^k}$ for
$|z| \le r$ and all large $r$. **Zero order** means $\log M(r,f) = O(r^\varepsilon)$ for **every**
$\varepsilon > 0$. Both are asymptotic conditions, for large $r$ only.

**$\phi = g\{f(z)\}$** is $g \circ f$: $f$ inside, $g$ outside. Which function is inner and which outer
is essential — the conclusion assigns the polynomial alternative to the *inner* function $f$ and the
zero-order alternative to the *outer* function $g$.

**The conclusion is a disjunction**, not an exclusive one: either $f$ is a polynomial or $g$ has order
zero (or both).
