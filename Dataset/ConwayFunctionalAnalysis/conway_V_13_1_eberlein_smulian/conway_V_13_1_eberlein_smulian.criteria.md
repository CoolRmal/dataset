# Criteria: conway_V_13_1_eberlein_smulian

**Statement:** [conway_V_13_1_eberlein_smulian.md](conway_V_13_1_eberlein_smulian.md) · **Lean:** [conway_V_13_1_eberlein_smulian.lean](conway_V_13_1_eberlein_smulian.lean) · **Context:** [conway_V_13_1_eberlein_smulian.context.md](conway_V_13_1_eberlein_smulian.context.md)

## What the theorem says

Let $\mathcal{X}$ be a Banach space and $A$ any subset of it. Three conditions are equivalent: every
sequence in $A$ has a subsequence converging weakly; every sequence in $A$ has a weak cluster point;
and the weak closure of $A$ is weakly compact. "Weak" means the topology $\sigma(\mathcal{X},
\mathcal{X}^*)$ throughout. The surprise is the first two being equivalent: in a general topological
space a cluster point of a sequence need not be the limit of any subsequence, and this theorem says
that in the weak topology it always is.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. In the assessment column, ✅ means the ground truth states the requirement and
◐ means it states it in a form that deliberately departs from the text — a narrower setting, a
stronger hypothesis, or an equivalent but not literal phrasing — with the reason given. A ◐ records
a decision, not an open defect; where a more literal rendering would be at least as good, the row
says so.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $\mathcal{X}$ is a Banach space — normed, and complete. | ✅ `[NormedAddCommGroup E] [NormedSpace ℂ E] [CompleteSpace E]`. Completeness is genuinely used. |
| 2 | $A$ is an arbitrary subset, with no further conditions. | ✅ `(A : Set E)`, bare. |
| 3 | The weak topology is used, not the norm topology. | ✅ Everything is transported through `toWeakSpace ℂ E` into `WeakSpace ℂ E`, Mathlib's type synonym carrying $\sigma(\mathcal{X}, \mathcal{X}^*)$. |
| 4 | Item (a): every sequence with values in $A$ has a subsequence — a strictly increasing reindexing — converging weakly to some point of $\mathcal{X}$. | ✅ `∀ u : ℕ → E, (∀ n, u n ∈ A) → ∃ φ : ℕ → ℕ, StrictMono φ ∧ ∃ x : E, Tendsto (fun n ↦ toWeakSpace ℂ E (u (φ n))) atTop (𝓝 (toWeakSpace ℂ E x))`. |
| 5 | The limit in item (a) may lie anywhere in $\mathcal{X}$, not necessarily in $A$. | ✅ `∃ x : E` with no membership condition. |
| 6 | Item (b): every sequence with values in $A$ has a weak *cluster point* — a topological cluster point of the sequence viewed as a net, not a subsequential limit. | ✅ `∃ x : E, MapClusterPt (toWeakSpace ℂ E x) atTop (fun n ↦ toWeakSpace ℂ E (u n))`, which unfolds to `ClusterPt x (map u atTop)`. |
| 7 | Item (c): the closure of $A$ in the weak topology is compact in the weak topology. | ✅ `IsCompact (closure (toWeakSpace ℂ E '' A))`, with both the closure and the compactness computed inside `WeakSpace ℂ E`. |
| 8 | "Each sequence of elements of $A$" is a universal quantifier over such sequences, in both (a) and (b). | ✅ `∀ u : ℕ → E, (∀ n, u n ∈ A) → …` in both items. |
| 9 | All three items appear in one equivalence. | ✅ `List.TFAE [subsequences, clusterPoints, IsCompact (closure (toWeakSpace ℂ E '' A))]`, a list of length 3. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Encoding "weak cluster point" in item (b) as "some subsequence converges weakly to $x$". | Item (b) then repeats item (a) word for word, and the equivalence (a) ⟺ (b) — the entire content of the theorem — becomes trivial. This is the single most likely failure here. |
| 2 | Computing the closure in item (c) in the norm topology, i.e. `toWeakSpace ℂ E '' closure A`. | The norm closure is in general a strictly smaller set than the weak closure, so the item asserted is not equivalent to the printed one. |
| 3 | Writing item (c) as `IsCompact A` in `E`. | That is norm compactness, which is far stronger and makes the equivalence false — the closed unit ball of an infinite-dimensional reflexive space satisfies (a) and (b) but is not norm compact. |
| 4 | Using `WeakDual ℂ E` for the weak topology on $\mathcal{X}$. | `WeakDual` carries the weak-\* topology on the *dual* space. It is a different topology on a different space. |
| 5 | Adding a hypothesis such as `Bornology.IsBounded A`, `IsClosed A` or `Convex ℝ A`. | None appears in V.13.1. Each restricts the class of sets covered, so the theorem stated is strictly weaker. |
| 6 | Formalizing only two of the three items, usually dropping (b). | The theorem is a three-way equivalence and (b) is where the content lives. |
| 7 | Dropping `StrictMono φ` in item (a), or demanding `x ∈ A`. | Without strict monotonicity `u ∘ φ` is not a subsequence. Requiring the limit to lie in $A$ makes (a) false for sets that are not weakly closed, so the equivalence breaks. |
| 8 | Using `∃ u` rather than `∀ u` in item (a) or (b). | That inverts the statement: "some sequence has a convergent subsequence" is far weaker than "every sequence does". |

## Notes on the ground truth

- Stating (a) and (b) by testing against functionals — for instance
  `∀ φ : E →L[ℂ] ℂ, Tendsto (fun n ↦ φ (u (φ' n))) atTop (𝓝 (φ x))` — is equivalent and acceptable.
  In practice a candidate that does this usually cannot state (c) and falls back to a norm-topology
  claim, so check (c) carefully in that case.
- Sequences "of elements of $A$" are written as `u : ℕ → E` plus `∀ n, u n ∈ A`. Using the subtype
  `u : ℕ → A` is equivalent.
- **Deliberate departure.** Conway allows $\mathcal{X}$ over $\mathbb{R}$ or $\mathbb{C}$; the Lean fixes `NormedSpace ℂ E`.
  Nothing is lost, since the weak topology of a complex space agrees with the weak topology of its
  underlying real space. A version parametrized by `RCLike 𝕜` would cover the text exactly and
  should not be penalized in a candidate.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[conway_V_13_1_eberlein_smulian.md](conway_V_13_1_eberlein_smulian.md) and the background in [conway_V_13_1_eberlein_smulian.context.md](conway_V_13_1_eberlein_smulian.context.md),
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

- Requirement 3 with the norm topology substituted anywhere: in the norm topology the three conditions are equivalent for trivial reasons and the theorem is lost.
- Requirement 5 with the limit required to lie in $A$.
- Requirement 9 stated as a chain of implications rather than a full equivalence, or with an item omitted.

### Domain-specific pitfalls for this problem

- Everything must be transported into the weak topology (Mathlib's `WeakSpace ℂ E` via `toWeakSpace`); writing `Tendsto` in the ambient normed space is norm convergence.
- A cluster point of a sequence is `MapClusterPt`, not the limit of a subsequence — conflating the two assumes the theorem.
- "Weak closure" is the closure taken inside the weak topology; the norm closure is a different (smaller) set.
- $A$ carries no hypotheses; adding boundedness or convexity states a special case.
