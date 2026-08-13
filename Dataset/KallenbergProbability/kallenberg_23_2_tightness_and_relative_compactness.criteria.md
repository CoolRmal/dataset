# Criteria: kallenberg_23_2_tightness_and_relative_compactness

**Statement:** [kallenberg_23_2_tightness_and_relative_compactness.md](kallenberg_23_2_tightness_and_relative_compactness.md) · **Lean:** [kallenberg_23_2_tightness_and_relative_compactness.lean](kallenberg_23_2_tightness_and_relative_compactness.lean)

## What the theorem says

Let $S$ be a metric space and let $\Xi$ be a family of random elements of $S$. Call $\Xi$ *tight* if
for every $\varepsilon > 0$ there is a compact set that all of them miss with probability at most
$\varepsilon$. Call $\Xi$ *relatively compact in distribution* if the closure of the set of their
laws is compact for weak convergence. Prohorov's theorem says that tightness always implies relative
compactness, in any metric space, and that the two are equivalent when $S$ is separable and
complete. The asymmetry is the point: the first half needs no assumption on $S$, the converse does.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $S$ carries a metric, and its measurable structure is the Borel one for that metric. | ✅ `[MetricSpace S] [MeasurableSpace S] [BorelSpace S]`. |
| 2 | The object under study is a family of probability laws on $S$, and the topology on that family is weak convergence. | ✅ `Ξ : Set (ProbabilityMeasure S)`; Mathlib gives `ProbabilityMeasure S` the topology of weak convergence. |
| 3 | Condition (i) is tightness of that family. | ✅ `IsTightMeasureSet {((ν : ProbabilityMeasure S) : Measure S) \| ν ∈ Ξ}`, i.e. for every $\varepsilon > 0$ there is a compact $K$ with $\nu(K^c) \le \varepsilon$ for all $\nu$ in the family. |
| 4 | Condition (ii) is compactness of the closure of the family inside the space of laws. | ✅ `IsCompact (closure Ξ)`, with the closure taken in `ProbabilityMeasure S`. |
| 5 | The unconditional half: tightness implies relative compactness, with no extra assumption on $S$. | ✅ First conjunct `tight → relativelyCompact`, stated with only `[MetricSpace S]` in scope. |
| 6 | The conditional half: when $S$ is separable and complete, the two conditions are equivalent. | ✅ Second conjunct `(TopologicalSpace.SeparableSpace S ∧ CompleteSpace S) → (tight ↔ relativelyCompact)`. |
| 7 | Separability and completeness must be assumptions of the second half only, not of the whole theorem. | ✅ They appear as an ordinary hypothesis inside the second conjunct, not as instance binders on the theorem. |
| 8 | The two halves must talk about the same two conditions. | ✅ `let tight := …` and `let relativelyCompact := …` are introduced once and used in both conjuncts. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Declaring `[TopologicalSpace.SeparableSpace S] [CompleteSpace S]` (or `[PolishSpace S]`) as instance binders. | This is the most likely error. It silently discards the general half of the theorem: the implication (i) ⇒ (ii) is then only asserted for Polish $S$, which is far less than Kallenberg states. |
| 2 | Stating only the equivalence `tight ↔ relativelyCompact` under a Polish assumption. | Same loss as above, made explicit: half the theorem is gone. |
| 3 | Taking the closure inside `Measure S` or `FiniteMeasure S`. | Those carry different topologies from the weak topology on probability measures, so the compactness claimed is not the one in the theorem. |
| 4 | Using sequential compactness of $\Xi$ instead of compactness of `closure Ξ`. | The two agree only when the space of laws is metrizable, which needs $S$ second countable — exactly the assumption the first half is supposed to avoid. |
| 5 | Hand-rolling tightness as `∀ ε > 0, ∃ K, ∀ ν ∈ Ξ, ν Kᶜ < ε` while forgetting `IsCompact K`. | Without compactness of $K$ the condition is trivially satisfiable (take $K = S$) and the theorem becomes false. |
| 6 | Dropping `[BorelSpace S]`. | Then the measurable structure is unrelated to the metric, and "compact set" carries no measure-theoretic information, so tightness says nothing. |

## Notes on the ground truth

- Kallenberg speaks of a set of random elements; the ground truth works with the set of their laws.
  This is legitimate, because both tightness and relative compactness in distribution depend only on
  the laws. ⚠️ It is one step away from the printed wording; a candidate that indexes actual random
  variables and then applies both conditions to the resulting set of laws is equally acceptable.
- `IsTightMeasureSet` in Mathlib is stated for `Set (Measure S)`, so the ground truth coerces:
  `{((ν : ProbabilityMeasure S) : Measure S) \| ν ∈ Ξ}`. This is the same set-builder coercion used
  in Mathlib's `isCompact_closure_of_isTightMeasureSet` and `isTightMeasureSet_of_isCompact_closure`.
- ⚠️ Separability and completeness appear as a `Prop`-valued hypothesis rather than as typeclass
  instances, which is unusual style. It is forced here: making them instances would contaminate the
  first conjunct. Splitting into two theorems — one general, one with `[SeparableSpace S]
  [CompleteSpace S]` as instances — would be more idiomatic and would preserve the content.
- In a metric space, separability is equivalent to second countability, which is the form Mathlib's
  converse direction is stated in.
