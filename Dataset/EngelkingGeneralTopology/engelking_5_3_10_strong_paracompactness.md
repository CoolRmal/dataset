# R. Engelking, *General Topology*, Theorem 5.3.10

- **Source:** R. Engelking, *General Topology*
- **Domain:** Topology
- **Lean declaration:** `Dataset.EngelkingGeneralTopology.engelking_5_3_10_strong_paracompactness` ([engelking_5_3_10_strong_paracompactness.lean](engelking_5_3_10_strong_paracompactness.lean))
- **Criteria:** [engelking_5_3_10_strong_paracompactness.criteria.md](engelking_5_3_10_strong_paracompactness.criteria.md)
- **Context:** [engelking_5_3_10_strong_paracompactness.context.md](engelking_5_3_10_strong_paracompactness.context.md)

## Statement

**Definitions.** A family $\{A_s\}_{s \in S}$ is *star-finite* (*star-countable*) if for every $s_0 \in S$ the set $\{s \in S : A_s \cap A_{s_0} \neq \emptyset\}$ is finite (countable). A topological space $X$ is called *strongly paracompact* if $X$ is a Hausdorff space and every open cover of $X$ has a star-finite open refinement.

**5.3.10. Theorem.** For every regular space $X$ the following conditions are equivalent:

1. **(i)** $X$ is strongly paracompact;
2. **(ii)** every open cover of $X$ has a closed refinement which is both locally finite and star-finite;
3. **(iii)** every open cover of $X$ has a closed refinement which is both locally finite and star-countable;
4. **(iv)** every open cover of $X$ has a star-countable open refinement.
