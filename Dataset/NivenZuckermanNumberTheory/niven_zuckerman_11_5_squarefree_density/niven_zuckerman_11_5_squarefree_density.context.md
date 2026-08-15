# Context: niven_zuckerman_11_5_squarefree_density

**Statement:** [niven_zuckerman_11_5_squarefree_density.md](niven_zuckerman_11_5_squarefree_density.md) · **Criteria:** [niven_zuckerman_11_5_squarefree_density.criteria.md](niven_zuckerman_11_5_squarefree_density.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Natural density of the square-free integers

**Two different densities, both in play in this chapter.**

- The **asymptotic (natural) density** of $A \subseteq \mathbb{N}$ is
  $\delta(A) = \lim_{n\to\infty}A(n)/n$, **when the limit exists**; $A(n)$ counts the elements of $A$ in
  $1 \le a \le n$. Asserting $\delta(A) = c$ therefore asserts both that the limit exists and that it
  equals $c$.
- The **Schnirelmann density** is $d(A) = \inf_{n\ge1}A(n)/n$ — an infimum over *all* $n \ge 1$, which
  always exists and is very sensitive to small $n$ (if $1 \notin A$ then $d(A) = 0$).

They are different numbers and different notions; confusing them changes every statement in which they
appear.

**Square-free** means divisible by no perfect square $a^2 > 1$ — equivalently, no prime square divides it.

**The density used is the asymptotic one**, Definition 11.1: $\lim_{n\to\infty}A(n)/n$ where $A(n)$ counts
the members of $A$ with $1 \le a \le n$. Asserting the density is $6/\pi^2$ asserts that this limit
**exists** and equals $6/\pi^2$ — not merely that some subsequence converges or that a limsup is bounded.

**The value** $6/\pi^2 = 1/\zeta(2)$, and the limit is along all of $\mathbb{N}$.
