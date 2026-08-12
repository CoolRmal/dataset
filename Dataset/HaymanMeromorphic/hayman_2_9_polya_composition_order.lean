module

public import Dataset.HaymanMeromorphic.Defs

/-!
# `hayman_2_9_polya_composition_order`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `hayman_2_9_polya_composition_order.md`.
Quality rubric: `hayman_2_9_polya_composition_order.criteria.md`.
-/

@[expose] public section

open Filter MeasureTheory Set ValueDistribution
open scoped Topology

namespace Dataset
namespace HaymanMeromorphic

/-- Hayman 2.9 (Pólya): if `f` and `g` are entire and the composition `g ∘ f` has finite order,
then `f` is a polynomial or `g` has order zero. -/
theorem hayman_2_9_polya_composition_order (f g : ℂ → ℂ)
    (hf : Differentiable ℂ f) (hg : Differentiable ℂ g)
    (hcomp : HasFiniteOrder (g ∘ f)) :
    (∃ p : Polynomial ℂ, ∀ z, f z = p.eval z) ∨ HasZeroOrder g := by
  sorry

end HaymanMeromorphic
end Dataset
