# Context: engelking_5_2_8_normal_product_interval

**Statement:** [engelking_5_2_8_normal_product_interval.md](engelking_5_2_8_normal_product_interval.md) · **Criteria:** [engelking_5_2_8_normal_product_interval.criteria.md](engelking_5_2_8_normal_product_interval.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Countable paracompactness and $X \times I$

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

**Countably paracompact** is defined in the statement: Hausdorff, and every **countable** open cover
has a locally finite open refinement. The restriction to countable covers is the entire difference
from paracompactness.

**$I$** is the closed unit interval $[0,1]$ with its usual topology, and $X \times I$ carries the
product topology.

**Both directions.** The statement is an equivalence, and both properties of $X$ — normality and
countable paracompactness — sit on the left of the biconditional. This is Dowker's theorem: a normal
space fails to be countably paracompact exactly when its product with $I$ fails to be normal.

**Engelking's "normal" includes $T_1$.**
