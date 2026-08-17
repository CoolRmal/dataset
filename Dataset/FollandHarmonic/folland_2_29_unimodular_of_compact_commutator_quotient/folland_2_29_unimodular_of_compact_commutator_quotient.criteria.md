# Criteria: folland_2_29_unimodular_of_compact_commutator_quotient

**Statement:** [folland_2_29_unimodular_of_compact_commutator_quotient.md](folland_2_29_unimodular_of_compact_commutator_quotient.md) · **Lean:** [folland_2_29_unimodular_of_compact_commutator_quotient.lean](folland_2_29_unimodular_of_compact_commutator_quotient.lean) · **Context:** [folland_2_29_unimodular_of_compact_commutator_quotient.context.md](folland_2_29_unimodular_of_compact_commutator_quotient.context.md)

## What the theorem says

Let $G$ be a locally compact group. Its modular function $\Delta$ measures how far a left Haar
measure is from being right invariant: $\lambda(Ex) = \Delta(x)\lambda(E)$. When $\Delta$ is
identically $1$ the group is called unimodular, and then one measure is both left and right
invariant.

Write $[G,G]$ for the smallest *closed* subgroup containing all commutators $xyx^{-1}y^{-1}$. The
proposition says: if the coset space $G/[G,G]$ is compact, then $G$ is unimodular. The idea is that
$\Delta$ is a homomorphism into the multiplicative group of positive reals, which is abelian, so
$\Delta$ kills all commutators and factors through $G/[G,G]$; a continuous homomorphism from a
compact group into the positive reals has image a compact subgroup, which must be $\{1\}$.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. The assessment column records how the ground-truth Lean
statement stands against each row; every row is ✅, and the notes at the end record the modelling
choices behind them.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $G$ is a topological group. | ✅ `[Group G] [TopologicalSpace G] [IsTopologicalGroup G]`. |
| 2 | $G$ is locally compact. Without this there is no Haar measure and no modular function. | ✅ `[LocallyCompactSpace G]`. |
| 3 | The subgroup being quotiented out is the *closure* of the commutator subgroup, matching Folland's "smallest closed subgroup". | ✅ `(commutator G).topologicalClosure`. |
| 4 | The hypothesis is that the coset space is compact. | ✅ `[CompactSpace (G ⧸ (commutator G).topologicalClosure)]`, as an instance rather than an explicit argument. |
| 5 | The conclusion is that the modular function takes the value $1$. | ✅ `IsUnimodular G`, defined in `Defs.lean` as `∀ y, Measure.modularCharacterFun y = 1` — the textbook's own word, rather than the equation spelled out at each use. |
| 6 | The conclusion holds at every group element, not at some distinguished one. | ✅ Built into `IsUnimodular`, which quantifies over all of `G`. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Using the bare algebraic subgroup `commutator G` instead of its topological closure. | The algebraic commutator subgroup can be strictly smaller and need not be closed. Its coset space maps continuously onto $G/\overline{[G,G]}$, so assuming *it* is compact is a stronger assumption. The theorem you then state is weaker than the printed one. |
| 2 | Concluding `∃ μ, μ.IsMulRightInvariant` instead of $\Delta \equiv 1$. | The zero measure is right invariant, so this existential is satisfied by every group. Even repaired with `μ ≠ 0` and left invariance it is a restatement, not Folland's assertion about $\Delta$. |
| 3 | Dropping `[LocallyCompactSpace G]`. | The modular function is defined from Haar measure, which requires local compactness; in Mathlib the hypothesis is part of the definition's context. |
| 4 | Assuming $G$ is abelian, or compact, or that $[G,G]$ is trivial. | Each makes the statement immediate and throws away the content, which is exactly the case where $G$ is far from abelian but the abelianisation is small. |
| 5 | Stating the conclusion for a single fixed $x$ supplied by the theorem rather than for all $x$. | Unimodularity is $\Delta \equiv 1$. A statement about one unnamed element says nothing. |
| 6 | Assuming $[G,G]$ is normal as an extra hypothesis. | It is automatically normal, since $z[x,y]z^{-1} = [zxz^{-1}, zyz^{-1}]$ and conjugation is a homeomorphism. Adding it is clutter, not the printed hypothesis. |

## Notes on the ground truth

- `Measure.modularCharacterFun` is Mathlib's $\Delta$. It is `ℝ≥0`-valued and takes no measure
  argument, because the modular function does not depend on which left Haar measure you use. We
  reuse it rather than defining our own.
- Mathlib's $\Delta$ is the reciprocal of Folland's (see the notes on `folland_2_31`). The equation
  $\Delta = 1$ is insensitive to that, so no correction is needed here.
- `Measure.modularCharacterFun` needs only `[TopologicalSpace G] [Group G] [IsTopologicalGroup G]
  [LocallyCompactSpace G]`, so the statement carries no measurable-space or Borel hypotheses.
- The closed commutator subgroup is normal, so `G ⧸ (commutator G).topologicalClosure` is a
  topological group; the statement only needs it as a compact coset space.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[folland_2_29_unimodular_of_compact_commutator_quotient.md](folland_2_29_unimodular_of_compact_commutator_quotient.md) and the background in [folland_2_29_unimodular_of_compact_commutator_quotient.context.md](folland_2_29_unimodular_of_compact_commutator_quotient.context.md),
not against the ground-truth Lean file: a candidate spelled differently but
mathematically equivalent to the text loses nothing. The scale is defined in
[GRADING.md](../../GRADING.md); the numbers below are this problem's instance of it.

| Band | Points | This problem |
|---|---|---|
| A. Completeness | 50 | The requirement table above has 6 rows, so each row is worth 8.3 points: full credit if the candidate states it in any equivalent form, half for a harmless strengthening or weakening, none if it is absent. |
| B. Semantic fidelity | 20 | Junk values, `ℝ` vs `ℝ≥0∞`, coercions, quantifier order, a.e. vs everywhere — see the pitfalls below. |
| C. Mathlib-concept correctness | 15 | The Mathlib notion must mean the textbook notion, with the typeclass assumptions it needs. |
| D. Non-degeneracy | 10 | Not vacuous, not trivial, not a strictly weaker theorem. |
| E. Hygiene | 5 | No needless definitions, redundant conjuncts or unused hypotheses. |

**Every row of the *Mistakes to check for* table above is a defect.** Charge each one to the band it belongs to and deduct there.

### Fatal — any of these caps the total at 25

- Requirement 3 with the *algebraic* commutator subgroup instead of its closure.
- Requirement 2 with local compactness dropped, so that no Haar measure and no modular function exist.
- Requirement 6 with the conclusion asserted at a single element rather than at every element.

### Domain-specific pitfalls for this problem

- The commutator subgroup must be topologically closed; `commutator G` in Mathlib is the algebraic one and `.topologicalClosure` is needed.
- Unimodularity is $\Delta \equiv 1$, a convention-independent statement — no care about which modular-function convention is in use is needed here.
- The hypothesis is compactness of the *quotient*, not of $G$.
- The modular function needs a locally compact group to exist at all.
