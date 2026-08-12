module

public import Dataset.KrylovSobolev.Defs
public import Mathlib.Analysis.SpecialFunctions.Pow.NNReal
public import Mathlib.MeasureTheory.Function.LpSeminorm.Basic
public import Mathlib.MeasureTheory.Integral.Bochner.Basic

/-!
# `krylov_sobolev_10_2_1_morrey_embedding`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `krylov_sobolev_10_2_1_morrey_embedding.md`.
Quality rubric: `krylov_sobolev_10_2_1_morrey_embedding.criteria.md`.
-/

@[expose] public section

open Filter Function MeasureTheory Set Topology
open scoped ContDiff ENNReal Topology

namespace Dataset
namespace KrylovSobolev

/-- Krylov 10.2.1, Morrey's theorem: a Campanato-type mean-oscillation bound on the
gradient forces a Hölder-continuous modification, and for `p > d` the hypothesis holds
automatically with `α = 1 - d/p` and `M = ‖u_x‖_{𝓛_p(Ω)}`. -/
theorem krylov_sobolev_10_2_1_morrey_embedding {d : ℕ} (κ : ℝ) :
    (∀ α : ℝ, 0 < α → α ≤ 1 → ∃ N : ℝ, 0 ≤ N ∧
        ∀ (Ω : TopologicalSpace.Opens (EuclideanSpace ℝ (Fin d))) (u : EuclideanSpace ℝ (Fin d) → ℝ)
          (D : (Fin d → ℕ) → EuclideanSpace ℝ (Fin d) → ℝ) (M : ℝ),
          IsConvexDomainWith κ Ω → 0 ≤ M → MemSobolevOn 1 1 Ω u →
          IsSobolevFamilyOn 1 Ω u D →
          (∀ (z : EuclideanSpace ℝ (Fin d)) (r : ℝ), 0 < r →
            Metric.ball z r ⊆ (Ω : Set (EuclideanSpace ℝ (Fin d))) →
            ⨍ x in Metric.ball z r, gradNorm D x ≤ M * r ^ (α - 1)) →
          ∃ v : EuclideanSpace ℝ (Fin d) → ℝ, v =ᵐ[volume.restrict Ω] u ∧
            (∀ x ∈ Ω, ∀ y ∈ Ω, |v x - v y| ≤ N * M * ‖x - y‖ ^ α) ∧
            ∀ x ∈ Ω, ENNReal.ofReal |v x| ≤
              ENNReal.ofReal (N * M) + unitBallAverageSup (Ω : Set (EuclideanSpace ℝ (Fin d))) u) ∧
      ∀ p : ℝ, 1 ≤ p → (d : ℝ) < p → ∃ N : ℝ, 0 ≤ N ∧
        ∀ (Ω : TopologicalSpace.Opens (EuclideanSpace ℝ (Fin d))) (u : EuclideanSpace ℝ (Fin d) → ℝ)
          (D : (Fin d → ℕ) → EuclideanSpace ℝ (Fin d) → ℝ),
          IsConvexDomainWith κ Ω → MemSobolevOn (ENNReal.ofReal p) 1 Ω u →
          IsSobolevFamilyOn 1 Ω u D →
          ∃ v : EuclideanSpace ℝ (Fin d) → ℝ, v =ᵐ[volume.restrict Ω] u ∧
            (∀ x ∈ Ω, ∀ y ∈ Ω, |v x - v y| ≤
              N * (eLpNorm (gradNorm D) (ENNReal.ofReal p) (volume.restrict Ω)).toReal *
                ‖x - y‖ ^ (1 - d / p)) ∧
            ∀ x ∈ Ω, ENNReal.ofReal |v x| ≤
              ENNReal.ofReal (N * (eLpNorm (gradNorm D) (ENNReal.ofReal p)
                  (volume.restrict Ω)).toReal) +
                unitBallAverageSup (Ω : Set (EuclideanSpace ℝ (Fin d))) u := by
  sorry

end KrylovSobolev
end Dataset
