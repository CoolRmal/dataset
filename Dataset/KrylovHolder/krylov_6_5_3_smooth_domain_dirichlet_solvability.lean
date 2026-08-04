module

public import Dataset.KrylovHolder.Defs
public import Mathlib.Analysis.Calculus.ContDiff.Basic
public import Mathlib.Analysis.Calculus.IteratedDeriv.Defs
public import Mathlib.MeasureTheory.Integral.Bochner.Basic
public import Mathlib.MeasureTheory.Measure.Haar.NormedSpace
public import Mathlib.MeasureTheory.Measure.Hausdorff

/-!
# `krylov_6_5_3_smooth_domain_dirichlet_solvability`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `krylov_6_5_3_smooth_domain_dirichlet_solvability.md`.
Quality rubric: `krylov_6_5_3_smooth_domain_dirichlet_solvability.criteria.md`.
-/

@[expose] public section

open Filter Function MeasureTheory Set Topology
open scoped ENNReal Topology

namespace Dataset
namespace KrylovHolder

/-- Krylov 6.5.3, the Holder Dirichlet problem on a smooth domain. -/
theorem krylov_6_5_3_smooth_domain_dirichlet_solvability
    {d k : ℕ} {δ : ℝ} {Ω : Set (EuclideanSpace ℝ (Fin d))}
    {L : (EuclideanSpace ℝ (Fin d) → ℝ) → EuclideanSpace ℝ (Fin d) → ℝ}
    (hδ : 0 < δ ∧ δ < 1) (hΩ : SmoothBoundedDomain Ω)
    (hL : SecondOrderEllipticOperator L 0)
    (hcoeff : OperatorCoefficientsHolder 2 (k + δ) L) :
    ∀ f g, HolderOn (k + δ) Ω f → HolderOn (k + 2 + δ) (closure Ω) g →
      ∃ u, HolderOn (k + 2 + δ) Ω u ∧ EllipticDirichletSolution Ω L f g u ∧
        ∀ v, HolderOn (k + 2 + δ) Ω v → EllipticDirichletSolution Ω L f g v →
          Set.EqOn v u (closure Ω) := by
  sorry

end KrylovHolder
end Dataset
