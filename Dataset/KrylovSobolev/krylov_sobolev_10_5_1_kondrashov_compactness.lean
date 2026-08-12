module

public import Dataset.KrylovSobolev.Defs
public import Mathlib.MeasureTheory.Function.LpSeminorm.Basic

/-!
# `krylov_sobolev_10_5_1_kondrashov_compactness`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `krylov_sobolev_10_5_1_kondrashov_compactness.md`.
Quality rubric: `krylov_sobolev_10_5_1_kondrashov_compactness.criteria.md`.
-/

@[expose] public section

open Filter Function MeasureTheory Set Topology
open scoped ContDiff ENNReal Topology

namespace Dataset
namespace KrylovSobolev

/-- Krylov 10.5.1, Kondrashov's theorem: on a bounded domain of class `C^k`, a set that
is bounded in `W_p^k(Ω)` is precompact in `W_q^m(Ω)` whenever `k - d/p > m - d/q`. -/
theorem krylov_sobolev_10_5_1_kondrashov_compactness {d : ℕ} (p q : ℝ) (k m : ℕ)
    (hp : 1 ≤ p) (hq : 1 ≤ q) (hm : m < k)
    (Ω : TopologicalSpace.Opens (EuclideanSpace ℝ (Fin d))) (hΩ : IsCkDomain k Ω)
    (hkm : (m : ℝ) - d / q < (k : ℝ) - d / p)
    (U : Set (EuclideanSpace ℝ (Fin d) → ℝ))
    (hU : ∀ u ∈ U, MemSobolevOn (ENNReal.ofReal p) k Ω u)
    (hbdd : ∃ M : ℝ≥0∞, M ≠ (∞ : ℝ≥0∞) ∧ ∀ u ∈ U, ∀ D, IsSobolevFamilyOn k Ω u D →
      sobolevNorm (ENNReal.ofReal p) k Ω D ≤ M)
    (F : ℕ → EuclideanSpace ℝ (Fin d) → ℝ) (hF : ∀ n, F n ∈ U)
    (DF : ℕ → (Fin d → ℕ) → EuclideanSpace ℝ (Fin d) → ℝ)
    (hDF : ∀ n, IsSobolevFamilyOn m Ω (F n) (DF n)) :
    ∃ (σ : ℕ → ℕ) (g : EuclideanSpace ℝ (Fin d) → ℝ)
      (Dg : (Fin d → ℕ) → EuclideanSpace ℝ (Fin d) → ℝ), StrictMono σ ∧
      MemSobolevOn (ENNReal.ofReal q) m Ω g ∧ IsSobolevFamilyOn m Ω g Dg ∧
      Tendsto (fun n ↦ ∑ α ∈ multiIndicesLE d m,
          eLpNorm (DF (σ n) α - Dg α) (ENNReal.ofReal q) (volume.restrict Ω)) atTop (𝓝 0) := by
  sorry

end KrylovSobolev
end Dataset
