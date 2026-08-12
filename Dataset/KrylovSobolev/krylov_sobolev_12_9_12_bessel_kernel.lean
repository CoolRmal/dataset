module

public import Dataset.KrylovSobolev.Defs
public import Mathlib.Analysis.Distribution.SchwartzSpace.Fourier
public import Mathlib.MeasureTheory.Function.LpSeminorm.Basic
public import Mathlib.MeasureTheory.Integral.Bochner.Basic

/-!
# `krylov_sobolev_12_9_12_bessel_kernel`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `krylov_sobolev_12_9_12_bessel_kernel.md`.
Quality rubric: `krylov_sobolev_12_9_12_bessel_kernel.criteria.md`.
-/

@[expose] public section

open Filter Function MeasureTheory Set Topology
open scoped ContDiff ENNReal FourierTransform SchwartzMap Topology

namespace Dataset
namespace KrylovSobolev

/-- Krylov 12.9.12: for `γ > 0` the operator `(1-Δ)^{-γ/2}` acts on Schwartz functions as
convolution with a radial kernel `G ≥ 0` of unit `𝓛₁` norm. -/
theorem krylov_sobolev_12_9_12_bessel_kernel {d : ℕ} (γ : ℝ) (hγ : 0 < γ) :
    ∃ G : EuclideanSpace ℝ (Fin d) → ℝ,
      (∀ x y, ‖x‖ = ‖y‖ → G x = G y) ∧ (∀ x, 0 ≤ G x) ∧
        eLpNorm G 1 volume = 1 ∧
        ∀ (φ : 𝓢(EuclideanSpace ℝ (Fin d), ℂ)) (v : EuclideanSpace ℝ (Fin d) → ℂ),
          Continuous v → Integrable v → IsBesselPotential γ (fun x ↦ φ x) v →
            ∀ x, v x = ∫ y, (G (x - y) : ℂ) * φ y := by
  sorry

end KrylovSobolev
end Dataset
