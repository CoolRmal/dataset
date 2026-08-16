import Dataset.KongODE.Defs

/-!
# `kong_3_5_2_lasalle_invariance_stability`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `kong_3_5_2_lasalle_invariance_stability.md`.
Quality rubric: `kong_3_5_2_lasalle_invariance_stability.criteria.md`.
-/

namespace Dataset
namespace KongODE

/-- Kong 3.5.2, LaSalle's invariance principle. -/
theorem kong_3_5_2_lasalle_invariance_stability
    {n : ℕ} {l : ℝ} {F : (Fin n → ℝ) → (Fin n → ℝ)} {V : (Fin n → ℝ) → ℝ}
    (hl : 0 < l) (hF : Continuous F)
    (huniq : ∀ x y : ℝ → Fin n → ℝ, IsAutonomousTrajectory F x → IsAutonomousTrajectory F y →
      ∀ t₀, x t₀ = y t₀ → x = y)
    (hF0 : F 0 = 0)
    (hV : LyapunovFunctionOnBall l V F)
    (horbit : NoNontrivialOrbitInZeroDerivativeSet l V F) :
    AsymptoticallyStableZeroSolution (fun _ x ↦ F x) := by
  sorry

end KongODE
end Dataset
