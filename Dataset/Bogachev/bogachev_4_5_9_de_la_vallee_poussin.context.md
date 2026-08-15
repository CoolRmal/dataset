# Context: bogachev_4_5_9_de_la_vallee_poussin

**Statement:** [bogachev_4_5_9_de_la_vallee_poussin.md](bogachev_4_5_9_de_la_vallee_poussin.md) · **Criteria:** [bogachev_4_5_9_de_la_vallee_poussin.criteria.md](bogachev_4_5_9_de_la_vallee_poussin.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## The de la Vallée Poussin criterion

**Uniform integrability.** For a family $\mathcal{F}$ of $\mu$-integrable functions on a finite
measure space, Bogachev's definition is: $\mathcal{F}$ is uniformly integrable when
$$\lim_{C \to \infty} \ \sup_{f \in \mathcal{F}} \int_{\{|f| > C\}} |f| \, d\mu = 0 .$$
Equivalently (for finite $\mu$): the $L^1$ norms are bounded and, for every $\varepsilon > 0$, there
is $\delta > 0$ with $\int_A |f| \, d\mu < \varepsilon$ for every $f \in \mathcal{F}$ and every
measurable $A$ with $\mu(A) < \delta$. The point of the notion, and of this theorem, is that a
single quantity controls the *whole family at once*.

**The supremum is over the family, and $G$ does not depend on $f$.** The criterion is: there is
**one** function $G$, chosen before $f$, such that $\sup_{f} \int G(|f|)\,d\mu < \infty$. Reading
the quantifiers the other way round — each $f$ gets its own $G$ — gives a condition satisfied by
every family of integrable functions, hence says nothing.

**"Increasing" and the domain of $G$.** In Bogachev "increasing" means nondecreasing (not strictly
increasing), and $G$ is a function on the half-line $[0,+\infty)$ only: all the conditions on $G$ —
nonnegativity, monotonicity, convexity in the refinement — are conditions on $[0,+\infty)$, because
$G$ is only ever evaluated at $|f(x)| \ge 0$.

**Superlinear growth.** $\lim_{t\to+\infty} G(t)/t = \infty$ is what rules out $G(t)=t$, for which
the boundedness condition would just be boundedness in $L^1$ and would carry no uniform-integrability
content. Typical witnesses are $G(t)=t^p$ with $p>1$ or $G(t) = t\log(1+t)$.

**The value of the integral.** $\int G(|f|)\,d\mu$ is an integral of a nonnegative function and may
legitimately be $+\infty$ before the criterion is applied; the assertion is that the supremum of these
values is finite.

**The last sentence.** "In such a case, one can choose a convex increasing function $G$" is a
*separate* second assertion: whenever the family is uniformly integrable, a $G$ with the three
properties can be found that is convex as well. It does not claim that every $G$ produced by the
first part is convex.
