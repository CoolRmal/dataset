# Context: engelking_3_11_16_hewitt_realcompactification

**Statement:** [engelking_3_11_16_hewitt_realcompactification.md](engelking_3_11_16_hewitt_realcompactification.md) · **Criteria:** [engelking_3_11_16_hewitt_realcompactification.criteria.md](engelking_3_11_16_hewitt_realcompactification.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Realcompactness and the Hewitt realcompactification

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

**The definition of realcompact is negative.** $X$ is realcompact when it is Tychonoff and there is
**no** Tychonoff space $\tilde X$ carrying a dense embedding of $X$ that is *strictly* larger
($r(X) \ne \overline{r(X)} = \tilde X$) and to which every continuous real function on $X$ extends. So
realcompactness says: $X$ admits no proper "real-function-preserving" enlargement. Note both clauses
inside the negation — density and strictness — are needed; without strictness the identity embedding
would refute realcompactness for every space.

**$\nu X$ and the maps.** $\nu \colon X \to \nu X$ is a homeomorphic embedding with dense image, and
$f^\nu$ denotes the extension of $f$ along $\nu$, so $f^\nu \circ \nu = f$. The superscript $\nu$ is
notation for "the extension", not a new function symbol.

**"Exactly one up to homeomorphism"** is a rigidity statement: any realcompact $Z$ with a dense
embedding $\zeta$ of $X$ satisfying (ii) is homeomorphic to $\nu X$ **by a homeomorphism compatible
with the embeddings** ($h \circ \nu = \zeta$). A bare homeomorphism $\nu X \cong Z$ would be much
weaker.

**Property (iii) is a universal property**: continuous maps into *any* realcompact target extend, not
just real-valued ones. It is stated as an additional property of $\nu X$, and follows from (i)–(ii),
but it is printed as part of the theorem.
