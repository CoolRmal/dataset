# Q. Kong, *A Short Course in Ordinary Differential Equations*, Theorem 5.4.2

- **Source:** Q. Kong, *A Short Course in Ordinary Differential Equations*
- **Domain:** ODE
- **Lean declaration:** `Dataset.KongODE.kong_5_4_2_hopf_friedrich_dichotomy` ([kong_5_4_2_hopf_friedrich_dichotomy.lean](kong_5_4_2_hopf_friedrich_dichotomy.lean))
- **Criteria:** [kong_5_4_2_hopf_friedrich_dichotomy.criteria.md](kong_5_4_2_hopf_friedrich_dichotomy.criteria.md)

## Statement

**Theorem 5.4.2.** Assume (5.4.2) and (5.4.4) hold with $\alpha'(0) = 0$. Then either

**(a)** all orbits of system (5.4.1-0) in a neighborhood of $(0,0)$ are closed orbits and system (5.4.1-$\mu$) does not have closed orbits for $\mu \ne 0$ in a neighborhood of $\mu = 0$, or

**(b)** for $\mu > 0$ sufficiently close to zero only or for $\mu < 0$ sufficiently close to zero only, system (5.4.1-$\mu$) has a unique limit cycle $\Gamma(\mu)$ satisfying $\Gamma(\mu) \to (0,0)$ with its period $T(\mu) \to 2\pi/\beta$ as $\mu \to 0$.

**System (5.4.1-$\mu$).** The planar one-parameter family $x' = F(x, \mu)$, $x \in \mathbb{R}^2$, $\mu \in \mathbb{R}$; system (5.4.1-0) is the member with $\mu = 0$.

**Hypotheses (5.4.2) and (5.4.4).** $F$ is analytic in $(x, \mu)$ near $(0,0)$ and $F(0, \mu) = 0$ for all $\mu$, so that the origin is an equilibrium of (5.4.1-$\mu$) for every $\mu$; and the eigenvalues of the linearization $\partial F/\partial x\,(0, \mu)$ are $\alpha(\mu) \pm i \beta(\mu)$ with

$$\alpha(0) = 0, \qquad \beta(0) = \beta > 0 .$$

Equivalently, $\operatorname{tr} \frac{\partial F}{\partial x}(0, 0) = 2\alpha(0) = 0$, $\det \frac{\partial F}{\partial x}(0, 0) = \alpha(0)^2 + \beta^2 = \beta^2$, and the degeneracy condition $\alpha'(0) = 0$ reads $\frac{d}{d\mu}\Big|_{\mu = 0} \operatorname{tr} \frac{\partial F}{\partial x}(0, \mu) = 0$.
