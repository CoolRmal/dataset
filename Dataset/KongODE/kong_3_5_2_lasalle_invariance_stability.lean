module

public import Dataset.KongODE.Defs
public import Mathlib.Analysis.Calculus.ContDiff.Defs
public import Mathlib.Analysis.ODE.PicardLindelof
public import Mathlib.Analysis.Normed.Algebra.MatrixExponential
public import Mathlib.LinearAlgebra.Matrix.NonsingularInverse
public import Mathlib.LinearAlgebra.Matrix.Charpoly.Basic
public import Mathlib.MeasureTheory.Integral.IntervalIntegral.Basic

/-!
# `kong_3_5_2_lasalle_invariance_stability`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `kong_3_5_2_lasalle_invariance_stability.md`.
Quality rubric: `kong_3_5_2_lasalle_invariance_stability.criteria.md`.
-/

@[expose] public section

open Filter Function MeasureTheory Set Topology
open scoped ENNReal Matrix NNReal Topology

namespace Dataset
namespace KongODE

/-- Kong 3.5.2, LaSalle's invariance principle. -/
theorem kong_3_5_2_lasalle_invariance_stability
    {n : ℕ} {l : ℝ} {F : (Fin n → ℝ) → (Fin n → ℝ)} {V : (Fin n → ℝ) → ℝ}
    (hl : 0 < l) (hV : LyapunovFunctionOnBall l V F)
    (horbit : NoNontrivialOrbitInZeroDerivativeSet l V F) :
    AsymptoticallyStableZeroSolution (fun _ x ↦ F x) := by
  sorry

end KongODE
end Dataset
