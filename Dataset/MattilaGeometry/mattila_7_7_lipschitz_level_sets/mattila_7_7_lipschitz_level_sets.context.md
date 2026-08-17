# Context: mattila_7_7_lipschitz_level_sets

**Statement:** [mattila_7_7_lipschitz_level_sets.md](mattila_7_7_lipschitz_level_sets.md) · **Criteria:** [mattila_7_7_lipschitz_level_sets.criteria.md](mattila_7_7_lipschitz_level_sets.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Notation

$\int^{*}$ is the **upper** integral, used because the slice function is not known to be measurable — no measurability is assumed anywhere. $f$ is Lipschitz **on $A$**. $\alpha(m)$ is the explicit constant $\mathcal{L}^m(B^m(0,1))$, the Lebesgue measure of the unit ball of $\mathbb{R}^m$: it depends only on $m$, not on $n$, and the theorem asserts the bound with this particular constant, not merely that *some* constant works. (Whether the unit ball is taken open or closed does not matter, since the boundary sphere has Lebesgue measure zero.) The exponent range $m \le s \le n$ is inclusive at both endpoints; reading it as strict drops cases the book relies on — the endpoint $s = m$, where $\mathcal{H}^{0}$ counts the points of each slice, is the case used for Lemma 18.4.
