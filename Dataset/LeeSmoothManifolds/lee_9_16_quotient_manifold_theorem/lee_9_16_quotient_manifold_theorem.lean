import Dataset.LeeSmoothManifolds.Defs

/-!
# `lee_9_16_quotient_manifold_theorem`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `lee_9_16_quotient_manifold_theorem.md`.
Quality rubric: `lee_9_16_quotient_manifold_theorem.criteria.md`.
-/

open Function
open scoped ContDiff Manifold

namespace Dataset
namespace LeeSmoothManifolds

universe u v

/-- Lee 9.16, the quotient-manifold theorem. -/
theorem lee_9_16_quotient_manifold_theorem
    {g m : ℕ} {G : Type u} {M : Type v} [Group G]
    [TopologicalSpace G] [ChartedSpace ((Fin g → ℝ)) G]
    [LieGroup 𝓘(ℝ, (Fin g → ℝ)) ∞ G]
    [TopologicalSpace M] [ChartedSpace ((Fin m → ℝ)) M]
    [IsManifold 𝓘(ℝ, (Fin m → ℝ)) ∞ M] [T2Space M] [SecondCountableTopology M]
    {act : G → M → M} (haction : SmoothFreeProperAction (g := g) (m := m) act) :
    ∃ (Q : Type v) (_ : TopologicalSpace Q) (_ : T2Space Q) (_ : SecondCountableTopology Q)
      (_ : ChartedSpace (Fin (m - g) → ℝ) Q)
      (_ : IsManifold 𝓘(ℝ, (Fin (m - g) → ℝ)) ∞ Q) (π : M → Q),
      Surjective π ∧ (∀ x y, π x = π y ↔ ∃ a, act a x = y) ∧
      Manifold.IsSubmersion 𝓘(ℝ, (Fin m → ℝ)) 𝓘(ℝ, (Fin (m - g) → ℝ)) ∞ π ∧
      ∀ (Q' : Type v) (_ : TopologicalSpace Q')
        (_ : ChartedSpace (Fin (m - g) → ℝ) Q')
        (_ : IsManifold 𝓘(ℝ, (Fin (m - g) → ℝ)) ∞ Q') (π' : M → Q'),
        Surjective π' → (∀ x y, π' x = π' y ↔ ∃ a, act a x = y) →
        Manifold.IsSubmersion 𝓘(ℝ, (Fin m → ℝ)) 𝓘(ℝ, (Fin (m - g) → ℝ)) ∞
          π' →
        ∃ e : Diffeomorph 𝓘(ℝ, (Fin (m - g) → ℝ)) 𝓘(ℝ, (Fin (m - g) → ℝ))
          Q Q' ∞, e ∘ π = π' := by
  sorry

end LeeSmoothManifolds
end Dataset
