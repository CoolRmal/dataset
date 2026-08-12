module

public import Mathlib.Analysis.InnerProductSpace.PiL2
public import Mathlib.MeasureTheory.Measure.MutuallySingular
public import Mathlib.Probability.CDF
public import Mathlib.Probability.Distributions.Gaussian.Basic
public import Mathlib.Probability.Distributions.Gaussian.Multivariate
public import Mathlib.Probability.Moments.Variance

/-!
# Shared definitions for the BogachevGaussian problems

Custom notions used by the statement files in `Dataset/BogachevGaussian/` that are
not already supplied by Mathlib. Each problem file that needs them imports
this module.
-/

@[expose] public section

open MeasureTheory ProbabilityTheory Set
open scoped ENNReal NNReal

namespace Dataset
namespace BogachevGaussian

/-- The quantile function of a measure on the line, valued in `[-∞, +∞]`; for the standard
Gaussian this is Bogachev's `Φ⁻¹`, with `Φ⁻¹(0) = -∞` and `Φ⁻¹(1) = +∞`. -/
noncomputable def quantile (μ : Measure ℝ) (t : ℝ) : EReal :=
  sInf (((↑) : ℝ → EReal) '' {y | t ≤ cdf μ y})

/-- The Cameron–Martin norm `|h|_{H(γ)} = sup {f h : f ∈ X*, ∫ (f - ∫ f dγ)² dγ ≤ 1}`,
valued in `[0, ∞]` so that vectors outside the Cameron–Martin space are not given a
junk finite value. -/
noncomputable def cameronMartinNorm {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    [MeasurableSpace E] (γ : Measure E) (h : E) : ℝ≥0∞ :=
  ⨆ f : {f : StrongDual ℝ E // Var[f; γ] ≤ 1}, ENNReal.ofReal ((f : StrongDual ℝ E) h)

/-- The Cameron–Martin space `H(γ) = {h : |h|_{H(γ)} < ∞}`. -/
def cameronMartinSpace {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    [MeasurableSpace E] (γ : Measure E) : Set E :=
  {h | cameronMartinNorm γ h ≠ ∞}

/-- The gauge `χ(f) = sup {f h : |h|_{H(γ)} ≤ 1}` of a seminorm against the Cameron–Martin
unit ball, valued in `[0, ∞]`. -/
noncomputable def cameronMartinGauge {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    [MeasurableSpace E] (γ : Measure E) (f : E → ℝ) : ℝ≥0∞ :=
  ⨆ h : {h : E // cameronMartinNorm γ h ≤ 1}, ENNReal.ofReal (f h)

/-- Two measures are equivalent when each is absolutely continuous with respect to the other. -/
def Equivalent {E : Type*} [MeasurableSpace E] (μ ν : Measure E) : Prop := μ ≪ ν ∧ ν ≪ μ

end BogachevGaussian
end Dataset
