# Context: engelking_7_2_1_countable_sum_theorem

**Statement:** [engelking_7_2_1_countable_sum_theorem.md](engelking_7_2_1_countable_sum_theorem.md) · **Criteria:** [engelking_7_2_1_countable_sum_theorem.criteria.md](engelking_7_2_1_countable_sum_theorem.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Covering dimension $\dim$

**Engelking's separation conventions — the single most common source of error in this book.**
Engelking builds separation axioms into the names of covering properties:

- a *regular space* is regular **and** $T_1$;
- a *normal space* is normal **and** $T_1$;
- a *compact space* is compact **and** Hausdorff;
- a *paracompact space* is paracompact **and** Hausdorff;
- a *Tychonoff space* is completely regular **and** $T_1$ (equivalently $T_{3\frac12}$).

Standard modern usage keeps these apart: "regular", "normal", "compact" and "paracompact" carry no
separation axiom of their own. So every one of Engelking's hypotheses and conclusions has to be read
as carrying its separation clause explicitly, and a reading that silently drops it is a different
theorem — sometimes a false one.

**Covers and refinements.** A family $\{U_s\}$ is an *open cover* when every member is open and the
union is the whole space. A family $\{V_t\}$ *refines* $\{U_s\}$ when every $V_t$ is contained in some
$U_s$ — the direction matters, and a refinement is not required to be a subfamily. A refinement is
itself required to be a cover. *Locally finite* means every point has a neighbourhood meeting only
finitely many members; *discrete* is the stronger condition that every point has a neighbourhood
meeting **at most one** member. A family is *$\sigma$-discrete* ($\sigma$-locally finite) when it is a
countable union of discrete (locally finite) subfamilies — the countable splitting is part of the data,
not a consequence.

**$\dim X \le n$ is the *covering* dimension.** Its definition uses **finite** open covers: every finite
open cover of $X$ has a finite open refinement of order at most $n+1$, meaning no point of $X$ lies in
more than $n+1$ members of the refinement. It is not the small or large inductive dimension, and it is
not the Hausdorff or Lebesgue dimension of a metric space; on normal spaces these agree in good cases,
but the theorem is about $\dim$.

**"Order at most $n+1$"** counts memberships: a point may belong to at most $n+1$ of the refining sets.
The off-by-one is the standard convention that makes $\dim \mathbb{R}^n = n$.

**$\dim F_j \le n$ is about $F_j$ as a space.** The pieces carry the subspace topology and their
dimension is computed intrinsically, with covers of $F_j$ by sets open *in $F_j$*.

**The cover is countable and closed** — indexed by $j = 1,2,\dots$, with each $F_j$ closed in $X$ — and
the same $n$ bounds every piece and appears in the conclusion.

**Normality of $X$ is essential**; the theorem is false without it.
