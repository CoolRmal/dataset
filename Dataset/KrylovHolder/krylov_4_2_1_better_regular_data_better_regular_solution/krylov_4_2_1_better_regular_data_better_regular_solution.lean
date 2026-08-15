module

public import Dataset.KrylovHolder.Defs
public import Mathlib.Analysis.Calculus.ContDiff.Basic
public import Mathlib.Analysis.Calculus.IteratedDeriv.Defs
public import Mathlib.MeasureTheory.Integral.Bochner.Basic
public import Mathlib.MeasureTheory.Measure.Haar.NormedSpace
public import Mathlib.MeasureTheory.Measure.Hausdorff

/-!
# `krylov_4_2_1_better_regular_data_better_regular_solution`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `krylov_4_2_1_better_regular_data_better_regular_solution.md`.
Quality rubric: `krylov_4_2_1_better_regular_data_better_regular_solution.criteria.md`.
-/

@[expose] public section

open Filter Function MeasureTheory Set Topology
open scoped ENNReal Topology

namespace Dataset
namespace KrylovHolder

/-- Krylov 4.2.1, improved regularity and the high-parameter Schauder estimate. -/
theorem krylov_4_2_1_better_regular_data_better_regular_solution
    {d m k : ℕ} {δ K₁ : ℝ}
    {L : (EuclideanSpace ℝ (Fin d) → ℝ) → EuclideanSpace ℝ (Fin d) → ℝ}
    (hm : 0 < m) (hδ : 0 < δ ∧ δ < 1) (hK₁ : 1 ≤ K₁)
    (hL : VariableCoefficientEllipticOperator m L)
    (hcoeff : OperatorCoefficientsHolder m (k + δ) L)
    (hcoeffBound : OperatorCoefficientGaugeLE m k δ (ENNReal.ofReal K₁) L) :
    ∃ lam₀ : ℝ, 0 < lam₀ ∧ ∃ C : ℝ≥0∞, C < ∞ ∧
      ∀ (lam : ℝ) (u f : EuclideanSpace ℝ (Fin d) → ℝ),
      HolderOn (m + δ) univ u → ShiftedEllipticEquation L lam u f →
      HolderOn (k + δ) univ f → HolderOn (k + m + δ) univ u ∧
        (lam₀ ≤ lam →
          holderGauge (k + m) δ univ u +
              ENNReal.rpow (ENNReal.ofReal |lam|) ((((k + m : ℕ) : ℝ) + δ) / m) *
                functionSupNorm univ u ≤
            C * (holderGauge k δ univ f +
              ENNReal.rpow (ENNReal.ofReal |lam|) ((((k : ℕ) : ℝ) + δ) / m) *
                functionSupNorm univ f)) := by
  sorry

end KrylovHolder
end Dataset
