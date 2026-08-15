# Context: niven_zuckerman_11_mann_alpha_beta_theorem

**Statement:** [niven_zuckerman_11_mann_alpha_beta_theorem.md](niven_zuckerman_11_mann_alpha_beta_theorem.md) · **Criteria:** [niven_zuckerman_11_mann_alpha_beta_theorem.criteria.md](niven_zuckerman_11_mann_alpha_beta_theorem.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Mann's $\alpha\beta$ theorem

**Two different densities, both in play in this chapter.**

- The **asymptotic (natural) density** of $A \subseteq \mathbb{N}$ is
  $\delta(A) = \lim_{n\to\infty}A(n)/n$, **when the limit exists**; $A(n)$ counts the elements of $A$ in
  $1 \le a \le n$. Asserting $\delta(A) = c$ therefore asserts both that the limit exists and that it
  equals $c$.
- The **Schnirelmann density** is $d(A) = \inf_{n\ge1}A(n)/n$ — an infimum over *all* $n \ge 1$, which
  always exists and is very sensitive to small $n$ (if $1 \notin A$ then $d(A) = 0$).

They are different numbers and different notions; confusing them changes every statement in which they
appear.

**The density here is the Schnirelmann density** $d(A) = \inf_{n\ge1}A(n)/n$, for all three of $A$, $B$
and $A+B$ — not the natural density. The infimum is over all $n \ge 1$.

**The sumset** $A+B = \{a+b : a \in A,\ b \in B\}$, under the standing assumption $0 \in A$ and
$0 \in B$ (Definition 11.3), so that $A \subseteq A+B$ and $B \subseteq A+B$.

**The bound** $\gamma \ge \min(1,\alpha+\beta)$ — the minimum with $1$ matters, since a density cannot
exceed $1$. The sumset density is on the **large** side of the inequality.

**No further hypotheses**: the sets need not be infinite, the densities need not be positive, and $A+B$ is
not assumed to be all of $\mathbb{N}$.
