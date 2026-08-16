# Criteria: engelking_5_1_9_paracompact_partition_of_unity

**Statement:** [engelking_5_1_9_paracompact_partition_of_unity.md](engelking_5_1_9_paracompact_partition_of_unity.md) · **Lean:** [engelking_5_1_9_paracompact_partition_of_unity.lean](engelking_5_1_9_paracompact_partition_of_unity.lean) · **Context:** [engelking_5_1_9_paracompact_partition_of_unity.context.md](engelking_5_1_9_paracompact_partition_of_unity.context.md)

## What the theorem says

A *partition of unity* subordinated to an open cover is a family of continuous functions
$\rho_i \colon X \to [0,1]$ that sum to $1$ at every point, with each $\rho_i$ supported inside the
$i$-th member of the cover. The theorem says three conditions on a space are equivalent: it is
paracompact; every open cover admits a subordinated partition of unity whose supports form a locally
finite family; and every open cover admits a subordinated partition of unity with no local finiteness
required at all. The last item is the surprise — the apparently weaker condition already forces
paracompactness.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The three items appear in Engelking's order as a single equivalence. | ✅ `List.TFAE [ParacompactSpace X, locallyFinitePartition, partition]`. |
| 2 | Hausdorffness is present, because Engelking's "paracompact" includes it and mathlib's `ParacompactSpace` does not. | ✅ `[T2Space X]` as an instance hypothesis, so item (i) `ParacompactSpace X` is Engelking's notion. |
| 3 | Items (ii) and (iii) quantify over **all** open covers of $X$, with an arbitrary index type. | ✅ `∀ (ι : Type v) (U : ι → Set X), IsOpenCover U → …` in both. |
| 4 | "Open cover" is: every member open, and the members' union is everything. | ✅ `IsOpenCover U := (∀ i, IsOpen (U i)) ∧ ⋃ i, U i = univ`. |
| 5 | Item (ii)'s partition of unity is locally finite: the supports form a locally finite family. | ✅ `PartitionOfUnity ι X`, which bundles `LocallyFinite fun i ↦ support (toFun i)` together with continuity, nonnegativity and the sum condition. |
| 6 | Item (iii) has the same data **minus** local finiteness, so it must be written out by hand. | ✅ `∃ ρ : ι → C(X, ℝ), 0 ≤ ρ ∧ (∀ x, HasSum (fun i ↦ ρ i x) 1) ∧ ∀ i, tsupport (ρ i) ⊆ U i`. |
| 7 | The functions are continuous and nonnegative. | ✅ `C(X, ℝ)` for continuity and `0 ≤ ρ` for nonnegativity in item (iii); `nonneg'` inside `PartitionOfUnity` for item (ii). |
| 8 | The functions sum to $1$ at every point, as an unordered sum over a possibly infinite index set. | ✅ `∀ x, HasSum (fun i ↦ ρ i x) 1` in item (iii). |
| 9 | Each function is supported inside the corresponding member of the cover. | ✅ `∀ i, tsupport (ρ i) ⊆ U i` in item (iii); `ρ.IsSubordinate U` in item (ii). |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Assuming only `[T1Space X]` (or nothing) and taking item (i) to be bare `ParacompactSpace X`. | The equivalence becomes false. Take $X = \mathbb{N}$ with the cofinite topology: it is $T_1$ and compact, hence `ParacompactSpace` by mathlib's `paracompact_of_compact` (which assumes no separation). But two nonempty cofinite sets always meet, so every continuous $f \colon X \to \mathbb{R}$ is constant. For the cover $U_n = \mathbb{N} \setminus \{n\}$, any subordinated family has some $\rho_i \neq 0$ with $\operatorname{supp}\rho_i = X \not\subseteq U_i$, under either subordination convention. So (i) holds and (ii), (iii) fail. |
| 2 | Using mathlib's `PartitionOfUnity` for item (iii) as well as item (ii). | `PartitionOfUnity` carries the field `locallyFinite'`, so the two items would be literally the same statement and the theorem would degenerate into a two-way equivalence. |
| 3 | Writing the sum in item (iii) as `∑ᶠ i, ρ i x = 1` (finsum). | Lean defines `finsum` to be `0` unless the support is finite. So item (iii) would secretly demand that only finitely many $\rho_i$ are nonzero at each point — a much stronger condition. |
| 4 | Writing the sum in item (iii) as `∑' i, ρ i x = 1` (tsum). | `tsum` returns `0` for families that are not summable, so a non-summable family could accidentally satisfy or fail the equation for the wrong reason. `HasSum` states summability and the value together. |
| 5 | Dropping nonnegativity of the $\rho_i$. | Signed families summing to $1$ exist on any space, so the condition would stop characterizing anything. |
| 6 | Requiring $\rho_i \le 1$ as an extra hypothesis and treating it as essential. | Not an error of substance, but redundant: nonnegativity plus $\sum_i \rho_i(x) = 1$ already forces $\rho_i \le 1$. |
| 7 | Hand-rolling item (ii) as separate conjuncts and forgetting local finiteness. | Item (ii) then becomes item (iii) and the equivalence is again only two-way. |

## Notes on the ground truth

- **Repaired ground truth.** An earlier version of this statement assumed only `[T1Space X]` and was
  false for the reason in mistake row 1. The current file assumes `[T2Space X]`; candidates must keep
  Hausdorffness, whether as an instance or as an explicit conjunct `T2Space X ∧ ParacompactSpace X`
  in item (i). Note that the mathlib route to (i) $\Rightarrow$ (ii) is
  `PartitionOfUnity.exists_isSubordinate`, which needs `[NormalSpace X]`, supplied by
  `T4Space.of_paracompactSpace_t2Space` — precisely the missing Hausdorff hypothesis.
- The printed statement says "$T_1$-space"; the Lean file says `T2Space`. This is a deliberate
  departure, since Engelking's paracompactness silently includes Hausdorff and item (i) would
  otherwise not mean what he means.
- Subordination is `∀ i, tsupport (ρ i) ⊆ U i`, the closed-support form. It implies Engelking's
  condition that the sets $\{\rho_i \ne 0\}$ refine the cover, and is the standard rendering.
- Every index type quantified in the statement lives in `X`'s own universe. That costs no
  generality — a cover of `X` can always be re-indexed by its image in `Set X` — and it removes
  the free universe parameter, so the statement is about all covers rather than about covers in
  one arbitrary universe. The generic family predicates in `Defs.lean` stay polymorphic in their
  index type, as they should.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[engelking_5_1_9_paracompact_partition_of_unity.md](engelking_5_1_9_paracompact_partition_of_unity.md) and the background in [engelking_5_1_9_paracompact_partition_of_unity.context.md](engelking_5_1_9_paracompact_partition_of_unity.context.md),
not against the ground-truth Lean file: a candidate spelled differently but
mathematically equivalent to the text loses nothing. The scale is defined in
[GRADING.md](../../GRADING.md); the numbers below are this problem's instance of it.

| Band | Points | This problem |
|---|---|---|
| A. Completeness | 50 | The requirement table above has 9 rows, so each row is worth 5.6 points: full credit if the candidate states it in any equivalent form, half for a harmless strengthening or weakening, none if it is absent. |
| B. Semantic fidelity | 20 | Junk values, `ℝ` vs `ℝ≥0∞`, coercions, quantifier order, a.e. vs everywhere — see the pitfalls below. |
| C. Mathlib-concept correctness | 15 | The Mathlib notion must mean the textbook notion, with the typeclass assumptions it needs. |
| D. Non-degeneracy | 10 | Not vacuous, not trivial, not a strictly weaker theorem. |
| E. Hygiene | 5 | No needless definitions, redundant conjuncts or unused hypotheses. |

**Every row of the *Mistakes to check for* table above is a defect.** Charge each one to the band it belongs to and deduct there.

### Fatal — any of these caps the total at 25

- Requirement 6 with local finiteness left in item (iii), collapsing it into item (ii).
- Requirement 8 with the sum asserted only for finitely many nonzero terms, or with no convergence assertion.
- Requirement 2 with Engelking's Hausdorff clause dropped from paracompactness.

### Domain-specific pitfalls for this problem

- Item (iii) is item (ii) *minus* local finiteness, so Mathlib's bundled `PartitionOfUnity` (which builds local finiteness in) can express (ii) but not (iii).
- The subordination condition is on the closed support (`tsupport`), not on the open set where the function is nonzero.
- The sum is over an arbitrary index type and must be an unordered sum equal to $1$ at each point.
- Engelking's "paracompact" carries Hausdorff; Mathlib's `ParacompactSpace` does not.
- The functions are nonnegative and continuous; dropping nonnegativity makes the notion meaningless.
