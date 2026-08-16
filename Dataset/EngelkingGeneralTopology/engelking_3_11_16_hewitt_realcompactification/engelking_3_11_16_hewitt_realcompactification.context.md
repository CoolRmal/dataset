# Context: engelking_3_11_16_hewitt_realcompactification

**Statement:** [engelking_3_11_16_hewitt_realcompactification.md](engelking_3_11_16_hewitt_realcompactification.md) · **Criteria:** [engelking_3_11_16_hewitt_realcompactification.criteria.md](engelking_3_11_16_hewitt_realcompactification.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Notation

Engelking builds separation axioms into his names: *regular* and *normal* include $T_1$, *compact* and *paracompact* include Hausdorff, and *Tychonoff* is completely regular plus $T_1$. Modern usage keeps these apart, so each must be restored explicitly.

**Realcompact** is defined negatively: no *strictly larger* Tychonoff space with a dense copy of $X$ to which every continuous real function extends. Uniqueness is up to a homeomorphism **commuting with the embeddings**.
