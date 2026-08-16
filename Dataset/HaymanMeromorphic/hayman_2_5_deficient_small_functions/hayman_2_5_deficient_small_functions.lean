import Dataset.HaymanMeromorphic.Defs

/-!
# `hayman_2_5_deficient_small_functions`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `hayman_2_5_deficient_small_functions.md`.
Quality rubric: `hayman_2_5_deficient_small_functions.criteria.md`.
-/

open Filter ValueDistribution
open scoped Topology

namespace Dataset
namespace HaymanMeromorphic

/-- Hayman 2.5: three meromorphic functions growing more slowly than `f` cannot all be
deficient — their reduced counting functions already account for `T(r,f)`. -/
theorem hayman_2_5_deficient_small_functions (f : ℂ → ℂ) (hf : Meromorphic f)
    (hadm : Tendsto (characteristic f ⊤) atTop atTop)
    (a : Fin 3 → ℂ → ℂ) (ha : ∀ ν, Meromorphic (a ν))
    (hdistinct : ∀ ν μ, ν ≠ μ → a ν ≠ a μ)
    (hsmall : ∀ ν, Tendsto (fun r ↦ characteristic (a ν) ⊤ r / characteristic f ⊤ r) atTop (𝓝 0)) :
    ∀ ε : ℝ, 0 < ε → ∀ᶠ r in atTop,
      (1 - ε) * characteristic f ⊤ r ≤
        ∑ ν : Fin 3, reducedLogCounting (fun z ↦ f z - a ν z) 0 r +
          ε * characteristic f ⊤ r := by
  sorry

end HaymanMeromorphic
end Dataset
