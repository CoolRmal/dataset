# Context: lee_9_16_quotient_manifold_theorem

**Statement:** [lee_9_16_quotient_manifold_theorem.md](lee_9_16_quotient_manifold_theorem.md) · **Criteria:** [lee_9_16_quotient_manifold_theorem.criteria.md](lee_9_16_quotient_manifold_theorem.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Free and proper Lie group actions, and the quotient

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

**Smooth action.** $\theta \colon G \times M \to M$ is smooth **jointly** in both arguments, with
$\theta(e,x)=x$ and $\theta(a,\theta(b,x)) = \theta(ab,x)$. Smoothness in each variable separately is not
enough.

**Free.** No non-identity element fixes any point: $a\cdot x = x \Rightarrow a = e$.

**Proper.** The map $G\times M \to M\times M$, $(a,x)\mapsto(a\cdot x, x)$, is a **proper map** — preimages
of compact sets are compact. This is the condition that makes the orbit space Hausdorff, and it is not
implied by freeness.

**The conclusion.** $M/G$ is a topological manifold of dimension $\dim M - \dim G$ — and "topological
manifold" for Lee includes **Hausdorff and second countable**, so those must be produced, not assumed away
— carrying a **unique** smooth structure making $\pi$ a smooth submersion. Uniqueness is the substantive
half: any other smooth structure on the orbit space with the same property is diffeomorphic to it by a map
commuting with the projections.

**The fibres of $\pi$ are exactly the orbits**, which is what makes $Q$ "the" orbit space.
