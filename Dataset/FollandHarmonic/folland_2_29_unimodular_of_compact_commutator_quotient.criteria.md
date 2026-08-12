# Criteria: folland_2_29_unimodular_of_compact_commutator_quotient

**Statement:** [folland_2_29_unimodular_of_compact_commutator_quotient.md](folland_2_29_unimodular_of_compact_commutator_quotient.md) · **Lean:** [folland_2_29_unimodular_of_compact_commutator_quotient.lean](folland_2_29_unimodular_of_compact_commutator_quotient.lean)

Short statement, two traps: the commutator subgroup here is the **closed** one (Folland says "the smallest closed subgroup containing all $[x,y]$"), and unimodularity means the modular function is identically $1$, not merely that some particular Haar measure is right invariant.

Legend: ✅ ground truth satisfies the criterion · ⚠️ ground truth acceptable but improvable · ❗ trap — known/likely model error to check in candidate statements.

| # | Category | Criterion / potential error | Assessment of ground truth |
|---|----------|-----------------------------|----------------------------|
| 1 | Faithful encoding | `[G,G]` is the topological closure of `commutator G`, not `commutator G` itself; for a general topological group the algebraic commutator subgroup need not be closed. | ✅ `(commutator G).topologicalClosure`. ❗ Predicted error: bare `commutator G`, which states a weaker hypothesis and hence a stronger (and unproved) theorem. |
| 2 | Faithful encoding | `G/[G,G]` compact is `CompactSpace` of the coset space; the closed commutator subgroup is normal, so this is also the quotient group. | ✅ `CompactSpace (G ⧸ (commutator G).topologicalClosure)`. |
| 3 | Conclusion completeness | Unimodular means `Δ ≡ 1`, stated for an arbitrary `x`. | ✅ `Measure.modularCharacterFun x = 1` with `x` universally quantified as a parameter. ❗ Predicted error: `∃ μ, μ.IsMulRightInvariant`, which is implied but is not Folland's `Δ ≡ 1`. |
| 4 | Mathlib conventions | `modularCharacterFun` is mathlib's `Δ`, valued in `ℝ≥0`; it needs `[LocallyCompactSpace G]` and `[IsTopologicalGroup G]` but no measure argument. | ✅ Reused rather than re-defined, and no spurious measure hypothesis. ⚠️ Mathlib's `Δ` is the reciprocal of Folland's on some conventions; the statement `Δ = 1` is insensitive to that. |
| 5 | Hypothesis completeness | Local compactness is needed for `Δ` to be defined at all. | ✅ `[LocallyCompactSpace G]`. |
