import Dataset.KrylovSobolev.Defs

/-!
# `krylov_sobolev_10_4_2_seminorm_embedding_forces_scaling_relation`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `krylov_sobolev_10_4_2_seminorm_embedding_forces_scaling_relation.md`.
Quality rubric:
`krylov_sobolev_10_4_2_seminorm_embedding_forces_scaling_relation.criteria.md`.
-/

open MeasureTheory
open scoped ContDiff NNReal

namespace Dataset
namespace KrylovSobolev

/-- Krylov Exercise 10.4.2: if the top-order seminorm bound `[u]_{W_q^m(Ω)} ≤ N [u]_{W_p^k(Ω)}`
holds on `C_0^∞(Ω)` for `Ω = ℝ^d` or `Ω = ℝ^d_+` with `N` independent of `u`, then `m ≤ k` and
`k - d/p = m - d/q`. Here `Finset.piAntidiag univ k` is the set of multi-indices with `|α| = k`. -/
theorem krylov_sobolev_10_4_2_seminorm_embedding_forces_scaling_relation {d : ℕ} [NeZero d]
    {Ω : Set (EuclideanSpace ℝ (Fin d))}
    (hΩ : Ω = Set.univ ∨ Ω = {x : EuclideanSpace ℝ (Fin d) | 0 < x 0})
    {k m : ℕ} (hk : 1 ≤ k) {p q : ℝ} (hp : 1 ≤ p) (hq : 0 < q)
    (hemb : ∃ N : ℝ≥0, ∀ u : EuclideanSpace ℝ (Fin d) → ℝ, ContDiff ℝ ∞ u → HasCompactSupport u →
      tsupport u ⊆ Ω →
      (∑ α ∈ Finset.piAntidiag Finset.univ m,
          eLpNorm (multiDeriv α u) (ENNReal.ofReal q) (volume.restrict Ω)) ≤
        N * ∑ α ∈ Finset.piAntidiag Finset.univ k,
          eLpNorm (multiDeriv α u) (ENNReal.ofReal p) (volume.restrict Ω)) :
    m ≤ k ∧ (k : ℝ) - (d : ℝ) / p = (m : ℝ) - (d : ℝ) / q := by
  sorry

end KrylovSobolev
end Dataset
