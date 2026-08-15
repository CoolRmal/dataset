# Context: lee_7_6_inverse_function_theorem

**Statement:** [lee_7_6_inverse_function_theorem.md](lee_7_6_inverse_function_theorem.md) · **Criteria:** [lee_7_6_inverse_function_theorem.criteria.md](lee_7_6_inverse_function_theorem.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## The smooth inverse function theorem

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

**The hypothesis** is that $DF(p)$ — the total derivative of $F$ at $p$, a linear map
$\mathbb{R}^n\to\mathbb{R}^n$ — is **nonsingular**, i.e. invertible. Since source and target have the same
dimension, injectivity, surjectivity and bijectivity coincide, but the condition is about the derivative
being genuine: the smoothness hypothesis is what makes the derivative operator return the real derivative.

**The conclusion** produces **connected** open neighbourhoods $U_0 \ni p$ inside $U$ and $V_0 \ni F(p)$
inside $V$, such that $F$ restricted to $U_0$ is a **diffeomorphism onto $V_0$**: a smooth bijection with
smooth inverse. Connectedness of both neighbourhoods is printed.

**The diffeomorphism must be $F$ itself**, not some other smooth bijection between the same two sets.
