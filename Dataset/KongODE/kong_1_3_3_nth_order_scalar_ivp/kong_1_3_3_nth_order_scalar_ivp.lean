import Dataset.KongODE.Defs
import Mathlib.Analysis.Calculus.ContDiff.Defs
import Mathlib.Analysis.ODE.PicardLindelof
import Mathlib.Analysis.Normed.Algebra.MatrixExponential
import Mathlib.LinearAlgebra.Matrix.NonsingularInverse
import Mathlib.LinearAlgebra.Matrix.Charpoly.Basic
import Mathlib.MeasureTheory.Integral.IntervalIntegral.Basic

/-!
# `kong_1_3_3_nth_order_scalar_ivp`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `kong_1_3_3_nth_order_scalar_ivp.md`.
Quality rubric: `kong_1_3_3_nth_order_scalar_ivp.criteria.md`.
-/

open Filter Function MeasureTheory Set Topology
open scoped ENNReal Matrix NNReal Topology

namespace Dataset
namespace KongODE

/-- Kong 1.3.3, local existence and uniqueness for scalar higher-order IVPs. -/
theorem kong_1_3_3_nth_order_scalar_ivp
    {n : ℕ} {D : Set (ℝ × (Fin n → ℝ))} {g : ℝ → (Fin n → ℝ) → ℝ}
    {t₀ : ℝ} {a : (Fin n → ℝ)} (hD : IsOpen D) (hpoint : (t₀, a) ∈ D) :
    (ContinuousOn (fun p : ℝ × (Fin n → ℝ) ↦ g p.1 p.2) D →
      ∃ γ : ℝ, 0 < γ ∧ let I := Set.Icc (t₀ - γ) (t₀ + γ)
        ∃ y : ℝ → (Fin n → ℝ), IsTrajectoryOn I (companionField g) y ∧ y t₀ = a ∧
          ∀ t ∈ I, (t, y t) ∈ D) ∧
    (ContinuousOn (fun p : ℝ × (Fin n → ℝ) ↦ g p.1 p.2) D →
      LocallyLipschitzInState D (companionField g) →
        ∃ γ : ℝ, 0 < γ ∧ let I := Set.Icc (t₀ - γ) (t₀ + γ)
          ∃ y : ℝ → (Fin n → ℝ), IsTrajectoryOn I (companionField g) y ∧ y t₀ = a ∧
            (∀ t ∈ I, (t, y t) ∈ D) ∧
            ∀ z : ℝ → (Fin n → ℝ), IsTrajectoryOn I (companionField g) z →
              z t₀ = a → (∀ t ∈ I, (t, z t) ∈ D) → Set.EqOn z y I) := by
  sorry

end KongODE
end Dataset
