import Mathlib.Analysis.CStarAlgebra.GelfandNaimarkSegal

/-!
# `conway_VIII_5_17_gelfand_naimark` — VIII.5.17

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `conway_VIII_5_17_gelfand_naimark.md`.
Quality rubric: `conway_VIII_5_17_gelfand_naimark.criteria.md`.
-/

namespace Dataset
namespace ConwayFunctionalAnalysis

universe u

/-- Conway VIII.5.17, the Gelfand-Naimark representation theorem. -/
theorem conway_VIII_5_17_gelfand_naimark {A : Type u} [NonUnitalCStarAlgebra A] :
    (∃ (H : Type u) (_ : NormedAddCommGroup H) (_ : InnerProductSpace ℂ H)
      (_ : CompleteSpace H) (π : A →⋆ₙₐ[ℂ] (H →L[ℂ] H)), Isometry π) ∧
    (TopologicalSpace.SeparableSpace A →
      ∃ (H : Type u) (_ : NormedAddCommGroup H) (_ : InnerProductSpace ℂ H)
        (_ : CompleteSpace H) (_ : TopologicalSpace.SeparableSpace H)
        (π : A →⋆ₙₐ[ℂ] (H →L[ℂ] H)), Isometry π) := by
  sorry

end ConwayFunctionalAnalysis
end Dataset
