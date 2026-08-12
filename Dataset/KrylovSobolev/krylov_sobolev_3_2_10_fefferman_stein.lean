module

public import Dataset.KrylovSobolev.Defs
public import Mathlib.Analysis.SpecialFunctions.Pow.NNReal
public import Mathlib.MeasureTheory.Function.LpSeminorm.Basic

/-!
# `krylov_sobolev_3_2_10_fefferman_stein`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `krylov_sobolev_3_2_10_fefferman_stein.md`.
Quality rubric: `krylov_sobolev_3_2_10_fefferman_stein.criteria.md`.
-/

@[expose] public section

open Filter Function MeasureTheory Set Topology
open scoped ContDiff ENNReal Topology

namespace Dataset
namespace KrylovSobolev

/-- Krylov 3.2.10, the Fefferman–Stein theorem: on a complete σ-finite measure space of
infinite total mass carrying a filtration of partitions with regularity constant `N₀`,
the `𝓛_p` norm of `f` is controlled by that of its sharp function, with the explicit
constant `(2q)^p N₀^{p-1}`, `q = p/(p-1)`. -/
theorem krylov_sobolev_3_2_10_fefferman_stein {X : Type*} [MeasurableSpace X]
    (μ : Measure X) [SigmaFinite μ] [μ.IsComplete] (hμ : μ univ = (∞ : ℝ≥0∞))
    (F : FiltrationOfPartitions X μ) (p : ℝ) (hp : 1 < p)
    (f : X → ℝ) (hf : MemLp f (ENNReal.ofReal p) μ) :
    eLpNorm f (ENNReal.ofReal p) μ ≤
      ENNReal.ofReal ((2 * (p / (p - 1))) ^ p) * F.regularityConstant ^ (p - 1) *
        eLpNorm' (sharpFunction F f) p μ := by
  sorry

end KrylovSobolev
end Dataset
