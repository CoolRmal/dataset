# Context: krylov_2_9_2_bounded_maximum_principle_resolvent

**Statement:** [krylov_2_9_2_bounded_maximum_principle_resolvent.md](krylov_2_9_2_bounded_maximum_principle_resolvent.md) · **Criteria:** [krylov_2_9_2_bounded_maximum_principle_resolvent.criteria.md](krylov_2_9_2_bounded_maximum_principle_resolvent.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Notation

$L$ is the second-order operator $Lu = a^{ij}D_{ij}u + b^iD_iu + cu$ with summation over repeated indices. Under Sec. 2.9's standing assumptions the matrix $a(x) = (a^{ij}(x))$ is symmetric and nonnegative definite at every point — degenerate ellipticity only. No uniform ellipticity is required, and reading "elliptic" here as "uniformly elliptic" narrows the theorem: the operator may degenerate, and $a$ may even vanish identically. Boundedness is asked of $a$ and $b$ only; $c$ is constrained solely from above by $c(x) \le -\lambda$ and may be unbounded below.

$t^- = \max(-t,0)$ is the **nonnegative** negative part. The hypothesis is $c(x) \le -\lambda$ with $\lambda>0$ strictly — $c\le0$ does not suffice. The boundary condition is conditional on $\partial\Omega \ne \emptyset$, so $\Omega=\mathbb{R}^d$ is admitted. Note that $u$ is bounded and continuous on the closure $\bar\Omega$, not merely on $\Omega$: continuity up to the boundary is what ties the zero boundary values to the behaviour of $u$ inside, and the estimates fail without it.
