# Context: engelking_5_1_38_tamano_theorem

**Statement:** [engelking_5_1_38_tamano_theorem.md](engelking_5_1_38_tamano_theorem.md) · **Criteria:** [engelking_5_1_38_tamano_theorem.criteria.md](engelking_5_1_38_tamano_theorem.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Compactifications, $\beta X$, and Tamano's theorem

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

**A compactification $cX$ of $X$** is a compact Hausdorff space together with a dense homeomorphic
embedding $X \hookrightarrow cX$. Both parts matter: the embedding must be a homeomorphism onto its
image, and its image must be dense. "Compact" here is Engelking's, so Hausdorff is included.

**$\beta X$** is the Čech–Stone compactification: the largest compactification, characterised by the
property that every bounded continuous real function on $X$ extends to it. Item (iii) names it
specifically, so a formalization must use that space and not an arbitrary one.

**$X \times cX$ carries the product topology**, and "normal" is Engelking's — normal **and** $T_1$. The
$T_1$ clause does not come for free with normality under the modern convention, so it has to be
stated for the product as well.

**The shape of the equivalence.** (ii) is universally quantified over compactifications, (iv)
existentially. The content of the theorem is precisely that these two, which look far apart, are
equivalent to each other and to paracompactness; collapsing the quantifiers destroys it.
