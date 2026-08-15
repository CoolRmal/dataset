import Dataset.KrylovHolder.Defs
import Mathlib.Analysis.Calculus.ContDiff.Basic
import Mathlib.Analysis.Calculus.IteratedDeriv.Defs
import Mathlib.MeasureTheory.Integral.Bochner.Basic
import Mathlib.MeasureTheory.Measure.Haar.NormedSpace
import Mathlib.MeasureTheory.Measure.Hausdorff

/-!
# `krylov_10_3_3_parabolic_dirichlet_domain_solvability`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `krylov_10_3_3_parabolic_dirichlet_domain_solvability.md`.
Quality rubric: `krylov_10_3_3_parabolic_dirichlet_domain_solvability.criteria.md`.
-/

open Filter Function MeasureTheory Set Topology
open scoped ENNReal Topology

namespace Dataset
namespace KrylovHolder

/-- Krylov 10.3.3, the parabolic Dirichlet problem in a domain. -/
theorem krylov_10_3_3_parabolic_dirichlet_domain_solvability
    {d : ℕ} {δ : ℝ} {Q : Set (ℝ × EuclideanSpace ℝ (Fin d))}
    {L : ((ℝ × EuclideanSpace ℝ (Fin d)) → ℝ) →
      (ℝ × EuclideanSpace ℝ (Fin d)) → ℝ}
    (hδ : 0 < δ ∧ δ < 1)
    (hL : ParabolicOperator L) (hQ : RegularParabolicDomain Q L)
    (hcoeff : ParabolicOperatorCoefficientsHolder δ Q L) :
    ∀ f g, ParabolicHolderOn δ Q f → ParabolicHolderOn (2 + δ) (closure Q) g →
      ∃ u, ParabolicHolderOn (2 + δ) Q u ∧
        ParabolicDirichletSolution Q L f g u ∧
        ∀ v, ParabolicHolderOn (2 + δ) Q v →
          ParabolicDirichletSolution Q L f g v →
            Set.EqOn v u (Q ∪ parabolicBoundary Q) := by
  sorry

end KrylovHolder
end Dataset
