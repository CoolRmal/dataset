module

public import Dataset.BogachevGaussian.Defs
public import Mathlib.MeasureTheory.Measure.MutuallySingular

/-!
# `bogachev_gaussian_2_4_5_cameron_martin_dichotomy`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `bogachev_gaussian_2_4_5_cameron_martin_dichotomy.md`.
Quality rubric: `bogachev_gaussian_2_4_5_cameron_martin_dichotomy.criteria.md`.
-/

@[expose] public section

open MeasureTheory ProbabilityTheory Set
open scoped ENNReal NNReal

namespace Dataset
namespace BogachevGaussian

/-- Bogachev 2.4.5: the shift `γ_h` of a Gaussian measure is mutually singular with `γ`
when `|h|_{H(γ)} = ∞` and equivalent to `γ` when `|h|_{H(γ)} < ∞`; consequently the
Cameron–Martin space is exactly the set of admissible shifts. -/
theorem bogachev_gaussian_2_4_5_cameron_martin_dichotomy {E : Type*} [NormedAddCommGroup E]
    [NormedSpace ℝ E] [MeasurableSpace E] [BorelSpace E] (γ : Measure E) [IsGaussian γ] :
    (∀ h : E, cameronMartinNorm γ h = ∞ → (γ.map (· + h)) ⟂ₘ γ) ∧
      (∀ h : E, cameronMartinNorm γ h ≠ ∞ → Equivalent (γ.map (· + h)) γ) ∧
      cameronMartinSpace γ = {h : E | Equivalent (γ.map (· + h)) γ} := by
  sorry

end BogachevGaussian
end Dataset
