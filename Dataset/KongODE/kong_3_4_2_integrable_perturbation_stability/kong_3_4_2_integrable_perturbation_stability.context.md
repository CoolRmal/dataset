# Context: kong_3_4_2_integrable_perturbation_stability

**Statement:** [kong_3_4_2_integrable_perturbation_stability.md](kong_3_4_2_integrable_perturbation_stability.md) · **Criteria:** [kong_3_4_2_integrable_perturbation_stability.criteria.md](kong_3_4_2_integrable_perturbation_stability.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Integrably small perturbations

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

**The hypothesis on the perturbation.** There is $p \ge 0$, continuous on $[0,\infty)$, with
$\int_0^\infty p < \infty$ and $|r(t,x)| \le p(t)|x|$ **for all sufficiently small $|x|$ and all
$t \in [0,\infty)$**. The smallness radius is one number fixed before $t$ — a radius depending on $t$ would
make the hypothesis useless. The bound is *linear* in $|x|$ with an integrable time-dependent coefficient.

**The two parts.** (a) uniform stability of the linear system $x'=A(t)x$ passes to the perturbed system
$x' = A(t)x + r(t,x)$; (b) uniform *and* asymptotic stability passes as well. In (b) the hypothesis is both
properties, and the conclusion is both.

**All stability statements are about the zero solution of the perturbed system**, with initial times on the
half-line $[0,\infty)$ where the hypotheses live.
