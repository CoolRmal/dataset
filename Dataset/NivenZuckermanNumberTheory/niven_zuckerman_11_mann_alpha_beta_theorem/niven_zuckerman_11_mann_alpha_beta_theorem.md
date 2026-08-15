# I. Niven and H. S. Zuckerman, *An Introduction to the Theory of Numbers*, Third Edition, §11.4, the $\alpha\beta$ theorem of H. B. Mann

- **Source:** I. Niven and H. S. Zuckerman, *An Introduction to the Theory of Numbers*, Third Edition
- **Domain:** Number theory
- **Lean declaration:** `Dataset.NivenZuckermanNumberTheory.niven_zuckerman_11_mann_alpha_beta_theorem` ([niven_zuckerman_11_mann_alpha_beta_theorem.lean](niven_zuckerman_11_mann_alpha_beta_theorem.lean))
- **Criteria:** [niven_zuckerman_11_mann_alpha_beta_theorem.criteria.md](niven_zuckerman_11_mann_alpha_beta_theorem.criteria.md)
- **Context:** [niven_zuckerman_11_mann_alpha_beta_theorem.context.md](niven_zuckerman_11_mann_alpha_beta_theorem.context.md)

## Statement

**The $\alpha\beta$ theorem of H. B. Mann.** If $A$ and $B$ are sets of non-negative integers, each containing $0$, and if $\alpha$, $\beta$, $\gamma$ are the Schnirelmann densities of $A$, $B$, $A+B$, then

$$\gamma \ge \min(1, \alpha+\beta).$$

In other words $\gamma \ge \alpha + \beta$ unless $\alpha + \beta \ge 1$, in which case $\gamma = 1$.

**Notation.** **Definition 11.1.** If $A$ is a set of positive integers and $A(n)$ denotes the number of elements of $A$ not exceeding $n$, the *asymptotic* (or natural) density of $A$ is $\delta(A) = \lim_{n\to\infty} A(n)/n$ when the limit exists. **Definition 11.2.** The *Schnirelmann density* $d(A)$ of a set $A$ of non-negative integers is $d(A) = \inf_{n\ge1} A(n)/n$. **Definition 11.3.** Assume $0 \in A$ and $0 \in B$. The sum $A + B$ is the collection of all integers of the form $a + b$ where $a \in A$ and $b \in B$.
