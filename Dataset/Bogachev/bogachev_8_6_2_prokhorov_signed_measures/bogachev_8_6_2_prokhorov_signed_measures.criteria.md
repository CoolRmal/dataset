# Criteria: bogachev_8_6_2_prokhorov_signed_measures

**Statement:** [bogachev_8_6_2_prokhorov_signed_measures.md](bogachev_8_6_2_prokhorov_signed_measures.md) · **Lean:** [bogachev_8_6_2_prokhorov_signed_measures.lean](bogachev_8_6_2_prokhorov_signed_measures.lean) · **Context:** [bogachev_8_6_2_prokhorov_signed_measures.context.md](bogachev_8_6_2_prokhorov_signed_measures.context.md)

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
row is incomplete. In the assessment column, ✅ means the ground truth states the requirement and
◐ means it states it in a form that deliberately departs from the text — a narrower setting, a
stronger hypothesis, or an equivalent but not literal phrasing — with the reason given. A ◐ records
a decision, not an open defect; where a more literal rendering would be at least as good, the row
says so.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The family consists of finite signed Borel measures. | ✅ `S : Set (SignedMeasure X)`. |
| 2 | The space is a complete metric space carrying its Borel $\sigma$-algebra. | ✅ `[MetricSpace X] [CompleteSpace X] [MeasurableSpace X] [BorelSpace X]`. |
| 3 | Weak convergence is tested against every bounded continuous real function. | ✅ `weakly_converges_signed`, quantified over `f : X →ᵇ ℝ`. |
| 4 | The integral of $f$ against a signed measure is defined through the Jordan decomposition, $\int f\,d\mu^+ - \int f\,d\mu^-$. | ✅ `signedMeasureIntegral` in `Defs.lean`; both parts are finite measures and $f$ is bounded continuous, so both integrals genuinely exist. |
| 5 | Condition (i) is *relative* sequential compactness: every sequence in $M$ has a subsequence converging weakly to some limit, and the limit need not lie in $M$. | ✅ `relatively_sequentially_weakly_compact_signed`: `∃ φ, StrictMono φ ∧ ∃ t, weakly_converges_signed …`, with `t` unconstrained. |
| 6 | Condition (ii) part one: uniform tightness, meaning tightness of the family of total variations. | ✅ `IsTightMeasureSet ((fun s ↦ s.totalVariation) '' S)`. |
| 7 | Condition (ii) part two: the variation norms are uniformly bounded. | ✅ `UniformlyBoundedInTotalVariation S`, now defined as `⨆ s : S, (s : SignedMeasure Ω).totalVariation univ < ∞` — the printed supremum read literally, taken in `ℝ≥0∞` where it is a genuine least upper bound. |
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

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[bogachev_8_6_2_prokhorov_signed_measures.md](bogachev_8_6_2_prokhorov_signed_measures.md) and the background in [bogachev_8_6_2_prokhorov_signed_measures.context.md](bogachev_8_6_2_prokhorov_signed_measures.context.md),
not against the ground-truth Lean file: a candidate spelled differently but
mathematically equivalent to the text loses nothing. The scale is defined in
[GRADING.md](../../GRADING.md); the numbers below are this problem's instance of it.

| Band | Points | This problem |
|---|---|---|
| A. Completeness | 50 | The requirement table above has 10 rows, so each row is worth 5.0 points: full credit if the candidate states it in any equivalent form, half for a harmless strengthening or weakening, none if it is absent. |
| B. Semantic fidelity | 20 | Junk values, `ℝ` vs `ℝ≥0∞`, coercions, quantifier order, a.e. vs everywhere — see the pitfalls below. |
| C. Mathlib-concept correctness | 15 | The Mathlib notion must mean the textbook notion, with the typeclass assumptions it needs. |
| D. Non-degeneracy | 10 | Not vacuous, not trivial, not a strictly weaker theorem. |
| E. Hygiene | 5 | No needless definitions, redundant conjuncts or unused hypotheses. |

**Every row of the *Mistakes to check for* table above is a defect.** Charge each one to the band it belongs to and deduct there.

### Fatal — any of these caps the total at 25

- Requirement 1: stating the theorem for `ProbabilityMeasure` or `FiniteMeasure`. For nonnegative measures the variation bound is automatic and the result is a much weaker, already-formalized statement.
- Requirement 5: requiring the weak limit of the subsequence to lie in $M$ turns relative compactness into compactness and makes the equivalence false.
- Requirement 7: dropping the uniform variation bound, which for signed measures does not follow from tightness.
- Requirement 10: assuming separability globally, so that the second conjunct repeats the first instead of stating the theorem's second claim.

### Domain-specific pitfalls for this problem

- The notational trap of this problem is $M$: Bogachev's "measure" in Chapter 8 is *signed*. `Measure X` in Mathlib is nonnegative and `ℝ≥0∞`-valued; the right type is `SignedMeasure X`.
- Tightness must be asserted for the total variation measures $|\mu|$, not for the signed measures. A signed measure is not a measure and `IsTightMeasureSet` does not apply to it directly.
- Weak convergence must be tested against *bounded continuous* functions (`X →ᵇ ℝ`). Compactly supported test functions give vague convergence; unbounded continuous ones are not integrable against a general finite measure.
- The integral of a bounded continuous function against a signed measure has to be built from the Jordan decomposition. An ad-hoc definition that ignores the negative part is not the integral, and every weak-convergence clause built on it is meaningless.
- Separability is `SecondCountableTopology` (equivalently, for metric spaces, `TopologicalSpace.SeparableSpace`), and it belongs to the first claim only. Putting it in the binder list rather than in the first conjunct silently deletes the second claim.
