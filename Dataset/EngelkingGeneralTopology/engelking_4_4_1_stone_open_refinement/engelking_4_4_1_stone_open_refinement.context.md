# Context: engelking_4_4_1_stone_open_refinement

**Statement:** [engelking_4_4_1_stone_open_refinement.md](engelking_4_4_1_stone_open_refinement.md) · **Criteria:** [engelking_4_4_1_stone_open_refinement.criteria.md](engelking_4_4_1_stone_open_refinement.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Stone's theorem: metrizability, refinements, $\sigma$-discreteness

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

**Metrizable** means the *given* topology is induced by some metric — not that the space carries a
metric structure as extra data, and not that it is merely homeomorphic to a metric space by an
unspecified map.

**What is asserted.** For *every* open cover there is a *single* open refinement that is
simultaneously locally finite and $\sigma$-discrete. Producing two separate refinements, one for each
property, is strictly weaker and is not Stone's theorem.

**$\sigma$-discrete needs its splitting.** Since "$\sigma$-discrete" is a property of a family together
with a decomposition into countably many discrete subfamilies, the decomposition has to appear: a
labelling of the index set by natural numbers such that each level is a discrete family.
