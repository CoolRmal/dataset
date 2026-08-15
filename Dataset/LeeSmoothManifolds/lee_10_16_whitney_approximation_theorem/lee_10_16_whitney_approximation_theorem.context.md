# Context: lee_10_16_whitney_approximation_theorem

**Statement:** [lee_10_16_whitney_approximation_theorem.md](lee_10_16_whitney_approximation_theorem.md) · **Criteria:** [lee_10_16_whitney_approximation_theorem.criteria.md](lee_10_16_whitney_approximation_theorem.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## $\delta$-closeness and relative approximation

**Lee's conventions, built into the words.** In *Introduction to Smooth Manifolds*, "smooth manifold"
means: a **second countable Hausdorff** topological space that is locally Euclidean of a fixed dimension,
together with a maximal $C^\infty$ atlas, and **without boundary** unless "with boundary" is said. Modern
libraries separate these: a charted space carries no separation or countability axiom of its own. So every
statement below has to restore Hausdorffness and second countability explicitly wherever they are used.

Second countability is the condition Lee *states*. For a locally Euclidean Hausdorff space it is equivalent
to $\sigma$-compactness and to paracompactness-plus-countably-many-components, but substituting an
equivalent condition is a departure from the text, and the equivalence is itself a theorem.

**"Smooth" means $C^\infty$**, not real-analytic and not $C^k$ for finite $k$.

**Smooth embedding.** This is the term most often mis-rendered. A smooth embedding is a map that is
**both an immersion** — its differential is injective at every point — **and a topological embedding**, a
homeomorphism onto its image with the subspace topology. "Smooth **and** a topological embedding" is
strictly weaker: $t \mapsto t^3$ is a smooth homeomorphism of $\mathbb{R}$ whose derivative vanishes at
$0$, so its image is not smoothly parametrised. Any formalization must use the notion that bundles
immersion with embedding.

**Immersion, submersion, rank.** The differential at $p$ is the linear map between tangent spaces. An
immersion has it injective everywhere, a submersion surjective everywhere, and a map has *constant rank
$k$* when its rank is $k$ at every point. All of these presuppose that the differential is the genuine
one, which requires the smoothness hypothesis to be present — a derivative operator applied to a
non-differentiable map returns a default value and any rank condition about it is meaningless.

**"$\delta$-close" with $\delta$ a *function*.** The tolerance is a strictly positive **continuous
function** on $M$, not a constant, and $F'$ is $\delta$-close to $F$ when $|F'(x)-F(x)| < \delta(x)$ for
every $x$. Replacing $\delta$ by a constant weakens the theorem badly on a non-compact manifold, where no
single constant tolerance can capture uniform-on-compacts approximation.

**$F$ is only continuous.** The theorem manufactures smoothness; assuming $F$ smooth makes it vacuous.

**"Smooth on a closed subset $A$".** For a set that is not open, "smooth on $A$" means smooth on some
open neighbourhood of $A$ — that is Lee's convention for smoothness on an arbitrary subset. The conclusion
is then that $F'$ can be chosen to agree with $F$ **exactly** on $A$, not merely to be close there.

**One $F'$ carries every conclusion**: smooth on all of $M$, $\delta$-close everywhere, and equal to $F$
on $A$.
