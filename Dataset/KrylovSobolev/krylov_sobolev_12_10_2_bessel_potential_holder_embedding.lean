module

public import Dataset.KrylovSobolev.Defs

/-!
# `krylov_sobolev_12_10_2_bessel_potential_holder_embedding`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `krylov_sobolev_12_10_2_bessel_potential_holder_embedding.md`.
Quality rubric: `krylov_sobolev_12_10_2_bessel_potential_holder_embedding.criteria.md`.
-/

@[expose] public section

open Filter Function MeasureTheory Set Topology
open scoped ContDiff ENNReal Laplacian NNReal SchwartzMap Topology

namespace Dataset
namespace KrylovSobolev

/-- Krylov Lemma 12.10.2: for `p ∈ (1, ∞]` with `0 < δ := γ - d/p < 1`, one constant `N` bounds
both `|φ(x)|` and `|φ(x) - φ(y)| / |x - y|^δ` by `‖(1 - Δ)^{γ/2}φ‖_{𝓛_p}`, for every `φ ∈ 𝓢`. -/
theorem krylov_sobolev_12_10_2_bessel_potential_holder_embedding {d : ℕ} {γ : ℝ} {p : ℝ≥0∞}
    (hp : 1 < p) (hδ₀ : 0 < γ - d * (p⁻¹).toReal) (hδ₁ : γ - d * (p⁻¹).toReal < 1) :
    ∃ N : ℝ, ∀ (φ : 𝓢(EuclideanSpace ℝ (Fin d), ℂ)) (x y : EuclideanSpace ℝ (Fin d)),
      ‖φ x‖ ≤ N * (eLpNorm (⇑(besselOp γ φ)) p volume).toReal ∧
        ‖φ x - φ y‖ ≤ N * ‖x - y‖ ^ (γ - d * (p⁻¹).toReal) *
          (eLpNorm (⇑(besselOp γ φ)) p volume).toReal := by
  sorry

end KrylovSobolev
end Dataset
