# Context: engelking_8_4_13_smirnov_proximity_compactification

**Statement:** [engelking_8_4_13_smirnov_proximity_compactification.md](engelking_8_4_13_smirnov_proximity_compactification.md) · **Criteria:** [engelking_8_4_13_smirnov_proximity_compactification.criteria.md](engelking_8_4_13_smirnov_proximity_compactification.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Proximities and the Smirnov correspondence

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

**A proximity** on $X$ is a relation $A \delta B$ ("$A$ is close to $B$") between subsets satisfying:
$\emptyset$ is close to nothing; sets that meet are close; the relation is symmetric; it is additive in
each argument ($A \cup B$ close to $C$ iff $A$ close to $C$ or $B$ close to $C$); the *strong*
(Efremovič) axiom — if $A$ is not close to $B$ then there is $E$ with $A$ not close to $E$ and $E^c$ not
close to $B$; and compatibility with the topology, $\overline{A} = \{x : \{x\} \delta A\}$. The last
axiom is what ties the proximity to the *given* topology of $X$, and the Efremovič axiom is what makes
the correspondence with compactifications work.

**$\delta(c)$, the proximity assigned to a compactification.** For a compactification $c \colon X \to cX$
one declares $A \delta B$ exactly when $\overline{c(A)} \cap \overline{c(B)} \ne \emptyset$ in $cX$. It
is an "if and only if" definition, not merely an implication.

**"One-to-one correspondence between compactifications and proximities"** is three assertions: every
compactification determines a proximity; every proximity arises from some compactification
(surjectivity); and two compactifications inducing the same proximity are *equivalent* (injectivity).

**"Equivalent compactifications"** means a homeomorphism $cX \to c'X$ commuting with the two embeddings,
not merely a homeomorphism of the two spaces. Compactifications are always counted up to that
equivalence — which is why the correspondence can be one-to-one at all.
