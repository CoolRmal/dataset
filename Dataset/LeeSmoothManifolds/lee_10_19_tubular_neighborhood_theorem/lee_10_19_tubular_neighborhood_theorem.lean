import Dataset.LeeSmoothManifolds.Defs

/-!
# `lee_10_19_tubular_neighborhood_theorem`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `lee_10_19_tubular_neighborhood_theorem.md`.
Quality rubric: `lee_10_19_tubular_neighborhood_theorem.criteria.md`.
-/

open scoped ContDiff

namespace Dataset
namespace LeeSmoothManifolds

universe u v

/-- Lee 10.19, the tubular-neighborhood theorem. -/
theorem lee_10_19_tubular_neighborhood_theorem
    {n codim : ℕ} {M : Set ((Fin n → ℝ))}
    (hM : EmbeddedSubmanifoldOfCodimension (m := n) M codim) :
    ∃ (radius : M → ℝ) (U : Set (Fin n → ℝ)),
      (∀ x, 0 < radius x) ∧ Continuous radius ∧ IsOpen U ∧ M ⊆ U ∧
      ∃ inverse : (Fin n → ℝ) → M × (Fin n → ℝ),
        Set.BijOn (fun p : M × (Fin n → ℝ) ↦ (p.1 : (Fin n → ℝ)) + p.2)
          (NormalDiskBundle M radius) U ∧
        ContinuousOn inverse U ∧
        ContDiffOn ℝ ∞ (fun z ↦ ((inverse z).1 : (Fin n → ℝ))) U ∧
        ContDiffOn ℝ ∞ (fun z ↦ (inverse z).2) U ∧
        ∀ p ∈ NormalDiskBundle M radius, inverse ((p.1 : (Fin n → ℝ)) + p.2) = p := by
  sorry

end LeeSmoothManifolds
end Dataset
