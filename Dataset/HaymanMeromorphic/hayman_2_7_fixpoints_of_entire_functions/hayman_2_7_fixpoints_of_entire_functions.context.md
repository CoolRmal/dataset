# Context: hayman_2_7_fixpoints_of_entire_functions

**Statement:** [hayman_2_7_fixpoints_of_entire_functions.md](hayman_2_7_fixpoints_of_entire_functions.md) · **Criteria:** [hayman_2_7_fixpoints_of_entire_functions.criteria.md](hayman_2_7_fixpoints_of_entire_functions.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Iterates, fix-points, and exact order

**Integral function** is Hayman's term for an **entire** function — holomorphic on all of $\mathbb{C}$.
It is *transcendental* when it is not a polynomial.

**Iterates.** $f_1 = f$ and $f_{\nu+1} = f \circ f_\nu$ — the new copy of $f$ is applied on the
**outside**. (For iterates of a single function the two orders agree, but the recursion as printed is
the outer one.)

**Fix-point of order $\nu$** is a solution of $f_\nu(z) = z$. **Exact order $\nu$** additionally requires
$f_m(z) \ne z$ for every $m$ with $1 \le m < \nu$: the point is genuinely periodic with least period
$\nu$, not a fix-point of some earlier iterate. Dropping the "exact" clause changes the theorem
completely, since every fix-point of order $1$ is a fix-point of every order.

**What is asserted.** For all but at most one $n \ge 1$, there are infinitely many fix-points of exact
order $n$. The exceptional set of orders is a set of natural numbers with at most one element, and only
orders $n \ge 1$ are considered.
