import Dataset.LeeSmoothManifolds.Defs

/-!
# `lee_7_13_rank_theorem_for_manifolds`

Statement-only formalization; the proof is intentionally `sorry`.
Natural-language statement: `lee_7_13_rank_theorem_for_manifolds.md`.
Quality rubric: `lee_7_13_rank_theorem_for_manifolds.criteria.md`.
-/

open Set
open scoped ContDiff Manifold

namespace Dataset
namespace LeeSmoothManifolds

universe u v

/-- Lee 7.13, the rank theorem for manifolds. -/
theorem lee_7_13_rank_theorem_for_manifolds
    {m n k : ℕ} {M : Type u} {N : Type v}
    [TopologicalSpace M] [ChartedSpace ((Fin m → ℝ)) M]
    [IsManifold 𝓘(ℝ, (Fin m → ℝ)) ∞ M]
    [TopologicalSpace N] [ChartedSpace ((Fin n → ℝ)) N]
    [IsManifold 𝓘(ℝ, (Fin n → ℝ)) ∞ N]
    {F : M → N} (hF : ContMDiff 𝓘(ℝ, (Fin m → ℝ)) 𝓘(ℝ, (Fin n → ℝ)) ∞ F)
    (hk : k ≤ m ∧ k ≤ n) (hrank : ConstantRank (m := m) (n := n) F k) :
    ∀ p, ∃ (φ : OpenPartialHomeomorph M (Fin m → ℝ))
      (ψ : OpenPartialHomeomorph N (Fin n → ℝ)),
      φ ∈ IsManifold.maximalAtlas 𝓘(ℝ, (Fin m → ℝ)) ∞ M ∧
      ψ ∈ IsManifold.maximalAtlas 𝓘(ℝ, (Fin n → ℝ)) ∞ N ∧
      p ∈ φ.source ∧ F p ∈ ψ.source ∧ MapsTo F φ.source ψ.source ∧
      φ p = 0 ∧ ψ (F p) = 0 ∧
      ∀ x ∈ φ.target, ψ (F (φ.symm x)) =
        fun i ↦ if h : i.1 < k ∧ i.1 < m then x ⟨i.1, h.2⟩ else 0 := by
  sorry

end LeeSmoothManifolds
end Dataset
