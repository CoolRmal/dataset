import Dataset.KongODE.Defs

/-!
# `kong_5_4_2_hopf_friedrich_dichotomy`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `kong_5_4_2_hopf_friedrich_dichotomy.md`.
Quality rubric: `kong_5_4_2_hopf_friedrich_dichotomy.criteria.md`.
-/

open Filter Set
open scoped Topology ContDiff

namespace Dataset
namespace KongODE

/-- Kong 5.4.2, the Hopf-Friedrich dichotomy. -/
theorem kong_5_4_2_hopf_friedrich_dichotomy
    {F : (Fin 2 → ℝ) → ℝ → (Fin 2 → ℝ)} {β : ℝ}
    (hβ : 0 < β)
    (hF : ContDiff ℝ ω (fun p : (Fin 2 → ℝ) × ℝ ↦ F p.1 p.2) ∧
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
          IsClosedOrbit (fun y ↦ F y μ) (orbit μ) ∧
            IsLeast {T | 0 < T ∧ ∀ t, orbit μ (t + T) = orbit μ t} (period μ) ∧
            ∀ y, IsClosedOrbit (fun z ↦ F z μ) y → ‖y 0‖ < ε →
              range y = range (orbit μ)) ∧
        (∀ μ, 0 < |μ| → |μ| < ε → (if positiveSide then μ < 0 else 0 < μ) →
          ¬∃ y : ℝ → (Fin 2 → ℝ), IsClosedOrbit (fun z ↦ F z μ) y ∧ ‖y 0‖ < ε) ∧
        Tendsto (fun μ ↦ ⨆ t : ℝ, ‖orbit μ t‖)
          (if positiveSide then 𝓝[>] 0 else 𝓝[<] 0) (𝓝 0) ∧
        Tendsto period (if positiveSide then 𝓝[>] 0 else 𝓝[<] 0)
          (𝓝 (2 * Real.pi / β))
    center ∨ hopf true ∨ hopf false := by
  sorry

end KongODE
end Dataset
