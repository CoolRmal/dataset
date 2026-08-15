# Context: bogachev_4_6_3_nikodym_vitali_hahn_saks

**Statement:** [bogachev_4_6_3_nikodym_vitali_hahn_saks.md](bogachev_4_6_3_nikodym_vitali_hahn_saks.md) · **Criteria:** [bogachev_4_6_3_nikodym_vitali_hahn_saks.criteria.md](bogachev_4_6_3_nikodym_vitali_hahn_saks.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Real measures, variation norm, uniform countable additivity

**$\mathcal{M}(X,\mathcal{A})$ is a space of signed measures.** The statement spells this out:
$\mathcal{M}(X,\mathcal{A})$ is the space of *real* measures of bounded variation on the σ-algebra
$\mathcal{A}$ — countably additive set functions $\mathcal{A} \to \mathbb{R}$, taking both signs,
never the values $\pm\infty$. Every such measure automatically has finite total variation. So
$\mu_n(A)$ is a real number for each measurable $A$, and $|\mu_n(A)|$ is an ordinary absolute value.

**$\|\mu\|$.** The variation norm $\|\mu\| = |\mu|(X)$, where $|\mu|$ is the total variation measure
of $\mu$ — the nonnegative measure obtained from the Jordan decomposition $\mu = \mu^+ - \mu^-$ as
$|\mu| = \mu^+ + \mu^-$. So $\sup_n \|\mu_n\| < \infty$ is uniform boundedness in that norm, which is
a *conclusion* of the theorem and not a hypothesis.

**The hypothesis.** Only this: for every $A \in \mathcal{A}$ the numerical sequence $\mu_n(A)$
converges to a finite limit. No uniformity of any kind is assumed. Everything uniform — the bound,
the countable additivity, the absolute continuity — is concluded. This is why the theorem is hard:
it is a Baire-category argument, not a manipulation.

**$\alpha$ is a modulus.** In part (2), $\alpha$ is a bounded nondecreasing nonnegative function on
$[0,+\infty)$ with $\alpha(t) \to 0$ as $t \to 0$. Boundedness is what makes $\sup_n \|\mu_n\|<\infty$
follow, and vanishing at $0$ is what makes the family uniformly absolutely continuous with respect to
$\nu$. Dropping either clause leaves a statement with no content.

**Uniform countable additivity** is Definition 4.6.2, quoted with the statement: for every sequence
of pairwise disjoint measurable sets, the tail sums $\sum_{i \ge n} \mu(A_i)$ are small *uniformly
over the family*, i.e. the threshold $n_\varepsilon$ may not depend on $\mu$.

**$\mu_n \ll \lambda$** is absolute continuity: $\lambda(A) = 0$ implies $\mu_n(A)=0$. Part (3) says
that if one nonnegative $\lambda \in \mathcal{M}$ dominates all the $\mu_n$, then their absolute
continuity is automatically *uniform* in $n$ — the $\delta$ in the $\varepsilon$–$\delta$ formulation
may be chosen independently of $n$. The dominating $\lambda$ is quantified inside the conclusion:
the theorem speaks about every such $\lambda$, and assumes none.
