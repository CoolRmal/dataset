# Criteria: bogachev_8_6_2_prokhorov_signed_measures

**Statement:** [bogachev_8_6_2_prokhorov_signed_measures.md](bogachev_8_6_2_prokhorov_signed_measures.md) · **Lean:** [bogachev_8_6_2_prokhorov_signed_measures.lean](bogachev_8_6_2_prokhorov_signed_measures.lean)

## What the theorem says

This is Prokhorov's compactness theorem, stated for finite *signed* Borel measures rather than
probability measures. On a complete separable metric space, a family $M$ of such measures has the
property that every sequence from $M$ has a weakly convergent subsequence exactly when two things
hold: the family is uniformly tight (all the mass sits on one compact set, up to $\varepsilon$,
uniformly over the family) and the total variations are uniformly bounded. Weak convergence here
means convergence of the integrals of every bounded continuous function. The same equivalence holds
on an arbitrary complete metric space provided every measure in the family is itself tight.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The family consists of finite signed Borel measures. | ✅ `S : Set (SignedMeasure X)`. |
| 2 | The space is a complete metric space carrying its Borel $\sigma$-algebra. | ✅ `[MetricSpace X] [CompleteSpace X] [MeasurableSpace X] [BorelSpace X]`. |
| 3 | Weak convergence is tested against every bounded continuous real function. | ✅ `weakly_converges_signed`, quantified over `f : X →ᵇ ℝ`. |
| 4 | The integral of $f$ against a signed measure is defined through the Jordan decomposition, $\int f\,d\mu^+ - \int f\,d\mu^-$. | ✅ `signedMeasureIntegral` in `Defs.lean`; both parts are finite measures and $f$ is bounded continuous, so both integrals genuinely exist. |
| 5 | Condition (i) is *relative* sequential compactness: every sequence in $M$ has a subsequence converging weakly to some limit, and the limit need not lie in $M$. | ✅ `relatively_sequentially_weakly_compact_signed`: `∃ φ, StrictMono φ ∧ ∃ t, weakly_converges_signed …`, with `t` unconstrained. |
| 6 | Condition (ii) part one: uniform tightness, meaning tightness of the family of total variations. | ✅ `IsTightMeasureSet ((fun s ↦ s.totalVariation) '' S)`. |
| 7 | Condition (ii) part two: the variation norms are uniformly bounded. | ⚠️ `UniformlyBoundedInTotalVariation S`, i.e. `∃ C : ℝ≥0, ∀ s ∈ S, s.totalVariation univ ≤ C`. Correct; a `⨆ … < ∞` form would read closer to $\sup_\mu \lVert\mu\rVert < \infty$. |
| 8 | The two conditions are equivalent — the statement is an "if and only if", not one implication. | ✅ Both halves are stated with `↔`. |
| 9 | The second part of the theorem: the same equivalence on an arbitrary complete metric space when every member of the family is tight. | ✅ Second conjunct, under the hypothesis `∀ s ∈ S, IsTightMeasureSet {s.totalVariation}` and with no separability assumption. |
| 10 | Separability is used only in the first part. | ✅ `SecondCountableTopology X` appears as a hypothesis arrow on the first conjunct only. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Stating the theorem for `ProbabilityMeasure X` or `FiniteMeasure X`, where Mathlib already has weak convergence. | A much weaker statement. For probability measures the variation bound is automatic, so half of condition (ii) says nothing, and the signed case is what the book proves. |
| 2 | Requiring the limit of the subsequence to belong to $M$. | That is compactness, not relative compactness. It is a strictly stronger condition and makes the equivalence false — a family of measures converging to something outside itself would be excluded. |
| 3 | Dropping the uniform variation bound and keeping only tightness. | For signed measures the bound does not follow from tightness, so the implication (ii) $\Rightarrow$ (i) fails. |
| 4 | Testing weak convergence against compactly supported continuous functions, or against merely continuous ones. | Compactly supported test functions give vague convergence, a different (weaker) topology, and the theorem changes. Unbounded continuous functions are not integrable against a general finite measure. |
| 5 | Formalizing only the first part and dropping the arbitrary-complete-metric-space version. | The last sentence of the theorem is a separate assertion and models routinely omit it. |
| 6 | Defining the integral against a signed measure by an ad-hoc formula that does not handle the negative part. | Without the Jordan decomposition the integral is undefined and the whole notion of weak convergence loses its meaning. |
| 7 | Encoding uniform tightness as tightness of the signed measures themselves rather than of their total variations. | Tightness is a statement about where mass lives; for a signed measure the right notion of mass is $\lvert \mu\rvert$. |

## Notes on the ground truth

- Mathlib has weak convergence only for nonnegative finite measures, so `signedMeasureIntegral`,
  `weakly_converges_signed` and `relatively_sequentially_weakly_compact_signed` are defined in
  `Defs.lean`. They are thin wrappers: the integral uses `toJordanDecomposition`, and tightness
  reuses Mathlib's `MeasureTheory.IsTightMeasureSet` on the image family.
- "Separable metric space" is carried as `SecondCountableTopology X`, which for metric spaces is the
  same property and is the convention in Mathlib's measure theory files.
- `SecondCountableTopology X` is written as a hypothesis arrow rather than an instance bracket so
  that both halves of the theorem can share one declaration. Splitting into two theorems, with
  `[SecondCountableTopology X]` on the first, would be more idiomatic.
- On a complete separable metric space every finite Borel measure is tight, so the hypothesis of the
  second conjunct holds automatically there and the first conjunct is a special case of the second.
  Both are kept because the book states both.
