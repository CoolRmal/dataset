# Context: folland_2_44_approximate_identity

**Statement:** [folland_2_44_approximate_identity.md](folland_2_44_approximate_identity.md) · **Criteria:** [folland_2_44_approximate_identity.criteria.md](folland_2_44_approximate_identity.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Notation

The family $\{\psi_U\}$ is **given**, indexed by a neighbourhood base $\mathcal{U}$ at $1$; the proposition
holds for every such family, so its existence is not part of the conclusion. "$\to 0$ as $U \to \{1\}$"
is a limit along the filter of small neighbourhoods. The exponent splits into cases: for $1 \le p < \infty$
the hypothesis is $f \in L^p$, while for $p = \infty$ it is left uniform continuity of $f$ (right uniform
continuity for the second half). Condition (iii), symmetry of $\psi_U$, is needed only for the second half.
