module

public import Dataset.KongODE.Defs
public import Mathlib.Analysis.Calculus.ContDiff.Defs
public import Mathlib.Analysis.ODE.PicardLindelof
public import Mathlib.Analysis.Normed.Algebra.MatrixExponential
public import Mathlib.LinearAlgebra.Matrix.NonsingularInverse
public import Mathlib.LinearAlgebra.Matrix.Charpoly.Basic
public import Mathlib.MeasureTheory.Integral.IntervalIntegral.Basic

/-!
# `kong_5_4_2_hopf_friedrich_dichotomy`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `kong_5_4_2_hopf_friedrich_dichotomy.md`.
Quality rubric: `kong_5_4_2_hopf_friedrich_dichotomy.criteria.md`.
-/

@[expose] public section

open Filter Function MeasureTheory Set Topology
open scoped ENNReal Matrix NNReal Topology

namespace Dataset
namespace KongODE

/-- Kong 5.4.2, the Hopf-Friedrich dichotomy. -/
theorem kong_5_4_2_hopf_friedrich_dichotomy
    {F : (Fin 2 → ℝ) → ℝ → (Fin 2 → ℝ)} {β : ℝ}
    (hβ : 0 < β)
    (hF : ContDiff ℝ ⊤ (fun p : (Fin 2 → ℝ) × ℝ ↦ F p.1 p.2) ∧
      (∀ μ, F 0 μ = 0) ∧ Matrix.trace (linearizationMatrix F 0) = 0 ∧
        Matrix.det (linearizationMatrix F 0) = β ^ 2 ∧
          HasDerivAt (fun μ ↦ Matrix.trace (linearizationMatrix F μ)) 0 0) :
    let center :=
      (∃ ε : ℝ, 0 < ε ∧
        ∀ x : ℝ → (Fin 2 → ℝ), IsAutonomousTrajectory (fun y ↦ F y 0) x →
          ‖x 0‖ < ε → (∃ t, x t ≠ x 0) → IsClosedOrbit (fun y ↦ F y 0) x) ∧
      ∃ ε : ℝ, 0 < ε ∧ ∀ μ, 0 < |μ| → |μ| < ε →
        ¬∃ x : ℝ → (Fin 2 → ℝ), IsClosedOrbit (fun y ↦ F y μ) x ∧ ‖x 0‖ < ε
    let hopf := fun positiveSide ↦
      ∃ ε : ℝ, ∃ orbit : ℝ → ℝ → (Fin 2 → ℝ),
        ∃ period : ℝ → ℝ, 0 < ε ∧
        (∀ μ, 0 < |μ| → |μ| < ε → (if positiveSide then 0 < μ else μ < 0) →
          IsClosedOrbit (fun y ↦ F y μ) (orbit μ) ∧ 0 < period μ ∧
            (∀ t, orbit μ (t + period μ) = orbit μ t) ∧
            ∀ y, IsClosedOrbit (fun z ↦ F z μ) y → ‖y 0‖ < ε →
              range y = range (orbit μ)) ∧
        Tendsto (fun μ ↦ ‖orbit μ 0‖) (𝓝[≠] 0) (𝓝 0) ∧
        Tendsto period (𝓝[≠] 0) (𝓝 (2 * Real.pi / β))
    center ∨ hopf true ∨ hopf false := by
  sorry

end KongODE
end Dataset
