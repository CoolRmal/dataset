# Criteria: folland_4_32_pontryagin_duality

**Statement:** [folland_4_32_pontryagin_duality.md](folland_4_32_pontryagin_duality.md) · **Lean:** [folland_4_32_pontryagin_duality.lean](folland_4_32_pontryagin_duality.lean) · **Context:** [folland_4_32_pontryagin_duality.context.md](folland_4_32_pontryagin_duality.context.md)

## What the theorem says

A locally compact abelian group is canonically isomorphic to its double dual, and the isomorphism is the
evaluation map: $x$ goes to the character of $\widehat{G}$ that sends $\xi$ to $\xi(x)$. Both halves
matter — that this particular map is bijective, and that it and its inverse are continuous.

## What a correct formalization must contain

Each row is one thing the Lean statement has to say. A formalization that is missing any
row is incomplete. In the assessment column, ✅ means the ground truth states the requirement and
◐ means it states it in a form that deliberately departs from the text — a narrower setting, a
stronger hypothesis, or an equivalent but not literal phrasing — with the reason given. A ◐ records
a decision, not an open defect; where a more literal rendering would be at least as good, the row
says so.

| # | Requirement | Does the ground truth have it? |
|---|-------------|-------------------------------|
| 1 | $G$ is a locally compact **abelian** Hausdorff topological group. | ✅ `[CommGroup G] [TopologicalSpace G] [IsTopologicalGroup G] [LocallyCompactSpace G] [T2Space G]`. |
| 2 | The target is the **double** dual, $\widehat{\widehat{G}}$. | ✅ `PontryaginDual (PontryaginDual G)`. |
| 3 | The dual is the group of continuous characters into the circle. | ✅ Mathlib's `PontryaginDual A` is `A →ₜ* Circle`, with the compact-open topology. |
| 4 | The map is a **group isomorphism**. | ✅ `ContinuousMulEquiv` extends `MulEquiv`. |
| 5 | It is also a **homeomorphism**, in both directions. | ✅ `ContinuousMulEquiv` extends `Homeomorph`, so the inverse is continuous too. |
| 6 | The map is the specific one of (4.29): evaluation, $\Phi(x)(\xi) = \xi(x)$. | ✅ `∀ x ξ, Φ x ξ = ξ x`, conjoined to the existence claim. |

## Mistakes to check for

Each row is an error we expect models to make. A formalization that makes any of these is
wrong, even if it compiles.

| # | Mistake | Why it is wrong |
|---|---------|-----------------|
| 1 | Asserting only that $G$ and $\widehat{\widehat{G}}$ are isomorphic, without identifying the map. | Much weaker, and it is not what "the map $\Phi$ defined by (4.29) is an isomorphism" says. Naturality of the isomorphism is the content. |
| 2 | Producing a continuous bijective homomorphism rather than an isomorphism of topological groups. | For locally compact groups a continuous bijective homomorphism need not be open, so the inverse need not be continuous. |
| 3 | Dropping local compactness. | Duality fails for general topological abelian groups. |
| 4 | Dropping commutativity. | The dual group is only a group when $G$ is abelian. |
| 5 | Using the single dual, or the dual of the double dual. | A different statement. |
| 6 | Taking characters valued in $\mathbb{C}^\times$ rather than the circle, or dropping continuity of the characters. | Both change the dual group. |
| 7 | Stating the evaluation identity with the arguments swapped, `ξ (Φ x)`. | Ill-typed as mathematics: $\Phi(x)$ is a character of $\widehat{G}$, so it eats $\xi$, not the other way round. |

## Notes on the ground truth

- Mathlib defines `PontryaginDual` and proves that it is again a locally compact abelian group, but
  does **not** have the duality theorem, so this statement is not a restatement of a library result.
- `ContinuousMulEquiv` bundles the multiplicative equivalence with the homeomorphism, which is exactly
  Folland's "isomorphism of topological groups"; requirements 4 and 5 are both carried by it.
- The Hausdorff hypothesis is stated explicitly, since Mathlib's `PontryaginDual` does not presuppose it
  while Folland's standing convention for locally compact groups does.

## Grading (out of 100)

Grade a candidate Lean statement of this problem against the textbook statement in
[folland_4_32_pontryagin_duality.md](folland_4_32_pontryagin_duality.md) and the background in [folland_4_32_pontryagin_duality.context.md](folland_4_32_pontryagin_duality.context.md),
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

- Requirement 6 omitted, so an unspecified isomorphism is produced: naturality is the content of the theorem.
- Requirement 5 weakened to a continuous bijective homomorphism, whose inverse need not be continuous.
- Requirement 1 with local compactness or commutativity dropped.

### Domain-specific pitfalls for this problem

- The map is evaluation, fixed by (4.29); an abstract isomorphism is a strictly weaker claim.
- An isomorphism of topological groups needs continuity in both directions, which a bundled equivalence supplies and a bare bijective homomorphism does not.
- Characters take values in the circle and are continuous; changing either changes the dual group.
- The target is the double dual, and $\Phi(x)$ is a character *of the dual*, so it is applied to $\xi$.
