module

public import Mathlib.Analysis.Distribution.SchwartzSpace.Fourier
public import Mathlib.Analysis.Fourier.AddCircle
public import Mathlib.MeasureTheory.Function.LpSeminorm.Basic
public import Mathlib.MeasureTheory.Integral.Bochner.Basic

/-!
# `grafakos_2_2_14_fourier_identities_on_schwartz`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `grafakos_2_2_14_fourier_identities_on_schwartz.md`.
Quality rubric: `grafakos_2_2_14_fourier_identities_on_schwartz.criteria.md`.
-/

@[expose] public section

open Filter Function MeasureTheory Metric Set
open scoped ENNReal FourierTransform SchwartzMap Topology

namespace Dataset
namespace GrafakosFourier

universe u v

/-- Grafakos 2.2.14, Fourier identities on the Schwartz space. -/
theorem grafakos_2_2_14_fourier_identities_on_schwartz
    {n : ℕ} (f g h : 𝓢(EuclideanSpace ℝ (Fin n), ℂ)) :
    ((∫ x, f x * 𝓕 g x) = ∫ x, 𝓕 f x * g x) ∧
      𝓕⁻ (𝓕 f) = f ∧ 𝓕 (𝓕⁻ f) = f ∧
      (∫ x, star (𝓕 f x) * 𝓕 g x) = ∫ x, star (f x) * g x ∧
      eLpNorm (fun x ↦ 𝓕 f x) 2 volume = eLpNorm f 2 volume ∧
      eLpNorm (fun x ↦ 𝓕⁻ f x) 2 volume = eLpNorm f 2 volume ∧
      (∫ x, 𝓕 f x * h x) = ∫ x, f x * 𝓕 h x := by
  sorry

end GrafakosFourier
end Dataset
