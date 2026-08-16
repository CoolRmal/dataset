# Context: engelking_8_4_13_smirnov_proximity_compactification

**Statement:** [engelking_8_4_13_smirnov_proximity_compactification.md](engelking_8_4_13_smirnov_proximity_compactification.md) · **Criteria:** [engelking_8_4_13_smirnov_proximity_compactification.criteria.md](engelking_8_4_13_smirnov_proximity_compactification.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Notation

Engelking builds separation axioms into his names: *regular* and *normal* include $T_1$, *compact* and *paracompact* include Hausdorff, and *Tychonoff* is completely regular plus $T_1$. Modern usage keeps these apart, so each must be restored explicitly.

A **proximity** includes the Efremovič axiom and compatibility with the given topology, $\overline{A}=\{x : \{x\}\,\delta\,A\}$. "One-to-one correspondence" is existence, surjectivity, and injectivity **up to equivalence** of compactifications — a homeomorphism commuting with the embeddings.
