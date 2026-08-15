# Criteria: mattila_18_1_besicovitch_federer_projection

**Statement:** [mattila_18_1_besicovitch_federer_projection.md](mattila_18_1_besicovitch_federer_projection.md) · **Lean:** [mattila_18_1_besicovitch_federer_projection.lean](mattila_18_1_besicovitch_federer_projection.lean) · **Context:** [mattila_18_1_besicovitch_federer_projection.context.md](mattila_18_1_besicovitch_federer_projection.context.md)

## What the theorem says

Let $A \subset \mathbb{R}^n$ be measurable with $\mathcal{H}^m(A) < \infty$. The Besicovitch–Federer
theorem characterizes rectifiability by how $A$ looks after projection onto $m$-dimensional
subspaces, averaged over the Grassmannian $G(n,m)$ with its rotation-invariant probability measure
$\gamma_{n,m}$. Part (1): $A$ is $m$-rectifiable — covered up to a null set by countably many
Lipschitz images of $\mathbb{R}^m$ — exactly when every measurable subset of $A$ of positive measure
projects onto a set of positive $\mathcal{H}^m$ measure for almost every subspace. Part (2): $A$ is
purely $m$-unrectifiable — it meets every rectifiable set in a null set — exactly when $A$ itself
projects onto a null set for almost every subspace. So rectifiable sets cast big shadows in almost
all directions, and purely unrectifiable ones cast invisible shadows in almost all directions.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | The Grassmannian must carry a fixed measurable structure, so that "for $\gamma_{n,m}$ almost all $V$" is determined. | ✅ `Defs.lean` gives `Grassmannian n m` the topology induced by the projection operators, then its Borel $\sigma$-algebra and a `BorelSpace` instance. |
| 2 | $\gamma_{n,m}$ is a probability measure invariant under every linear isometry of $\mathbb{R}^n$. | ✅ `γ : Measure (Grassmannian n m)` with `hγ : IsInvariantGrassmannianMeasure γ`. |
| 3 | $A$ is $\mathcal{H}^m$ measurable with $\mathcal{H}^m(A) < \infty$. | ✅ `hA : MeasurableSet A`, `hAfin : μH[(m : ℝ)] A < ∞`. ⚠️ The book's "$\mathcal{H}^m$ measurable" is Carathéodory measurability, `NullMeasurableSet A μH[(m:ℝ)]`; Borel `MeasurableSet` is stronger and so gives a slightly weaker theorem. |
| 4 | Part (1) is a biconditional between rectifiability of $A$ and the projection condition, with the "for almost every $V$" quantifier **inside** the "for every subset $B$" quantifier. | ✅ `RectifiableSet n m A ↔ ∀ B, MeasurableSet B → B ⊆ A → 0 < μH[(m:ℝ)] B → ∀ᵐ V ∂γ, 0 < μH[(m:ℝ)] (P_V '' B)`. |
| 5 | The test sets $B$ in part (1) are the measurable subsets of $A$ with positive $\mathcal{H}^m$ measure. | ✅ All three conditions appear as hypotheses of the inner implication. |
| 6 | Part (2) is a biconditional between pure unrectifiability of $A$ and $\mathcal{H}^m(P_V A) = 0$ for almost every $V$. | ✅ `PurelyUnrectifiableSet n m A ↔ ∀ᵐ V ∂γ, μH[(m:ℝ)] (P_V '' A) = 0`. |
| 7 | Rectifiability (15.3): countably many Lipschitz maps $\mathbb{R}^m \to \mathbb{R}^n$, each with its own constant, covering the set up to an $\mathcal{H}^m$-null set. | ✅ `RectifiableSet n m E = ∃ f : ℕ → …, (∀ j, ∃ K : ℝ≥0, LipschitzWith K (f j)) ∧ μH[(m:ℝ)] (E \ ⋃ j, range (f j)) = 0`. |
| 8 | Pure unrectifiability: the set meets **every** $m$-rectifiable set in an $\mathcal{H}^m$-null set. | ✅ `PurelyUnrectifiableSet n m A = ∀ E, RectifiableSet n m E → μH[(m:ℝ)] (A ∩ E) = 0`. |
| 9 | $P_V$ is the orthogonal projection onto $V$, and $\mathcal{H}^m$ of the image is measured inside $V$. | ✅ `(fun x ↦ V.1.orthogonalProjectionOnto x) '' B`, where `Submodule.orthogonalProjectionOnto : E →L[ℝ] ↥V.1` lands in the subtype; the value agrees with the ambient one because the inclusion of $V$ is an isometry. |
| 10 | Both biconditionals, in both directions, are asserted. | ✅ A conjunction of two `↔`s. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Leaving the $\sigma$-algebra on $G(n,m)$ as an unconstrained instance argument. | Invariance plus total mass $1$ characterizes $\gamma_{n,m}$ only relative to the Borel structure of its natural topology. With the trivial $\sigma$-algebra a Dirac measure qualifies, "for a.e. $V$" collapses to "for all $V$", and part (1)'s forward direction already fails for a line segment in $\mathbb{R}^2$ projected onto the orthogonal line. |
| 2 | Writing `∀ᵐ V ∂γ, ∀ B, …` in part (1). | That demands one full-measure set of directions that works for all subsets $B$ simultaneously — strictly stronger than the theorem, and false. |
| 3 | Asserting `MeasurableSet (P_V '' B)`, or wrapping the image in `toMeasurable`. | Projections of measurable sets need not be Borel. `μH[·]` is an outer measure defined on all sets, so no measurability of the image is needed, and assuming it is unjustified. |
| 4 | Requiring one Lipschitz constant for the whole family in the definition of rectifiability, or requiring exact containment $E \subseteq \bigcup_i f_i(\mathbb{R}^m)$. | Definition 15.3 gives each map its own constant and only asks for containment up to an $\mathcal{H}^m$-null set. Either change alters which sets count as rectifiable. |
| 5 | Keeping only "rectifiable $\Rightarrow$ projections have positive measure". | Both directions of both biconditionals are part of 18.1, and the reverse implications are the hard ones. |
| 6 | Collapsing parts (1) and (2) into a single dichotomy. | Part (2) is not the formal negation of part (1); the dichotomy additionally needs the decomposition theorem, which is a separate result. |
| 7 | Dropping $\mathcal{H}^m(A) < \infty$. | Both parts need it; the projection characterization fails for sets of infinite measure. |

## Notes on the ground truth

- An earlier version left the measurable structure on the Grassmannian as an unconstrained instance
  argument; that defect has been repaired in `Defs.lean` and survives above as Mistake 1.
- ⚠️ `MeasurableSet` is used both for $A$ and for the test sets $B$, where the book means
  $\mathcal{H}^m$ measurability. On $A$ this weakens the theorem; on $B$ it shrinks the family of
  test sets, which weakens the forward direction of part (1) and strengthens the reverse one.
  `NullMeasurableSet · μH[(m:ℝ)]` would be the literal rendering.
- ⚠️ `hm : 0 < m` and `hmn : m < n` are our additions. They exclude the degenerate cases the text
  nominally covers: at $m = n$ the Grassmannian is a single point and $P_V$ is the identity. Harmless
  but a narrowing.
- The Hausdorff exponent is the real cast `(m : ℝ)` of the natural number `m` throughout, and the
  comparisons `0 < μH[(m:ℝ)] B` and `μH[(m:ℝ)] (…) = 0` are made in `ℝ≥0∞`, where they are the right
  junk-free readings for a possibly infinite measure.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[mattila_18_1_besicovitch_federer_projection.md](mattila_18_1_besicovitch_federer_projection.md) and the background in [mattila_18_1_besicovitch_federer_projection.context.md](mattila_18_1_besicovitch_federer_projection.context.md),
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

- Requirement 5 with the quantifiers over $B$ and over $V$ interchanged.
- Requirement 8 with pure unrectifiability quantified over some family rather than all rectifiable sets.
- Requirement 10 with either biconditional reduced to one direction.

### Domain-specific pitfalls for this problem

- In part (1) the null set of bad directions may depend on the test set $B$; hoisting the "almost all $V$" outside states something stronger.
- $P_V$ is the orthogonal projection, and $\mathcal{H}^m$ of the image is computed in $V$ with its inherited metric.
- Rectifiability is by countably many Lipschitz maps with a null remainder; pure unrectifiability is a statement about intersections with *every* rectifiable set.
- Finiteness of $\mathcal{H}^m(A)$ is a hypothesis.
- The Grassmannian carries an invariant probability measure and a fixed measurable structure.
