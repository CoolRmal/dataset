import Dataset.KongODE.Defs
import Mathlib.Analysis.Calculus.ContDiff.Defs
import Mathlib.Analysis.ODE.PicardLindelof
import Mathlib.Analysis.Normed.Algebra.MatrixExponential
import Mathlib.LinearAlgebra.Matrix.NonsingularInverse
import Mathlib.LinearAlgebra.Matrix.Charpoly.Basic
import Mathlib.MeasureTheory.Integral.IntervalIntegral.Basic

/-!
# `kong_2_3_1_variation_of_parameters`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `kong_2_3_1_variation_of_parameters.md`.
Quality rubric: `kong_2_3_1_variation_of_parameters.criteria.md`.
-/

open Filter Function MeasureTheory Set Topology
open scoped ENNReal Matrix NNReal Topology

namespace Dataset
namespace KongODE

/-- Kong 2.3.1, variation of parameters. -/
theorem kong_2_3_1_variation_of_parameters
    {n : ℕ} {I : Set ℝ} {A : ℝ → Matrix (Fin n) (Fin n) ℝ} {f : ℝ → (Fin n → ℝ)}
    {X : ℝ → Matrix (Fin n) (Fin n) ℝ} {t₀ : ℝ}
    (hI : I.OrdConnected) (hA : ContinuousOn A I) (hf : ContinuousOn f I)
    (hX : FundamentalMatrixSolution I A X) (ht₀ : t₀ ∈ I) :
    (∀ y : ℝ → (Fin n → ℝ),
      IsTrajectoryOn I (fun t x ↦ A t *ᵥ x + f t) y ↔
        ∃ c : Fin n → ℝ, ∀ t ∈ I,
          y t = X t *ᵥ c + ∫ s in t₀..t, (X t * (X s)⁻¹) *ᵥ f s) ∧
      ∀ x₀, ∃ y : ℝ → (Fin n → ℝ), y t₀ = x₀ ∧
        IsTrajectoryOn I (fun t x ↦ A t *ᵥ x + f t) y ∧
        (∀ t ∈ I, y t = (X t * (X t₀)⁻¹) *ᵥ x₀ +
          ∫ s in t₀..t, (X t * (X s)⁻¹) *ᵥ f s) ∧
        ∀ z : ℝ → (Fin n → ℝ), z t₀ = x₀ →
          IsTrajectoryOn I (fun t x ↦ A t *ᵥ x + f t) z → Set.EqOn z y I := by
  sorry

end KongODE
end Dataset
