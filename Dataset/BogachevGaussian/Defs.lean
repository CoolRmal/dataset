import Mathlib.Probability.CDF
import Mathlib.Probability.Distributions.Gaussian.Multivariate

/-!
# Shared definitions for the BogachevGaussian problems

Custom notions used by the statement files in `Dataset/BogachevGaussian/` that are
not already supplied by Mathlib. Each problem file that needs them imports
this module.
-/

open MeasureTheory ProbabilityTheory
open scoped ENNReal

namespace Dataset
namespace BogachevGaussian

/-- The quantile function of a measure on the line, valued in `[-∞, +∞]`; for the standard
Gaussian this is Bogachev's `Φ⁻¹`, with `Φ⁻¹(0) = -∞` and `Φ⁻¹(1) = +∞`. -/
noncomputable def quantile (μ : Measure ℝ) (t : ℝ) : EReal :=
  sInf (((↑) : ℝ → EReal) '' {y | t ≤ cdf μ y})

/-- The Cameron–Martin norm `|h|_{H(γ)} = sup {f h : f ∈ X*, ∫ (f - ∫ f dγ)² dγ ≤ 1}`,
valued in `[0, ∞]` so that vectors outside the Cameron–Martin space are not given a
junk finite value. -/
noncomputable def cameronMartinNorm {E : Type*} [AddCommGroup E] [Module ℝ E] [TopologicalSpace E]
    [IsTopologicalAddGroup E] [ContinuousSMul ℝ E] [LocallyConvexSpace ℝ E]
    [MeasurableSpace E] (γ : Measure E) (h : E) : ℝ≥0∞ :=
  ⨆ f : {f : StrongDual ℝ E // Var[f; γ] ≤ 1}, ENNReal.ofReal ((f : StrongDual ℝ E) h)

/-- The covariance operator `R_γ` of `γ` applied to `f`, as a functional on the dual:
`R_γ(f)(g) = ∫ (f - a_γ(f))(g - a_γ(g)) dγ`. -/
noncomputable def covarianceForm {E : Type*} [AddCommGroup E] [Module ℝ E] [TopologicalSpace E]
    [IsTopologicalAddGroup E] [ContinuousSMul ℝ E] [LocallyConvexSpace ℝ E]
    [MeasurableSpace E] (γ : Measure E) (f g : StrongDual ℝ E) : ℝ :=
  ∫ x, (f x - γ[f]) * (g x - γ[g]) ∂γ

/-- Bogachev's `X ∩ R_γ(X*)`: the vectors of `X` that represent `R_γ(f)` for some `f ∈ X*`,
i.e. `h` such that `g h = R_γ(f)(g)` for every `g ∈ X*`. -/
def covarianceRange {E : Type*} [AddCommGroup E] [Module ℝ E] [TopologicalSpace E]
    [IsTopologicalAddGroup E] [ContinuousSMul ℝ E] [LocallyConvexSpace ℝ E]
    [MeasurableSpace E] (γ : Measure E) : Set E :=
  {h | ∃ f : StrongDual ℝ E, ∀ g : StrongDual ℝ E, g h = covarianceForm γ f g}

/-- The Cameron–Martin space `H(γ) = {h : |h|_{H(γ)} < ∞}`. -/
def cameronMartinSpace {E : Type*} [AddCommGroup E] [Module ℝ E] [TopologicalSpace E]
    [IsTopologicalAddGroup E] [ContinuousSMul ℝ E] [LocallyConvexSpace ℝ E]
    [MeasurableSpace E] (γ : Measure E) : Set E :=
  {h | cameronMartinNorm γ h ≠ ∞}

/-- The gauge `χ(f) = sup {f h : |h|_{H(γ)} ≤ 1}` of a seminorm against the Cameron–Martin
unit ball, valued in `[0, ∞]`. -/
noncomputable def cameronMartinGauge {E : Type*} [AddCommGroup E] [Module ℝ E] [TopologicalSpace E]
    [IsTopologicalAddGroup E] [ContinuousSMul ℝ E] [LocallyConvexSpace ℝ E]
    [MeasurableSpace E] (γ : Measure E) (f : E → ℝ) : ℝ≥0∞ :=
  ⨆ h : {h : E // cameronMartinNorm γ h ≤ 1}, ENNReal.ofReal (f h)

/-- Two measures are equivalent when each is absolutely continuous with respect to the other. -/
def Equivalent {E : Type*} [MeasurableSpace E] (μ ν : Measure E) : Prop := μ ≪ ν ∧ ν ≪ μ

end BogachevGaussian
end Dataset
