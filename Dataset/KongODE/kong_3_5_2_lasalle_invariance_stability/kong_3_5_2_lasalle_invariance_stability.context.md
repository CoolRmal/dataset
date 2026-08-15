# Context: kong_3_5_2_lasalle_invariance_stability

**Statement:** [kong_3_5_2_lasalle_invariance_stability.md](kong_3_5_2_lasalle_invariance_stability.md) · **Criteria:** [kong_3_5_2_lasalle_invariance_stability.criteria.md](kong_3_5_2_lasalle_invariance_stability.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Lyapunov functions and the invariance hypothesis

**$C(D, \mathbb{R}^m)$ means *jointly* continuous.** Kong writes $f \in C(D,\mathbb{R}^m)$ for a function
continuous on $D$ as a function of all its variables together. Continuity in each variable separately is
strictly weaker and is not what is meant.

**"Solution" means a genuinely differentiable function.** A solution of $x' = f(t,x)$ on an interval is a
differentiable $x$ with $x'(t) = f(t,x(t))$ at every point of the interval — at the endpoints, the
one-sided derivative within the interval. A formalization that asserts the identity only for the values of
some derivative operator, without asserting differentiability, says nothing where the derivative does not
exist.

**Solutions must stay in the domain.** Where $f$ is defined only on $D$, the requirement $(t,x(t)) \in D$
is part of being a solution — both for the solution produced and for every competitor in a uniqueness
claim.

**Stability notions, with the uniformity spelled out.** The zero solution is *uniformly stable* when for
every $\varepsilon>0$ there is $\delta>0$, **independent of the initial time $t_0$**, such that every
solution with $|x(t_0)|<\delta$ satisfies $|x(t)|<\varepsilon$ for all $t \ge t_0$. It is *asymptotically
stable* when in addition there is a single attraction radius $\delta>0$, again independent of $t_0$, such
that $|x(t_0)|<\delta$ forces $x(t)\to 0$. The independence of $t_0$ is what the word "uniformly" carries,
and a version in which $\delta$ may depend on $t_0$ is a different (weaker) notion.

**$\dot V$, the orbital derivative**, is $\nabla V(x)\cdot f(x)$ — the derivative of $V$ *along solutions*
of $x'=f(x)$, computed without solving the equation. It is not the time derivative of a specific solution.

**Positive definite / negative semi-definite.** $V$ is positive definite on the closed ball
$D = \{|x|\le l\}$ when $V(0)=0$ and $V(x)>0$ for every other $x \in D$; $\dot V$ is negative semi-definite
when $\dot V(x)\le 0$ throughout $D$. Note the asymmetry: strict for $V$, non-strict for $\dot V$ — that is
exactly what makes the invariance hypothesis necessary.

**The invariance hypothesis.** $D_0 = \{x \in D : \dot V(x)=0\}$ contains **no nontrivial orbit** — no
orbit of a solution other than $x\equiv 0$ lies entirely inside $D_0$. This is LaSalle's condition and is
what upgrades stability to asymptotic stability.

**$V \in C^1(D)$ on a closed ball** means the derivative is taken within $D$.

**The conclusion is both properties**: uniform stability and asymptotic stability of the zero solution.
