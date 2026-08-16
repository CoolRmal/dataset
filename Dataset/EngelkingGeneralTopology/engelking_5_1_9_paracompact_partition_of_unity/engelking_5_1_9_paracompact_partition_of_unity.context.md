# Context: engelking_5_1_9_paracompact_partition_of_unity

**Statement:** [engelking_5_1_9_paracompact_partition_of_unity.md](engelking_5_1_9_paracompact_partition_of_unity.md) · **Criteria:** [engelking_5_1_9_paracompact_partition_of_unity.criteria.md](engelking_5_1_9_paracompact_partition_of_unity.criteria.md)

Background needed to read the statement correctly. Natural language only: no Lean, and no hint at how to formalize it.

## Notation

Engelking builds separation axioms into his names: *regular* and *normal* include $T_1$, *compact* and *paracompact* include Hausdorff, and *Tychonoff* is completely regular plus $T_1$. Modern usage keeps these apart, so each must be restored explicitly.

Item (iii) is item (ii) **minus** local finiteness, so the sum $\sum_s\rho_s(x)=1$ may have infinitely many nonzero terms. Subordination constrains the closed support.
