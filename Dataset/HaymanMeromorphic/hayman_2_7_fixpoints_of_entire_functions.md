# W. K. Hayman, *Meromorphic Functions*, Theorem 2.7 (Baker's theorem on fix-points)

- **Source:** W. K. Hayman, *Meromorphic Functions*
- **Domain:** Complex analysis
- **Lean declaration:** `Dataset.HaymanMeromorphic.hayman_2_7_fixpoints_of_entire_functions` ([hayman_2_7_fixpoints_of_entire_functions.lean](hayman_2_7_fixpoints_of_entire_functions.lean))
- **Criteria:** [hayman_2_7_fixpoints_of_entire_functions.criteria.md](hayman_2_7_fixpoints_of_entire_functions.criteria.md)

## Statement

**Theorem 2.7.** If $f(z)$ is a transcendental integral function then $f(z)$ possesses infinitely many fix-points of exact order $n$, except for at most one value of $n$.

**Notation.** Let $f(z)$ be an integral function. Set $f_1(z) = f(z)$ and inductively $f_{\nu+1}(z) = f\{f_\nu(z)\}$ for $\nu \ge 1$. The solutions of the equation $f_\nu(z) = z$ are called *fix-points of $f(z)$ of order $\nu$*. If $\zeta$ is a fix-point of $f(z)$ of order $\nu$, but of no lower order, then $\zeta$ is called a fix-point of *exact order* $\nu$. An *integral function* is an entire function, and it is *transcendental* when it is not a polynomial.
