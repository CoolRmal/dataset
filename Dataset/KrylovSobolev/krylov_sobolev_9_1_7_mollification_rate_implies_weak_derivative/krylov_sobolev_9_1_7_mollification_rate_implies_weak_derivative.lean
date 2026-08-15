import Dataset.KrylovSobolev.Defs

/-!
# `krylov_sobolev_9_1_7_mollification_rate_implies_weak_derivative`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `krylov_sobolev_9_1_7_mollification_rate_implies_weak_derivative.md`.
Quality rubric: `krylov_sobolev_9_1_7_mollification_rate_implies_weak_derivative.criteria.md`.
-/

open Filter Function MeasureTheory Set Topology
open scoped ContDiff ENNReal Laplacian NNReal SchwartzMap Topology

namespace Dataset
namespace KrylovSobolev

/-- Krylov Exercise 9.1.7: with `u^{(ε)}(x) = ∫ u(x - εy)ζ(y) dy` the mollification of `u` by an
even `ζ ∈ C_0^∞` of unit mass, if `u ∈ 𝓛_2` and `∫_0^1 ‖u^{(ε)} - u‖²_{𝓛_2} ε^{-3} dε ≤ M²`, then
`u ∈ W_2^1` and `‖u_x‖_{𝓛_2} ≤ N(M + ‖u‖_{𝓛_2})`, with `N` independent of `M` and `u`. -/
theorem krylov_sobolev_9_1_7_mollification_rate_implies_weak_derivative {d : ℕ}
    (ζ : EuclideanSpace ℝ (Fin d) → ℝ) (hζsmooth : ContDiff ℝ ∞ ζ)
    (hζsupp : HasCompactSupport ζ) (hζeven : ∀ y, ζ (-y) = ζ y) (hζone : (∫ y, ζ y) = 1) :
    ∃ N : ℝ≥0, ∀ (u : EuclideanSpace ℝ (Fin d) → ℝ) (M : ℝ≥0), MemLp u 2 volume →
      (∫⁻ ε in Ioo (0 : ℝ) 1, eLpNorm (fun x ↦ (∫ y, u (x - ε • y) * ζ y) - u x) 2 volume ^ 2 *
          ENNReal.ofReal (ε ^ (-3 : ℤ))) ≤ (M : ℝ≥0∞) ^ 2 →
      ∃ v : Fin d → EuclideanSpace ℝ (Fin d) → ℝ, HasWeakGradient u v ∧
        (∀ j, MemLp (v j) 2 volume) ∧
        ∑ j, eLpNorm (v j) 2 volume ≤ (N : ℝ≥0∞) * ((M : ℝ≥0∞) + eLpNorm u 2 volume) := by
  sorry

end KrylovSobolev
end Dataset
