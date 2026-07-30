module

public import Dataset.GrafakosFourier.Defs
public import Mathlib.Analysis.Distribution.SchwartzSpace.Fourier
public import Mathlib.Analysis.Fourier.AddCircle
public import Mathlib.MeasureTheory.Function.LpSeminorm.Basic
public import Mathlib.MeasureTheory.Integral.Bochner.Basic

/-!
# `grafakos_4_1_1_torus_summability_uniform_boundedness`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `grafakos_4_1_1_torus_summability_uniform_boundedness.md`.
Quality rubric: `grafakos_4_1_1_torus_summability_uniform_boundedness.criteria.md`.
-/

@[expose] public section

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
    let A := fun (f : (Fin n → AddCircle (1 : ℝ)) → ℂ)
      (x : Fin n → AddCircle (1 : ℝ)) ↦
        ∑' m, aLimit m * torusFourierCoefficient μ f m * torusCharacter m x
    ((∀ f, MemLp f (ENNReal.ofReal p) μ →
        Tendsto (fun R ↦ eLpNorm (S R f - A f) (ENNReal.ofReal p) μ) atTop (𝓝 0)) ↔
      ∃ C : ℝ≥0∞, C < ∞ ∧ ∀ R, 0 < R →
        HasStrongType μ μ (S R) (ENNReal.ofReal p) (ENNReal.ofReal p) C) ∧
    ∀ C : ℝ≥0∞,
      (∀ R, 0 < R → HasStrongType μ μ (S R) (ENNReal.ofReal p) (ENNReal.ofReal p) C) →
        HasStrongType μ μ A (ENNReal.ofReal p) (ENNReal.ofReal p) C := by
  sorry

end GrafakosFourier
end Dataset
