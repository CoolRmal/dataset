# Context: lee_8_10_regular_level_set_theorem

**Statement:** [lee_8_10_regular_level_set_theorem.md](lee_8_10_regular_level_set_theorem.md) · **Criteria:** [lee_8_10_regular_level_set_theorem.criteria.md](lee_8_10_regular_level_set_theorem.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Regular values and embedded submanifolds

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

**Regular value.** $c \in N$ is a regular value of $\Phi$ when the differential $d\Phi_p$ is **surjective**
at **every** $p$ in the fibre $\Phi^{-1}(c)$. Points outside the fibre are unconstrained, and a value not
attained at all is vacuously regular.

**Embedded submanifold** in Lee's sense is the local slice condition: every point of $S$ has a chart of $M$
carrying $S$ near it onto a coordinate slice. The chart must belong to the smooth structure, and the slice
condition is relative to the chart's image.

**Codimension = $\dim N$.** The conclusion pins the codimension to the dimension of the *range* manifold,
not to the rank of $\Phi$ at a point.

**Two conclusions**: the level set is closed in $M$, and it is an embedded submanifold of that codimension.
