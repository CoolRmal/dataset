module

public import Dataset.KongODE.Defs
public import Mathlib.Analysis.Calculus.ContDiff.Defs
public import Mathlib.Analysis.ODE.PicardLindelof
public import Mathlib.Analysis.Normed.Algebra.MatrixExponential
public import Mathlib.LinearAlgebra.Matrix.NonsingularInverse
public import Mathlib.LinearAlgebra.Matrix.Charpoly.Basic
public import Mathlib.MeasureTheory.Integral.IntervalIntegral.Basic

/-!
# `kong_4_5_3_generalized_poincare_bendixson`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `kong_4_5_3_generalized_poincare_bendixson.md`.
Quality rubric: `kong_4_5_3_generalized_poincare_bendixson.criteria.md`.
-/

@[expose] public section

open Filter Function MeasureTheory Set Topology
open scoped ENNReal Matrix NNReal Topology

namespace Dataset
namespace KongODE

/-- Kong 4.5.3, the generalized Poincare-Bendixson theorem. -/
theorem kong_4_5_3_generalized_poincare_bendixson
    {F : (Fin 2 → ℝ) → (Fin 2 → ℝ)} {x : ℝ → (Fin 2 → ℝ)}
    {E : Set (Fin 2 → ℝ)}
    (hF : ContDiff ℝ 1 F) (hcompact : IsCompact E) (horbit : IsAutonomousTrajectory F x)
    (hfinite : {x ∈ E | F x = 0}.Finite) :
    let classify := fun limitSet : Set (Fin 2 → ℝ) ↦
      (∃ e, limitSet = {e} ∧ F e = 0) ∨ IsClosedOrbit F x ∨
        (∃ y, IsClosedOrbit F y ∧ limitSet = range y) ∨ GraphicForPlanarSystem F limitSet
    ((∀ t, 0 ≤ t → x t ∈ E) → classify (omegaLimitSet x)) ∧
      ((∀ t, t ≤ 0 → x t ∈ E) → classify (alphaLimitSet x)) := by
  sorry

end KongODE
end Dataset
