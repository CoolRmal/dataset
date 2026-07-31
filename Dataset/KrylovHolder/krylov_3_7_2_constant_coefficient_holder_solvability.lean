module

public import Dataset.KrylovHolder.Defs
public import Mathlib.Analysis.Calculus.ContDiff.Basic
public import Mathlib.Analysis.Calculus.IteratedDeriv.Defs
public import Mathlib.MeasureTheory.Integral.Bochner.Basic
public import Mathlib.MeasureTheory.Measure.Haar.NormedSpace
public import Mathlib.MeasureTheory.Measure.Hausdorff

/-!
# `krylov_3_7_2_constant_coefficient_holder_solvability`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `krylov_3_7_2_constant_coefficient_holder_solvability.md`.
Quality rubric: `krylov_3_7_2_constant_coefficient_holder_solvability.criteria.md`.
-/

@[expose] public section

open Filter Function MeasureTheory Set Topology
open scoped ENNReal Topology

namespace Dataset
namespace KrylovHolder

/-- Krylov 3.7.2, global Holder solvability for constant coefficients. -/
theorem krylov_3_7_2_constant_coefficient_holder_solvability
    {d m k : ℕ} {δ lam : ℝ} {L : ((Fin d → ℝ) → ℝ) → (Fin d → ℝ) → ℝ}
    (hm : 0 < m) (hδ : 0 < δ ∧ δ < 1) (hlam : lam ≠ 0)
    (hL : ConstantCoefficientEllipticOperator m L) :
    ∀ f, HolderOn (k + δ) univ f →
      ∃! u, HolderOn (k + m + δ) univ u ∧ ShiftedEllipticEquation L lam u f := by
  sorry

end KrylovHolder
end Dataset
