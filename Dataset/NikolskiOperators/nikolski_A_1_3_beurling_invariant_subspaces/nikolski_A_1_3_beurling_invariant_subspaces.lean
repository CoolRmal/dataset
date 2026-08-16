import Dataset.NikolskiOperators.Defs

/-!
# `nikolski_A_1_3_beurling_invariant_subspaces` — 1.3.2

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `nikolski_A_1_3_beurling_invariant_subspaces.md`.
Quality rubric: `nikolski_A_1_3_beurling_invariant_subspaces.criteria.md`.
-/

open Filter MeasureTheory
open scoped Topology

namespace Dataset
namespace NikolskiOperators

/-- Nikol'ski A.1.3.2, the Beurling--Helson theorem for simply invariant `L²` subspaces. -/
theorem nikolski_A_1_3_beurling_invariant_subspaces
    {E : Set (ℝ → ℂ)} (hlinear : IsCircleL2Subspace E)
    (hclosed : ∀ f : ℝ → ℂ, MemLp f 2 circleMeasure →
      (∃ approximant : ℕ → ℝ → ℂ, (∀ j, approximant j ∈ E) ∧
        Tendsto (fun j ↦ eLpNorm (approximant j - f) 2 circleMeasure) atTop (𝓝 0)) → f ∈ E)
    (hshiftProper : {g : ℝ → ℂ | ∃ f ∈ E,
      g =ᵐ[circleMeasure] fun t ↦ Complex.exp (Complex.I * t) * f t} ⊂ E) :
    ∃ theta : ℝ → ℂ, UnimodularGeneratedSubspace E theta ∧
      ∀ eta : ℝ → ℂ, UnimodularGeneratedSubspace E eta →
        ∃ c : ℂ, ‖c‖ = 1 ∧ eta =ᵐ[circleMeasure] fun t ↦ c * theta t := by
  sorry

end NikolskiOperators
end Dataset
