import Dataset.NikolskiOperators.Defs

/-!
# `nikolski_B_3_2_nevanlinna_pick_interpolation` — 3.2.4

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `nikolski_B_3_2_nevanlinna_pick_interpolation.md`.
Quality rubric: `nikolski_B_3_2_nevanlinna_pick_interpolation.criteria.md`.
-/

namespace Dataset
namespace NikolskiOperators

/--
Nikol'ski, *Operators, Functions, and Systems*, Volume 1, Part B, Section 3.2:
Nevanlinna-Pick interpolation: finite disk data admit a Schur-class interpolant
if and only if the Pick matrix is positive semidefinite.
-/
theorem nikolski_B_3_2_nevanlinna_pick_interpolation
    {n : ℕ} {z w : Fin n → ℂ} (hz : ∀ i : Fin n, z i ∈ Metric.ball (0 : ℂ) 1)
    (hz_injective : Function.Injective z) :
    let solutions := {f : ℂ → ℂ | SchurFunction f ∧ ∀ i : Fin n, f (z i) = w i}
    (solutions.Nonempty ↔ PositiveSemidefiniteMatrix (pickMatrix z w)) ∧
      (solutions.Nonempty →
        ((∀ f ∈ solutions, ∀ g ∈ solutions, Set.EqOn f g (Metric.ball (0 : ℂ) 1)) ↔
          Matrix.det (pickMatrix z w) = 0)) := by
  sorry

end NikolskiOperators
end Dataset
