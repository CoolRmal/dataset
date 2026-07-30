module

public import Dataset.KrylovHolder.Defs
public import Mathlib.Analysis.Calculus.ContDiff.Basic
public import Mathlib.Analysis.Calculus.IteratedDeriv.Defs
public import Mathlib.MeasureTheory.Integral.Bochner.Basic
public import Mathlib.MeasureTheory.Measure.Haar.NormedSpace
public import Mathlib.MeasureTheory.Measure.Hausdorff

/-!
# `krylov_2_5_2_harmonic_smooth_interior_estimates`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `krylov_2_5_2_harmonic_smooth_interior_estimates.md`.
Quality rubric: `krylov_2_5_2_harmonic_smooth_interior_estimates.criteria.md`.
-/

@[expose] public section

open Filter Function MeasureTheory Set Topology
open scoped ENNReal Topology

namespace Dataset
namespace KrylovHolder

/-- Krylov 2.5.2, smoothness and interior estimates for harmonic functions. -/
theorem krylov_2_5_2_harmonic_smooth_interior_estimates
    {d : ℕ} {Ω : Set (Fin d → ℝ)} {u : (Fin d → ℝ) → ℝ}
    (hΩ : IsOpen Ω ∧ IsConnected Ω) (hu : HarmonicIn Ω u) :
    ContDiffOn ℝ ⊤ u Ω ∧
      ∀ α : (Fin d → ℕ), ∃ C : ℝ, 0 ≤ C ∧ ∀ x ∈ Ω,
        ∀ R : ℝ, 0 < R → Metric.closedBall x R ⊆ Ω →
          |multiDerivative α u x| ≤ C * R ^ (-(∑ i, α i : ℤ)) *
            sSup {|u y| | y ∈ Metric.closedBall x R} := by
  sorry

end KrylovHolder
end Dataset
