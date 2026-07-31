module

public import Dataset.KrylovHolder.Defs
public import Mathlib.Analysis.Calculus.ContDiff.Basic
public import Mathlib.Analysis.Calculus.IteratedDeriv.Defs
public import Mathlib.MeasureTheory.Integral.Bochner.Basic
public import Mathlib.MeasureTheory.Measure.Haar.NormedSpace
public import Mathlib.MeasureTheory.Measure.Hausdorff

/-!
# `krylov_10_3_3_parabolic_dirichlet_domain_solvability`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `krylov_10_3_3_parabolic_dirichlet_domain_solvability.md`.
Quality rubric: `krylov_10_3_3_parabolic_dirichlet_domain_solvability.criteria.md`.
-/

@[expose] public section

open Filter Function MeasureTheory Set Topology
open scoped ENNReal Topology

namespace Dataset
namespace KrylovHolder

/-- Krylov 10.3.3, the parabolic Dirichlet problem in a domain. -/
theorem krylov_10_3_3_parabolic_dirichlet_domain_solvability
    {d : ℕ} {δ : ℝ} {Q : Set (ℝ × (Fin d → ℝ))}
    {L : ((ℝ × (Fin d → ℝ)) → ℝ) → (ℝ × (Fin d → ℝ)) → ℝ}
    (hδ : 0 < δ ∧ δ < 1)
    (hQ : IsOpen Q ∧ Bornology.IsBounded Q ∧ Q.Nonempty)
    (hL : ParabolicOperator L) (hcoeff : ParabolicOperatorCoefficientsHolder δ Q L) :
    ∀ f g, ParabolicHolderOn δ Q f → ParabolicHolderOn (2 + δ) Q g →
      ∃ u, ParabolicHolderOn (2 + δ) Q u ∧
        ParabolicDirichletSolution Q L f g u ∧
        ∀ v, ParabolicHolderOn (2 + δ) Q v →
          ParabolicDirichletSolution Q L f g v →
            Set.EqOn v u (Q ∪ parabolicBoundary Q) := by
  sorry

end KrylovHolder
end Dataset
