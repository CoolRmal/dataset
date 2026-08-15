# Context: engelking_5_1_9_paracompact_partition_of_unity

**Statement:** [engelking_5_1_9_paracompact_partition_of_unity.md](engelking_5_1_9_paracompact_partition_of_unity.md) · **Criteria:** [engelking_5_1_9_paracompact_partition_of_unity.criteria.md](engelking_5_1_9_paracompact_partition_of_unity.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Partitions of unity subordinated to a cover

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

**A partition of unity subordinated to $\{U_s\}$** is a family of continuous functions
$\rho_s \colon X \to [0,\infty)$ with $\sum_s \rho_s(x) = 1$ for every $x$, and with the (closed)
support of $\rho_s$ contained in $U_s$. The sum is an unordered sum over a possibly infinite index
set, so its convergence at each point is part of the assertion.

**Locally finite versus not.** Item (ii) requires the supports to form a locally finite family; item
(iii) drops that requirement, so at a given point infinitely many $\rho_s$ may be nonzero and the sum is
a genuine infinite sum. The theorem is that the weaker item (iii) already implies paracompactness, so
the two items must be kept apart.

**Engelking's paracompactness includes Hausdorff**, and the hypothesis on $X$ is only $T_1$ — but the
Hausdorff clause of "paracompact" then appears inside item (i).

**Support.** The condition is on the *closed* support $\overline{\{x : \rho_s(x) \ne 0\}}$, not on the
set where $\rho_s$ is nonzero.
