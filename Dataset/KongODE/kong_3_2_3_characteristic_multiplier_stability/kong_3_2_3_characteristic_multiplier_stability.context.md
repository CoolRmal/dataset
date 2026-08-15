# Context: kong_3_2_3_characteristic_multiplier_stability

**Statement:** [kong_3_2_3_characteristic_multiplier_stability.md](kong_3_2_3_characteristic_multiplier_stability.md) · **Criteria:** [kong_3_2_3_characteristic_multiplier_stability.criteria.md](kong_3_2_3_characteristic_multiplier_stability.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Transition matrix, characteristic multipliers, and semisimplicity

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

**Transition matrix.** For a fundamental matrix solution $X$ of the $\omega$-periodic system,
$V = X(\omega)X^{-1}(0)$; equivalently $X(t+\omega) = X(t)V$. Different choices of $X$ give similar $V$, so
the eigenvalues are well defined.

**Characteristic multipliers** $\mu_1,\dots,\mu_n$ are the eigenvalues of $V$, **listed with algebraic
multiplicity** — there are exactly $n$ of them, possibly repeated.

**"In the diagonal Jordan block"** means: every Jordan block of $V$ belonging to that eigenvalue is
$1\times 1$; equivalently the eigenvalue is *semisimple* (its algebraic and geometric multiplicities
agree). This is the condition that distinguishes bounded from polynomially growing solutions when
$|\mu| = 1$.

**The trichotomy.** (a) uniformly stable $\iff$ all $|\mu_i|\le 1$ and every multiplier of modulus $1$ is
semisimple; (b) asymptotically stable $\iff$ all $|\mu_i| < 1$; (c) unstable $\iff$ some $|\mu_i|>1$, or
some $|\mu_i|=1$ that is not semisimple. All three are **equivalences**.
