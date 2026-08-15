# Context: lee_10_7_sards_theorem

**Statement:** [lee_10_7_sards_theorem.md](lee_10_7_sards_theorem.md) · **Criteria:** [lee_10_7_sards_theorem.criteria.md](lee_10_7_sards_theorem.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Critical points, critical values, and "measure zero in $N$"

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

**Critical point / critical value.** $p$ is a *critical point* of $F$ when the differential $dF_p$ is
**not surjective**; a *critical value* is the image $F(p)$ of a critical point. Sard's theorem is about
the set of critical **values** — a subset of $N$ — not the set of critical points, which is generally not
null.

**"Measure zero in $N$".** A manifold carries no canonical measure, so nullity is defined chart by chart:
$S \subseteq N$ has measure zero when $\psi(S \cap \operatorname{dom}\psi)$ is Lebesgue-null in
$\mathbb{R}^n$ for every chart $\psi$ **belonging to the smooth structure**. Only the part of $S$ inside a
chart's domain can be pushed forward, and the charts must be smoothly compatible ones — an arbitrary
homeomorphism would give a different notion.

**Second countability of $M$ is essential**, since the chartwise argument needs a countable atlas; the
statement is false without it.

**No measurability side condition**: the set of critical values need not be measurable a priori, and an
outer measure applies to every set.
