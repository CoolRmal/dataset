# Criteria: folland_3_34_gelfand_raikov

**Statement:** [folland_3_34_gelfand_raikov.md](folland_3_34_gelfand_raikov.md) · **Lean:** [folland_3_34_gelfand_raikov.lean](folland_3_34_gelfand_raikov.lean) · **Context:** [folland_3_34_gelfand_raikov.context.md](folland_3_34_gelfand_raikov.context.md)

## What the theorem says

A locally compact group has enough irreducible unitary representations to tell its elements apart: given
two distinct points, some irreducible unitary representation takes different values at them. Equivalently,
the irreducible representations separate points. This is the culmination of Folland's Chapter 3 and rests
on the GNS construction together with the theory of functions of positive type.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. In the assessment column, ✅ means the ground truth states the requirement and
◐ means it states it in a form that deliberately departs from the text — a narrower setting, a
stronger hypothesis, or an equivalent but not literal phrasing — with the reason given. A ◐ records
a decision, not an open defect; where a more literal rendering would be at least as good, the row
says so.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $G$ is a locally compact (Hausdorff) topological group; nothing more is assumed. | ✅ `[Group G] [TopologicalSpace G] [IsTopologicalGroup G] [LocallyCompactSpace G] [T2Space G]`. |
| 2 | The two points are distinct. | ✅ `(x y : G) (hxy : x ≠ y)`. |
| 3 | The representation is produced *after* the points, so it may depend on them. | ✅ The existential over `H` and `π` sits inside the binders for `x`, `y`. |
| 4 | The representation space is a complex **Hilbert** space: inner product and complete. | ✅ `NormedAddCommGroup H`, `InnerProductSpace ℂ H`, `CompleteSpace H`. |
| 5 | The representation space is **nonzero**, or irreducibility is vacuous. | ✅ `Nontrivial H` among the produced instances. |
| 6 | $\pi$ is a homomorphism into the **unitary** operators. | ✅ `UnitaryRepresentation`: `map_one`, `map_mul` and `mem_unitary`. |
| 7 | $\pi$ is continuous in the **strong** operator topology. | ✅ `strongly_continuous : ∀ v, Continuous fun x ↦ π.toFun x v`. |
| 8 | Irreducibility quantifies over **closed** invariant subspaces and admits only the trivial ones. | ✅ `UnitaryRepresentation.Irreducible`, over `K : Submodule ℂ H` with `IsClosed (K : Set H)`. |
| 9 | The conclusion is that $\pi$ takes different **values** at $x$ and $y$. | ✅ `π.toFun x ≠ π.toFun y`, an inequality of operators. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Requiring $\pi$ to be norm continuous. | Far too strong: for most groups the only norm-continuous representations are trivial on the connected component, and the theorem would be false. |
| 2 | Dropping closedness from the definition of irreducibility. | Every infinite-dimensional representation has proper non-closed invariant subspaces, so the condition would be unsatisfiable. |
| 3 | Omitting `Nontrivial H`. | The zero space has $\bot = \top$, so the zero representation counts as irreducible while separating nothing. |
| 4 | Quantifying the representation before the pair of points. | That asserts one irreducible representation is faithful, which is false in general. |
| 5 | Asking only that $\pi$ be a homomorphism into bounded invertible operators. | Unitarity is part of the statement and is what the GNS construction supplies. |
| 6 | Concluding $\pi(x) \ne \pi(y)$ for some *unitary* representation without irreducibility. | Much weaker, and immediate from the regular representation. |
| 7 | Fixing the Hilbert space in advance, e.g. to $\ell^2$ or a finite-dimensional space. | The dimension cannot be bounded in general; compact groups aside, irreducible representations are usually infinite dimensional. |

## Notes on the ground truth

- Mathlib has no unitary representations of topological groups, so `UnitaryRepresentation` and its
  `Irreducible` predicate are defined in `Defs.lean`. Unitarity is `π x ∈ unitary (H →L[ℂ] H)`, which
  is Mathlib's predicate and unfolds to the pair of adjoint identities.
- The Hilbert space is produced in the same universe as `G`. The GNS construction builds it from a
  quotient of a function space on `G`, so this is the right strength.
- No measure appears: although the proof runs through $L^1(G)$ and functions of positive type, the
  statement itself is purely representation-theoretic.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[folland_3_34_gelfand_raikov.md](folland_3_34_gelfand_raikov.md) and the background in [folland_3_34_gelfand_raikov.context.md](folland_3_34_gelfand_raikov.context.md),
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

- Requirement 7 with norm continuity in place of strong continuity: the theorem becomes false.
- Requirement 8 with closedness dropped from irreducibility, making the condition unsatisfiable.
- Requirement 3 with the representation quantified before the points, which asserts a faithful irreducible representation.

### Domain-specific pitfalls for this problem

- Continuity of a unitary representation is always in the strong operator topology.
- Irreducibility is about *closed* invariant subspaces; without closedness no representation qualifies.
- The representation space must be nonzero, or the zero representation is vacuously irreducible.
- Unitarity is `π x ∈ unitary (H →L[ℂ] H)`, equivalently `π x` adjoint-invertible on both sides; invertibility alone is weaker.
- The conclusion compares the *operators* `π x` and `π y`, not their actions on a chosen vector.
