# Criteria: engelking_8_4_13_smirnov_proximity_compactification

**Statement:** [engelking_8_4_13_smirnov_proximity_compactification.md](engelking_8_4_13_smirnov_proximity_compactification.md) · **Lean:** [engelking_8_4_13_smirnov_proximity_compactification.lean](engelking_8_4_13_smirnov_proximity_compactification.lean) · **Context:** [engelking_8_4_13_smirnov_proximity_compactification.context.md](engelking_8_4_13_smirnov_proximity_compactification.context.md)

## What the theorem says

A *proximity* on a space is a relation "$A$ is close to $B$" between subsets, obeying a short list of
axioms, and compatible with the topology in the sense that the closure of $A$ is the set of points
close to $A$. Every compactification $cX$ of a Tychonoff space $X$ produces one: declare $A$ close to
$B$ when the closures of their images in $cX$ meet. Smirnov's theorem says this assignment is a
one-to-one correspondence — every proximity on $X$ arises this way, and two compactifications giving
the same proximity are equivalent, meaning there is a homeomorphism between them matching up the two
copies of $X$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. In the assessment column, ✅ means the ground truth states the requirement and
◐ means it states it in a form that deliberately departs from the text — a narrower setting, a
stronger hypothesis, or an equivalent but not literal phrasing — with the reason given. A ◐ records
a decision, not an open defect; where a more literal rendering would be at least as good, the row
says so.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $X$ is Tychonoff. | ✅ `[T35Space X]`, mathlib's exact analogue of Engelking's Tychonoff. |
| 2 | "Compactification" is a dense embedding into a compact **Hausdorff** space. | ✅ `IsCompactification e := IsEmbedding e ∧ DenseRange e ∧ IsCompact (univ : Set K) ∧ T2Space K`. |
| 3 | The proximity axioms: $\emptyset$ is close to nothing; overlapping sets are close; the relation is symmetric; $A \cup B$ is close to $C$ exactly when $A$ or $B$ is. | ✅ The fields `empty_left`, `intersects`, `symmetric`, `union_left` of the `Proximity` structure. |
| 4 | The strong (Efremovič) axiom: if $A$ is not close to $B$, there is a set $E$ with $A$ not close to $E$ and $E^{c}$ not close to $B$. | ✅ `strong : ∀ A B, ¬close A B → ∃ E, ¬close A E ∧ ¬close Eᶜ B`. |
| 5 | The proximity is compatible with the **given** topology of $X$: $\overline{A}$ is the set of points close to $A$. | ✅ `closure_eq : ∀ A : Set X, closure A = {x \| close {x} A}`, using the ambient `closure`. |
| 6 | The assigned proximity is defined by an "if and only if": $A$ is close to $B$ exactly when the closures **in $cX$** of $e(A)$ and $e(B)$ meet. | ✅ `IsAssignedProximity e p := ∀ A B, p.close A B ↔ (closure (e '' A) ∩ closure (e '' B)).Nonempty`, with closures taken in `K`. |
| 7 | Clause (a): every compactification is assigned a proximity. | ✅ `∀ K tK e, IsCompactification e → ∃ p : Proximity X, IsAssignedProximity e p`. |
| 8 | Clause (b), surjectivity: every proximity on $X$ comes from some compactification. | ✅ `∀ p : Proximity X, ∃ K _ e, IsCompactification e ∧ IsAssignedProximity e p`. |
| 9 | Clause (c), injectivity up to equivalence: two compactifications assigned the same proximity are equivalent. | ✅ The third conjunct, concluding `EquivalentCompactifications e f`. |
| 10 | "Equivalent" means a homeomorphism that matches the embeddings, not merely a homeomorphism. | ✅ `EquivalentCompactifications e f := ∃ h : K ≃ₜ L, h ∘ e = f`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Stating only clause (b), "every proximity comes from a compactification". | The usual truncation. Without injectivity there is no correspondence, only a surjection, and the theorem's content is lost. |
| 2 | Dropping the strong axiom from the `Proximity` structure. | Without it the structures are mere "basic proximities", which do not correspond to compactifications. Clause (b) then becomes false. |
| 3 | Omitting the compatibility field `closure_eq`, or stating it only for singletons or closed sets. | The correspondence would then be with proximities on the underlying *set*. The same set carries proximities inducing different topologies, so the theorem is false without this axiom. |
| 4 | Taking closures in $X$ rather than in $cX$, or comparing $e(A) \cap e(B)$ with no closures at all. | Gives a different relation, which is not even a proximity — the whole point is that the compactification is where the extra "closeness" appears. |
| 5 | Stating the assigned proximity as a one-way implication rather than an `iff`. | It is a definition of the assignment; one direction alone does not determine the relation. |
| 6 | Replacing equivalence of compactifications by `Nonempty (K ≃ₜ L)`. | Strictly weaker and wrong as a characterization: inequivalent compactifications of the same space can be homeomorphic as bare spaces. |
| 7 | Using `CompactSpace K` without `T2Space K`. | Engelking's "compact" includes Hausdorff, and the Smirnov correspondence is with compact Hausdorff compactifications only. |

## Notes on the ground truth

- "Establishes a one-to-one correspondence" is not itself a formal statement, so the whole modelling
  decision is how to unfold it. The ground truth unfolds it as the three conjuncts (a), (b), (c).
- Uniqueness of the proximity in clause (a) needs no separate conjunct: `IsAssignedProximity e p`
  determines `p.close` completely, and two `Proximity` values with equal `close` fields are equal.
- The converse of clause (c) is stated as well: equivalent compactifications induce the same
  proximity, so the correspondence is one-to-one in both directions.
- Mathlib has no proximity spaces and no Smirnov theorem, so the `Proximity` structure and the
  compactification predicates are hand-rolled; `Homeomorph`, `IsEmbedding`, `DenseRange`, `closure`
  and `Set.Nonempty` are the correct mathlib primitives. `union_left` is stated on the left only,
  which suffices given `symmetric`.
- **Deliberate departure.** `T2Space K` and `IsCompact univ` appear as `Prop`-conjuncts rather than instances. This is
  forced by `tK` being a bound variable and is acceptable.
- **Deliberate departure.** Compactifications are quantified over `K L : Type v` with `v` free, whereas the compactification
  constructed in clause (b) naturally lives in `Type u` (a quotient of a space built from
  `Set (Set X)`). For `v` below `u`, clause (b) may be unsatisfiable for size reasons, so `Type u`
  (or `Type (max u v)`) would be the safe choice.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[engelking_8_4_13_smirnov_proximity_compactification.md](engelking_8_4_13_smirnov_proximity_compactification.md) and the background in [engelking_8_4_13_smirnov_proximity_compactification.context.md](engelking_8_4_13_smirnov_proximity_compactification.context.md),
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

- Requirement 4: dropping the Efremovič (strong) axiom, without which the correspondence is false.
- Requirement 10 with "equivalent" read as a bare homeomorphism rather than one commuting with the embeddings.
- Requirement 8 or 9 omitted, so that the "one-to-one correspondence" is asserted only in one direction.

### Domain-specific pitfalls for this problem

- The compatibility axiom $\overline{A} = \{x : \{x\}\,\delta\,A\}$ ties the proximity to the given topology; a proximity structure without it is unrelated to $X$'s topology.
- The assignment $\delta(c)$ is a biconditional definition in terms of closures of images inside $cX$.
- "One-to-one correspondence" unpacks into existence, surjectivity and injectivity-up-to-equivalence; all three are needed.
- A compactification is a *dense embedding* into a compact Hausdorff space, and Engelking's "compact" includes Hausdorff.
