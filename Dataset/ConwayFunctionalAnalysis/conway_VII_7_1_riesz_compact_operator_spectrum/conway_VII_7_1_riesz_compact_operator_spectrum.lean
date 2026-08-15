import Mathlib.Analysis.CStarAlgebra.GelfandNaimarkSegal
import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.InnerProductSpace.Adjoint
import Mathlib.Analysis.Normed.Operator.Compact.Basic
import Mathlib.MeasureTheory.Measure.Complex
import Mathlib.MeasureTheory.VectorMeasure.Integral
import Mathlib.Topology.Algebra.Module.Spaces.WeakDual
import Mathlib.Topology.ContinuousMap.Bounded.Basic
import Mathlib.Tactic.TFAE

/-!
# `conway_VII_7_1_riesz_compact_operator_spectrum` — VII.7.1

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `conway_VII_7_1_riesz_compact_operator_spectrum.md`.
Quality rubric: `conway_VII_7_1_riesz_compact_operator_spectrum.criteria.md`.
-/

open Filter MeasureTheory Set Topology
open scoped BoundedContinuousFunction Topology

namespace Dataset
namespace ConwayFunctionalAnalysis

universe u

/-- Conway VII.7.1, Riesz's spectral theorem for compact operators. -/
theorem conway_VII_7_1_riesz_compact_operator_spectrum
    {E : Type*} [NormedAddCommGroup E] [NormedSpace ℂ E] [CompleteSpace E]
    (hE : ¬FiniteDimensional ℂ E) (T : E →L[ℂ] E) (hT : IsCompactOperator T) :
    spectrum ℂ T = {0} ∨
      (∃ n : ℕ, 0 < n ∧ ∃ eig : Fin n → ℂ,
        Function.Injective eig ∧ (∀ i, eig i ≠ 0) ∧
        spectrum ℂ T = insert 0 (range eig) ∧
        ∀ i, (∃ x : E, x ≠ 0 ∧ T x = eig i • x) ∧
          FiniteDimensional ℂ
            (LinearMap.ker
              (T - eig i • ContinuousLinearMap.id ℂ E).toLinearMap)) ∨
      ∃ eig : ℕ → ℂ,
        Function.Injective eig ∧ (∀ n, eig n ≠ 0) ∧
        spectrum ℂ T = insert 0 (range eig) ∧ Tendsto eig atTop (𝓝 0) ∧
        ∀ n, (∃ x : E, x ≠ 0 ∧ T x = eig n • x) ∧
          FiniteDimensional ℂ
            (LinearMap.ker
              (T - eig n • ContinuousLinearMap.id ℂ E).toLinearMap) := by
  sorry

end ConwayFunctionalAnalysis
end Dataset
