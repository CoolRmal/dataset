module

public import Dataset.FollandHarmonic.Defs


/-!
# `folland_4_52_hull_of_kernel`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `folland_4_52_hull_of_kernel.md`.
Quality rubric: `folland_4_52_hull_of_kernel.criteria.md`.
-/

@[expose] public section

open Filter MeasureTheory Set Topology
open scoped ENNReal NNReal Topology

namespace Dataset
namespace FollandHarmonic

/-- Folland 4.52: taking the hull of the kernel of a closed set of characters returns the set. -/
theorem folland_4_52_hull_of_kernel {G : Type*} [CommGroup G]
    [TopologicalSpace G] [IsTopologicalGroup G]
    [LocallyCompactSpace G] [MeasurableSpace G] [BorelSpace G]
    (μ : Measure G) [μ.IsHaarMeasure]
    (N : Set (PontryaginDual G)) (hN : IsClosed N) : hull μ (kernel μ N) = N := by
  sorry

end FollandHarmonic
end Dataset
