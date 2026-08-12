module

public import Dataset.HaymanMeromorphic.Defs

/-!
# `hayman_3_8_tumura_clunie_form`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `hayman_3_8_tumura_clunie_form.md`.
Quality rubric: `hayman_3_8_tumura_clunie_form.criteria.md`.
-/

@[expose] public section

open Filter MeasureTheory Set ValueDistribution
open scoped Topology

namespace Dataset
namespace HaymanMeromorphic

/-- Hayman 3.8, in the Tumura–Clunie circle of ideas: a meromorphic function with finitely many
poles whose `l`-th derivative also has finitely many zeros is `P₁ e^{P₃} / P₂` for polynomials
`P₁, P₂, P₃`; if in addition `f` and `f^{(l)}` have no zeros then `f = e^{Az+B}` or
`f = (Az+B)^{-n}`. -/
theorem hayman_3_8_tumura_clunie_form (f : ℂ → ℂ) (hf : Meromorphic f) (l : ℕ) (hl : 2 ≤ l)
    (hpoles : {z : ℂ | ¬ AnalyticAt ℂ f z}.Finite)
    (hzeros : {z : ℂ | f z = 0}.Finite)
    (hlzeros : {z : ℂ | iteratedDeriv l f z = 0}.Finite) :
    (∃ P₁ P₂ P₃ : Polynomial ℂ, P₂ ≠ 0 ∧
        ∀ z, P₂.eval z ≠ 0 → f z = P₁.eval z / P₂.eval z * Complex.exp (P₃.eval z)) ∧
      (({z : ℂ | f z = 0} = ∅ ∧ {z : ℂ | iteratedDeriv l f z = 0} = ∅) →
        (∃ A B : ℂ, ∀ z, f z = Complex.exp (A * z + B)) ∨
          ∃ (A B : ℂ) (n : ℕ), 1 ≤ n ∧ ∀ z, A * z + B ≠ 0 → f z = (A * z + B) ^ (-(n : ℤ))) := by
  sorry

end HaymanMeromorphic
end Dataset
