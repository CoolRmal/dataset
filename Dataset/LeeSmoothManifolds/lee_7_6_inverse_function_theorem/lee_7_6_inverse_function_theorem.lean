import Dataset.LeeSmoothManifolds.Defs
import Mathlib.Geometry.Manifold.Algebra.LieGroup
import Mathlib.Geometry.Manifold.ContMDiffMFDeriv
import Mathlib.Geometry.Manifold.Immersion
import Mathlib.Geometry.Manifold.SmoothApprox
import Mathlib.Geometry.Manifold.Submersion
import Mathlib.Geometry.Manifold.WhitneyEmbedding
import Mathlib.MeasureTheory.Measure.Haar.NormedSpace

/-!
# `lee_7_6_inverse_function_theorem`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `lee_7_6_inverse_function_theorem.md`.
Quality rubric: `lee_7_6_inverse_function_theorem.criteria.md`.
-/

open Function MeasureTheory Set Topology
open scoped ContDiff Manifold Topology

namespace Dataset
namespace LeeSmoothManifolds

universe u v

/-- Lee 7.6, the inverse function theorem. -/
theorem lee_7_6_inverse_function_theorem
    {n : ℕ} {U V : Set ((Fin n → ℝ))} {F : (Fin n → ℝ) → (Fin n → ℝ)}
    {p : (Fin n → ℝ)} (hU : IsOpen U) (hV : IsOpen V)
    (hF : MapsTo F U V ∧ ContDiffOn ℝ ∞ F U) (hp : p ∈ U)
    (hD : Function.Bijective (fderiv ℝ F p)) :
    ∃ U₀ V₀,
      (IsOpen U₀ ∧ IsConnected U₀ ∧ p ∈ U₀ ∧ U₀ ⊆ U) ∧
      (IsOpen V₀ ∧ IsConnected V₀ ∧ F p ∈ V₀ ∧ V₀ ⊆ V) ∧
      ∃ e : SmoothDiffeomorphismOn U₀ V₀, e.toFun = F := by
  sorry

end LeeSmoothManifolds
end Dataset
