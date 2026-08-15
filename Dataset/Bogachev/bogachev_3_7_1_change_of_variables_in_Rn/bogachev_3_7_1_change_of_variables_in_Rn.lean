import Mathlib.Analysis.Calculus.ContDiff.Basic
import Mathlib.MeasureTheory.Integral.Prod

/-!
# `bogachev_3_7_1_change_of_variables_in_Rn` — 3.7.1

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `bogachev_3_7_1_change_of_variables_in_Rn.md`.
Quality rubric: `bogachev_3_7_1_change_of_variables_in_Rn.criteria.md`.
-/

open MeasureTheory Set

namespace Dataset
namespace Bogachev

/--
Bogachev, *Measure Theory*, Volume I, Theorem 3.7.1:
"If `F : U → ℝⁿ` is continuously differentiable and injective on the open set
`U`, then for every measurable `A ⊂ U` and every Borel integrable function `g`,
`∫_A g(F x) |J_F(x)| dx = ∫_{F(A)} g(y) dy`."
-/
theorem bogachev_3_7_1_change_of_variables_in_Rn
    {n : ℕ} {U A : Set (Fin n → ℝ)} {F : (Fin n → ℝ) → (Fin n → ℝ)}
    {g : (Fin n → ℝ) → ℝ}
    (hU : IsOpen U) (hF : ContDiffOn ℝ 1 F U) (hinj : InjOn F U)
    (hA : NullMeasurableSet A volume) (hAU : A ⊆ U) (hgB : Measurable g) (hg : Integrable g volume) :
    (∫ x in A, g (F x) * |(fderivWithin ℝ F U x).det| ∂volume) =
      ∫ y in F '' A, g y ∂volume := by
  sorry

end Bogachev
end Dataset
