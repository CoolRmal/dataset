# Context: lee_10_11_whitney_embedding_theorem

**Statement:** [lee_10_11_whitney_embedding_theorem.md](lee_10_11_whitney_embedding_theorem.md) · **Criteria:** [lee_10_11_whitney_embedding_theorem.criteria.md](lee_10_11_whitney_embedding_theorem.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Proper smooth embeddings into $\mathbb{R}^{2n+1}$

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

**Proper.** A map is proper when the preimage of every compact set is compact. For an embedding this is
what forces the image to be **closed**, so that the copy of $M$ does not run off to infinity inside a
bounded region.

**The target dimension $2n+1$ is part of the statement.** Existentially quantifying it — "$M$ embeds in
some $\mathbb{R}^N$" — throws away the whole quantitative content, and that weaker form is elementary for
compact $M$.

**Why the hypotheses cannot be dropped.** Without Hausdorffness the line with two origins is a smooth
$1$-manifold that embeds in no Hausdorff space. Without second countability an uncountable disjoint union
of copies of $\mathbb{R}^n$ is Hausdorff and locally Euclidean but cannot embed in the second countable
$\mathbb{R}^{2n+1}$.
