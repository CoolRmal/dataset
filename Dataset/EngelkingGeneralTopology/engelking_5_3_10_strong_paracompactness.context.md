# Context: engelking_5_3_10_strong_paracompactness

**Statement:** [engelking_5_3_10_strong_paracompactness.md](engelking_5_3_10_strong_paracompactness.md) · **Criteria:** [engelking_5_3_10_strong_paracompactness.criteria.md](engelking_5_3_10_strong_paracompactness.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Star-finite and star-countable families

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

**Star-finite / star-countable.** A family $\{A_s\}_{s\in S}$ is star-finite when for every index
$s_0$ the set $\{s : A_s \cap A_{s_0} \ne \emptyset\}$ is finite, and star-countable when that set is
countable. This is a condition indexed by *members* of the family, not by points of the space, and it
is unrelated to local finiteness: a star-finite family need not be locally finite and vice versa.

**Strongly paracompact** is defined in the statement: Hausdorff, and every open cover has a star-finite
**open** refinement.

**The four items differ in three independent ways** — open versus closed refinement, star-finite versus
star-countable, and local finiteness present or absent. (ii) closed + locally finite + star-finite;
(iii) closed + locally finite + star-countable; (iv) open + star-countable, with no local finiteness.
Conflating any two of these loses the theorem.

**Engelking's "regular" includes $T_1$.**
