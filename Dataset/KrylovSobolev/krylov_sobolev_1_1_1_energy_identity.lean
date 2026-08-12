module

public import Dataset.KrylovSobolev.Defs
public import Mathlib.Analysis.Calculus.ContDiff.Basic
public import Mathlib.MeasureTheory.Integral.Bochner.Basic

/-!
# `krylov_sobolev_1_1_1_energy_identity`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `krylov_sobolev_1_1_1_energy_identity.md`.
Quality rubric: `krylov_sobolev_1_1_1_energy_identity.criteria.md`.
-/

@[expose] public section

open Filter Function MeasureTheory Set Topology
open scoped ContDiff ENNReal Laplacian Topology

namespace Dataset
namespace KrylovSobolev

/-- Krylov 1.1.1, the `𝓛₂` energy identity for the equation `λu - Δu = f` in `ℝ^d`. -/
theorem krylov_sobolev_1_1_1_energy_identity {d : ℕ} (lam : ℝ) (hlam : 0 < lam)
    (u f : EuclideanSpace ℝ (Fin d) → ℝ)
    (hu : ContDiff ℝ 2 u) (hsupp : HasCompactSupport u)
    (heq : ∀ x, lam * u x - Δ u x = f x) :
    lam ^ 2 * (∫ x, u x ^ 2) +
          2 * lam * (∑ j, ∫ x, directionalDerivativeList [j] u x ^ 2) +
          (∑ j, ∑ k, ∫ x, directionalDerivativeList [j, k] u x ^ 2) =
        ∫ x, f x ^ 2 := by
  sorry

end KrylovSobolev
end Dataset
