# Context: engelking_4_4_8_bing_metrization

**Statement:** [engelking_4_4_8_bing_metrization.md](engelking_4_4_8_bing_metrization.md) · **Criteria:** [engelking_4_4_8_bing_metrization.criteria.md](engelking_4_4_8_bing_metrization.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## $\sigma$-discrete bases

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

**A $\sigma$-discrete base** is a base $\mathcal{B} = \bigcup_{n\in\mathbb{N}} \mathcal{B}_n$ where each
$\mathcal{B}_n$ is a *discrete* family — every point has a neighbourhood meeting at most one member of
that layer. It is the **union** that is a base. Discreteness is strictly stronger than local finiteness,
which is why Bing's criterion is formally stronger-looking than Nagata–Smirnov even though the two are
equivalent.

**Both directions are asserted.** The statement is an equivalence: metrizability implies the base
condition, and the base condition together with regularity implies metrizability.

**Regularity belongs on the right-hand side.** It is one of the two conditions being shown equivalent
to metrizability, not a standing hypothesis — though $T_1$, which Engelking bundles into "regular", has
to be assumed throughout for the equivalence to be stated at all.
