# Context: kallenberg_23_2_tightness_and_relative_compactness

**Statement:** [kallenberg_23_2_tightness_and_relative_compactness.md](kallenberg_23_2_tightness_and_relative_compactness.md) · **Criteria:** [kallenberg_23_2_tightness_and_relative_compactness.criteria.md](kallenberg_23_2_tightness_and_relative_compactness.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Tightness and Prohorov's theorem

**Tight family.** $\Xi$ is tight when for every $\varepsilon>0$ there is a compact $K \subseteq S$ with
$P\{\xi \in K\} > 1-\varepsilon$ for **every** $\xi \in \Xi$ simultaneously — one compact set for the
whole family.

**Relatively compact in distribution** means the closure of the set of laws is compact in the topology of
weak convergence on the space of probability measures on $S$. It is a statement about *laws*, not about
the random elements themselves; two random elements with the same law are interchangeable throughout.

**The theorem is asymmetric.** (i) $\Rightarrow$ (ii) holds on *any* metric space. The converse needs $S$
separable and complete (Polish). A formalization that assumes separability and completeness globally
therefore states only half the theorem — the unconditional implication has to appear without them.
