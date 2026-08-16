# Context: kong_1_5_3_differentiable_dependence

**Statement:** [kong_1_5_3_differentiable_dependence.md](kong_1_5_3_differentiable_dependence.md) · **Criteria:** [kong_1_5_3_differentiable_dependence.criteria.md](kong_1_5_3_differentiable_dependence.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Notation

$J$ is the Jacobian in $x$ evaluated **along the solution**, at $(t, x(t;t_0,x_0,\mu))$, not at the initial point. The three variational equations share that coefficient and differ only in their initial value: $0$, the identity matrix, and $-f(t_0,x_0;\mu)$ — the minus sign is not a typo.
