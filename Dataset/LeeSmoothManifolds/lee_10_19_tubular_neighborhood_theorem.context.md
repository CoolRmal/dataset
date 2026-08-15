# Context: lee_10_19_tubular_neighborhood_theorem

**Statement:** [lee_10_19_tubular_neighborhood_theorem.md](lee_10_19_tubular_neighborhood_theorem.md) · **Criteria:** [lee_10_19_tubular_neighborhood_theorem.criteria.md](lee_10_19_tubular_neighborhood_theorem.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Normal bundles and tubular neighbourhoods

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

**Embedded submanifold of $\mathbb{R}^n$.** Lee's local slice condition: every point of $M$ has a chart of
$\mathbb{R}^n$ carrying $M$ near that point onto a coordinate slice. No closedness, compactness or
properness is assumed.

**Normal vector.** $v$ is normal to $M$ at $x$ when it is orthogonal to the tangent space $T_xM$.

**Tubular neighbourhood.** A neighbourhood $U$ of $M$ in $\mathbb{R}^n$ that is the diffeomorphic image,
under $(x,v)\mapsto x+v$, of a **disk bundle** $\{(x,v) : v \perp T_xM,\ |v| < \delta(x)\}$ for some
**positive continuous** radius function $\delta$ on $M$. Three things matter:

- the radius **varies from point to point** — a single constant will not do for a non-compact $M$;
- the radius must be **continuous**, or the "disk bundle" is not even open in the normal bundle and the
  object produced is not a tubular neighbourhood;
- the map $(x,v)\mapsto x+v$ must be a **bijection onto $U$ with smooth inverse**, not merely injective
  or merely surjective.
