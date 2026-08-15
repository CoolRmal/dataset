# Context: lee_8_8_constant_rank_level_set_theorem

**Statement:** [lee_8_8_constant_rank_level_set_theorem.md](lee_8_8_constant_rank_level_set_theorem.md) · **Criteria:** [lee_8_8_constant_rank_level_set_theorem.criteria.md](lee_8_8_constant_rank_level_set_theorem.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Constant rank and level sets

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

**Constant rank $k$** is a hypothesis at **every** point of $M$ — a single condition, not one per level
set. It is strictly weaker than being a submersion (rank $= \dim N$) and strictly stronger than having
rank $k$ at one point.

**Every level set.** The conclusion applies to **all** $c \in N$, including values not attained (whose
level set is empty and is trivially a closed embedded submanifold). So $c$ is quantified inside the
conclusion, not among the hypotheses.

**Codimension $k$**, the rank — not $\dim N$. This is what distinguishes 8.8 from the regular level set
theorem 8.10, where the rank is full and the two numbers agree.

**Embedded submanifold** is again the local slice condition with charts from the smooth structure.
