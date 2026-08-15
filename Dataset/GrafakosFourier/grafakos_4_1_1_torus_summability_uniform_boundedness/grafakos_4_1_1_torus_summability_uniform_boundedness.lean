import Dataset.GrafakosFourier.Defs
import Mathlib.Analysis.Distribution.SchwartzSpace.Fourier
import Mathlib.Analysis.Fourier.AddCircle
import Mathlib.MeasureTheory.Function.LpSeminorm.Basic
import Mathlib.MeasureTheory.Integral.Bochner.Basic

/-!
# `grafakos_4_1_1_torus_summability_uniform_boundedness`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `grafakos_4_1_1_torus_summability_uniform_boundedness.md`.
Quality rubric: `grafakos_4_1_1_torus_summability_uniform_boundedness.criteria.md`.
-/

open Filter Function MeasureTheory Metric Set
open scoped ENNReal FourierTransform SchwartzMap Topology

namespace Dataset
namespace GrafakosFourier

universe u v

/-- Grafakos 4.1.1, uniform boundedness for torus summability. -/
theorem grafakos_4_1_1_torus_summability_uniform_boundedness
    {n : ℕ}
    (a : ℝ → (Fin n → ℤ) → ℂ) (aLimit : (Fin n → ℤ) → ℂ)
    (hfinite : ∀ R, 0 < R → (Function.support (a R)).Finite)
    (hbounded : ∃ M : ℝ, 0 ≤ M ∧ ∀ R m, 0 < R → ‖a R m‖ ≤ M)
    (htendsto : ∀ m, Tendsto (fun R ↦ a R m) atTop (𝓝 (aLimit m)))
    {p : ℝ} (hp : 1 ≤ p) :
    let μ : Measure (Fin n → AddCircle (1 : ℝ)) := volume
    let S := fun R (f : (Fin n → AddCircle (1 : ℝ)) → ℂ)
      (x : Fin n → AddCircle (1 : ℝ)) ↦
        ∑' m, a R m * torusFourierCoefficient μ f m * torusCharacter m x
    let formalLimit := fun (f : (Fin n → AddCircle (1 : ℝ)) → ℂ)
      (x : Fin n → AddCircle (1 : ℝ)) ↦
        ∑' m, aLimit m * torusFourierCoefficient μ f m * torusCharacter m x
    ((∀ f, MemLp f (ENNReal.ofReal p) μ →
        ∃ g, MemLp g (ENNReal.ofReal p) μ ∧
          Tendsto (fun R ↦ eLpNorm (S R f - g) (ENNReal.ofReal p) μ) atTop (𝓝 0)) ↔
      ∃ C : ℝ≥0∞, C < ∞ ∧ ∀ R, 0 < R →
        HasStrongType μ μ (S R) (ENNReal.ofReal p) (ENNReal.ofReal p) C) ∧
    ∀ C : ℝ≥0∞,
      (∀ R, 0 < R → HasStrongType μ μ (S R) (ENNReal.ofReal p) (ENNReal.ofReal p) C) →
        ∃ A : ((Fin n → AddCircle (1 : ℝ)) → ℂ) →
            (Fin n → AddCircle (1 : ℝ)) → ℂ,
          HasStrongType μ μ A (ENNReal.ofReal p) (ENNReal.ofReal p) C ∧
          (∀ h, MemLp h (ENNReal.ofReal p) μ →
            Summable (fun m ↦ fun x ↦
              aLimit m * torusFourierCoefficient μ h m * torusCharacter m x) →
              A h = formalLimit h) ∧
          ∀ f, MemLp f (ENNReal.ofReal p) μ →
            Tendsto (fun R ↦ eLpNorm (S R f - A f) (ENNReal.ofReal p) μ) atTop (𝓝 0) := by
  sorry

end GrafakosFourier
end Dataset
