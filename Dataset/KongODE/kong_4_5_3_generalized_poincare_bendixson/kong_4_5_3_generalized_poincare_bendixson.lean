import Dataset.KongODE.Defs

/-!
# `kong_4_5_3_generalized_poincare_bendixson`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `kong_4_5_3_generalized_poincare_bendixson.md`.
Quality rubric: `kong_4_5_3_generalized_poincare_bendixson.criteria.md`.
-/

open Set

namespace Dataset
namespace KongODE

/-- Kong 4.5.3, the generalized Poincare-Bendixson theorem. -/
theorem kong_4_5_3_generalized_poincare_bendixson
    {F : (Fin 2 → ℝ) → (Fin 2 → ℝ)} {x : ℝ → (Fin 2 → ℝ)}
    {E : Set (Fin 2 → ℝ)}
    (hF : Continuous F)
    (huniq : ∀ x y : ℝ → Fin 2 → ℝ, IsAutonomousTrajectory F x → IsAutonomousTrajectory F y →
      ∀ t₀, x t₀ = y t₀ → x = y) (hcompact : IsCompact E)
    (hfinite : {x ∈ E | F x = 0}.Finite) :
    let classify := fun (s : Set ℝ) (limitSet : Set (Fin 2 → ℝ)) ↦
      (∃ e, limitSet = {e} ∧ F e = 0) ∨
        (∃ y, IsClosedOrbit F y ∧ Set.EqOn x y s) ∨
        (∃ y, IsClosedOrbit F y ∧ limitSet = range y) ∨ GraphicForPlanarSystem F limitSet
    (IsTrajectoryOn (Set.Ici 0) (fun _ y ↦ F y) x → (∀ t, 0 ≤ t → x t ∈ E) →
        classify (Set.Ici 0) (omegaLimitSet x)) ∧
      (IsTrajectoryOn (Set.Iic 0) (fun _ y ↦ F y) x → (∀ t, t ≤ 0 → x t ∈ E) →
        classify (Set.Iic 0) (alphaLimitSet x)) := by
  sorry

end KongODE
end Dataset
